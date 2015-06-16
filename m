Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 1/2] Bluetooth: hci_uart: Include vendor headers if required
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434459321-20281-1-git-send-email-chanyeol.park@samsung.com>
Date: Tue, 16 Jun 2015 16:21:45 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <360D4EF5-34F8-476F-B8CF-A5C98F1481D1@holtmann.org>
References: <1434459321-20281-1-git-send-email-chanyeol.park@samsung.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> Vendor specific headers should be included only when enabled because
> hci_uart does not need it always.
> 
> Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index ac87346..231c622 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -45,8 +45,12 @@
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> 
> +#ifdef CONFIG_BT_HCIUART_INTEL
> #include "btintel.h"
> +#endif

empty lines here,

> +#ifdef CONFIG_BT_HCIUART_BCM
> #include "btbcm.h"
> +#endif

And another empty line here.

> #include "hci_uart.h"
> 

However is this really needed? I did not do this since it essentially results into an empty include which will be optimized out. And it just makes the including code more complex.

If we worry about the extra structs, then we can just move them down into the IS_ENABLED section into the header itself. I did not worry since my assumption is that compiler optimizes unused structs.

Regards

Marcel


