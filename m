Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] SDP patch to add support for HDP
From: Marcel Holtmann <marcel@holtmann.org>
To: jcaden@libresoft.es
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200912101150.15707.jcaden@libresoft.es>
References: <200911131343.21326.jcaden@libresoft.es>
	 <200911171208.13972.jcaden@libresoft.es> <1260030350.3041.25.camel@violet>
	 <200912101150.15707.jcaden@libresoft.es>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Dec 2009 22:59:15 +0100
Message-ID: <1260482355.2901.67.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

> diff --git a/lib/sdp.c b/lib/sdp.c
> index 822ec1a..ddf2d1a 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -4621,3 +4621,113 @@ uint16_t sdp_gen_tid(sdp_session_t *session)
>  {
>  	return session->tid++;
>  }
> +
> +/*
> + * Set the supported features
> + */
> +int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
> +{
> +	const sdp_list_t *p, *r;
> +	sdp_data_t *feat, *seq_feat;
> +	int seqlen, i, err;
> +	void **seqDTDs, **seqVals;
> +
> +	err = -1;

what is this err = -1 business. That is pointless. See below.

> +	i = 0;

Move this to the place where it is actually used.

> +	seqlen = sdp_list_len(sf);
> +	seqDTDs = malloc(seqlen * sizeof(void *));
> +	if (!seqDTDs)
> +		return err;

This is return -1;

> +	seqVals = malloc(seqlen * sizeof(void *));
> +	if (!seqVals) {
> +		free(seqDTDs);
> +		return err;

And this, too. Just use return -1;

> +	}
> +
> +	for (p = sf; p; p = p->next) {
> +		int plen, j;
> +		void **dtds, **vals;
> +
> +		plen = sdp_list_len(p->data);
> +		dtds = malloc(plen * sizeof(void *));
> +		if (!dtds)
> +			goto set_sup_feat_exit;
> +		vals = malloc(plen * sizeof(void *));
> +		if (!vals) {
> +			free(dtds);
> +			goto set_sup_feat_exit;
> +		}
> +		j = 0;
> +		for (r = p->data; r; r = r->next) {
> +			sdp_data_t *data = (sdp_data_t*)r->data;
> +			dtds[j] = &data->dtd;
> +			vals[j] = &data->val;
> +			j++;
> +		}
> +		feat = sdp_seq_alloc(dtds, vals, plen);
> +		free(dtds);
> +		free(vals);
> +		if (!feat)
> +			goto set_sup_feat_exit;
> +		seqDTDs[i] = &feat->dtd;
> +		seqVals[i] = feat;
> +		i++;
> +	}
> +	seq_feat = sdp_seq_alloc(seqDTDs, seqVals, seqlen);
> +	if (!seq_feat)
> +		goto set_sup_feat_exit;
> +	sdp_attr_replace(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST, seq_feat);
> +
> +	err = 0;

Replace this with return 0;

> +
> +set_sup_feat_exit:

Call this label "fail" to be consistent across the code.

> +	free(seqVals);
> +	free(seqDTDs);
> +	return err;

This needs to be return -1;

And then remove the whole err variable since I don't see it used
anywhere.

> +}
> +
> +/*
> + * Get the supported features
> + * If an error occurred -1 is returned and errno is set
> + */
> +int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp)
> +{
> +	sdp_data_t * sdpdata, *d;
> +	sdp_list_t * next;

Who said we declare variable like this. It is sdp_list_t *next. No extra
space between * and the variable name.

> +	*seqp = NULL;

This is pretty much a bad idea. So in case this functions fails you
should not touch *seqp at all. It is not your pointer in the end.

I would prefer if you use a temporary pointer and only assign it on
success.

> +	sdpdata = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);
> +
> +	if (!sdpdata || sdpdata->dtd < SDP_SEQ8 || sdpdata->dtd > SDP_SEQ32)
> +		return sdp_get_uuidseq_attr(rec,
> +				     SDP_ATTR_SUPPORTED_FEATURES_LIST, seqp);
> +
> +	for (d = sdpdata->val.dataseq; d; d = d->next) {
> +		sdp_data_t *dd;
> +		sdp_list_t *subseq;
> +		subseq = NULL;
> +		if (d->dtd < SDP_SEQ8 || d->dtd > SDP_SEQ32)
> +			goto fail;

Move the subseq after the if check.

> +		for (dd = d->val.dataseq; dd; dd = dd->next) {
> +			sdp_data_t *data;
> +			if (dd->dtd != SDP_UINT8 && dd->dtd != SDP_UINT16 &&
> +						dd->dtd != SDP_TEXT_STR8)
> +				goto fail;
> +			data = sdp_data_alloc(dd->dtd, &dd->val);
> +			if (data)
> +				subseq = sdp_list_append(subseq, data);
> +		}
> +		*seqp = sdp_list_append(*seqp, subseq);
> +	}
> +	return 0;
> +
> +fail:
> +	while (*seqp) {
> +		next = (*seqp)->next;

The next variable could be declared inside the while loop actually.

> +		sdp_list_free(*seqp, free);
> +		*seqp = next;
> +	}
> +	errno = EINVAL;
> +	return -1;
> +}

Regards

Marcel


