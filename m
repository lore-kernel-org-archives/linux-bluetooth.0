Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: BT3C_CS broken in kernel 2.6.14? [Also with
	2.6.15]
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1136374995.13931.21.camel@localhost>
References: <loom.20051107T122754-207@post.gmane.org>
	 <1131371019.5824.123.camel@blade> <loom.20060104T122021-876@post.gmane.org>
	 <1136374995.13931.21.camel@localhost>
Content-Type: multipart/mixed; boundary="=-45ptFSp2BewaNGcNZ6VA"
Message-Id: <1136375857.13931.23.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 04 Jan 2006 12:57:37 +0100


--=-45ptFSp2BewaNGcNZ6VA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Antti,

> > > remember what the real problem or even the solution was when it came up
> > > on LKML. Try to do some research on LKML by yourself and also check the
> > > latest 2.6.14-git10 kernel.
> > 
> >   I tried now with 2.6.15 - Still not fixed. Can you point me to these LKML 
> > postings? I couldn't find then (tried searching with keywords bt3c, bluetooth 
> > and firmware - the latter two were too broad and the first did not give 
> > anything useful.)
> 
> it must have been something with the atmel_cs and request_firmware(),
> because the atmel_cs and bt3c_cs drivers had the same problem.

and maybe the attached patch helps. I haven't tested it, but it compiles
fine with my latest kernel.

Regards

Marcel


--=-45ptFSp2BewaNGcNZ6VA
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index d2a0add..d6b021b 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -480,18 +480,6 @@ static int bt3c_hci_ioctl(struct hci_dev
 /* ======================== Card services HCI interaction ======================== */
 
 
-static struct device *bt3c_device(void)
-{
-	static struct device dev = {
-		.bus_id = "pcmcia",
-	};
-	kobject_set_name(&dev.kobj, "bt3c");
-	kobject_init(&dev.kobj);
-
-	return &dev;
-}
-
-
 static int bt3c_load_firmware(bt3c_info_t *info, unsigned char *firmware, int count)
 {
 	char *ptr = (char *) firmware;
@@ -580,6 +568,7 @@ static int bt3c_open(bt3c_info_t *info)
 {
 	const struct firmware *firmware;
 	struct hci_dev *hdev;
+	client_handle_t handle;
 	int err;
 
 	spin_lock_init(&(info->lock));
@@ -611,8 +600,10 @@ static int bt3c_open(bt3c_info_t *info)
 
 	hdev->owner = THIS_MODULE;
 
+	handle = info->link.handle;
+
 	/* Load firmware */
-	err = request_firmware(&firmware, "BT3CPCC.bin", bt3c_device());
+	err = request_firmware(&firmware, "BT3CPCC.bin", &handle_to_dev(handle));
 	if (err < 0) {
 		BT_ERR("Firmware request failed");
 		goto error;

--=-45ptFSp2BewaNGcNZ6VA--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
