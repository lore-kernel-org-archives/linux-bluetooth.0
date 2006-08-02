Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Milind Dumbare <milind@linsyssoft.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1154525531.3905.45.camel@aeonflux.holtmann.net>
References: <1154441823.5306.13.camel@Shadowfox.linsyssoft.com>
	<d23110170608011015h3bef584cn65a7d24fc73ec931@mail.gmail.com>
	<1154499074.2302.2.camel@Shadowfox.linsyssoft.com>
	<1154514862.3905.40.camel@aeonflux.holtmann.net>
	<1154508670.2302.10.camel@Shadowfox.linsyssoft.com>
	<1154525531.3905.45.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed; boundary="=-FercR4Xpp8M4GYXztb9e"
Date: Wed, 02 Aug 2006 19:51:59 +0530
Message-Id: <1154528519.2302.22.camel@shadowfox.linsyssoft.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Reboot notifier
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-FercR4Xpp8M4GYXztb9e
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcel,
	I have attached patch for reboot notifier. Any suggestions are
appreciated.

Thanks 
On Wed, 2006-08-02 at 15:32 +0200, Marcel Holtmann wrote:
> Hi Milind,
> 
> > The first most useful think is doing module cleanup while rebooting.
> > About other things, you will know them more deeply. May be like keeping
> > informing user level utilities to do some interesting stuff like.
> > Keeping connection settings live post reboot or other.
> 
> there is no need for a module cleanup. And unloading of kernel modules
> still has to be considered as a race condition.
> 
> Once you reset the USB bus for example all USB Bluetooth dongles will
> disconnect and be powered off and all connections will go away anyway.
> There is no real chance to keep connections over reboot.
> 
> So I don't see any need for this, but feel free to send in patches for
> it and convince me otherwise.
> 
> Regards
> 
> Marcel
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
-- 
-Milind
"There is no place like 127.0.0.1"

--=-FercR4Xpp8M4GYXztb9e
Content-Disposition: attachment; filename=blue_reboot.patch
Content-Type: text/x-patch; name=blue_reboot.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Singed Off: Milind Dumbare <milind@linsyssoft.com>

 hci_usb.c |   32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

Index: linux-2.6.15-pre3/drivers/bluetooth/hci_usb.c
===================================================================
--- linux-2.6.15-pre3.orig/drivers/bluetooth/hci_usb.c	2006-08-02 08:44:42.000000000 -0500
+++ linux-2.6.15-pre3/drivers/bluetooth/hci_usb.c	2006-08-02 09:15:22.000000000 -0500
@@ -46,6 +46,9 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/skbuff.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+
 
 #include <linux/usb.h>
 
@@ -133,6 +136,13 @@
 	{ }	/* Terminating entry */
 };
 
+static int hci_usb_notify_reboot(struct notifier_block *this,
+		unsigned long code ,void *x);
+
+static struct notifier_block hci_usb_reboot_notifier = {
+		.notifier_call  = hci_usb_notify_reboot,
+	};
+
 static struct _urb *_urb_alloc(int isoc, gfp_t gfp)
 {
 	struct _urb *_urb = kmalloc(sizeof(struct _urb) +
@@ -1053,10 +1063,15 @@
 
 static int __init hci_usb_init(void)
 {
-	int err;
+	int err, ret;
 
 	BT_INFO("HCI USB driver ver %s", VERSION);
 
+	ret = register_reboot_notifier(&hci_usb_reboot_notifier);
+	if(ret) 
+		BT_ERR("Could not register to reboot notifier list");
+	
+		
 	if ((err = usb_register(&hci_usb_driver)) < 0)
 		BT_ERR("Failed to register HCI USB driver");
 
@@ -1068,6 +1083,21 @@
 	usb_deregister(&hci_usb_driver);
 }
 
+static int hci_usb_notify_reboot(struct notifier_block *this,
+		unsigned long event ,void *unused)
+{
+		switch(event) {
+			/*FIXME*/
+		case SYS_RESTART:
+		case SYS_HALT:
+		case SYS_POWER_OFF:
+		default:
+			hci_usb_exit();
+		break;
+		}
+
+		return NOTIFY_DONE;
+}
 module_init(hci_usb_init);
 module_exit(hci_usb_exit);
 

--=-FercR4Xpp8M4GYXztb9e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-FercR4Xpp8M4GYXztb9e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-FercR4Xpp8M4GYXztb9e--
