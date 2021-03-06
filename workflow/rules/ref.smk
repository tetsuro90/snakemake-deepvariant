rule genome_faidx:
    input:
        config["ref"]["genome"]
    output:
        "data/ref/{}.fai".format(get_fasta_basename())
    log:
        "logs/genome-faidx.log"
    wrapper:
        "0.59.2/bio/samtools/faidx"


rule bwa_index:
    input:
        config["ref"]["genome"]
    output:
        multiext("data/ref/{}".format(get_fasta_basename()), 
        ".amb", ".ann", ".bwt", ".pac", ".sa")
    log:
        "logs/bwa_index.log"
    resources:
        mem_mb=369000
    wrapper:
        "0.59.2/bio/bwa/index"


rule genome_dict:
    input:
        config["ref"]["genome"]
    output:
        "data/ref/{}.dict".format(os.path.splitext(get_fasta_basename())[0]),
    log:
        "logs/samtools/create_dict.log"
    conda:
        "../envs/samtools.yaml"
    shell:
        "samtools dict {input} > {output} 2> {log}"
