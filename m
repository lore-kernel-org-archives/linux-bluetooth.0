Return-Path: <cyrus@holtmann.org>
Message-ID: <1357615542.1806.22.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/5] lib: Add SDP_IS_TEXT_STR() macro for
 SDP_TEXT_STR* checking
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 07 Jan 2013 19:25:42 -0800
In-Reply-To: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> This new macro avoids constructs like "if (d->dtd < SDP_TEXT_STR8 ||
> d->dtd > SDP_TEXT_STR32)" which are harder to read.
> ---
>  lib/sdp.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/sdp.h b/lib/sdp.h
> index 4448805..42681a2 100644
> --- a/lib/sdp.h
> +++ b/lib/sdp.h
> @@ -440,6 +440,8 @@ typedef struct {
>  
>  #define SDP_IS_UUID(x) ((x) == SDP_UUID16 || (x) == SDP_UUID32 || (x) ==SDP_UUID128)
>  #define SDP_IS_SEQ(x)  ((x) == SDP_SEQ8 || (x) == SDP_SEQ16 || (x) == SDP_SEQ32)
> +#define SDP_IS_TEXT_STR(x) ((x) == SDP_TEXT_STR8 || (x) == SDP_TEXT_STR16 || \
> +							(x) == SDP_TEXT_STR32)

can someone please explain to me why we are extending the library. I
thought I made it clear that it is mostly end of life and we are not
adding new features. However some people keep adding stuff.

Regards

Marcel


