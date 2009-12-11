Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?= <jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] SDP patch to add support for HDP
Date: Fri, 11 Dec 2009 10:21:18 +0100
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200911131343.21326.jcaden@libresoft.es> <200912101150.15707.jcaden@libresoft.es> <1260482355.2901.67.camel@violet>
In-Reply-To: <1260482355.2901.67.camel@violet>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912111021.18521.jcaden@libresoft.es>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

El Thursday 10 December 2009 22:59:15 Marcel Holtmann escribi=F3:
> Hi Jose,
>
> > diff --git a/lib/sdp.c b/lib/sdp.c
> > index 822ec1a..ddf2d1a 100644
> > --- a/lib/sdp.c
> > +++ b/lib/sdp.c
> > @@ -4621,3 +4621,113 @@ uint16_t sdp_gen_tid(sdp_session_t *session)
> >  {
> >  	return session->tid++;
> >  }
> > +
> > +/*
> > + * Set the supported features
> > + */
> > +int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
> > +{
> > +	const sdp_list_t *p, *r;
> > +	sdp_data_t *feat, *seq_feat;
> > +	int seqlen, i, err;
> > +	void **seqDTDs, **seqVals;
> > +
> > +	err =3D -1;
>
> what is this err =3D -1 business. That is pointless. See below.

I use this err variable because i need to distinguish between the error and=
 no=20
error cases. I explained better below.

>
> > +	i =3D 0;
>
> Move this to the place where it is actually used.
>
> > +	seqlen =3D sdp_list_len(sf);
> > +	seqDTDs =3D malloc(seqlen * sizeof(void *));
> > +	if (!seqDTDs)
> > +		return err;
>
> This is return -1;
>
> > +	seqVals =3D malloc(seqlen * sizeof(void *));
> > +	if (!seqVals) {
> > +		free(seqDTDs);
> > +		return err;
>
> And this, too. Just use return -1;
>
> > +	}
> > +
> > +	for (p =3D sf; p; p =3D p->next) {
> > +		int plen, j;
> > +		void **dtds, **vals;
> > +
> > +		plen =3D sdp_list_len(p->data);
> > +		dtds =3D malloc(plen * sizeof(void *));
> > +		if (!dtds)
> > +			goto set_sup_feat_exit;
> > +		vals =3D malloc(plen * sizeof(void *));
> > +		if (!vals) {
> > +			free(dtds);
> > +			goto set_sup_feat_exit;
> > +		}
> > +		j =3D 0;
> > +		for (r =3D p->data; r; r =3D r->next) {
> > +			sdp_data_t *data =3D (sdp_data_t*)r->data;
> > +			dtds[j] =3D &data->dtd;
> > +			vals[j] =3D &data->val;
> > +			j++;
> > +		}
> > +		feat =3D sdp_seq_alloc(dtds, vals, plen);
> > +		free(dtds);
> > +		free(vals);
> > +		if (!feat)
> > +			goto set_sup_feat_exit;
> > +		seqDTDs[i] =3D &feat->dtd;
> > +		seqVals[i] =3D feat;
> > +		i++;
> > +	}
> > +	seq_feat =3D sdp_seq_alloc(seqDTDs, seqVals, seqlen);
> > +	if (!seq_feat)
> > +		goto set_sup_feat_exit;
> > +	sdp_attr_replace(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST, seq_feat);
> > +
> > +	err =3D 0;
>
> Replace this with return 0;
>
> > +
> > +set_sup_feat_exit:
>
> Call this label "fail" to be consistent across the code.

This part should be executed on error and on no error, because seqVals and=
=20
seqDTDs must be freed in all the cases. Because of that I called it exit:=20
instead of fail.  May be it is better to repeat this two statements (I mean=
=20
free statements) in order to keep readability and use return as you suggest=
ed,=20
without any variable.

>
> > +	free(seqVals);
> > +	free(seqDTDs);
> > +	return err;
>
> This needs to be return -1;
>
> And then remove the whole err variable since I don't see it used
> anywhere.
>
> > +}
> > +
> > +/*
> > + * Get the supported features
> > + * If an error occurred -1 is returned and errno is set
> > + */
> > +int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp)
> > +{
> > +	sdp_data_t * sdpdata, *d;
> > +	sdp_list_t * next;
>
> Who said we declare variable like this. It is sdp_list_t *next. No extra
> space between * and the variable name.
>
> > +	*seqp =3D NULL;
>
> This is pretty much a bad idea. So in case this functions fails you
> should not touch *seqp at all. It is not your pointer in the end.
>
> I would prefer if you use a temporary pointer and only assign it on
> success.
>
> > +	sdpdata =3D sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);
> > +
> > +	if (!sdpdata || sdpdata->dtd < SDP_SEQ8 || sdpdata->dtd > SDP_SEQ32)
> > +		return sdp_get_uuidseq_attr(rec,
> > +				     SDP_ATTR_SUPPORTED_FEATURES_LIST, seqp);
> > +
> > +	for (d =3D sdpdata->val.dataseq; d; d =3D d->next) {
> > +		sdp_data_t *dd;
> > +		sdp_list_t *subseq;
> > +		subseq =3D NULL;
> > +		if (d->dtd < SDP_SEQ8 || d->dtd > SDP_SEQ32)
> > +			goto fail;
>
> Move the subseq after the if check.
>
> > +		for (dd =3D d->val.dataseq; dd; dd =3D dd->next) {
> > +			sdp_data_t *data;
> > +			if (dd->dtd !=3D SDP_UINT8 && dd->dtd !=3D SDP_UINT16 &&
> > +						dd->dtd !=3D SDP_TEXT_STR8)
> > +				goto fail;
> > +			data =3D sdp_data_alloc(dd->dtd, &dd->val);
> > +			if (data)
> > +				subseq =3D sdp_list_append(subseq, data);
> > +		}
> > +		*seqp =3D sdp_list_append(*seqp, subseq);
> > +	}
> > +	return 0;
> > +
> > +fail:
> > +	while (*seqp) {
> > +		next =3D (*seqp)->next;
>
> The next variable could be declared inside the while loop actually.
>
> > +		sdp_list_free(*seqp, free);
> > +		*seqp =3D next;
> > +	}
> > +	errno =3D EINVAL;
> > +	return -1;
> > +}
>
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
