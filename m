Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1167713436.30886.22.camel@violet>
References: <elmo11674783871759394055518@atlantide>
	<1167713436.30886.22.camel@violet>
Content-Type: multipart/mixed; boundary="=-O0E2OUDwt/n+dFFUeSwe"
Date: Tue, 02 Jan 2007 06:17:31 +0100
Message-Id: <1167715051.30886.25.camel@violet>
Mime-Version: 1.0
Cc: mrkiko.rs@gmail.com
Subject: Re: [Bluez-devel] A bug in the bluetooth stack?
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


--=-O0E2OUDwt/n+dFFUeSwe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

> I can reproduce this issue with a 2.6.20-rc3 kernel running on my G5:
> 
> add_conn: Failed to register connection device
> Unable to handle kernel paging request for data at address 0x00000020
> Faulting instruction address: 0xc0000000002877d8
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=4 
> Modules linked in: hci_usb binfmt_misc rfcomm hidp l2cap bluetooth ipv6 cpufreq_stats usbhid hid fuse ide_cd cdrom snd_aoa_codec_onyx snd_aoa_fabric_layout snd_aoa snd_aoa_i2sbus snd_aoa_soundbus snd_pcm snd_page_alloc snd_timer bcm43xx snd ieee80211softmac ieee80211 ohci_hcd ieee80211_crypt ehci_hcd evdev ide_core soundcore tg3 firmware_class ata_generic pmac_zilog serial_core usbcore
> NIP: C0000000002877D8 LR: C0000000001B7380 CTR: C0000000001B7344
> REGS: c00000003ff07940 TRAP: 0300   Not tainted  (2.6.20-rc3)
> MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 28000028  XER: 000FFFFF
> DAR: 0000000000000020, DSISR: 0000000040000000
> TASK = c0000000018cc040[17] 'events/3' THREAD: c00000003ff04000 CPU: 3
> GPR00: C0000000001B7380 C00000003FF07BC0 C0000000003D1F50 0000000000000000 
> GPR04: 0000000000000001 0000000000000001 0000000028000022 0000000000F12E00 
> GPR08: C00000003FF07EB0 0000000000000001 C000000001981FB0 C0000000001B7344 
> GPR12: D000000000402360 C00000000034BC80 0000000000000000 C0000000002C6F78 
> GPR16: 4000000001400000 C0000000002C5A98 0000000000000000 0000000000000000 
> GPR20: C00000000033BCA8 000000000173BCA8 C00000000033BF18 000000000173BF18 
> GPR24: 0000000000241AC0 0000000000000000 C00000003FF04000 C000000001981F80 
> GPR28: C00000003823FD10 0000000000000000 C000000000386668 C00000003823FCE8 
> NIP [C0000000002877D8] .klist_del+0x24/0xb4
> LR [C0000000001B7380] .device_del+0x3c/0x278
> Call Trace:
> [C00000003FF07BC0] [C0000000018CC040] 0xc0000000018cc040 (unreliable)
> [C00000003FF07C50] [C0000000001B7380] .device_del+0x3c/0x278
> [C00000003FF07CE0] [D000000000400820] .del_conn+0x14/0x28 [bluetooth]
> [C00000003FF07D60] [C000000000058560] .run_workqueue+0xec/0x1d4
> [C00000003FF07E00] [C000000000059198] .worker_thread+0x15c/0x1b4
> [C00000003FF07EE0] [C00000000005DE88] .kthread+0x11c/0x16c
> [C00000003FF07F90] [C0000000000210EC] .kernel_thread+0x4c/0x68
> Instruction dump:
> eba1ffe8 7c0803a6 4e800020 7c0802a6 fb81ffe0 fba1ffe8 fbe1fff8 7c7c1b78 
> f8010010 f821ff71 eba30000 7fa3eb78 <ebfd0020> 4800386d 60000000 7f83e378 
> 
> The problem is that the add_conn call fails for some strange reasons. I
> have no idea why, because it actually shouldn't. Even if it fails, it
> shouldn't kill the kernel on del_conn.

I am still unsure why the device_add operation fails, but the attached
patch fixes the case where the device_del produces the kernel oops.

Regards

Marcel


--=-O0E2OUDwt/n+dFFUeSwe
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index d4c9356..801d687 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -242,7 +242,7 @@ static void add_conn(struct work_struct 
 	struct hci_conn *conn = container_of(work, struct hci_conn, work);
 	int i;
 
-	if (device_register(&conn->dev) < 0) {
+	if (device_add(&conn->dev) < 0) {
 		BT_ERR("Failed to register connection device");
 		return;
 	}
@@ -272,6 +272,8 @@ void hci_conn_add_sysfs(struct hci_conn 
 
 	dev_set_drvdata(&conn->dev, conn);
 
+	device_initialize(&conn->dev);
+
 	INIT_WORK(&conn->work, add_conn);
 
 	schedule_work(&conn->work);
@@ -287,6 +289,9 @@ void hci_conn_del_sysfs(struct hci_conn 
 {
 	BT_DBG("conn %p", conn);
 
+	if (!device_is_registered(&conn->dev))
+		return;
+
 	INIT_WORK(&conn->work, del_conn);
 
 	schedule_work(&conn->work);

--=-O0E2OUDwt/n+dFFUeSwe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-O0E2OUDwt/n+dFFUeSwe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-O0E2OUDwt/n+dFFUeSwe--
