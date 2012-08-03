Return-Path: <cyrus@holtmann.org>
From: "Aj, SanthoshX" <santhoshx.aj@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 1/1] add LE_create_conn_cancel
Date: Fri, 3 Aug 2012 05:26:21 +0000
Message-ID: <001F63875E1AF5428162B5A2D3ED1BDD15C0146B@BGSMSX101.gar.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From hcitool when we call LE  create connection, the controller is set to initiating  state. But when we exit, the controller will remain in  same state. To correct this we need to send LE create  conn cancel.

---
 lib/hci.c       |   23 +++++++++++++++++++++++
 lib/hci.h       |    5 +++++
 tools/hcitool.c |    2 ++
 3 files changed, 30 insertions(+)

diff --git a/lib/hci.c b/lib/hci.c
index 66b2d5f..b0a8ed5 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -2875,6 +2875,29 @@ int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 	return 0;
 }
 
+int hci_le_create_conn_cancel(int dd, int to) {
+	struct hci_request rq;
+	evt_le_connection_complete conn_complete_rp;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_CREATE_CONN_CANCEL;
+	rq.event = EVT_LE_CONN_COMPLETE;
+	rq.clen = LE_CREATE_CONN_CANCEL_CP_SIZE;
+	rq.rparam = &conn_complete_rp;
+	rq.rlen = EVT_CONN_COMPLETE_SIZE;
+
+	if (hci_send_req(dd, &rq, to) < 0)
+		return -1;
+
+	if (conn_complete_rp.status) {
+		errno = EIO;
+		return -1;
+	}
+	return 0;
+}
+
 int hci_le_conn_update(int dd, uint16_t handle, uint16_t min_interval,
 			uint16_t max_interval, uint16_t latency,
 			uint16_t supervision_timeout, int to) diff --git a/lib/hci.h b/lib/hci.h index f90ac26..ed450e8 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1551,6 +1551,11 @@ typedef struct {
 #define LE_CREATE_CONN_CP_SIZE 25
 
 #define OCF_LE_CREATE_CONN_CANCEL		0x000E
+#define LE_CREATE_CONN_CANCEL_CP_SIZE 0 typedef struct {
+	uint8_t		status;
+} __attribute__ ((packed)) le_create_conn_cancel_rp; #define 
+LE_CREATE_CONN_CANCEL_RP_SIZE 1
 
 #define OCF_LE_READ_WHITE_LIST_SIZE		0x000F
 typedef struct {
diff --git a/tools/hcitool.c b/tools/hcitool.c index 66e5c20..a6c1ba8 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2644,6 +2644,8 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 			min_ce_length, max_ce_length, &handle, 25000);
 	if (err < 0) {
 		perror("Could not create connection");
+		/* Before exit reset controller state to standby */
+		err = hci_le_create_conn_cancel(dd,25000);
 		exit(1);
 	}
 
--
1.7.9.5

