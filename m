Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Sep 2014 12:39:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/8] emulator/btdev: Overwrite default feature mask when
 SPP is toggled
Message-ID: <20140903093938.GA23986@t440s.lan>
References: <1409734969-10716-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1409734969-10716-5-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409734969-10716-5-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Sep 03, 2014, Jakub Tyszkowski wrote:
> Without this we cannot test the legacy HID Device reconnection, as L2Cap
> connection is refused when SSP is reported in remote device's features.
> ---
>  emulator/btdev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index 86fd3d9..8aebb8f 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -2332,6 +2332,13 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
>  			goto unsupported;
>  		wspm = data;
>  		btdev->simple_pairing_mode = wspm->mode;
> +
> +		/* set SSP feature mask */
> +		if (wspm->mode)
> +			btdev->features[6] |= 0x08;
> +		else
> +			btdev->features[6] &= ~0x08;
> +

This looks suspicious to me. The only thing that should matter is
whether the host features bit is set on or not. That already looks
correct to me in the btdev_get_host_features() function. I.e. isn't your
problem with some piece of code higher up in the stack that's not
keeping SSP properly disabled? (since what you're now doing is not just
disabling SSP but making it look like SSP was never supported to begin
with as soon as you disable it).

Johan
