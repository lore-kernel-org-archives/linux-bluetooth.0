Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 6/6] android/bluetooth: Clear auto connect list on startup
Date: Mon,  4 Aug 2014 12:34:19 +0200
Message-Id: <1407148459-20125-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In android we add devices to auto connect list when application trigger
connect. We need to make sure that when bluetooth is turn on there is
no devices in auto connect list in the kernel.
---
 android/bluetooth.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 34690b7..38ee9a9 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3129,6 +3129,34 @@ static void add_mps_record(void)
 	}
 }
 
+static void clear_auto_connect_list_complete(uint8_t status,
+							uint16_t length,
+							const void *param,
+							void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS)
+		error("Failed to clear auto connect list: %s (0x%02x)",
+						mgmt_errstr(status), status);
+}
+
+static void clear_auto_connect_list(void)
+{
+	struct mgmt_cp_remove_device cp;
+
+	if (!kernel_conn_control)
+		return;
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (mgmt_send(mgmt_if, MGMT_OP_REMOVE_DEVICE, adapter.index,
+					sizeof(cp), &cp,
+					clear_auto_connect_list_complete,
+					NULL, NULL) > 0)
+		return;
+
+	error("Could not clear auto connect list");
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -3186,6 +3214,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	register_mgmt_handlers();
 
 	clear_uuids();
+	clear_auto_connect_list();
 
 	set_io_capability();
 	set_device_id();
-- 
1.8.4

