Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/handsfree: Check service class is not zero
Date: Thu, 27 Mar 2014 21:48:50 +0100
Message-ID: <2072967.UJTOv3NnB9@athlon>
In-Reply-To: <1394713917-21428-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394713917-21428-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 13 March 2014 14:31:57 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fixes static analyzers NULL dereference warnings. The similar check is
> done in src/device.c in line 2959.
> ---
>  android/handsfree.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index b71c28e..7167938 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -1152,6 +1152,9 @@ static void sdp_hsp_search_cb(sdp_list_t *recs, int
> err, gpointer data) goto fail;
>  	}
> 
> +	if (!classes)
> +		goto fail;
> +
>  	if (sdp_get_access_protos(recs->data, &protos) < 0) {
>  		error("handsfree: unable to get access protocols from record");
>  		sdp_list_free(classes, free);
> @@ -1242,6 +1245,9 @@ static void sdp_hfp_search_cb(sdp_list_t *recs, int
> err, gpointer data) goto fail;
>  	}
> 
> +	if (!classes)
> +		goto fail;
> +
>  	if (sdp_get_access_protos(recs->data, &protos) < 0) {
>  		error("handsfree: unable to get access protocols from record");
>  		sdp_list_free(classes, free);

Applied with some modifications so that we log error in case classes are NULL.
Thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
