Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] Bluetooth: Fix missing update of conn params
Date: Wed,  2 Jul 2014 16:35:57 +0300
Message-Id: <1404308161-15100-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404308161-15100-1-git-send-email-johan.hedberg@gmail.com>
References: <1404308161-15100-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should update any stored connection parameters when we receive the LE
Remove Connection Parameter Request HCI event. This patch adds the
necessary code to the function that handles the event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b9d16e0ed661..03779e4f21f6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4417,9 +4417,21 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
 
-	if (test_bit(HCI_CONN_MASTER, &hcon->flags))
+	if (test_bit(HCI_CONN_MASTER, &hcon->flags)) {
+		struct hci_conn_params *params;
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
 		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type, min, max,
 				    latency, timeout);
+	}
 
 	cp.handle = ev->handle;
 	cp.interval_min = ev->interval_min;
-- 
1.9.3

