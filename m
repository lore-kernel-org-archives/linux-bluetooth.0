Return-Path: <cyrus@holtmann.org>
From: Wu zheng <wu.zheng@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Wu zheng <wu.zheng@intel.com>
Subject: [PATCH] Don't care about power status and adapter power on after rfkill unblock
Date: Tue, 19 Nov 2013 15:01:06 +0800
Message-Id: <1384844466-12902-1-git-send-email-wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't care about the power status of BT adapter before rfkill block.
(BT adapter is power on or off)

When rfkill unblock, BT will set the adapter power on.

It results in the following issue.

Connman can't control BT adapter power on/off rightly.

When using connman down BT, connman will send the dbus command
of power off and set rfkill block BT.

Power off BT: adapter power off -> rfkill block BT.

When using connman up BT, connman will set rfkill unblock BT
and send the dbus command of power on.

Power on BT: rfkill unblock adapter power on -> adapter power on.

When connman enable BT, BT adapter will power on after rfkill unblock.

After then, connman will receive the message of adapter property change.
The message is received before connman finish the message BT up to Bluez.

Thefore, the BT power status of connman is different with BT power status
in the message of adapter property change.

It will result in that connman send the dbus message of power off
to Bluez and power down BT adapter again.

---
 src/adapter.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d904a56..bed195b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -138,6 +138,7 @@ struct btd_adapter {
 	char *short_name;		/* controller short name */
 	uint32_t supported_settings;	/* controller supported settings */
 	uint32_t current_settings;	/* current controller settings */
+	gboolean current_powered;       /* current power status */
 
 	char *path;			/* adapter object path */
 	uint8_t major_class;		/* configured major class */
@@ -1845,6 +1846,7 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 {
 	struct property_set_data *data = user_data;
 	struct btd_adapter *adapter = data->adapter;
+	uint32_t settings;
 
 	DBG("%s (0x%02x)", mgmt_errstr(status), status);
 
@@ -1866,6 +1868,13 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 
 	g_dbus_pending_property_success(data->id);
 
+	settings = bt_get_le32(param);
+
+	if (settings & MGMT_SETTING_POWERED)
+		adapter->current_powered = TRUE;
+	else
+		adapter->current_powered = FALSE;
+
 	/*
 	 * The parameters are identical and also the task that is
 	 * required in both cases. So it is safe to just call the
@@ -4527,6 +4536,9 @@ int btd_adapter_restore_powered(struct btd_adapter *adapter)
 	if (adapter->current_settings & MGMT_SETTING_POWERED)
 		return 0;
 
+	if (adapter->current_powered == FALSE)
+		return 0;
+
 	set_mode(adapter, MGMT_OP_SET_POWERED, 0x01);
 
 	return 0;
@@ -5637,6 +5649,7 @@ static int adapter_register(struct btd_adapter *adapter)
 		load_connections(adapter);
 
 	adapter->initialized = TRUE;
+	adapter->current_powered = FALSE;
 
 	if (main_opts.did_source) {
 		/* DeviceID record is added by sdpd-server before any other
-- 
1.7.7

