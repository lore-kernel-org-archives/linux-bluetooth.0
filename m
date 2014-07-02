Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/10] Bluetooth: Fix missing update of conn params
Date: Wed,  2 Jul 2014 17:37:30 +0300
Message-Id: <1404311854-12233-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
References: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should update any stored connection parameters when we receive the LE
Remote Connection Parameter Request HCI event. This patch adds the
necessary code to the function that handles the event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ed49a065dd67..3ad2576fd3f1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4429,9 +4429,25 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
 
-	if (test_bit(HCI_CONN_MASTER, &hcon->flags))
+	if (test_bit(HCI_CONN_MASTER, &hcon->flags)) {
+		struct hci_conn_params *params;
+
+		hci_dev_lock(hdev);
+
+		params = hci_conn_params_lookup(hdev, &hcon->dst,
+						hcon->dst_type);
+		if (params) {
+			params->conn_min_interval = min;
+			params->conn_max_interval = max;
+			params->conn_latency = latency;
+			params->supervision_timeout = timeout;
+		}
+
+		hci_dev_unlock(hdev);
+
 		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type, min, max,
 				    latency, timeout);
+	}
 
 	cp.handle = ev->handle;
 	cp.interval_min = ev->interval_min;
-- 
1.9.3

