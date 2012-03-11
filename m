Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 1/3] mgmt: implement read tx power
Date: Sun, 11 Mar 2012 11:23:17 +0200
Message-Id: <1331457799-26506-2-git-send-email-arik@wizery.com>
In-Reply-To: <1331457799-26506-1-git-send-email-arik@wizery.com>
References: <1331457799-26506-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement the read Tx power mgmt op and completion event. Based on a
similar patch by Bruna Moreira <bruna.moreira@openbossa.org>
---
 lib/mgmt.h        |   11 +++++++++
 plugins/mgmtops.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h     |    6 +++++
 3 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index f3bc6da..073752f 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -311,6 +311,17 @@ struct mgmt_cp_unblock_device {
 	struct mgmt_addr_info addr;
 } __packed;
 
+#define MGMT_OP_READ_TX_POWER_LEVEL	0x0028
+struct mgmt_cp_read_tx_power_level {
+	struct mgmt_addr_info addr;
+	uint8_t type;
+} __packed;
+struct mgmt_rp_read_tx_power_level {
+	struct mgmt_addr_info addr;
+	uint8_t status;
+	int8_t level;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 4aa38fe..317df24 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1229,6 +1229,38 @@ static void set_local_name_complete(int sk, uint16_t index, void *buf,
 	adapter_name_changed(adapter, (char *) rp->name);
 }
 
+static void read_tx_power_complete(int sk, uint16_t index, void *buf,
+				   size_t len)
+{
+	struct mgmt_rp_read_tx_power_level *rp = buf;
+	struct controller_info *info;
+	struct btd_adapter *adapter;
+	char addr[18];
+
+	if (len != sizeof(*rp)) {
+		error("Too small tx power complete event");
+		return;
+	}
+
+	if (index > max_index) {
+		error("Unexpected index %u in read tx power complete", index);
+		return;
+	}
+
+	ba2str(&rp->addr.bdaddr, addr);
+
+	DBG("hci%d addr=%s status=%d level=%d", index, addr, rp->status,
+	    rp->level);
+
+	info = &controllers[index];
+
+	adapter = manager_find_adapter(&info->bdaddr);
+	if (adapter == NULL) {
+		DBG("Adapter not found");
+		return;
+	}
+}
+
 static void read_local_oob_data_complete(int sk, uint16_t index, void *buf,
 								size_t len)
 {
@@ -1402,6 +1434,9 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_SET_LOCAL_NAME:
 		set_local_name_complete(sk, index, ev->data, len);
 		break;
+	case MGMT_OP_READ_TX_POWER_LEVEL:
+		read_tx_power_complete(sk, index, ev->data, len);
+		break;
 	case MGMT_OP_READ_LOCAL_OOB_DATA:
 		read_local_oob_data_complete(sk, index, ev->data, len);
 		break;
@@ -1969,6 +2004,31 @@ static int mgmt_read_clock(int index, bdaddr_t *bdaddr, int which, int timeout,
 	return -ENOSYS;
 }
 
+static int mgmt_read_tx_power(int index, bdaddr_t *bdaddr,
+			      addr_type_t addr_type, uint8_t type)
+{
+	char addr[18];
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_read_tx_power_level)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_read_tx_power_level *cp = (void *) &buf[sizeof(*hdr)];
+
+	ba2str(bdaddr, addr);
+	DBG("index %d addr %s read transmit power level", index, addr);
+	memset(buf, 0, sizeof(buf));
+	hdr->opcode = htobs(MGMT_OP_READ_TX_POWER_LEVEL);
+	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
+
+	bacpy(&cp->addr.bdaddr, bdaddr);
+	cp->addr.type = mgmt_addr_type(addr_type);
+	cp->type = type;
+
+	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
+		return -errno;
+
+	return 0;
+}
+
 static int mgmt_read_bdaddr(int index, bdaddr_t *bdaddr)
 {
 	char addr[18];
@@ -2436,6 +2496,7 @@ static struct btd_adapter_ops mgmt_ops = {
 	.remove_remote_oob_data = mgmt_remove_remote_oob_data,
 	.confirm_name = mgmt_confirm_name,
 	.load_ltks = mgmtops_load_ltks,
+	.read_tx_power = mgmt_read_tx_power,
 };
 
 static int mgmt_init(void)
diff --git a/src/adapter.h b/src/adapter.h
index 4933baf..1407c18 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -41,6 +41,10 @@
 /* Invalid SSP passkey value used to indicate negative replies */
 #define INVALID_PASSKEY		0xffffffff
 
+/* Tx Power measurement types */
+#define TX_POWER_CURRENT_POWER	0
+#define TX_POWER_MAX_POWER	1
+
 typedef enum {
 	ADDR_TYPE_BREDR,
 	ADDR_TYPE_LE_PUBLIC,
@@ -229,6 +233,8 @@ struct btd_adapter_ops {
 	int (*confirm_name) (int index, bdaddr_t *bdaddr, addr_type_t type,
 							gboolean name_known);
 	int (*load_ltks) (int index, GSList *keys);
+	int (*read_tx_power) (int index, bdaddr_t *bdaddr,
+			      addr_type_t addr_type, uint8_t type);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *ops, gboolean priority);
-- 
1.7.5.4

