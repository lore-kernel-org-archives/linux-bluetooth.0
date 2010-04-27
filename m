Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Added checks in memory allocated with malloc in SDP
From: Marcel Holtmann <marcel@holtmann.org>
To: Santiago Carot-Nemesio <scarot@libresoft.es>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1272395759.1914.3.camel@mosquito>
References: <1272395759.1914.3.camel@mosquito>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 21:21:44 +0200
Message-ID: <1272396104.22838.155.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

> This patch add checks in memory allocated using malloc in SDP. 
> 
> >From b19940a05fcd341b1197606661320fa91ba19390 Mon Sep 17 00:00:00 2001
> From: Santiago Carot-Nemesio <sancane@gmail.com>
> Date: Tue, 27 Apr 2010 20:44:18 +0200
> Subject: [PATCH 1/2] Added checks in memory allocated with malloc in SDP
> 
> ---
>  lib/sdp.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 76 insertions(+), 6 deletions(-)
>  mode change 100644 => 100755 lib/sdp.c
> 
> diff --git a/lib/sdp.c b/lib/sdp.c
> old mode 100644
> new mode 100755
> index 667d412..0def315
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -1078,6 +1078,8 @@ static sdp_data_t *extract_int(const void *p, int bufsize, int *len)
>  	}
>  
>  	d = malloc(sizeof(sdp_data_t));
> +	if (!d)
> +		return NULL;
>  
>  	SDPDBG("Extracting integer\n");
>  	memset(d, 0, sizeof(sdp_data_t));
> @@ -1152,6 +1154,9 @@ static sdp_data_t *extract_uuid(const uint8_t *p, int bufsize, int *len,
>  {
>  	sdp_data_t *d = malloc(sizeof(sdp_data_t));
>  
> +	if (!d)
> +		return NULL;
> +
>  	SDPDBG("Extracting UUID");
>  	memset(d, 0, sizeof(sdp_data_t));
>  	if (sdp_uuid_extract(p, bufsize, &d->val.uuid, len) < 0) {
> @@ -1179,6 +1184,8 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
>  	}
>  
>  	d = malloc(sizeof(sdp_data_t));
> +	if (!d)
> +		return NULL;
>  
>  	memset(d, 0, sizeof(sdp_data_t));
>  	d->dtd = *(uint8_t *) p;
> @@ -1302,6 +1309,9 @@ static sdp_data_t *extract_seq(const void *p, int bufsize, int *len,
>  	sdp_data_t *curr, *prev;
>  	sdp_data_t *d = malloc(sizeof(sdp_data_t));
>  
> +	if (!d)
> +		return NULL;
> +
>  	SDPDBG("Extracting SEQ");
>  	memset(d, 0, sizeof(sdp_data_t));
>  	*len = sdp_extract_seqtype(p, bufsize, &d->dtd, &seqlen);
> @@ -1945,10 +1955,15 @@ int sdp_get_uuidseq_attr(const sdp_record_t *rec, uint16_t attr,
>  		sdp_data_t *d;
>  		for (d = sdpdata->val.dataseq; d; d = d->next) {
>  			uuid_t *u;
> -			if (d->dtd < SDP_UUID16 || d->dtd > SDP_UUID128)
> +			if (d->dtd < SDP_UUID16 || d->dtd > SDP_UUID128) {
> +				errno = EINVAL;
>  				goto fail;
> +			}
>  
>  			u = malloc(sizeof(uuid_t));
> +			if (!u)
> +				goto fail;
> +
>  			memset(u, 0, sizeof(uuid_t));
>  			*u = d->val.uuid;
>  			*seqp = sdp_list_append(*seqp, u);
> @@ -1957,7 +1972,7 @@ int sdp_get_uuidseq_attr(const sdp_record_t *rec, uint16_t attr,
>  	}
>  fail:
>  	sdp_list_free(*seqp, free);
> -	errno = EINVAL;
> +	*seqp = NULL;
>  	return -1;
>  }
>  
> @@ -1974,7 +1989,15 @@ int sdp_set_uuidseq_attr(sdp_record_t *rec, uint16_t aid, sdp_list_t *seq)
>  	if (!seq || len == 0)
>  		return -1;
>  	dtds = (void **)malloc(len * sizeof(void *));
> +	if (!dtds)
> +		return -1;
> +
>  	values = (void **)malloc(len * sizeof(void *));
> +	if (!values) {
> +		free(dtds);
> +		return -1;
> +	}
> +

since you are touching this code, remove the pointless (void **) casting
for malloc.

>  	for (p = seq, i = 0; i < len; i++, p = p->next) {
>  		uuid_t *uuid = (uuid_t *)p->data;
>  		if (uuid)
> @@ -2028,6 +2051,9 @@ int sdp_get_lang_attr(const sdp_record_t *rec, sdp_list_t **langSeq)
>  		sdp_data_t *pOffset = pEncoding->next;
>  		if (pEncoding && pOffset) {
>  			lang = malloc(sizeof(sdp_lang_attr_t));
> +			if (!lang)
> +				goto fail;
> +
>  			lang->code_ISO639 = pCode->val.uint16;
>  			lang->encoding = pEncoding->val.uint16;
>  			lang->base_offset = pOffset->val.uint16;
> @@ -2039,6 +2065,10 @@ int sdp_get_lang_attr(const sdp_record_t *rec, sdp_list_t **langSeq)
>  		curr_data = pOffset->next;
>  	}
>  	return 0;
> +fail:
> +	sdp_list_free(*langSeq, free);
> +	*langSeq = NULL;
> +	return -1;
>  }

Why a goto here. There is only one user.
 
>  int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
> @@ -2069,6 +2099,8 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
>  
>  		if (uuid != NULL) {
>  			profDesc = malloc(sizeof(sdp_profile_desc_t));
> +			if (!profDesc)
> +				goto fail;
>  			profDesc->uuid = *uuid;
>  			profDesc->version = version;
>  #ifdef SDP_DEBUG
> @@ -2079,6 +2111,10 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
>  		}
>  	}
>  	return 0;
> +fail:
> +	sdp_list_free(*profDescSeq, free);
> +	*profDescSeq = NULL;
> +	return -1;
>  }

Same here. Only one user. So better keep the the error handling in
place.
 
>  int sdp_get_server_ver(const sdp_record_t *rec, sdp_list_t **u16)
> @@ -2231,7 +2267,15 @@ static sdp_data_t *access_proto_to_dataseq(sdp_record_t *rec, sdp_list_t *proto)
>  
>  	seqlen = sdp_list_len(proto);
>  	seqDTDs = (void **)malloc(seqlen * sizeof(void *));
> +	if (!seqDTDs)
> +		return NULL;
> +
>  	seqs = (void **)malloc(seqlen * sizeof(void *));
> +	if (!seqs) {
> +		free(seqDTDs);
> +		return NULL;
> +	}
> +

Remove the casting while at it.

> @@ -2350,10 +2394,19 @@ int sdp_set_lang_attr(sdp_record_t *rec, const sdp_list_t *seq)
>  {
>  	uint8_t uint16 = SDP_UINT16;
>  	int status = 0, i = 0, seqlen = sdp_list_len(seq);
> -	void **dtds = (void **)malloc(3 * seqlen * sizeof(void *));
> -	void **values = (void **)malloc(3 * seqlen * sizeof(void *));
> +	void **dtds, **values;
>  	const sdp_list_t *p;
>  
> +	dtds = (void **)malloc(3 * seqlen * sizeof(void *));
> +	if (!dtds)
> +		return -1;
> +
> +	values = (void **)malloc(3 * seqlen * sizeof(void *));
> +	if (!values) {
> +		free(dtds);
> +		return -1;
> +	}
> +

Don't re-introduce this casting. It is pointless.

Regards

Marcel


