Return-Path: <cyrus@holtmann.org>
From: Maxime Chevallier <maxime.chevallier@openwide.fr>
To: linux-bluetooth@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@openwide.fr>
Subject: [PATCH] lib: Add HCI command "LE_SET_ADVERTISING_PARAMETERS"
Date: Thu, 24 Sep 2015 15:23:48 +0200
Message-Id: <1443101028-4064-1-git-send-email-maxime.chevallier@openwide.fr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added missing HCI 'LE_SET_ADVERTISING_PARAMETERS' command wrapper in
lib, in function hci_le_set_advertising_parameters().

Signed-off-by: Maxime Chevallier <maxime.chevallier@openwide.fr>
---
 lib/hci.c     | 39 +++++++++++++++++++++++++++++++++++++++
 lib/hci_lib.h |  5 +++++
 2 files changed, 44 insertions(+)

diff --git a/lib/hci.c b/lib/hci.c
index c25be9e..ac6f1f8 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -2996,6 +2996,45 @@ int hci_le_set_advertise_enable(int dd, uint8_t enable, int to)
 	return 0;
 }
 
+int hci_le_set_advertising_parameters(int dd, uint16_t min_interval,
+					uint16_t max_interval, uint8_t advtype,
+					uint8_t own_bdaddr_type, uint8_t direct_bdaddr_type,
+					const bdaddr_t *direct_bdaddr, uint8_t chan_map,
+					uint8_t filter, int to)
+{
+	struct hci_request rq;
+	le_set_advertising_parameters_cp param_cp;
+	uint8_t status;
+
+	memset(&param_cp, 0, sizeof(param_cp));
+	param_cp.min_interval = min_interval;
+	param_cp.max_interval = max_interval;
+	param_cp.advtype = advtype;
+	param_cp.own_bdaddr_type = own_bdaddr_type;
+	param_cp.direct_bdaddr_type = direct_bdaddr_type;
+	bacpy(&param_cp.direct_bdaddr, direct_bdaddr);
+	param_cp.chan_map = chan_map;
+	param_cp.filter = filter;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_SET_ADVERTISING_PARAMETERS;
+	rq.cparam = &param_cp;
+	rq.clen = LE_SET_ADVERTISING_PARAMETERS_CP_SIZE;
+	rq.rparam = &status;
+	rq.rlen = 1;
+
+	if (hci_send_req(dd, &rq, to) < 0)
+		return -1;
+
+	if (status) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
 int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 		uint8_t initiator_filter, uint8_t peer_bdaddr_type,
 		bdaddr_t peer_bdaddr, uint8_t own_bdaddr_type,
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index 55aeb17..9fd7505 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -120,6 +120,11 @@ int hci_le_set_scan_parameters(int dev_id, uint8_t type, uint16_t interval,
 					uint16_t window, uint8_t own_type,
 					uint8_t filter, int to);
 int hci_le_set_advertise_enable(int dev_id, uint8_t enable, int to);
+int hci_le_set_advertising_parameters(int dd, uint16_t min_interval,
+					uint16_t max_interval, uint8_t advtype,
+					uint8_t own_bdaddr_type, uint8_t direct_bdaddr_type,
+					const bdaddr_t *direct_bdaddr, uint8_t chan_map,
+					uint8_t filter, int to);
 int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 		uint8_t initiator_filter, uint8_t peer_bdaddr_type,
 		bdaddr_t peer_bdaddr, uint8_t own_bdaddr_type,
-- 
2.1.4

