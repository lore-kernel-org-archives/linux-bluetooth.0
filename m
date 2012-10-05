Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/7] mgmt: Constify use of bdaddr_t pointer parameters
Date: Fri, 5 Oct 2012 10:16:59 +0200
Message-ID: <1349425021-16766-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349425021-16766-1-git-send-email-szymon.janc@tieto.com>
References: <1349425021-16766-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mark all input only bdaddr_t pointer parameters as const.

---
 plugins/neard.c |    5 +++--
 src/adapter.c   |    6 +++---
 src/adapter.h   |    6 +++---
 src/mgmt.c      |   31 ++++++++++++++++---------------
 src/mgmt.h      |   26 +++++++++++++-------------
 5 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 2fe1785..2da5024 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -216,8 +216,9 @@ static void read_local_complete(struct btd_adapter *adapter, uint8_t *hash,
 		error("D-Bus send failed");
 }
 
-static void bonding_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-					uint8_t status, void *user_data)
+static void bonding_complete(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr, uint8_t status,
+					void *user_data)
 {
 	DBusMessage *msg = user_data;
 	DBusMessage *reply;
diff --git a/src/adapter.c b/src/adapter.c
index 46048ad..152d3bd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3716,7 +3716,7 @@ int adapter_cancel_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr)
 }
 
 static void check_oob_bonding_complete(struct btd_adapter *adapter,
-					bdaddr_t *bdaddr, uint8_t status)
+					const bdaddr_t *bdaddr, uint8_t status)
 {
 	if (!adapter->oob_handler || !adapter->oob_handler->bonding_cb)
 		return;
@@ -3731,8 +3731,8 @@ static void check_oob_bonding_complete(struct btd_adapter *adapter,
 	adapter->oob_handler = NULL;
 }
 
-void adapter_bonding_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-								uint8_t status)
+void adapter_bonding_complete(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr, uint8_t status)
 {
 	struct btd_device *device;
 	char addr[18];
diff --git a/src/adapter.h b/src/adapter.h
index d4fb14b..07c0ad5 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -47,7 +47,7 @@ typedef void (*oob_read_local_cb_t) (struct btd_adapter *adapter,
 					uint8_t *hash, uint8_t *randomizer,
 					void *user_data);
 typedef void (*oob_bonding_cb_t) (struct btd_adapter *adapter,
-					bdaddr_t *bdaddr, uint8_t status,
+					const bdaddr_t *bdaddr, uint8_t status,
 					void *user_data);
 
 struct oob_handler {
@@ -236,8 +236,8 @@ int adapter_create_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 
 int adapter_cancel_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 
-void adapter_bonding_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-							uint8_t status);
+void adapter_bonding_complete(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr, uint8_t status);
 
 int btd_adapter_read_local_oob_data(struct btd_adapter *adapter);
 void adapter_read_local_oob_data_complete(struct btd_adapter *adapter,
diff --git a/src/mgmt.c b/src/mgmt.c
index b689be8..d3f7809 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -432,8 +432,8 @@ static void mgmt_new_settings(int sk, uint16_t index, void *buf, size_t len)
 	info->current_settings = settings;
 }
 
-static void bonding_complete(struct controller_info *info, bdaddr_t *bdaddr,
-								uint8_t status)
+static void bonding_complete(struct controller_info *info,
+					const bdaddr_t *bdaddr, uint8_t status)
 {
 	struct btd_adapter *adapter;
 
@@ -579,7 +579,7 @@ static void mgmt_connect_failed(int sk, uint16_t index, void *buf, size_t len)
 	bonding_complete(info, &ev->addr.bdaddr, ev->status);
 }
 
-int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin,
+int mgmt_pincode_reply(int index, const bdaddr_t *bdaddr, const char *pin,
 								size_t pin_len)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_pin_code_reply)];
@@ -660,7 +660,7 @@ static void mgmt_pin_code_request(int sk, uint16_t index, void *buf, size_t len)
 	}
 }
 
-int mgmt_confirm_reply(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
+int mgmt_confirm_reply(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean success)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_user_confirm_reply)];
@@ -691,7 +691,7 @@ int mgmt_confirm_reply(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	return 0;
 }
 
-int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
+int mgmt_passkey_reply(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							uint32_t passkey)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_user_passkey_reply)];
@@ -2130,7 +2130,7 @@ int mgmt_set_fast_connectable(int index, gboolean enable)
 	return 0;
 }
 
-int mgmt_read_clock(int index, bdaddr_t *bdaddr, int which, int timeout,
+int mgmt_read_clock(int index, const bdaddr_t *bdaddr, int which, int timeout,
 					uint32_t *clock, uint16_t *accuracy)
 {
 	char addr[18];
@@ -2158,7 +2158,7 @@ int mgmt_read_bdaddr(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
-int mgmt_block_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
+int mgmt_block_device(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_block_device)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -2187,7 +2187,7 @@ int mgmt_block_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
 	return 0;
 }
 
-int mgmt_unblock_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
+int mgmt_unblock_device(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_unblock_device)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -2228,7 +2228,7 @@ int mgmt_get_conn_list(int index, GSList **conns)
 	return 0;
 }
 
-int mgmt_disconnect(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
+int mgmt_disconnect(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_disconnect)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -2252,7 +2252,7 @@ int mgmt_disconnect(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
 	return 0;
 }
 
-int mgmt_unpair_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
+int mgmt_unpair_device(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_unpair_device)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -2373,7 +2373,8 @@ int mgmt_set_io_capability(int index, uint8_t io_capability)
 	return 0;
 }
 
-int mgmt_create_bonding(int index, bdaddr_t *bdaddr, uint8_t addr_type, uint8_t io_cap)
+int mgmt_create_bonding(int index, const bdaddr_t *bdaddr, uint8_t addr_type,
+								uint8_t io_cap)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_pair_device)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -2399,7 +2400,7 @@ int mgmt_create_bonding(int index, bdaddr_t *bdaddr, uint8_t addr_type, uint8_t
 	return 0;
 }
 
-int mgmt_cancel_bonding(int index, bdaddr_t *bdaddr)
+int mgmt_cancel_bonding(int index, const bdaddr_t *bdaddr)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_addr_info)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -2438,7 +2439,7 @@ int mgmt_read_local_oob_data(int index)
 	return 0;
 }
 
-int mgmt_add_remote_oob_data(int index, bdaddr_t *bdaddr,
+int mgmt_add_remote_oob_data(int index, const bdaddr_t *bdaddr,
 					uint8_t *hash, uint8_t *randomizer)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_add_remote_oob_data)];
@@ -2467,7 +2468,7 @@ int mgmt_add_remote_oob_data(int index, bdaddr_t *bdaddr,
 	return 0;
 }
 
-int mgmt_remove_remote_oob_data(int index, bdaddr_t *bdaddr)
+int mgmt_remove_remote_oob_data(int index, const bdaddr_t *bdaddr)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_remove_remote_oob_data)];
 	struct mgmt_hdr *hdr = (void *) buf;
@@ -2491,7 +2492,7 @@ int mgmt_remove_remote_oob_data(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
-int mgmt_confirm_name(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
+int mgmt_confirm_name(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean name_known)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_confirm_name)];
diff --git a/src/mgmt.h b/src/mgmt.h
index 1d25cb0..a2c0497 100644
--- a/src/mgmt.h
+++ b/src/mgmt.h
@@ -36,18 +36,18 @@ int mgmt_start_discovery(int index);
 int mgmt_start_le_scanning(int index);
 int mgmt_stop_discovery(int index);
 
-int mgmt_read_clock(int index, bdaddr_t *bdaddr, int which, int timeout,
+int mgmt_read_clock(int index, const bdaddr_t *bdaddr, int which, int timeout,
 					uint32_t *clock, uint16_t *accuracy);
 int mgmt_read_bdaddr(int index, bdaddr_t *bdaddr);
 
-int mgmt_block_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type);
-int mgmt_unblock_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type);
+int mgmt_block_device(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type);
+int mgmt_unblock_device(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type);
 
 int mgmt_get_conn_list(int index, GSList **conns);
 
-int mgmt_disconnect(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type);
+int mgmt_disconnect(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type);
 
-int mgmt_unpair_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type);
+int mgmt_unpair_device(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type);
 
 int mgmt_add_uuid(int index, uuid_t *uuid, uint8_t svc_hint);
 int mgmt_remove_uuid(int index, uuid_t *uuid);
@@ -60,24 +60,24 @@ int mgmt_load_ltks(int index, GSList *keys);
 
 int mgmt_set_io_capability(int index, uint8_t io_capability);
 
-int mgmt_create_bonding(int index, bdaddr_t *bdaddr, uint8_t addr_type,
+int mgmt_create_bonding(int index, const bdaddr_t *bdaddr, uint8_t addr_type,
 							uint8_t io_cap);
-int mgmt_cancel_bonding(int index, bdaddr_t *bdaddr);
+int mgmt_cancel_bonding(int index, const bdaddr_t *bdaddr);
 
-int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin,
+int mgmt_pincode_reply(int index, const bdaddr_t *bdaddr, const char *pin,
 								size_t pin_len);
-int mgmt_confirm_reply(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
+int mgmt_confirm_reply(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean success);
-int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
+int mgmt_passkey_reply(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							uint32_t passkey);
 
 int mgmt_read_local_oob_data(int index);
 
-int mgmt_add_remote_oob_data(int index, bdaddr_t *bdaddr,
+int mgmt_add_remote_oob_data(int index, const bdaddr_t *bdaddr,
 					uint8_t *hash, uint8_t *randomizer);
-int mgmt_remove_remote_oob_data(int index, bdaddr_t *bdaddr);
+int mgmt_remove_remote_oob_data(int index, const bdaddr_t *bdaddr);
 
-int mgmt_confirm_name(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
+int mgmt_confirm_name(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean name_known);
 
 int mgmt_ssp_enabled(int index);
-- 
1.7.9.5

