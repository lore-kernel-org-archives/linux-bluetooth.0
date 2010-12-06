Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1291643777-18851-1-git-send-email-johan.hedberg@gmail.com>
References: <1291643777-18851-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 6 Dec 2010 16:34:49 +0200
Message-ID: <AANLkTin-GeijFDGrkBSBDJkEJmqaindzuJs3k7cN-fdu@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix initial RFCOMM DLC security level
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 6, 2010 at 3:56 PM,  <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@nokia.com>
>
> Due to commit 63ce0900 connections initiated through TTYs created with
> "rfcomm bind ..." would have security level BT_SECURITY_SDP instead of
> BT_SECURITY_LOW. This would cause instant connection failure between any
> two SSP capable devices due to the L2CAP connect request to RFCOMM being
> sent before authentication has been performed. This patch fixes the
> regression by always initializing the DLC security level to
> BT_SECURITY_LOW.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  net/bluetooth/rfcomm/core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index fa642aa..432a9a6 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -311,6 +311,7 @@ static void rfcomm_dlc_clear_state(struct rfcomm_dlc *d)
>        d->state      = BT_OPEN;
>        d->flags      = 0;
>        d->mscex      = 0;
> +       d->sec_level  = BT_SECURITY_LOW;
>        d->mtu        = RFCOMM_DEFAULT_MTU;
>        d->v24_sig    = RFCOMM_V24_RTC | RFCOMM_V24_RTR | RFCOMM_V24_DV;
>

Nice catch, I completely forgot to check if tty initialize sec_level
with anything.

Acked-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

-- 
Luiz Augusto von Dentz
Computer Engineer
