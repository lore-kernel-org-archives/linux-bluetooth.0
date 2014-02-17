Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: allocate static minor for vhci
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392649945-2338-1-git-send-email-lucas.demarchi@intel.com>
Date: Mon, 17 Feb 2014 08:34:32 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Message-Id: <6D43DF5A-CFA0-4867-8518-ECDA167BDB71@holtmann.org>
References: <1392649945-2338-1-git-send-email-lucas.demarchi@intel.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> Commit bfacbb9 (Bluetooth: Use devname:vhci module alias for virtual HCI
> driver) added the module alias to hci_vhci module so it's possible to
> create the /dev/vhci node. However creating an alias without
> specifying the minor doesn't allow us to create the node ahead,
> triggerring module auto-load when it's first accessed.
> 
> Starting with depmod from kmod 16 we started to warn if there's a
> devname alias without specifying the major and minor.
> 
> Let's do the same done for uhid, kvm, fuse and others, specifying a
> fixed minor. In systems with systemd as the init the following will
> happen: on early boot systemd will call "kmod static-nodes" to read
> /lib/modules/$(uname -r)/modules.devname and then create the nodes. When
> first accessed these "dead" nodes will trigger the module loading.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 3 ++-
> include/linux/miscdevice.h   | 1 +
> 2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 1ef6990..add1c6a 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -359,7 +359,7 @@ static const struct file_operations vhci_fops = {
> static struct miscdevice vhci_miscdev= {
> 	.name	= "vhci",
> 	.fops	= &vhci_fops,
> -	.minor	= MISC_DYNAMIC_MINOR,
> +	.minor	= VHCI_MINOR,
> };
> 
> static int __init vhci_init(void)
> @@ -385,3 +385,4 @@ MODULE_DESCRIPTION("Bluetooth virtual HCI driver ver " VERSION);
> MODULE_VERSION(VERSION);
> MODULE_LICENSE("GPL");
> MODULE_ALIAS("devname:vhci");
> +MODULE_ALIAS_MISCDEV(VHCI_MINOR);
> diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> index 3737f72..846a317 100644
> --- a/include/linux/miscdevice.h
> +++ b/include/linux/miscdevice.h
> @@ -48,6 +48,7 @@
> #define LOOP_CTRL_MINOR		237
> #define VHOST_NET_MINOR		238
> #define UHID_MINOR		239
> +#define VHCI_MINOR		240
> #define MISC_DYNAMIC_MINOR	255

you have read Documentation/devices.txt where it states that 240-254 is reserved for local use.

Regards

Marcel

