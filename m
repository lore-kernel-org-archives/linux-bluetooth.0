Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 May 2012 14:40:16 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v0 03/16] client: Add progress property to transfer
Message-ID: <20120523174016.GA32263@samus>
References: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1337785218-8661-4-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337785218-8661-4-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On 17:00 Wed 23 May, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> The number of transferred bytes is exposed in D-Bus using a specific
> property for this purpose.
> 
> Internally, the value of this property does not necessarily match the
> internal progress counter. In order to avoid D-Bus overhead, the
> property will be updated at least every N bytes, where N is fixed and
> hardcoded (TRANSFER_PROGRESS_PERIOD).
> ---
>  client/transfer.c |   47 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/client/transfer.c b/client/transfer.c
> index 8292265..2c6e1ed 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -44,6 +44,7 @@
>  
>  #define TRANSFER_INTERFACE  "org.openobex.Transfer"
>  #define TRANSFER_BASEPATH   "/org/openobex"
> +#define TRANSFER_PROGRESS_PERIOD (16 * 1024)

Just a detail, but this value is half the value of the default Bluetooth
MTU, right? 

For a future improvement, I think it would be nice to consider a value
related to the MTU.

[snip]

>  
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
