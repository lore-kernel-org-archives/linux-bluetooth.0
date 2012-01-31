Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 6/6] adapter_ops: Add address type information to the pair_device command
Date: Tue, 31 Jan 2012 14:10:53 -0300
Message-Id: <1328029853-21134-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328029853-21134-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328029853-21134-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we have address type information we have to inform it
when pairing with an device.
---
 plugins/hciops.c  |    3 ++-
 plugins/mgmtops.c |    3 ++-
 src/adapter.c     |    5 +++--
 src/adapter.h     |    5 +++--
 src/device.c      |    3 ++-
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index be8b412..90106df 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3649,7 +3649,8 @@ failed:
 	bonding_complete(dev, conn, HCI_UNSPECIFIED_ERROR);
 }
 
-static int hciops_create_bonding(int index, bdaddr_t *bdaddr, uint8_t io_cap)
+static int hciops_create_bonding(int index, bdaddr_t *bdaddr,
+					uint8_t addr_type, uint8_t io_cap)
 {
 	struct dev_info *dev = &devs[index];
 	BtIOSecLevel sec_level;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 63af363..8f6788e 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1952,7 +1952,7 @@ static int mgmt_set_io_capability(int index, uint8_t io_capability)
 	return 0;
 }
 
-static int mgmt_create_bonding(int index, bdaddr_t *bdaddr, uint8_t io_cap)
+static int mgmt_create_bonding(int index, bdaddr_t *bdaddr, uint8_t addr_type, uint8_t io_cap)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_pair_device)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -1968,6 +1968,7 @@ static int mgmt_create_bonding(int index, bdaddr_t *bdaddr, uint8_t io_cap)
 	hdr->index = htobs(index);
 
 	bacpy(&cp->addr.bdaddr, bdaddr);
+	cp->addr.type = addr_type;
 	cp->io_cap = io_cap;
 
 	if (write(mgmt_sock, &buf, sizeof(buf)) < 0)
diff --git a/src/adapter.c b/src/adapter.c
index 25f70ff..89f6ca7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3551,10 +3551,11 @@ int btd_adapter_set_did(struct btd_adapter *adapter, uint16_t vendor,
 }
 
 int adapter_create_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-								uint8_t io_cap)
+					uint8_t addr_type, uint8_t io_cap)
 {
 	suspend_discovery(adapter);
-	return adapter_ops->create_bonding(adapter->dev_id, bdaddr, io_cap);
+	return adapter_ops->create_bonding(adapter->dev_id, bdaddr,
+						addr_type, io_cap);
 }
 
 int adapter_cancel_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr)
diff --git a/src/adapter.h b/src/adapter.h
index c1f981a..7265d8b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -212,7 +212,8 @@ struct btd_adapter_ops {
 	int (*restore_powered) (int index);
 	int (*load_keys) (int index, GSList *keys, gboolean debug_keys);
 	int (*set_io_capability) (int index, uint8_t io_capability);
-	int (*create_bonding) (int index, bdaddr_t *bdaddr, uint8_t io_cap);
+	int (*create_bonding) (int index, bdaddr_t *bdaddr, uint8_t addr_type,
+							uint8_t io_cap);
 	int (*cancel_bonding) (int index, bdaddr_t *bdaddr);
 	int (*read_local_oob_data) (int index);
 	int (*add_remote_oob_data) (int index, bdaddr_t *bdaddr, uint8_t *hash,
@@ -265,7 +266,7 @@ int btd_adapter_set_did(struct btd_adapter *adapter, uint16_t vendor,
 					uint16_t product, uint16_t version);
 
 int adapter_create_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							uint8_t io_cap);
+				uint8_t addr_type, uint8_t io_cap);
 
 int adapter_cancel_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 
diff --git a/src/device.c b/src/device.c
index 0133e07..b2c8379 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2297,7 +2297,8 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 	if (device_is_bonded(device))
 		return btd_error_already_exists(msg);
 
-	err = adapter_create_bonding(adapter, &device->bdaddr, capability);
+	err = adapter_create_bonding(adapter, &device->bdaddr,
+					device->type, capability);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
-- 
1.7.8.1

