Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/4] Bluetooth: Connection parameters check helper
Date: Wed, 25 Jun 2014 16:48:27 -0300
Message-Id: <1403725710-29750-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1403725710-29750-1-git-send-email-andre.guedes@openbossa.org>
References: <1403725710-29750-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames l2cap_check_conn_param() to hci_check_conn_params()
and moves it to hci_core.h so it can reused in others files. This helper
will be reused in the next patch.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 21 +++++++++++++++++++++
 net/bluetooth/l2cap_core.c       | 23 +----------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dda7f00..016d262 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1173,6 +1173,27 @@ static inline struct smp_irk *hci_get_irk(struct hci_dev *hdev,
 	return hci_find_irk_by_rpa(hdev, bdaddr);
 }
 
+static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
+					u16 to_multiplier)
+{
+	u16 max_latency;
+
+	if (min > max || min < 6 || max > 3200)
+		return -EINVAL;
+
+	if (to_multiplier < 10 || to_multiplier > 3200)
+		return -EINVAL;
+
+	if (max >= to_multiplier * 8)
+		return -EINVAL;
+
+	max_latency = (to_multiplier * 8 / max) - 1;
+	if (latency > 499 || latency > max_latency)
+		return -EINVAL;
+
+	return 0;
+}
+
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d015aa1..e203a5f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5213,27 +5213,6 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
 	return 0;
 }
 
-static inline int l2cap_check_conn_param(u16 min, u16 max, u16 latency,
-					 u16 to_multiplier)
-{
-	u16 max_latency;
-
-	if (min > max || min < 6 || max > 3200)
-		return -EINVAL;
-
-	if (to_multiplier < 10 || to_multiplier > 3200)
-		return -EINVAL;
-
-	if (max >= to_multiplier * 8)
-		return -EINVAL;
-
-	max_latency = (to_multiplier * 8 / max) - 1;
-	if (latency > 499 || latency > max_latency)
-		return -EINVAL;
-
-	return 0;
-}
-
 static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 					      struct l2cap_cmd_hdr *cmd,
 					      u16 cmd_len, u8 *data)
@@ -5261,7 +5240,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	err = l2cap_check_conn_param(min, max, latency, to_multiplier);
+	err = hci_check_conn_params(min, max, latency, to_multiplier);
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
-- 
1.9.1

