Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
References: <1418995940-16166-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1418995940-16166-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH] tools/bccmd: Remove dead code
Date: Wed, 07 Jan 2015 15:24:34 +0530
Message-id: <001401d02a5f$f4248c40$dc6da4c0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Friday, December 19, 2014 7:02 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: d.kasatkin@samsung.com; bharat.panda@samsung.com;
> cpgs@samsung.com; Gowtham Anandha Babu
> Subject: [PATCH] tools/bccmd: Remove dead code
> 
> warning: Value stored to 'handle' is never read
>         handle = array[0] | (array[1] << 8);
>         ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~
> ---
>  tools/bccmd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/bccmd.c b/tools/bccmd.c index 4649ad5..2646660 100644
> --- a/tools/bccmd.c
> +++ b/tools/bccmd.c
> @@ -279,7 +279,6 @@ static int cmd_keylen(int transport, int argc, char
> *argv[])
>  	if (err < 0)
>  		return -1;
> 
> -	handle = array[0] | (array[1] << 8);
>  	keylen = array[2] | (array[3] << 8);
> 
>  	printf("Crypt key length: %d bit\n", keylen * 8);
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

