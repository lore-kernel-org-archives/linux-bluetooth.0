Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v7 2/6] Add support for Out of Band (OOB) association model in mgmtops
Date: Sat, 26 Mar 2011 12:27:07 +0100
Message-ID: <1301138831-12082-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1301138831-12082-1-git-send-email-szymon.janc@tieto.com>
References: <1301138831-12082-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/mgmt.h        |   18 +++++++++
 plugins/mgmtops.c |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index bd65328..3d29b24 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -179,6 +179,24 @@ struct mgmt_cp_set_local_name {
 	uint8_t name[249];
 } __packed;
 
+#define MGMT_OP_READ_LOCAL_OOB_DATA	0x0018
+struct mgmt_rp_read_local_oob_data {
+	uint8_t hash[16];
+	uint8_t randomizer[16];
+} __packed;
+
+#define MGMT_OP_ADD_REMOTE_OOB_DATA	0x0019
+struct mgmt_cp_add_remote_oob_data {
+	bdaddr_t bdaddr;
+	uint8_t hash[16];
+	uint8_t randomizer[16];
+} __packed;
+
+#define MGMT_OP_REMOVE_REMOTE_OOB_DATA	0x001A
+struct mgmt_cp_remove_remote_oob_data {
+	bdaddr_t bdaddr;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 6bb033b..3aca861 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -47,6 +47,7 @@
 #include "manager.h"
 #include "device.h"
 #include "event.h"
+#include "oob.h"
 
 #define MGMT_BUF_SIZE 1024
 
@@ -1029,6 +1030,49 @@ static void set_local_name_complete(int sk, uint16_t index, void *buf,
 	adapter_update_local_name(adapter, (char *) rp->name);
 }
 
+static void read_local_oob_data_complete(int sk, uint16_t index, void *buf,
+								size_t len)
+{
+	struct mgmt_rp_read_local_oob_data *rp = buf;
+	struct btd_adapter *adapter;
+
+	if (len != sizeof(*rp)) {
+		error("Wrong read_local_oob_data_complete event size");
+		return;
+	}
+
+	if (index > max_index) {
+		error("Unexpected index %u in read_local_oob_data_complete",
+								index);
+		return;
+	}
+
+	DBG("hci%u", index);
+
+	adapter = manager_find_adapter_by_id(index);
+
+	if (adapter)
+		oob_read_local_data_complete(adapter, rp->hash, rp->randomizer);
+}
+
+static void read_local_oob_data_failed(int sk, uint16_t index)
+{
+	struct btd_adapter *adapter;
+
+	if (index > max_index) {
+		error("Unexpected index %u in read_local_oob_data_failed",
+								index);
+		return;
+	}
+
+	DBG("hci%u", index);
+
+	adapter = manager_find_adapter_by_id(index);
+
+	if (adapter)
+		oob_read_local_data_complete(adapter, NULL, NULL);
+}
+
 static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_cmd_complete *ev = buf;
@@ -1113,6 +1157,15 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_SET_LOCAL_NAME:
 		set_local_name_complete(sk, index, ev->data, len);
 		break;
+	case MGMT_OP_READ_LOCAL_OOB_DATA:
+		read_local_oob_data_complete(sk, index, ev->data, len);
+		break;
+	case MGMT_OP_ADD_REMOTE_OOB_DATA:
+		DBG("add_remote_oob_data complete");
+		break;
+	case MGMT_OP_REMOVE_REMOTE_OOB_DATA:
+		DBG("remove_remote_oob_data complete");
+		break;
 	default:
 		error("Unknown command complete for opcode %u", opcode);
 		break;
@@ -1132,6 +1185,12 @@ static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
 	opcode = btohs(bt_get_unaligned(&ev->opcode));
 
 	DBG("status %u opcode %u (index %u)", ev->status, opcode, index);
+
+	switch (opcode) {
+	case MGMT_OP_READ_LOCAL_OOB_DATA:
+		read_local_oob_data_failed(sk, index);
+		break;
+	}
 }
 
 static void mgmt_controller_error(int sk, uint16_t index, void *buf, size_t len)
@@ -1750,30 +1809,69 @@ static int mgmt_cancel_bonding(int index, bdaddr_t *bdaddr)
 
 static int mgmt_read_local_oob_data(int index)
 {
+	struct mgmt_hdr hdr;
+
 	DBG("hci%d", index);
 
-	return -ENOSYS;
+	hdr.opcode = htobs(MGMT_OP_READ_LOCAL_OOB_DATA);
+	hdr.len = 0;
+	hdr.index = htobs(index);
+
+	if (write(mgmt_sock, &hdr, sizeof(hdr)) < 0)
+		return -errno;
+
+	return 0;
 }
 
 static int mgmt_add_remote_oob_data(int index, bdaddr_t *bdaddr,
 					uint8_t *hash, uint8_t *randomizer)
 {
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_add_remote_oob_data)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_add_remote_oob_data *cp = (void *) &buf[sizeof(*hdr)];
 	char addr[18];
 
 	ba2str(bdaddr, addr);
 	DBG("hci%d bdaddr %s", index, addr);
 
-	return -ENOSYS;
+	memset(buf, 0, sizeof(buf));
+
+	hdr->opcode = htobs(MGMT_OP_ADD_REMOTE_OOB_DATA);
+	hdr->index = htobs(index);
+	hdr->len = htobs(sizeof(*cp));
+
+	bacpy(&cp->bdaddr, bdaddr);
+	memcpy(cp->hash, hash, 16);
+	memcpy(cp->randomizer, randomizer, 16);
+
+	if (write(mgmt_sock, &buf, sizeof(buf)) < 0)
+		return -errno;
+
+	return 0;
 }
 
 static int mgmt_remove_remote_oob_data(int index, bdaddr_t *bdaddr)
 {
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_remove_remote_oob_data)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_remove_remote_oob_data *cp = (void *) &buf[sizeof(*hdr)];
 	char addr[18];
 
 	ba2str(bdaddr, addr);
 	DBG("hci%d bdaddr %s", index, addr);
 
-	return -ENOSYS;
+	memset(buf, 0, sizeof(buf));
+
+	hdr->opcode = htobs(MGMT_OP_REMOVE_REMOTE_OOB_DATA);
+	hdr->index = htobs(index);
+	hdr->len = htobs(sizeof(*cp));
+
+	bacpy(&cp->bdaddr, bdaddr);
+
+	if (write(mgmt_sock, &buf, sizeof(buf)) < 0)
+		return -errno;
+
+	return 0;
 }
 
 static struct btd_adapter_ops mgmt_ops = {
-- 
1.7.0.4

