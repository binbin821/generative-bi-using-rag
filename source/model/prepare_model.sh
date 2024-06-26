function usage {
  echo "Make sure python3 installed properly. Usage: $0 -s S3_BUCKET_NAME"
  echo "  -s S3_BUCKET_NAME   S3 bucket name to upload the model"
  exit 1
}

# Parse command-line options
while getopts ":s:" opt; do
  case $opt in
    s) s3_bucket_name="$OPTARG" ;;
    \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
    :) echo "Option -$OPTARG requires an argument." >&2; usage ;;
  esac
done

# Validate the hf_token and python3 interpreter exist
if [ -z "$s3_bucket_name" ] || ! command -v python3 &> /dev/null; then
  usage
fi

cd internlm/model
hf_names=("bartowski/internlm2-chat-7b-llama-exl2") 
model_names=("internlm2-chat-7b")
commit_hashs=("54a594b0be43065e7b7674d0f236911cd7c465ab")
tensor_parallel_degree=(1)

for index in "${!model_names[@]}"; do
  hf_name="${hf_names[$index]}"
  model_name="${model_names[$index]}"
  commit_hash="${commit_hashs[$index]}"
  tp="${tensor_parallel_degree[$index]}"
  echo "model name $model_name"
  echo "commit hash $commit_hash"
  ./model.sh -h $hf_name -m $model_name -c $commit_hash -p $tp -s $s3_bucket_name
done


cd ../../sqlcoder/model
hf_names=("defog/sqlcoder-7b-2")
model_names=("sqlcoder-7b-2")
commit_hashs=("7e5b6f7981c0aa7d143f6bec6fa26625bdfcbe66")
tensor_parallel_degree=(1)

for index in "${!model_names[@]}"; do
  hf_name="${hf_names[$index]}"
  model_name="${model_names[$index]}"
  commit_hash="${commit_hashs[$index]}"
  tp="${tensor_parallel_degree[$index]}"
  echo "model name $model_name"
  echo "commit hash $commit_hash"
  ./model.sh -h $hf_name -m $model_name -c $commit_hash -p $tp -s $s3_bucket_name
done

cd ../../embedding/model
hf_names=("BAAI/bge-m3")
model_names=("bge-m3")
commit_hashs=("3ab7155aa9b89ac532b2f2efcc3f136766b91025")
tensor_parallel_degree=(1)

for index in "${!model_names[@]}"; do
  hf_name="${hf_names[$index]}"
  model_name="${model_names[$index]}"
  commit_hash="${commit_hashs[$index]}"
  tp="${tensor_parallel_degree[$index]}"
  echo "model name $model_name"
  echo "commit hash $commit_hash"
  ./model.sh -h $hf_name -m $model_name -c $commit_hash -p $tp -s $s3_bucket_name
done