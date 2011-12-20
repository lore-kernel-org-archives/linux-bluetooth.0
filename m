Return-Path: <cyrus@holtmann.org>
Message-id: <4EF04767.3040306@samsung.com>
Date: Tue, 20 Dec 2011 17:29:27 +0900
From: DoHyun Pyun <dh79.pyun@samsung.com>
MIME-version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] pbap: Fix NULL check rutine
References: <1324366024-19523-1-git-send-email-dh79.pyun@samsung.com>
In-reply-to: <1324366024-19523-1-git-send-email-dh79.pyun@samsung.com>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, All

2011/12/20 16:27, DoHyun Pyun wrote:
> If obj->buffer is NULL, we should exit the function.
> Because the crash will be occured in string_read() function.
>
> THe previous statement returns the error when both obj->buffer and obj->aparams is NULL.
> ---
>   plugins/pbap.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/plugins/pbap.c b/plugins/pbap.c
> index 0f07c46..e642599 100644
> --- a/plugins/pbap.c
> +++ b/plugins/pbap.c
> @@ -996,7 +996,7 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count)
>   	DBG("buffer %p maxlistcount %d", obj->buffer,
>   						pbap->params->maxlistcount);
>
> -	if (!obj->buffer&&  !obj->aparams)
> +	if (!obj->buffer || !obj->aparams)
>   		return -EAGAIN;
>
>   	if (pbap->params->maxlistcount == 0)

I found some problems in this patch, and I will re-write the patch.
So please ignore this patch.

Thanks,
Pyun
