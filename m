Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 7/8] Bluetooth: 6LoWPAN: Create a kernel module
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400837248-12179-8-git-send-email-jukka.rissanen@linux.intel.com>
Date: Sat, 24 May 2014 22:13:30 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3BAD492D-8077-455D-9108-D441C1F65EC7@holtmann.org>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com> <1400837248-12179-8-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Instead of adding the 6LoWPAN functionality to Bluetooth module,
> we create a separate kernel module for it.
> 
> Usage:
> 
> In the client side do this:
> 
> # modprobe bluetooth_6lowpan
> # echo 'psm 62' > /sys/kernel/debug/bluetooth/hci0/6lowpan
> # hciconfig hci0 leadv
> 
> 
> In the server side do this:
> 
> # modprobe bluetooth_6lowpan
> # echo 'psm 62' > /sys/kernel/debug/bluetooth/hci0/6lowpan
> # hcitool lecc E0:06:E6:B7:2A:73
> # echo 'connect E0:06:E6:B7:2A:73 1' > \
>                  /sys/kernel/debug/bluetooth/hci0/6lowpan

since we have connect/disconnect in the 6loWPAN debugfs control file, the lecc should not be needed at all. Actually it should all work like we do with the socket interface. The underlying LE link should be created automatically for us.

Unless we really go for an API where we just configure the addresses that should enable 6loWPAN and then they get auto-connected once we get a connection on the LE link layer. In that case using add/remove seem the more appropriate control commands.

Something you might want to explore and come back with what would make sense for actual use cases.

> The 6LoWPAN functionality can be controlled by psm value. If it
> is left to 0, then the module is disabled and all the 6LoWPAN
> connections are dropped if there were any.
> 
> The 6lowpan controlling interface is a temporary solution
> until the specifications are ready.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> net/bluetooth/6lowpan.c | 13 +++++++++++--
> net/bluetooth/Kconfig   |  6 +++---
> net/bluetooth/Makefile  |  4 +++-
> 3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 46cc298..04e0501 100644
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
> @@ -1223,14 +1224,14 @@ static struct hci_cb lowpan_cb = {
> 	.connect_cfm	= lowpan_connect_hcon,
> };
> 
> -int bt_6lowpan_init(void)
> +static int __init bt_6lowpan_init(void)
> {
> 	hci_register_cb(&lowpan_cb);
> 
> 	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
> }
> 
> -void bt_6lowpan_cleanup(void)
> +static void __exit bt_6lowpan_cleanup(void)
> {
> 	debugfs_remove(lowpan_debugfs);
> 
> @@ -1238,3 +1239,11 @@ void bt_6lowpan_cleanup(void)
> 
> 	unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
> }
> +
> +module_init(bt_6lowpan_init);
> +module_exit(bt_6lowpan_cleanup);
> +
> +MODULE_AUTHOR("Jukka Rissanen <jukka.rissanen@linux.intel.com>");
> +MODULE_DESCRIPTION("Bluetooth LE 6LoWPAN");
> +MODULE_VERSION(VERSION);
> +MODULE_LICENSE("GPL");
> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> index 06ec144..7ef1a5a 100644
> --- a/net/bluetooth/Kconfig
> +++ b/net/bluetooth/Kconfig
> @@ -6,7 +6,6 @@ menuconfig BT
> 	tristate "Bluetooth subsystem support"
> 	depends on NET && !S390
> 	depends on RFKILL || !RFKILL
> -	select 6LOWPAN_IPHC if BT_6LOWPAN
> 	select CRC16
> 	select CRYPTO
> 	select CRYPTO_BLKCIPHER
> @@ -41,10 +40,11 @@ menuconfig BT
> 	  more information, see <http://www.bluez.org/>.
> 
> config BT_6LOWPAN
> -	bool "Bluetooth 6LoWPAN support"
> +	tristate "Bluetooth LE 6LoWPAN support”

Remove the LE bit out of the description. Just Bluetooth 6loWPAN support is good enough.
> 	depends on BT && IPV6
> +	select 6LOWPAN_IPHC if BT_6LOWPAN
> 	help
> -	  IPv6 compression over Bluetooth.
> +	  IPv6 compression over Bluetooth LE.

Here you need to spell our Bluetooth Low Energy.

> 
> source "net/bluetooth/rfcomm/Kconfig"
> 
> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
> index ca51246..886e9aa 100644
> --- a/net/bluetooth/Makefile
> +++ b/net/bluetooth/Makefile
> @@ -7,10 +7,12 @@ obj-$(CONFIG_BT_RFCOMM)	+= rfcomm/
> obj-$(CONFIG_BT_BNEP)	+= bnep/
> obj-$(CONFIG_BT_CMTP)	+= cmtp/
> obj-$(CONFIG_BT_HIDP)	+= hidp/
> +obj-$(CONFIG_BT_6LOWPAN) += bluetooth_6lowpan.o
> +
> +bluetooth_6lowpan-y := 6lowpan.o
> 
> bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
> 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
> 	a2mp.o amp.o
> -bluetooth-$(CONFIG_BT_6LOWPAN) += 6lowpan.o
> 
> subdir-ccflags-y += -D__CHECK_ENDIAN__

Regards

Marcel

