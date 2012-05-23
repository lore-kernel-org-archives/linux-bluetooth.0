Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 May 2012 17:26:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 5/5] media-api: Update documentation to include
 Volume property
Message-ID: <20120523142642.GB19662@x220.P-661HNU-F1>
References: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
 <1337695255-9197-5-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337695255-9197-5-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, May 22, 2012, Luiz Augusto von Dentz wrote:
> ---
>  doc/media-api.txt |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index 7a593c3..20772f0 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -341,3 +341,11 @@ Properties	object Device [readonly]
>  			Optional. Indicates where is the transport being routed
>  
>  			Possible Values: "HCI" or "PCM"
> +
> +		byte Volume [readwrite]
> +
> +			Optional. Indicates volume level of the transport,
> +			this property is only writeable when the transport was
> +			acquired by the sender.
> +
> +			Possible Values: 0-127

I'm not sure if byte is best here. I'd rather have this as an unsigned
value (the code itself looks strange too with you having to switch to
int8_t from uint8_t). Since there's no one byte unsigned D-Bus parameter
I suppose we should use uint16.

Johan
