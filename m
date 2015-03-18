Return-Path: <cyrus@holtmann.org>
Message-ID: <1426682851.3386.21.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add skeleton for 6LoWPAN mgmt command
 handling
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Mar 2015 14:47:31 +0200
In-Reply-To: <1426669840-2933-1-git-send-email-johan.hedberg@gmail.com>
References: <1426669840-2933-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On ke, 2015-03-18 at 11:10 +0200, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch defines a new HCI channel for 6LoWPAN usage and registers a
> command handler table for it in the 6lowpan module.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>

Looks good to me.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


> ---
>  include/net/bluetooth/hci_sock.h |  1 +
>  net/bluetooth/6lowpan.c          | 21 ++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
> index 9a46d665c1b5..6be6120e1bc9 100644
> --- a/include/net/bluetooth/hci_sock.h
> +++ b/include/net/bluetooth/hci_sock.h
> @@ -45,6 +45,7 @@ struct sockaddr_hci {
>  #define HCI_CHANNEL_USER	1
>  #define HCI_CHANNEL_MONITOR	2
>  #define HCI_CHANNEL_CONTROL	3
> +#define HCI_CHANNEL_6LOWPAN	4
>  
>  struct hci_filter {
>  	unsigned long type_mask;
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 1742b849fcff..524218aeea6f 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -25,6 +25,7 @@
>  
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/hci_sock.h>
>  #include <net/bluetooth/l2cap.h>
>  
>  #include <net/6lowpan.h> /* for the compression support */
> @@ -1433,8 +1434,20 @@ static struct notifier_block bt_6lowpan_dev_notifier = {
>  	.notifier_call = device_event,
>  };
>  
> +static const struct hci_mgmt_handler bt_6lowpan_handlers[] = {
> +	{ NULL }, /* 0x0000 (no command) */
> +};
> +
> +static struct hci_mgmt_chan bt_6lowpan_chan = {
> +	.channel	= HCI_CHANNEL_6LOWPAN,
> +	.handler_count	= ARRAY_SIZE(bt_6lowpan_handlers),
> +	.handlers	= bt_6lowpan_handlers,
> +};
> +
>  static int __init bt_6lowpan_init(void)
>  {
> +	int err;
> +
>  	lowpan_enable_debugfs = debugfs_create_file("6lowpan_enable", 0644,
>  						    bt_debugfs, NULL,
>  						    &lowpan_enable_fops);
> @@ -1442,11 +1455,17 @@ static int __init bt_6lowpan_init(void)
>  						     bt_debugfs, NULL,
>  						     &lowpan_control_fops);
>  
> -	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
> +	err = register_netdevice_notifier(&bt_6lowpan_dev_notifier);
> +	if (err)
> +		return err;
> +
> +	return hci_mgmt_chan_register(&bt_6lowpan_chan);
>  }
>  
>  static void __exit bt_6lowpan_exit(void)
>  {
> +	hci_mgmt_chan_unregister(&bt_6lowpan_chan);
> +
>  	debugfs_remove(lowpan_enable_debugfs);
>  	debugfs_remove(lowpan_control_debugfs);
>  


Cheers,
Jukka


