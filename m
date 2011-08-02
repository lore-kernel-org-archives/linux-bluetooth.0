Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 2/8] Add RSSI threshold monitor implementation
Date: Tue,  2 Aug 2011 18:37:34 -0300
Message-Id: <1312321060-19283-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312321060-19283-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312321060-19283-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements new commands to enable and disable the RSSI threshold
monitoring through the management interface.
---
 plugins/hciops.c  |   13 +++++++++++
 plugins/mgmtops.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h     |    3 ++
 3 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index ecc0e86..1f7bd52 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3193,6 +3193,17 @@ static int hciops_unblock_device(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int hciops_enable_rssi_monitor(int index, bdaddr_t *bdaddr,
+						int8_t low, int8_t high)
+{
+	return -ENOSYS;
+}
+
+static int hciops_disable_rssi_monitor(int index, bdaddr_t *bdaddr)
+{
+	return -ENOSYS;
+}
+
 static int hciops_get_conn_list(int index, GSList **conns)
 {
 	struct dev_info *dev = &devs[index];
@@ -3652,6 +3663,8 @@ static struct btd_adapter_ops hci_ops = {
 	.read_bdaddr = hciops_read_bdaddr,
 	.block_device = hciops_block_device,
 	.unblock_device = hciops_unblock_device,
+	.enable_rssi_monitor = hciops_enable_rssi_monitor,
+	.disable_rssi_monitor = hciops_disable_rssi_monitor,
 	.get_conn_list = hciops_get_conn_list,
 	.disconnect = hciops_disconnect,
 	.remove_bonding = hciops_remove_bonding,
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 3cdb97e..e01f330 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1751,6 +1751,65 @@ static int mgmt_unblock_device(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int mgmt_enable_rssi_monitor(int index, bdaddr_t *bdaddr,
+						int8_t low, int8_t high)
+{
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_enable_rssi_monitor)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_enable_rssi_monitor *cp;
+	size_t buf_len;
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	DBG("index %d addr %s", index, addr);
+
+	memset(buf, 0, sizeof(buf));
+
+	hdr->opcode = htobs(MGMT_OP_ENABLE_RSSI_MONITOR);
+	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
+
+	cp = (void *) &buf[sizeof(*hdr)];
+	bacpy(&cp->bdaddr, bdaddr);
+	cp->low = low;
+	cp->high = high;
+
+	buf_len = sizeof(*hdr) + sizeof(*cp);
+
+	if (write(mgmt_sock, buf, buf_len) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int mgmt_disable_rssi_monitor(int index, bdaddr_t *bdaddr)
+{
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_disable_rssi_monitor)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_disable_rssi_monitor *cp;
+	size_t buf_len;
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	DBG("index %d addr %s", index, addr);
+
+	memset(buf, 0, sizeof(buf));
+
+	hdr->opcode = htobs(MGMT_OP_DISABLE_RSSI_MONITOR);
+	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
+
+	cp = (void *) &buf[sizeof(*hdr)];
+	bacpy(&cp->bdaddr, bdaddr);
+
+	buf_len = sizeof(*hdr) + sizeof(*cp);
+
+	if (write(mgmt_sock, buf, buf_len) < 0)
+		return -errno;
+
+	return 0;
+}
+
 static int mgmt_get_conn_list(int index, GSList **conns)
 {
 	struct controller_info *info = &controllers[index];
@@ -2047,6 +2106,8 @@ static struct btd_adapter_ops mgmt_ops = {
 	.read_bdaddr = mgmt_read_bdaddr,
 	.block_device = mgmt_block_device,
 	.unblock_device = mgmt_unblock_device,
+	.enable_rssi_monitor = mgmt_enable_rssi_monitor,
+	.disable_rssi_monitor = mgmt_disable_rssi_monitor,
 	.get_conn_list = mgmt_get_conn_list,
 	.disconnect = mgmt_disconnect,
 	.remove_bonding = mgmt_remove_bonding,
diff --git a/src/adapter.h b/src/adapter.h
index 687275a..658a211 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -196,6 +196,9 @@ struct btd_adapter_ops {
 	int (*read_bdaddr) (int index, bdaddr_t *bdaddr);
 	int (*block_device) (int index, bdaddr_t *bdaddr);
 	int (*unblock_device) (int index, bdaddr_t *bdaddr);
+	int (*enable_rssi_monitor) (int index, bdaddr_t *bdaddr, int8_t low,
+								int8_t high);
+	int (*disable_rssi_monitor) (int index, bdaddr_t *bdaddr);
 	int (*get_conn_list) (int index, GSList **conns);
 	int (*disconnect) (int index, bdaddr_t *bdaddr);
 	int (*remove_bonding) (int index, bdaddr_t *bdaddr);
-- 
1.7.6

