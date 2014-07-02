Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] Bluetooth: Pass store hint to mgmt_new_conn_param
Date: Wed,  2 Jul 2014 16:35:59 +0300
Message-Id: <1404308161-15100-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404308161-15100-1-git-send-email-johan.hedberg@gmail.com>
References: <1404308161-15100-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The calling functions of mgmt_new_conn_param have more information about
the parameters, such as whether the kernel is tracking them or not. It
makes therefore sense to have them pass an initial store_hint value to
the mgmt_new_conn_param function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/hci_event.c        |  8 ++++++--
 net/bluetooth/l2cap_core.c       | 15 +++++++++++++--
 net/bluetooth/mgmt.c             |  6 +++---
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3a8d0e2b1406..cf99c20739d9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1335,8 +1335,8 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk);
 void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		   bool persistent);
 void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			 u8 bdaddr_type, u16 min_interval, u16 max_interval,
-			 u16 latency, u16 timeout);
+			 u8 bdaddr_type, u8 store_hint, u16 min_interval,
+			 u16 max_interval, u16 latency, u16 timeout);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 03779e4f21f6..e26d0177bfaa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4419,6 +4419,7 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 
 	if (test_bit(HCI_CONN_MASTER, &hcon->flags)) {
 		struct hci_conn_params *params;
+		u8 store_hint;
 
 		params = hci_conn_params_lookup(hdev, &hcon->dst,
 						hcon->dst_type);
@@ -4427,10 +4428,13 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 			params->conn_max_interval = max;
 			params->conn_latency = latency;
 			params->supervision_timeout = timeout;
+			store_hint = 0x01;
+		} else{
+			store_hint = 0x00;
 		}
 
-		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type, min, max,
-				    latency, timeout);
+		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type,
+				    store_hint, min, max, latency, timeout);
 	}
 
 	cp.handle = ev->handle;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 058b3b2b59b5..4f0b01be396d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5250,10 +5250,21 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 		       sizeof(rsp), &rsp);
 
 	if (!err) {
+		struct hci_conn_params *params;
+		u8 store_hint;
+
+		params = hci_le_conn_update(hcon, min, max, latency,
+					    to_multiplier);
+		/* If we're tracking these parameters the set store_hint */
+		if (params)
+			store_hint = 0x01;
+		else
+			store_hint = 0x00;
+
 		mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_type,
-				    min, max, latency, to_multiplier);
+				    store_hint, min, max, latency,
+				    to_multiplier);
 
-		hci_le_conn_update(hcon, min, max, latency, to_multiplier);
 	}
 
 	return 0;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 59bf1ac41429..fb1aa0cac137 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5790,15 +5790,15 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 }
 
 void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			 u8 bdaddr_type, u16 min_interval, u16 max_interval,
-			 u16 latency, u16 timeout)
+			 u8 bdaddr_type, u8 store_hint, u16 min_interval,
+			 u16 max_interval, u16 latency, u16 timeout)
 {
 	struct mgmt_ev_new_conn_param ev;
 
 	memset(&ev, 0, sizeof(ev));
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(LE_LINK, bdaddr_type);
-	ev.store_hint = 0x00;
+	ev.store_hint = store_hint;
 	ev.min_interval = cpu_to_le16(min_interval);
 	ev.max_interval = cpu_to_le16(max_interval);
 	ev.latency = cpu_to_le16(latency);
-- 
1.9.3

