Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 6/6] android/bluetooth: Clear auto connect list on startup
Date: Fri,  1 Aug 2014 10:45:33 +0200
Message-Id: <1406882733-6064-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1406882733-6064-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1406882733-6064-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In android we add devices to auto connect list when application trigger
connect. We need to make sure that when bluetooth is turn on there is
no devices in auto connect list in the kernel.
---
 android/bluetooth.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index def9d0b..c94f7e7 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3123,6 +3123,34 @@ static void add_mps_record(void)
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
+	if (!main_opts.kernel_conn_control)
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
@@ -3180,6 +3208,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	register_mgmt_handlers();
 
 	clear_uuids();
+	clear_auto_connect_list();
 
 	set_io_capability();
 	set_device_id();
-- 
1.8.4

