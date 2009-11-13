Return-Path: <cyrus@holtmann.org>
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>
Subject: [PATCH 2/2] Bluetooth: Enter active mode even if the remote device initiated sniff mode.
Date: Thu, 12 Nov 2009 16:38:33 -0800
Message-Id: <1258072713-25262-1-git-send-email-npelly@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

power_save == 0 indicated the remote device initiated sniff mode, and prevented
hci_conn_enter_active_mode from entering active mode. Therefore when sending
ACL data we relied on the link manager or the remote device to exit sniff mode.

I'm not sure what the motivation for this behavior is - it seems more desirable
to explicitly enter active mode when required.

As a result of this behavior it can take 4+ seconds to setup a SCO connection
if the remote device initiated sniff mode, because we fail to enter active mode
before requesting a SCO connection.

Tested on host Bluetooth chipsets: TI1271 and BCM4329.

Signed-off-by: Nick Pelly <npelly@google.com>
---
 include/net/bluetooth/hci_core.h |    1 -
 net/bluetooth/hci_conn.c         |    3 +--
 net/bluetooth/hci_event.c        |    7 +------
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7b640ae..87403eb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -172,7 +172,6 @@ struct hci_conn {
 	__u32		 link_mode;
 	__u8             auth_type;
 	__u8             sec_level;
-	__u8             power_save;
 	__u16            disc_timeout;
 	unsigned long	 pend;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b3e0338..8fd7fd4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -212,7 +212,6 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->mode  = HCI_CM_ACTIVE;
 	conn->state = BT_OPEN;
 
-	conn->power_save = 1;
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 
 	switch (type) {
@@ -497,7 +496,7 @@ void hci_conn_enter_active_mode(struct hci_conn *conn)
 	if (test_bit(HCI_RAW, &hdev->flags))
 		return;
 
-	if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
+	if (conn->mode != HCI_CM_SNIFF)
 		goto timer;
 
 	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e99fe38..c4450f1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1473,12 +1473,7 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 		conn->mode = ev->mode;
 		conn->interval = __le16_to_cpu(ev->interval);
 
-		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
-			if (conn->mode == HCI_CM_ACTIVE)
-				conn->power_save = 1;
-			else
-				conn->power_save = 0;
-		}
+		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
 	}
 
 	hci_dev_unlock(hdev);
-- 
1.6.3.1

