Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] SDP patch to add support for HDP
From: Marcel Holtmann <marcel@holtmann.org>
To: jcaden@libresoft.es
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200912111021.18521.jcaden@libresoft.es>
References: <200911131343.21326.jcaden@libresoft.es>
	 <200912101150.15707.jcaden@libresoft.es> <1260482355.2901.67.camel@violet>
	 <200912111021.18521.jcaden@libresoft.es>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Dec 2009 19:32:30 +0100
Message-ID: <1260556350.2901.74.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

> > > diff --git a/lib/sdp.c b/lib/sdp.c
> > > index 822ec1a..ddf2d1a 100644
> > > --- a/lib/sdp.c
> > > +++ b/lib/sdp.c
> > > @@ -4621,3 +4621,113 @@ uint16_t sdp_gen_tid(sdp_session_t *session)
> > >  {
> > >  	return session->tid++;
> > >  }
> > > +
> > > +/*
> > > + * Set the supported features
> > > + */
> > > +int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
> > > +{
> > > +	const sdp_list_t *p, *r;
> > > +	sdp_data_t *feat, *seq_feat;
> > > +	int seqlen, i, err;
> > > +	void **seqDTDs, **seqVals;
> > > +
> > > +	err = -1;
> >
> > what is this err = -1 business. That is pointless. See below.
> 
> I use this err variable because i need to distinguish between the error and no 
> error cases. I explained better below.
> 
> >
> > > +	i = 0;
> >
> > Move this to the place where it is actually used.
> >
> > > +	seqlen = sdp_list_len(sf);
> > > +	seqDTDs = malloc(seqlen * sizeof(void *));
> > > +	if (!seqDTDs)
> > > +		return err;
> >
> > This is return -1;
> >
> > > +	seqVals = malloc(seqlen * sizeof(void *));
> > > +	if (!seqVals) {
> > > +		free(seqDTDs);
> > > +		return err;
> >
> > And this, too. Just use return -1;
> >
> > > +	}
> > > +
> > > +	for (p = sf; p; p = p->next) {
> > > +		int plen, j;
> > > +		void **dtds, **vals;
> > > +
> > > +		plen = sdp_list_len(p->data);
> > > +		dtds = malloc(plen * sizeof(void *));
> > > +		if (!dtds)
> > > +			goto set_sup_feat_exit;
> > > +		vals = malloc(plen * sizeof(void *));
> > > +		if (!vals) {
> > > +			free(dtds);
> > > +			goto set_sup_feat_exit;
> > > +		}
> > > +		j = 0;
> > > +		for (r = p->data; r; r = r->next) {
> > > +			sdp_data_t *data = (sdp_data_t*)r->data;
> > > +			dtds[j] = &data->dtd;
> > > +			vals[j] = &data->val;
> > > +			j++;
> > > +		}
> > > +		feat = sdp_seq_alloc(dtds, vals, plen);
> > > +		free(dtds);
> > > +		free(vals);
> > > +		if (!feat)
> > > +			goto set_sup_feat_exit;
> > > +		seqDTDs[i] = &feat->dtd;
> > > +		seqVals[i] = feat;
> > > +		i++;
> > > +	}
> > > +	seq_feat = sdp_seq_alloc(seqDTDs, seqVals, seqlen);
> > > +	if (!seq_feat)
> > > +		goto set_sup_feat_exit;
> > > +	sdp_attr_replace(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST, seq_feat);
> > > +
> > > +	err = 0;
> >
> > Replace this with return 0;
> >
> > > +
> > > +set_sup_feat_exit:
> >
> > Call this label "fail" to be consistent across the code.
> 
> This part should be executed on error and on no error, because seqVals and 
> seqDTDs must be freed in all the cases. Because of that I called it exit: 
> instead of fail.  May be it is better to repeat this two statements (I mean 
> free statements) in order to keep readability and use return as you suggested, 
> without any variable.

I see your point here. However this doesn't make the code more readable.
It actually does complicates the flow through it. A simple goto fail and
return -1 is easier to understand then trying to remember the err value
across such a complex function.

So just after sdp_attr_replace duplicated the two free calls and then
return 0. And the label as a pure failure case. While you have two extra
free calls, you have on less variable and a lot simple code path here.

Remember that if the code makes my brain hurt, it is too complex ;)

Regards

Marcel


