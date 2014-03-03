Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Mar 2014 16:55:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools: Fix using uninitialized value
Message-ID: <20140303145516.GA16395@localhost.P-661HNU-F1>
References: <1393838024-18439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393838024-18439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Mar 03, 2014, Andrei Emeltchenko wrote:
> Fixes warning:
> tools/ibeacon.c:150:14: warning: The left expression of the compound
> assignment is an uninitialized value. The computed value will also be
> garbage
>         cmd.data[2] |= 0x02;            /* LE General Discoverable Mode
> */
>         ~~~~~~~~~~~ ^
> 1 warning generated.
> ---
>  tools/ibeacon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/ibeacon.c b/tools/ibeacon.c
> index 458f9e7..2071c6b 100644
> --- a/tools/ibeacon.c
> +++ b/tools/ibeacon.c
> @@ -147,7 +147,7 @@ static void adv_tx_power_callback(const void *data, uint8_t size,
>  
>  	cmd.data[0] = 0x02;		/* Field length */
>  	cmd.data[1] = 0x01;		/* Flags */
> -	cmd.data[2] |= 0x02;		/* LE General Discoverable Mode */
> +	cmd.data[2] = 0x02;		/* LE General Discoverable Mode */
>  	cmd.data[2] |= 0x04;		/* BR/EDR Not Supported */
>  
>  	cmd.data[3] = 0x1a;		/* Field length */

Applied. Thanks.

Johan
