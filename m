Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8Dw6BRN2ao0zugd"
Message-Id: <200501170104.12868.cijoml@volny.cz>
Subject: [Bluez-users] hid2hci error?
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
Date: Mon, 17 Jan 2005 01:04:12 +0100

--Boundary-00=_8Dw6BRN2ao0zugd
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

Vojtech fixed bug in usb and this is our problem he seid.

usb 2-1: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0 ret -84


Michal

--Boundary-00=_8Dw6BRN2ao0zugd
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="hid-disconnect-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hid-disconnect-fix"

ChangeSet@1.1970, 2005-01-11 17:33:17+01:00, vojtech@silver.ucw.cz
  input: Handle -EILSEQ return code in the HID driver completion
         handlers as unplug.
         Flush request queue on unplug, too.
         
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hid-core.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)


diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	2005-01-11 17:34:52 +01:00
+++ b/drivers/usb/input/hid-core.c	2005-01-11 17:34:52 +01:00
@@ -925,8 +925,9 @@
 			break;
 		case -ECONNRESET:	/* unlink */
 		case -ENOENT:
-		case -ESHUTDOWN:
 		case -EPERM:
+		case -ESHUTDOWN:	/* unplug */
+		case -EILSEQ:		/* unplug timeout on uhci */
 			return;
 		case -ETIMEDOUT:	/* NAK */
 			break;
@@ -1136,12 +1137,15 @@
 {
 	struct hid_device *hid = urb->context;
 	unsigned long flags;
+	int unplug = 0;
 
 	switch (urb->status) {
 		case 0:			/* success */
+		case -ESHUTDOWN:	/* unplug */
+		case -EILSEQ:		/* unplug timeout on uhci */
+			unplug = 1;
 		case -ECONNRESET:	/* unlink */
 		case -ENOENT:
-		case -ESHUTDOWN:
 			break;
 		default:		/* error */
 			warn("output irq status %d received", urb->status);
@@ -1149,7 +1153,10 @@
 
 	spin_lock_irqsave(&hid->outlock, flags);
 
-	hid->outtail = (hid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE - 1);
+	if (unplug)
+		hid->outtail = hid->outhead;
+	else
+		hid->outtail = (hid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE - 1);
 
 	if (hid->outhead != hid->outtail) {
 		if (hid_submit_out(hid)) {
@@ -1173,6 +1180,7 @@
 {
 	struct hid_device *hid = urb->context;
 	unsigned long flags;
+	int unplug = 0;
 
 	spin_lock_irqsave(&hid->ctrllock, flags);
 
@@ -1180,16 +1188,21 @@
 		case 0:			/* success */
 			if (hid->ctrl[hid->ctrltail].dir == USB_DIR_IN) 
 				hid_input_report(hid->ctrl[hid->ctrltail].report->type, urb, regs);
+		case -ESHUTDOWN:	/* unplug */
+		case -EILSEQ:		/* unplug timectrl on uhci */
+			unplug = 1;
 		case -ECONNRESET:	/* unlink */
 		case -ENOENT:
-		case -ESHUTDOWN:
 		case -EPIPE:		/* report not available */
 			break;
 		default:		/* error */
 			warn("ctrl urb status %d received", urb->status);
 	}
 
-	hid->ctrltail = (hid->ctrltail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
+	if (unplug)
+		hid->ctrltail = hid->ctrlhead;
+	else
+		hid->ctrltail = (hid->ctrltail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
 
 	if (hid->ctrlhead != hid->ctrltail) {
 		if (hid_submit_ctrl(hid)) {

--Boundary-00=_8Dw6BRN2ao0zugd--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
