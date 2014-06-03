Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v5 3/5] Bluetooth: 6LoWPAN: Create a kernel module
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401721227-28439-4-git-send-email-jukka.rissanen@linux.intel.com>
Date: Tue, 3 Jun 2014 05:57:46 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4D3EAA53-5380-46B9-8EBC-EE52C8CE15B5@holtmann.org>
References: <1401721227-28439-1-git-send-email-jukka.rissanen@linux.intel.com> <1401721227-28439-4-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Instead of adding the 6LoWPAN functionality to Bluetooth module,
> we create a separate kernel module for it.
> 
> Usage:
> 
> In the slave side do this:
> 
> $ modprobe bluetooth_6lowpan
> $ echo 62 > /sys/kernel/debug/bluetooth/6lowpan_psm
> $ hciconfig hci0 leadv
> 
> In the master side do this:
> 
> $ modprobe bluetooth_6lowpan
> $ echo 62 > /sys/kernel/debug/bluetooth/6lowpan_psm
> $ echo 'connect E0:06:E6:B7:2A:73 1' > \
>                  /sys/kernel/debug/bluetooth/6lowpan_control
> 
> The 6LoWPAN functionality can be controlled by psm value. If it
> is left to 0, then the module is disabled and all the 6LoWPAN
> connections are dropped if there were any. In the above example,
> the psm value is just an example and not a real value for
> 6LoWPAN service. The real psm value is yet to be defined in
> Bluetooth specification.
> 
> The 6lowpan controlling interface is a temporary solution
> until the specifications are ready.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> net/bluetooth/6lowpan.c | 11 ++++++++++-
> net/bluetooth/Kconfig   |  6 +++---
> net/bluetooth/Makefile  |  4 +++-
> 3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index d197bbe..debf003 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -14,6 +14,7 @@
> #include <linux/if_arp.h>
> #include <linux/netdevice.h>
> #include <linux/etherdevice.h>
> +#include <linux/module.h>
> #include <linux/debugfs.h>
> 
> #include <net/ipv6.h>
> @@ -1231,7 +1232,7 @@ static int __init bt_6lowpan_init(void)
> 	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
> }
> 
> -void bt_6lowpan_cleanup(void)
> +static void __exit bt_6lowpan_cleanup(void)
> {
> 	cleanup_6lowpan();
> 
> @@ -1239,3 +1240,11 @@ void bt_6lowpan_cleanup(void)
> 
> 	unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
> }
> +
> +module_init(bt_6lowpan_init);
> +module_exit(bt_6lowpan_cleanup);

I prefer if we call it bt_6lowpan_exit here or you fix this up in the previous patch.

> +
> +MODULE_AUTHOR("Jukka Rissanen <jukka.rissanen@linux.intel.com>");
> +MODULE_DESCRIPTION("Bluetooth 6LoWPAN");
> +MODULE_VERSION(VERSION);
> +MODULE_LICENSE("GPL");

Regards

Marcel

