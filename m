Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 5/7] Implement mgmt_read_rssi command
Date: Wed, 15 Jun 2011 17:03:02 -0400
Message-Id: <4df91d70.0b73650a.190f.17aa@mx.google.com>
In-Reply-To: <1308171784-24442-1-git-send-email-y>
References: <y>
 <1308171784-24442-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch implements Read RSSI command in management interface.
---
 lib/mgmt.h        |   10 ++++++++++
 plugins/mgmtops.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 57e7603..038b18d 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -205,6 +205,16 @@ struct mgmt_cp_remove_remote_oob_data {
 
 #define MGMT_OP_STOP_DISCOVERY		0x001C
 
+#define MGMT_OP_READ_RSSI		0x001D
+struct mgmt_cp_read_rssi {
+	bdaddr_t bdaddr;
+} __packed;
+struct mgmt_rp_read_rssi {
+	uint8_t status;
+	bdaddr_t bdaddr;
+	int8_t rssi;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 3be2607..074435c 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1108,6 +1108,36 @@ static void read_local_oob_data_failed(int sk, uint16_t index)
 		oob_read_local_data_complete(adapter, NULL, NULL);
 }
 
+static void read_rssi_complete(int sk, uint16_t index, void *buf, size_t len)
+{
+	struct mgmt_rp_read_rssi *rp = buf;
+	struct controller_info *info;
+	char addr[18];
+
+	if (len != sizeof(*rp)) {
+		error("Wrong read_rssi_complete event size");
+		return;
+	}
+
+	if (rp->status) {
+		DBG("Read rssi cmd error %01x", rp->status);
+		return;
+	}
+
+	ba2str(&rp->bdaddr, addr);
+
+	DBG("hci%d %s rssi %d", index, addr, rp->rssi);
+
+	if (index > max_index) {
+		error("Unexpected index %u in read_rssi complete", index);
+		return;
+	}
+
+	info = &controllers[index];
+
+	btd_event_rssi_read(&info->bdaddr, &rp->bdaddr, rp->rssi);
+}
+
 static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_cmd_complete *ev = buf;
@@ -1201,6 +1231,9 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_REMOVE_REMOTE_OOB_DATA:
 		DBG("remove_remote_oob_data complete");
 		break;
+	case MGMT_OP_READ_RSSI:
+		read_rssi_complete(sk, index, ev->data, len);
+		break;
 	default:
 		error("Unknown command complete for opcode %u", opcode);
 		break;
@@ -1675,12 +1708,21 @@ static int mgmt_read_clock(int index, bdaddr_t *bdaddr, int which, int timeout,
 
 static int mgmt_read_rssi(int index, bdaddr_t *bdaddr)
 {
-	char addr[18];
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_read_rssi)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_read_rssi *cp = (void *) &buf[sizeof(*hdr)];
 
-	ba2str(bdaddr, addr);
-	DBG("index %d addr %s", index, addr);
+	memset(buf, 0, sizeof(buf));
+	hdr->opcode = htobs(MGMT_OP_READ_RSSI);
+	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
 
-	return -ENOSYS;
+	bacpy(&cp->bdaddr, bdaddr);
+
+	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
+		return -errno;
+
+	return 0;
 }
 
 static int mgmt_read_tx_power(int index, bdaddr_t *bdaddr)
-- 
1.7.4.1

