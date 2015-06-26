Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: hci_ldisc: backport changes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1435342414-21061-1-git-send-email-fgrandel@gmail.com>
Date: Fri, 26 Jun 2015 20:30:15 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C64B93E8-D2FE-421F-B2D7-87A9C6AC22BA@holtmann.org>
References: <1435342414-21061-1-git-send-email-fgrandel@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

> The references to tty->termios in hci_ldisc were not backports
> compatible. Introducing #define statements to make this file compile
> against earlier kernel versions.
> 
> Signed-off-by: Florian Grandel <fgrandel@gmail.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 19 ++++++++++++++++++-
> 1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 177dd69..14d08b1 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -24,6 +24,7 @@
>  */
> 
> #include <linux/module.h>
> +#include <linux/version.h>
> 
> #include <linux/kernel.h>
> #include <linux/init.h>
> @@ -277,7 +278,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> 
> 	if (enable) {
> 		/* Disable hardware flow control */
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
> 		ktermios = tty->termios;
> +#else
> +		ktermios = *tty->termios;
> +#endif

such a patch is not acceptable upstream. This is something that the backports projects has to keep out-of-tree.

Regards

Marcel

