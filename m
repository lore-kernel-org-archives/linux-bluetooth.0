Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/10] Bluetooth: Pass store hint to mgmt_new_conn_param
Date: Wed,  2 Jul 2014 17:37:32 +0300
Message-Id: <1404311854-12233-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
References: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The calling functions of mgmt_new_conn_param have more information about
the parameters, such as whether the kernel is tracking them or not. It
makes therefore sense to have them pass an initial store_hint value to
the mgmt_new_conn_param function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/hci_event.c        | 8 ++++++--
 net/bluetooth/l2cap_core.c       | 8 ++++++--
 net/bluetooth/mgmt.c             | 6 +++---
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 32c8e51f6b26..d0bca13843ce 100644
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
index 3ad2576fd3f1..846f6a6af881 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4431,6 +4431,7 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 
 	if (test_bit(HCI_CONN_MASTER, &hcon->flags)) {
 		struct hci_conn_params *params;
+		u8 store_hint;
 
 		hci_dev_lock(hdev);
 
@@ -4441,12 +4442,15 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 			params->conn_max_interval = max;
 			params->conn_latency = latency;
 			params->supervision_timeout = timeout;
+			store_hint = 0x01;
+		} else{
+			store_hint = 0x00;
 		}
 
 		hci_dev_unlock(hdev);
 
-		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type, min, max,
-				    latency, timeout);
+		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type,
+				    store_hint, min, max, latency, timeout);
 	}
 
 	cp.handle = ev->handle;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a6e276204ae9..dbef22d644e2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5250,10 +5250,14 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 		       sizeof(rsp), &rsp);
 
 	if (!err) {
+		u8 store_hint;
+
+		store_hint = hci_le_conn_update(hcon, min, max, latency,
+						to_multiplier);
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

