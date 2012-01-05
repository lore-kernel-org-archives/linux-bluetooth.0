Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/9] Bluetooth: Add discovery state tracking
Date: Thu,  5 Jan 2012 17:16:21 +0200
Message-Id: <1325776582-10314-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds proper state tracking to the device discovery process.
This makes it possible to return appropriate errors when trying to stop
a non-active discovery or start discovery when it is already ongoing.
Once name resolving is implemented this also makes it possible to know
what the right action to do is when a remote name lookup is cancelled.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    9 +++++++++
 net/bluetooth/hci_core.c         |   25 +++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |    6 +++---
 net/bluetooth/mgmt.c             |   16 ++++++++++++++++
 4 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5a566fd..2f19de4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -57,6 +57,12 @@ struct inquiry_entry {
 };
 
 struct discovery_state {
+	enum {
+		DISCOVERY_STOPPED,
+		DISCOVERY_STARTING,
+		DISCOVERY_ACTIVE,
+		DISCOVERY_STOPPING,
+	} state;
 	struct list_head all;		/* All devices found during inquiry */
 	struct list_head unknown;	/* Name state not known */
 	struct list_head resolve;	/* Name needs to be resolved */
@@ -359,11 +365,14 @@ extern int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
 
 static inline void discovery_init(struct hci_dev *hdev)
 {
+	hdev->discovery.state = DISCOVERY_STOPPED;
 	INIT_LIST_HEAD(&hdev->discovery.all);
 	INIT_LIST_HEAD(&hdev->discovery.unknown);
 	INIT_LIST_HEAD(&hdev->discovery.resolve);
 }
 
+void hci_discovery_set_state(struct hci_dev *hdev, int state);
+
 static inline int inquiry_cache_empty(struct hci_dev *hdev)
 {
 	return list_empty(&hdev->discovery.all);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 82829c1..f3aaa3c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -355,6 +355,30 @@ struct hci_dev *hci_dev_get(int index)
 }
 
 /* ---- Inquiry support ---- */
+
+void hci_discovery_set_state(struct hci_dev *hdev, int state)
+{
+	BT_DBG("%s state %u -> %u", hdev->name, hdev->discovery.state, state);
+
+	if (hdev->discovery.state == state)
+		return;
+
+	switch (state) {
+	case DISCOVERY_STOPPED:
+		mgmt_discovering(hdev, 0);
+		break;
+	case DISCOVERY_STARTING:
+		break;
+	case DISCOVERY_ACTIVE:
+		mgmt_discovering(hdev, 1);
+		break;
+	case DISCOVERY_STOPPING:
+		break;
+	}
+
+	hdev->discovery.state = state;
+}
+
 static void inquiry_cache_flush(struct hci_dev *hdev)
 {
 	struct discovery_state *cache = &hdev->discovery;
@@ -367,6 +391,7 @@ static void inquiry_cache_flush(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&cache->unknown);
 	INIT_LIST_HEAD(&cache->resolve);
+	cache->state = DISCOVERY_STOPPED;
 }
 
 struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 828ff14..6213b5f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -65,7 +65,7 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 
 	hci_dev_lock(hdev);
-	mgmt_discovering(hdev, 0);
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	hci_dev_unlock(hdev);
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
@@ -1119,7 +1119,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	set_bit(HCI_INQUIRY, &hdev->flags);
 
 	hci_dev_lock(hdev);
-	mgmt_discovering(hdev, 1);
+	hci_discovery_set_state(hdev, DISCOVERY_ACTIVE);
 	hci_dev_unlock(hdev);
 }
 
@@ -1507,7 +1507,7 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 		return;
 
 	hci_dev_lock(hdev);
-	mgmt_discovering(hdev, 0);
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 894f11b..590966d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1918,6 +1918,12 @@ static int start_discovery(struct sock *sk, u16 index,
 		goto failed;
 	}
 
+	if (hdev->discovery.state != DISCOVERY_STOPPED) {
+		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
+						MGMT_STATUS_BUSY);
+		goto failed;
+	}
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
@@ -1927,6 +1933,8 @@ static int start_discovery(struct sock *sk, u16 index,
 	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
+	else
+		hci_discovery_set_state(hdev, DISCOVERY_STARTING);
 
 failed:
 	hci_dev_unlock(hdev);
@@ -1950,6 +1958,12 @@ static int stop_discovery(struct sock *sk, u16 index)
 
 	hci_dev_lock(hdev);
 
+	if (hdev->discovery.state != DISCOVERY_ACTIVE) {
+		err = cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
+						MGMT_STATUS_REJECTED);
+		goto failed;
+	}
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
@@ -1959,6 +1973,8 @@ static int stop_discovery(struct sock *sk, u16 index)
 	err = hci_cancel_inquiry(hdev);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
+	else
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
 
 failed:
 	hci_dev_unlock(hdev);
-- 
1.7.7.3

