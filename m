Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
References: <1421229458-11207-1-git-send-email-gowtham.ab@samsung.com>
 <1421229458-11207-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1421229458-11207-4-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH  3/3] tools/hciattach_ath3k: Remove dead code warnings
Date: Tue, 20 Jan 2015 15:05:33 +0530
Message-id: <001501d03494$7a6be580$6f43b080$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Wednesday, January 14, 2015 3:28 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
> Babu
> Subject: [PATCH 3/3] tools/hciattach_ath3k: Remove dead code warnings
> 
> tools/hciattach_ath3k.c:848:3: warning: Value stored to 'err' is never
read
>                 err = 0;
>                 ^     ~
> tools/hciattach_ath3k.c:852:3: warning: Value stored to 'err' is never
read
>                 err = 0;
>                 ^     ~
> ---
>  tools/hciattach_ath3k.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c index
> 23208c6..d31732e 100644
> --- a/tools/hciattach_ath3k.c
> +++ b/tools/hciattach_ath3k.c
> @@ -840,17 +840,8 @@ static int ath_ps_download(int fd)
>  		goto download_cmplete;
>  	}
> 
> -	/*
> -	 * It is not necessary that Patch file be available,
> -	 * continue with PS Operations if patch file is not available.
> -	 */
> -	if (patch_file[0] == '\0')
> -		err = 0;
> -
>  	stream = fopen(patch_file, "r");
> -	if (!stream)
> -		err = 0;
> -	else {
> +	if(stream) {
>  		patch_count = ps_patch_download(fd, stream);
>  		fclose(stream);
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

