Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Update MGMT and SMP timeout constants to use msecs_to_jiffies
Date: Thu,  1 Mar 2012 14:32:37 -0800
Message-Id: <1330641157-32626-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The MGMT and SMP timeout constants are always used in form of jiffies. So
just include the conversion from msecs in the define itself. This has the
advantage of making the code where the timeout is used more readable.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |    5 ++---
 net/bluetooth/smp.c  |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7bd7d57..40b3da3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -116,7 +116,7 @@ static const u16 mgmt_events[] = {
 #define INQUIRY_LEN_BREDR		0x08	/* TGAP(100) */
 #define INQUIRY_LEN_BREDR_LE		0x04	/* TGAP(100)/2 */
 
-#define SERVICE_CACHE_TIMEOUT (5 * 1000)
+#define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
 
 #define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
 				!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
@@ -1298,8 +1298,7 @@ static bool enable_service_cache(struct hci_dev *hdev)
 		return false;
 
 	if (!test_and_set_bit(HCI_SERVICE_CACHE, &hdev->dev_flags)) {
-		schedule_delayed_work(&hdev->service_cache,
-				msecs_to_jiffies(SERVICE_CACHE_TIMEOUT));
+		schedule_delayed_work(&hdev->service_cache, CACHE_TIMEOUT);
 		return true;
 	}
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f6a6d8b..75937d7 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -29,7 +29,7 @@
 #include <linux/scatterlist.h>
 #include <crypto/b128ops.h>
 
-#define SMP_TIMEOUT 30000 /* 30 seconds */
+#define SMP_TIMEOUT	msecs_to_jiffies(30000)
 
 static inline void swap128(u8 src[16], u8 dst[16])
 {
@@ -186,8 +186,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 	hci_send_acl(conn->hchan, skb, 0);
 
 	cancel_delayed_work_sync(&conn->security_timer);
-	schedule_delayed_work(&conn->security_timer,
-					msecs_to_jiffies(SMP_TIMEOUT));
+	schedule_delayed_work(&conn->security_timer, SMP_TIMEOUT);
 }
 
 static __u8 authreq_to_seclevel(__u8 authreq)
-- 
1.7.7.6

