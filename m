Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] android/handsfree: Check service class is not zero
Date: Thu, 17 Apr 2014 14:54:35 +0200
Message-ID: <2086828.EMa9AY2hXh@uw000953>
In-Reply-To: <1397737431-6101-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1397737431-6101-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 17 of April 2014 15:23:45 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fixes static analyzers NULL dereference warnings. The similar check is
> done in src/device.c in line 2959.
> ---
>  android/handsfree.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index 02b6dad..c8026a0 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -1405,6 +1405,9 @@ static void sdp_hsp_search_cb(sdp_list_t *recs, int err, gpointer data)
>  		goto fail;
>  	}
>  
> +	if (!classes)
> +		goto fail;
> +

This is already checked :
	if (sdp_get_service_classes(recs->data, &classes) < 0 || !classes) {
		error("handsfree: unable to get service classes from record");
		goto fail;
	}

What kind of warning do you get from static analyzer?

>  	if (sdp_get_access_protos(recs->data, &protos) < 0) {
>  		error("handsfree: unable to get access protocols from record");
>  		sdp_list_free(classes, free);
> @@ -1495,6 +1498,9 @@ static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
>  		goto fail;
>  	}
>  
> +	if (!classes)
> +		goto fail;
> +

Ditto.

>  	if (sdp_get_access_protos(recs->data, &protos) < 0) {
>  		error("handsfree: unable to get access protocols from record");
>  		sdp_list_free(classes, free);
> 

-- 
Best regards, 
Szymon Janc
