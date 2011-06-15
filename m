Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC 6/7] Implement mgmt_read_tx_power command
Date: Wed, 15 Jun 2011 17:03:03 -0400
Message-Id: <4df91d72.0b73650a.190f.17ab@mx.google.com>
In-Reply-To: <1308171784-24442-1-git-send-email-y>
References: <y>
 <1308171784-24442-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

This patch implements a new command to read the TX power of an active
connection asynchronously in the management interface.
---
 lib/mgmt.h        |   10 ++++++++++
 plugins/mgmtops.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 038b18d..57f22d8 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -215,6 +215,16 @@ struct mgmt_rp_read_rssi {
 	int8_t rssi;
 } __packed;
 
+#define MGMT_OP_READ_TX_POWER_LEVEL	0x001E
+struct mgmt_cp_read_tx_power_level {
+	bdaddr_t bdaddr;
+} __packed;
+struct mgmt_rp_read_tx_power_level {
+	uint8_t status;
+	bdaddr_t bdaddr;
+	int8_t level;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 074435c..bf702ea 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1065,6 +1065,36 @@ static void set_local_name_complete(int sk, uint16_t index, void *buf,
 	adapter_update_local_name(adapter, (char *) rp->name);
 }
 
+static void read_tx_power_complete(int sk, uint16_t index, void *buf, size_t len)
+{
+	struct mgmt_rp_read_tx_power_level *rp = buf;
+	struct controller_info *info;
+	char addr[18];
+
+	if (len < sizeof(*rp)) {
+		error("Too small tx power complete event");
+		return;
+	}
+
+	if (index > max_index) {
+		error("Unexpected index %u in read tx power complete", index);
+		return;
+	}
+
+	if (rp->status) {
+		DBG("TX power read error %01x", rp->status);
+		return;
+	}
+
+	ba2str(&rp->bdaddr, addr);
+
+	DBG("hci%d addr=%s level=%d", index, addr, rp->level);
+
+	info = &controllers[index];
+
+	btd_event_txpower_read(&info->bdaddr, &rp->bdaddr, rp->level);
+}
+
 static void read_local_oob_data_complete(int sk, uint16_t index, void *buf,
 								size_t len)
 {
@@ -1222,6 +1252,9 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_SET_LOCAL_NAME:
 		set_local_name_complete(sk, index, ev->data, len);
 		break;
+	case MGMT_OP_READ_TX_POWER_LEVEL:
+		read_tx_power_complete(sk, index, ev->data, len);
+		break;
 	case MGMT_OP_READ_LOCAL_OOB_DATA:
 		read_local_oob_data_complete(sk, index, ev->data, len);
 		break;
@@ -1727,12 +1760,21 @@ static int mgmt_read_rssi(int index, bdaddr_t *bdaddr)
 
 static int mgmt_read_tx_power(int index, bdaddr_t *bdaddr)
 {
-	char addr[18];
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_read_tx_power_level)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_read_tx_power_level *cp = (void *) &buf[sizeof(*hdr)];
 
-	ba2str(bdaddr, addr);
-	DBG("index %d addr %s read transmit power level", index, addr);
+	memset(buf, 0, sizeof(buf));
+	hdr->opcode = htobs(MGMT_OP_READ_TX_POWER_LEVEL);
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
 
 static int mgmt_read_bdaddr(int index, bdaddr_t *bdaddr)
-- 
1.7.4.1

