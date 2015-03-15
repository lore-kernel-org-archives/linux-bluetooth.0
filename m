Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 09/14] Bluetooth: Add support for untrusted access to management commands
Date: Sat, 14 Mar 2015 19:28:01 -0700
Message-Id: <1426386486-15962-9-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some management commands are safe to be accessed from any user without
special permissions. First step for allowing access to any of these
commands from untrusted application is to mark them accordingly.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/mgmt.c             | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 859005c9a8fc..3546789c1616 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1291,7 +1291,8 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 
 #define HCI_MGMT_VAR_LEN	(1 << 0)
 #define HCI_MGMT_NO_HDEV	(1 << 1)
-#define HCI_MGMT_UNCONFIGURED	(1 << 2)
+#define HCI_MGMT_UNTRUSTED	(1 << 2)
+#define HCI_MGMT_UNCONFIGURED	(1 << 3)
 
 struct hci_mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bd65f7630725..484ee8e2b52c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6251,12 +6251,16 @@ unlock:
 static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ NULL }, /* 0x0000 (no command) */
 	{ read_version,            MGMT_READ_VERSION_SIZE,
-						HCI_MGMT_NO_HDEV },
+						HCI_MGMT_NO_HDEV |
+						HCI_MGMT_UNTRUSTED },
 	{ read_commands,           MGMT_READ_COMMANDS_SIZE,
-						HCI_MGMT_NO_HDEV },
+						HCI_MGMT_NO_HDEV |
+						HCI_MGMT_UNTRUSTED },
 	{ read_index_list,         MGMT_READ_INDEX_LIST_SIZE,
-						HCI_MGMT_NO_HDEV },
-	{ read_controller_info,    MGMT_READ_INFO_SIZE,                 0 },
+						HCI_MGMT_NO_HDEV |
+						HCI_MGMT_UNTRUSTED },
+	{ read_controller_info,    MGMT_READ_INFO_SIZE,
+						HCI_MGMT_UNTRUSTED },
 	{ set_powered,             MGMT_SETTING_SIZE,                   0 },
 	{ set_discoverable,        MGMT_SET_DISCOVERABLE_SIZE,          0 },
 	{ set_connectable,         MGMT_SETTING_SIZE,                   0 },
@@ -6312,9 +6316,11 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ load_conn_param,         MGMT_LOAD_CONN_PARAM_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ read_unconf_index_list,  MGMT_READ_UNCONF_INDEX_LIST_SIZE,
-						HCI_MGMT_NO_HDEV },
+						HCI_MGMT_NO_HDEV |
+						HCI_MGMT_UNTRUSTED },
 	{ read_config_info,        MGMT_READ_CONFIG_INFO_SIZE,
-						HCI_MGMT_UNCONFIGURED },
+						HCI_MGMT_UNCONFIGURED |
+						HCI_MGMT_UNTRUSTED },
 	{ set_external_config,     MGMT_SET_EXTERNAL_CONFIG_SIZE,
 						HCI_MGMT_UNCONFIGURED },
 	{ set_public_address,      MGMT_SET_PUBLIC_ADDRESS_SIZE,
@@ -6323,7 +6329,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_VAR_LEN },
 	{ NULL },
 	{ read_ext_index_list,     MGMT_READ_EXT_INDEX_LIST_SIZE,
-						HCI_MGMT_NO_HDEV },
+						HCI_MGMT_NO_HDEV |
+						HCI_MGMT_UNTRUSTED },
 };
 
 int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
-- 
2.1.0

