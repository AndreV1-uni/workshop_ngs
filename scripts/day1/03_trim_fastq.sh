#!/usr/bin/env bash
set -euo pipefail

sample="WT_2"

raw_dir="raw_data/fastq/rnaseq"
out_dir="results/day1_qc/trimmed_fastq/rnaseq"
report_dir="results/logs/day1/fastp"

mkdir -p "${out_dir}" "${report_dir}"

read1="${raw_dir}/${sample}_R1.fastq.gz"
read2="${raw_dir}/${sample}_R2.fastq.gz"

fastp \
  -i "${read1}" \
  -I "${read2}" \
  -o "${out_dir}/${sample}_R1.trimmed.fastq.gz" \
  -O "${out_dir}/${sample}_R2.trimmed.fastq.gz" \
  --detect_adapter_for_pe \
  --cut_tail \
  --cut_tail_window_size 4 \
  --cut_tail_mean_quality 20 \
  --thread 2 \
  --html "${report_dir}/${sample}.fastp.html" \
  --json "${report_dir}/${sample}.fastp.json" \
  > "${report_dir}/${sample}.fastp.log" 2>&1

echo "Finished fastp for ${sample}"
