Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>
Subject: Re: [PATCH 1/1] Fixes sdp_get_supp_feat function
Date: Fri, 14 May 2010 09:02:23 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <1273806810-29602-1-git-send-email-epx@signove.com>
In-Reply-To: <1273806810-29602-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005140902.23338.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

El Friday 14 May 2010 05:13:30 Elvis Pfützenreuter escribió:
> In case of string data items, value is a pointer by itself.
> ---
>  lib/sdp.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/sdp.c b/lib/sdp.c
> index fb8ccdc..c75a000 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -4801,10 +4801,15 @@ int sdp_get_supp_feat(const sdp_record_t *rec,
> sdp_list_t **seqp) subseq = NULL;
>  		for (dd = d->val.dataseq; dd; dd = dd->next) {
>  			sdp_data_t *data;
> +			void *val;
>  			if (dd->dtd != SDP_UINT8 && dd->dtd != SDP_UINT16 &&
>  						dd->dtd != SDP_TEXT_STR8)
>  				goto fail;
> -			data = sdp_data_alloc(dd->dtd, &dd->val);
> +			if (dd->dtd == SDP_TEXT_STR8)
> +				val = dd->val.str;
> +			else
> +				val = &dd->val;
> +			data = sdp_data_alloc(dd->dtd, val);

No only strings are pointers, if you see this patch:
http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=1d1154156df28660e41031df5c3f1ffe91c01aae

that I sent few days ago for fixing the set function, also sequences are 
pointers and should be treated in a different way. Also strings can be formed 
by other types not only SDP_TEXT_STR8. I think a switch will fix this better.

>  			if (data)
>  				subseq = sdp_list_append(subseq, data);
>  		}

Regards.
