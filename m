Return-Path: <cyrus@holtmann.org>
From: Marco Sinigaglia <marco.sinigaglia@csr.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marco Sinigaglia <marco.sinigaglia@csr.com>
Subject: [PATCH v2] Adjust timeout LE and API
Date: Wed,  9 Mar 2011 16:59:45 +0000
Message-Id: <1299689985-6818-1-git-send-email-marco.sinigaglia@csr.com>
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


The timeout value has been hardcoded on hci_send_req call and, instead, it should be passed from above (for ex from hci_le_set_scan_enable).
This patch removes the hardcoded value from hci_send_req and it increases the timeout to 1000ms.

v1-->v2: used git-format-patch

Signed-off-by: Marco Sinigaglia <marco.sinigaglia@csr.com>

---
 lib/hci.c         |   12 ++++++------
 lib/hci_lib.h     |    6 +++---
 tools/hciconfig.c |    2 +-
 tools/hcitool.c   |    6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 02fc0cf..eb00730 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -2735,7 +2735,7 @@ int hci_read_clock(int dd, uint16_t handle, uint8_t which, uint32_t *clock,
 	return 0;
 }
 
-int hci_le_set_scan_enable(int dd, uint8_t enable, uint8_t filter_dup)
+int hci_le_set_scan_enable(int dd, uint8_t enable, uint8_t filter_dup, int to)
 {
 	struct hci_request rq;
 	le_set_scan_enable_cp scan_cp;
@@ -2753,7 +2753,7 @@ int hci_le_set_scan_enable(int dd, uint8_t enable, uint8_t filter_dup)
 	rq.rparam = &status;
 	rq.rlen = 1;
 
-	if (hci_send_req(dd, &rq, 100) < 0)
+	if (hci_send_req(dd, &rq, to) < 0)
 		return -1;
 
 	if (status) {
@@ -2766,7 +2766,7 @@ int hci_le_set_scan_enable(int dd, uint8_t enable, uint8_t filter_dup)
 
 int hci_le_set_scan_parameters(int dd, uint8_t type,
 					uint16_t interval, uint16_t window,
-					uint8_t own_type, uint8_t filter)
+					uint8_t own_type, uint8_t filter, int to)
 {
 	struct hci_request rq;
 	le_set_scan_parameters_cp param_cp;
@@ -2787,7 +2787,7 @@ int hci_le_set_scan_parameters(int dd, uint8_t type,
 	rq.rparam = &status;
 	rq.rlen = 1;
 
-	if (hci_send_req(dd, &rq, 100) < 0)
+	if (hci_send_req(dd, &rq, to) < 0)
 		return -1;
 
 	if (status) {
@@ -2798,7 +2798,7 @@ int hci_le_set_scan_parameters(int dd, uint8_t type,
 	return 0;
 }
 
-int hci_le_set_advertise_enable(int dd, uint8_t enable)
+int hci_le_set_advertise_enable(int dd, uint8_t enable, int to)
 {
 	struct hci_request rq;
 	le_set_advertise_enable_cp adv_cp;
@@ -2815,7 +2815,7 @@ int hci_le_set_advertise_enable(int dd, uint8_t enable)
 	rq.rparam = &status;
 	rq.rlen = 1;
 
-	if (hci_send_req(dd, &rq, 100) < 0)
+	if (hci_send_req(dd, &rq, to) < 0)
 		return -1;
 
 	if (status) {
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index de3e636..725eb05 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -115,11 +115,11 @@ int hci_read_rssi(int dd, uint16_t handle, int8_t *rssi, int to);
 int hci_read_afh_map(int dd, uint16_t handle, uint8_t *mode, uint8_t *map, int to);
 int hci_read_clock(int dd, uint16_t handle, uint8_t which, uint32_t *clock, uint16_t *accuracy, int to);
 
-int hci_le_set_scan_enable(int dev_id, uint8_t enable, uint8_t filter_dup);
+int hci_le_set_scan_enable(int dev_id, uint8_t enable, uint8_t filter_dup, int to);
 int hci_le_set_scan_parameters(int dev_id, uint8_t type, uint16_t interval,
 					uint16_t window, uint8_t own_type,
-					uint8_t filter);
-int hci_le_set_advertise_enable(int dev_id, uint8_t enable);
+					uint8_t filter, int to);
+int hci_le_set_advertise_enable(int dev_id, uint8_t enable, int to);
 int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 		uint8_t initiator_filter, uint8_t peer_bdaddr_type,
 		bdaddr_t peer_bdaddr, uint8_t own_bdaddr_type,
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 05a8910..aa6d009 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -268,7 +268,7 @@ static void cmd_le_adv(int ctl, int hdev, char *opt)
 	rq.rparam = &status;
 	rq.rlen = 1;
 
-	ret = hci_send_req(dd, &rq, 100);
+	ret = hci_send_req(dd, &rq, 1000);
 
 	hci_close_dev(dd);
 
diff --git a/tools/hcitool.c b/tools/hcitool.c
index e79d76b..05f4df8 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2467,13 +2467,13 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 	}
 
 	err = hci_le_set_scan_parameters(dd, scan_type, interval, window,
-							own_type, 0x00);
+							own_type, 0x00, 1000);
 	if (err < 0) {
 		perror("Set scan parameters failed");
 		exit(1);
 	}
 
-	err = hci_le_set_scan_enable(dd, 0x01, 0x00);
+	err = hci_le_set_scan_enable(dd, 0x01, 0x00, 1000);
 	if (err < 0) {
 		perror("Enable scan failed");
 		exit(1);
@@ -2487,7 +2487,7 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 		exit(1);
 	}
 
-	err = hci_le_set_scan_enable(dd, 0x00, 0x00);
+	err = hci_le_set_scan_enable(dd, 0x00, 0x00, 1000);
 	if (err < 0) {
 		perror("Disable scan failed");
 		exit(1);
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
