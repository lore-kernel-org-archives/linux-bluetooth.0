Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [Patch v2] Bluetooth: Wait active mode to setup SCO channel
Date: Wed, 18 Nov 2015 20:40:43 +0900
Message-id: <1447846843-10566-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Seungyoun Ju <sy39.ju@samsung.com>

Some of headset such as Samsung HS7000 randomly takes long time to
exit Sniff Mode because once we get unsniff req from headset and we
send LMP_accepted but we send it again repeatedly for around 500ms
because there is no ACK from headset. So SCO connection request might
be failed due to "Command Disallowed" and user space gets "EBUSY".

But it's not easy that user space expects when the connection
becomes active mode. So if kernel call hci_sco_setup() by
HCI_CONN_SCO_SETUP_PEND flag, overall SCO connection time could be
reduced compared to user space's retrial way.

2015-11-17 15:21:31.131227 > ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 0]
      0000: 6b ff 15 03 41 54 2b 42  56 52 41 3d 31 0d f8     k...AT+BVRA=1..
2015-11-17 15:21:31.132436 < HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
    handle 11
2015-11-17 15:21:31.182614 < ACL data: handle 11 flags 0x00 dlen 14
    L2CAP(d): cid 0x0043 len 10 [psm 0]
      0000: 69 ef 0d 0d 0a 4f 4b 0d  0a 3e                    i....OK..>
2015-11-17 15:21:31.184210 > HCI Event: Command Status (0x0f) plen 4
    Exit Sniff Mode (0x02|0x0004) status 0x0c ncmd 1
    Error: Command Disallowed
2015-11-17 15:21:31.491043 < ACL data: handle 11 flags 0x00 dlen 20
    L2CAP(d): cid 0x0043 len 16 [psm 0]
      0000: 69 ef 19 0d 0a 2b 42 56  52 41 3a 20 31 0d 0a 3e  i....+BVRA: 1..>
2015-11-17 15:21:31.491502 < HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
    handle 11
2015-11-17 15:21:31.492683 > HCI Event: Command Status (0x0f) plen 4
    Exit Sniff Mode (0x02|0x0004) status 0x0c ncmd 1
    Error: Command Disallowed
2015-11-17 15:21:31.612180 < HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
    handle 11
2015-11-17 15:21:31.613193 > HCI Event: Command Status (0x0f) plen 4
    Exit Sniff Mode (0x02|0x0004) status 0x0c ncmd 1
    Error: Command Disallowed
2015-11-17 15:21:31.624963 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 11 mode 0x00 interval 0
    Mode: Active
2015-11-17 15:21:31.625373 < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 11 voice setting 0x0060 ptype 0x038f
2015-11-17 15:21:31.626614 > HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1

Signed-off-by: Seungyoun Ju <sy39.ju@samsung.com>
Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         | 17 +++++++++++++++++
 net/bluetooth/hci_event.c        | 15 ++++++++++-----
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cc22167..95dee704 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -263,6 +263,7 @@ enum {
 #define HCI_INIT_TIMEOUT	msecs_to_jiffies(10000)	/* 10 seconds */
 #define HCI_CMD_TIMEOUT		msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
+#define HCI_SCO_TIMEOUT		msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 55ce209..ae1d0d3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -442,6 +442,7 @@ struct hci_conn {
 	__u8		passkey_entered;
 	__u16		disc_timeout;
 	__u16		conn_timeout;
+	__u16		sco_timeout;
 	__u16		setting;
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
@@ -472,6 +473,7 @@ struct hci_conn {
 	struct delayed_work disc_work;
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
+	struct delayed_work sco_conn_timeout;
 	struct delayed_work le_conn_timeout;
 	struct work_struct  le_scan_cleanup;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2d334e0..b6c0332 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -491,6 +491,19 @@ static void le_conn_timeout(struct work_struct *work)
 	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 }
 
+static void sco_conn_timeout(struct work_struct *work)
+{
+	struct hci_conn *conn = container_of(work, struct hci_conn,
+					     sco_conn_timeout.work);
+
+	BT_DBG("");
+
+	if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags)) {
+		BT_ERR("Fail to exit sniff mode to setup SCO within timeout");
+		hci_sco_setup(conn, 0x0c);
+	}
+}
+
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role)
 {
@@ -519,6 +532,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 
 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+	conn->sco_timeout = HCI_SCO_TIMEOUT;
 
 	if (conn->role == HCI_ROLE_MASTER)
 		conn->out = true;
@@ -550,6 +564,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
+	INIT_DELAYED_WORK(&conn->sco_conn_timeout, sco_conn_timeout);
 	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
 	INIT_WORK(&conn->le_scan_cleanup, le_scan_cleanup);
 
@@ -581,6 +596,8 @@ int hci_conn_del(struct hci_conn *conn)
 		if (sco)
 			sco->link = NULL;
 
+		cancel_delayed_work_sync(&conn->sco_conn_timeout);
+
 		/* Unacked frames */
 		hdev->acl_cnt += conn->sent;
 	} else if (conn->type == LE_LINK) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d57c11c..a6df504 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1839,8 +1839,10 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
 	if (conn) {
 		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags);
 
-		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags)) {
+			cancel_delayed_work(&conn->sco_conn_timeout);
 			hci_sco_setup(conn, status);
+		}
 	}
 
 	hci_dev_unlock(hdev);
@@ -1865,9 +1867,10 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
 	if (conn) {
 		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags);
-
-		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
-			hci_sco_setup(conn, status);
+		if (test_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
+			queue_delayed_work(conn->hdev->workqueue,
+					   &conn->sco_conn_timeout,
+					   conn->sco_timeout);
 	}
 
 	hci_dev_unlock(hdev);
@@ -3335,8 +3338,10 @@ static void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 				clear_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 		}
 
-		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags)) {
+			cancel_delayed_work(&conn->sco_conn_timeout);
 			hci_sco_setup(conn, ev->status);
+		}
 	}
 
 	hci_dev_unlock(hdev);
-- 
2.5.0

