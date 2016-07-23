Return-Path: <johan.hedberg@gmail.com>
Date: Sat, 23 Jul 2016 17:43:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Put led_trigger field behind
 CONFIG_BT_LEDS
Message-ID: <20160723144311.GA15045@t440s.P-661HNU-F1>
References: <1469103161-39260-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469103161-39260-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jul 21, 2016, Marcel Holtmann wrote:
> The led_trigger field in hci_dev should be conditional based on if
> CONFIG_BT_LEDS is set or not.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 2 ++
>  1 file changed, 2 insertions(+)

Both patches have been applied to bluetooth-next. Thanks.

Johan
