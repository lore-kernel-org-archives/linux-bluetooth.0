Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC 1/7] Add current tx power read on hciops
Date: Wed, 15 Jun 2011 17:02:58 -0400
Message-Id: <4df91d69.0b73650a.190f.17a6@mx.google.com>
In-Reply-To: <1308171784-24442-1-git-send-email-y>
References: <y>
 <1308171784-24442-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Asynchronous read of the current transmission power of a given
connection. Results are reported through events.
---
 plugins/hciops.c  |   43 +++++++++++++++++++++++++++++++++++++++++++
 plugins/mgmtops.c |   11 +++++++++++
 src/adapter.h     |    1 +
 src/event.c       |    8 ++++++++
 src/event.h       |    1 +
 5 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 6ce0e27..93cf822 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1773,6 +1773,22 @@ static inline void cc_le_set_scan_enable(int index, uint8_t status)
 		set_state(index, DISCOV_SCAN);
 }
 
+static inline void read_txpower_complete(int index, void *ptr)
+{
+	struct dev_info *dev = &devs[index];
+	read_transmit_power_level_rp *rp = ptr;
+	struct bt_conn *conn;
+
+	if (rp->status)
+		return;
+
+	conn = find_conn_by_handle(dev, rp->handle);
+	if (conn == NULL)
+		return;
+
+	btd_event_txpower_read(&dev->bdaddr, &conn->bdaddr, rp->level);
+}
+
 static inline void cmd_complete(int index, void *ptr)
 {
 	struct dev_info *dev = &devs[index];
@@ -1844,6 +1860,10 @@ static inline void cmd_complete(int index, void *ptr)
 		ptr += sizeof(evt_cmd_complete);
 		read_local_oob_data_complete(index, status, ptr);
 		break;
+	case cmd_opcode_pack(OGF_HOST_CTL, OCF_READ_TRANSMIT_POWER_LEVEL):
+		ptr += sizeof(evt_cmd_complete);
+		read_txpower_complete(index, ptr);
+		break;
 	};
 }
 
@@ -3158,6 +3178,28 @@ static int hciops_read_clock(int index, bdaddr_t *bdaddr, int which,
 	return 0;
 }
 
+static int hciops_read_tx_power(int index, bdaddr_t *bdaddr)
+{
+	struct dev_info *dev = &devs[index];
+	read_transmit_power_level_cp cp;
+	uint16_t handle;
+	int err;
+
+	err = get_handle(index, bdaddr, &handle);
+	if (err < 0)
+		return err;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = htobs(handle);
+	cp.type = 0x00; /* Current */
+
+	if (hci_send_cmd(dev->sk, OGF_HOST_CTL, OCF_READ_TRANSMIT_POWER_LEVEL,
+				READ_TRANSMIT_POWER_LEVEL_CP_SIZE, &cp) < 0)
+		return -errno;
+
+	return 0;
+}
+
 static int hciops_read_bdaddr(int index, bdaddr_t *bdaddr)
 {
 	struct dev_info *dev = &devs[index];
@@ -3664,6 +3706,7 @@ static struct btd_adapter_ops hci_ops = {
 	.set_dev_class = hciops_set_dev_class,
 	.set_fast_connectable = hciops_fast_connectable,
 	.read_clock = hciops_read_clock,
+	.read_tx_power = hciops_read_tx_power,
 	.read_bdaddr = hciops_read_bdaddr,
 	.block_device = hciops_block_device,
 	.unblock_device = hciops_unblock_device,
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 4302813..7ee86de 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1673,6 +1673,16 @@ static int mgmt_read_clock(int index, bdaddr_t *bdaddr, int which, int timeout,
 	return -ENOSYS;
 }
 
+static int mgmt_read_tx_power(int index, bdaddr_t *bdaddr)
+{
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	DBG("index %d addr %s read transmit power level", index, addr);
+
+	return -ENOSYS;
+}
+
 static int mgmt_read_bdaddr(int index, bdaddr_t *bdaddr)
 {
 	char addr[18];
@@ -2016,6 +2026,7 @@ static struct btd_adapter_ops mgmt_ops = {
 	.set_dev_class = mgmt_set_dev_class,
 	.set_fast_connectable = mgmt_fast_connectable,
 	.read_clock = mgmt_read_clock,
+	.read_tx_power = mgmt_read_tx_power,
 	.read_bdaddr = mgmt_read_bdaddr,
 	.block_device = mgmt_block_device,
 	.unblock_device = mgmt_unblock_device,
diff --git a/src/adapter.h b/src/adapter.h
index 3526849..1fa7431 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -182,6 +182,7 @@ struct btd_adapter_ops {
 	int (*set_fast_connectable) (int index, gboolean enable);
 	int (*read_clock) (int index, bdaddr_t *bdaddr, int which, int timeout,
 					uint32_t *clock, uint16_t *accuracy);
+	int (*read_tx_power) (int index, bdaddr_t *bdaddr);
 	int (*read_bdaddr) (int index, bdaddr_t *bdaddr);
 	int (*block_device) (int index, bdaddr_t *bdaddr);
 	int (*unblock_device) (int index, bdaddr_t *bdaddr);
diff --git a/src/event.c b/src/event.c
index 86a413e..e6383e6 100644
--- a/src/event.c
+++ b/src/event.c
@@ -475,3 +475,11 @@ void btd_event_returned_link_key(bdaddr_t *local, bdaddr_t *peer)
 
 	device_set_paired(device, TRUE);
 }
+
+void btd_event_txpower_read(bdaddr_t *local, bdaddr_t *peer, int8_t level)
+{
+	char peer_addr[18];
+
+	ba2str(peer, peer_addr);
+	DBG("%s TX Power: %d", peer_addr, level);
+}
diff --git a/src/event.h b/src/event.h
index 1268edf..011d933 100644
--- a/src/event.h
+++ b/src/event.h
@@ -40,3 +40,4 @@ int btd_event_user_passkey(bdaddr_t *sba, bdaddr_t *dba);
 int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 					uint8_t key_type, uint8_t pin_length);
+void btd_event_txpower_read(bdaddr_t *local, bdaddr_t *peer, int8_t level);
-- 
1.7.4.1

