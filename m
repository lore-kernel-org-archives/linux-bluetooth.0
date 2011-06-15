Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [RFC 2/7] Add read RSSI on hciops
Date: Wed, 15 Jun 2011 17:02:59 -0400
Message-Id: <4df91d6b.0b73650a.190f.17a7@mx.google.com>
In-Reply-To: <1308171784-24442-1-git-send-email-y>
References: <y>
 <1308171784-24442-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sheldon Demario <sheldon.demario@openbossa.org>

Extend adapter_ops adding a function to read the RSSI of an active
connection asynchronously. This patch extends hciops only, mgmtops
requires kernel changes to become functional.
---
 plugins/hciops.c  |   39 +++++++++++++++++++++++++++++++++++++++
 plugins/mgmtops.c |   11 +++++++++++
 src/adapter.h     |    1 +
 src/event.c       |    8 ++++++++
 src/event.h       |    1 +
 5 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 93cf822..a9cfc25 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1789,6 +1789,22 @@ static inline void read_txpower_complete(int index, void *ptr)
 	btd_event_txpower_read(&dev->bdaddr, &conn->bdaddr, rp->level);
 }
 
+static inline void read_rssi_complete(int index, void *ptr)
+{
+	struct dev_info *dev = &devs[index];
+	read_rssi_rp *rp = ptr;
+	struct bt_conn *conn;
+
+	if (rp->status)
+		return;
+
+	conn = find_conn_by_handle(dev, rp->handle);
+	if (conn == NULL)
+		return;
+
+	btd_event_rssi_read(&dev->bdaddr, &conn->bdaddr, rp->rssi);
+}
+
 static inline void cmd_complete(int index, void *ptr)
 {
 	struct dev_info *dev = &devs[index];
@@ -1863,6 +1879,9 @@ static inline void cmd_complete(int index, void *ptr)
 	case cmd_opcode_pack(OGF_HOST_CTL, OCF_READ_TRANSMIT_POWER_LEVEL):
 		ptr += sizeof(evt_cmd_complete);
 		read_txpower_complete(index, ptr);
+	case cmd_opcode_pack(OGF_STATUS_PARAM, OCF_READ_RSSI):
+		ptr += sizeof(evt_cmd_complete);
+		read_rssi_complete(index, ptr);
 		break;
 	};
 }
@@ -3178,6 +3197,25 @@ static int hciops_read_clock(int index, bdaddr_t *bdaddr, int which,
 	return 0;
 }
 
+static int hciops_read_rssi(int index, bdaddr_t *bdaddr)
+{
+	struct dev_info *dev = &devs[index];
+	uint16_t handle;
+	int err;
+
+	err = get_handle(index, bdaddr, &handle);
+	if (err < 0)
+		return err;
+
+	err = hci_send_cmd(dev->sk, OGF_STATUS_PARAM, OCF_READ_RSSI,
+						sizeof(handle), &handle);
+
+	if (err < 0 )
+		return -errno;
+
+	return 0;
+}
+
 static int hciops_read_tx_power(int index, bdaddr_t *bdaddr)
 {
 	struct dev_info *dev = &devs[index];
@@ -3706,6 +3744,7 @@ static struct btd_adapter_ops hci_ops = {
 	.set_dev_class = hciops_set_dev_class,
 	.set_fast_connectable = hciops_fast_connectable,
 	.read_clock = hciops_read_clock,
+	.read_rssi = hciops_read_rssi,
 	.read_tx_power = hciops_read_tx_power,
 	.read_bdaddr = hciops_read_bdaddr,
 	.block_device = hciops_block_device,
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 7ee86de..3be2607 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1673,6 +1673,16 @@ static int mgmt_read_clock(int index, bdaddr_t *bdaddr, int which, int timeout,
 	return -ENOSYS;
 }
 
+static int mgmt_read_rssi(int index, bdaddr_t *bdaddr)
+{
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	DBG("index %d addr %s", index, addr);
+
+	return -ENOSYS;
+}
+
 static int mgmt_read_tx_power(int index, bdaddr_t *bdaddr)
 {
 	char addr[18];
@@ -2026,6 +2036,7 @@ static struct btd_adapter_ops mgmt_ops = {
 	.set_dev_class = mgmt_set_dev_class,
 	.set_fast_connectable = mgmt_fast_connectable,
 	.read_clock = mgmt_read_clock,
+	.read_rssi = mgmt_read_rssi,
 	.read_tx_power = mgmt_read_tx_power,
 	.read_bdaddr = mgmt_read_bdaddr,
 	.block_device = mgmt_block_device,
diff --git a/src/adapter.h b/src/adapter.h
index 1fa7431..342530c 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -182,6 +182,7 @@ struct btd_adapter_ops {
 	int (*set_fast_connectable) (int index, gboolean enable);
 	int (*read_clock) (int index, bdaddr_t *bdaddr, int which, int timeout,
 					uint32_t *clock, uint16_t *accuracy);
+	int (*read_rssi) (int index, bdaddr_t *bdaddr);
 	int (*read_tx_power) (int index, bdaddr_t *bdaddr);
 	int (*read_bdaddr) (int index, bdaddr_t *bdaddr);
 	int (*block_device) (int index, bdaddr_t *bdaddr);
diff --git a/src/event.c b/src/event.c
index e6383e6..4c613a3 100644
--- a/src/event.c
+++ b/src/event.c
@@ -483,3 +483,11 @@ void btd_event_txpower_read(bdaddr_t *local, bdaddr_t *peer, int8_t level)
 	ba2str(peer, peer_addr);
 	DBG("%s TX Power: %d", peer_addr, level);
 }
+
+void btd_event_rssi_read(bdaddr_t *local, bdaddr_t *peer, int8_t rssi)
+{
+	char peer_addr[18];
+
+	ba2str(peer, peer_addr);
+	DBG("%s RSSI: %d", peer_addr, rssi);
+}
diff --git a/src/event.h b/src/event.h
index 011d933..e0148bb 100644
--- a/src/event.h
+++ b/src/event.h
@@ -41,3 +41,4 @@ int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 					uint8_t key_type, uint8_t pin_length);
 void btd_event_txpower_read(bdaddr_t *local, bdaddr_t *peer, int8_t level);
+void btd_event_rssi_read(bdaddr_t *local, bdaddr_t *peer, int8_t rssi);
-- 
1.7.4.1

