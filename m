Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Stephen Hemminger <shemminger@osdl.org>
To: Marcel Holtmann <marcel@holtman.org>,
   Maxim Krasnyansky
 <maxk@qualcomm.com>
Cc: bluez-devel@lists.sourceforge.net
Message-Id: <20040622144148.13ef5b10@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] [PATCH] change inquiry_cache to hci_inquiry_cache to avoid possible
 name conflicts
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 22 Jun 2004 14:41:48 -0700

This patch changes the inquiry_XXX function to be either local to hci_core.c
or change name from inquiry_cache_lookup to hci_inquiry_cache_lookup to try and
reduce the potential for namespace conflicts.  There could be USB or SCSI or other
code that uses an inquiry_cache.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

diff -Nru a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
--- a/include/net/bluetooth/hci_core.h	2004-06-22 14:38:03 -07:00
+++ b/include/net/bluetooth/hci_core.h	2004-06-22 14:38:03 -07:00
@@ -195,10 +195,8 @@
 	return jiffies - e->timestamp;
 }
 
-struct inquiry_entry *inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
-void inquiry_cache_update(struct hci_dev *hdev, struct inquiry_info *info);
-void inquiry_cache_flush(struct hci_dev *hdev);
-int  inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf);
+struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
+void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_info *info);
 
 /* ----- HCI Connections ----- */
 enum {
diff -Nru a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
--- a/net/bluetooth/hci_core.c	2004-06-22 14:38:03 -07:00
+++ b/net/bluetooth/hci_core.c	2004-06-22 14:38:03 -07:00
@@ -287,7 +287,7 @@
 EXPORT_SYMBOL(hci_dev_get);
 
 /* ---- Inquiry support ---- */
-void inquiry_cache_flush(struct hci_dev *hdev)
+static void inquiry_cache_flush(struct hci_dev *hdev)
 {
 	struct inquiry_cache *cache = &hdev->inq_cache;
 	struct inquiry_entry *next  = cache->list, *e;
@@ -301,7 +301,7 @@
 	}
 }
 
-struct inquiry_entry *inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
+struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct inquiry_cache *cache = &hdev->inq_cache;
 	struct inquiry_entry *e;
@@ -314,14 +314,14 @@
 	return e;
 }
 
-void inquiry_cache_update(struct hci_dev *hdev, struct inquiry_info *info)
+void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_info *info)
 {
 	struct inquiry_cache *cache = &hdev->inq_cache;
 	struct inquiry_entry *e;
 
 	BT_DBG("cache %p, %s", cache, batostr(&info->bdaddr));
 
-	if (!(e = inquiry_cache_lookup(hdev, &info->bdaddr))) {
+	if (!(e = hci_inquiry_cache_lookup(hdev, &info->bdaddr))) {
 		/* Entry not in the cache. Add new one. */
 		if (!(e = kmalloc(sizeof(struct inquiry_entry), GFP_ATOMIC)))
 			return;
@@ -335,7 +335,7 @@
 	cache->timestamp = jiffies;
 }
 
-int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
+static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
 {
 	struct inquiry_cache *cache = &hdev->inq_cache;
 	struct inquiry_info *info = (struct inquiry_info *) buf;
diff -Nru a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
--- a/net/bluetooth/hci_event.c	2004-06-22 14:38:03 -07:00
+++ b/net/bluetooth/hci_event.c	2004-06-22 14:38:03 -07:00
@@ -486,7 +486,7 @@
 
 	hci_dev_lock(hdev);
 	for (; num_rsp; num_rsp--)
-		inquiry_cache_update(hdev, info++);
+		hci_inquiry_cache_update(hdev, info++);
 	hci_dev_unlock(hdev);
 }
 
@@ -508,7 +508,7 @@
 		memcpy(tmp.dev_class, &info->dev_class, 3);
 		tmp.clock_offset      = info->clock_offset;
 		info++;
-		inquiry_cache_update(hdev, &tmp);
+		hci_inquiry_cache_update(hdev, &tmp);
 	}
 	hci_dev_unlock(hdev);
 }


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
