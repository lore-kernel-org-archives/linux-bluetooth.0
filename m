Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Jul 2010 10:46:49 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add "hciX" to hciconfig man page
Message-ID: <20100706134649.GA22300@jh-x301>
References: <19504.50180.287560.834476@gargle.gargle.HOWL>
 <1278421242-21854-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1278421242-21854-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jul 06, 2010, Gustavo F. Padovan wrote:
> ---
>  tools/hciconfig.8 |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/tools/hciconfig.8 b/tools/hciconfig.8
> index 13f52c6..35956c4 100644
> --- a/tools/hciconfig.8
> +++ b/tools/hciconfig.8
> @@ -10,6 +10,7 @@ hciconfig \- configure Bluetooth devices
>  .br
>  .B hciconfig
>  .RB [\| \-a \|]
> +.B hciX
>  .RI [\| command
>  .RI [\| "command parameters" \|]\|]

Thanks. The patch is now upstream.

Johan
