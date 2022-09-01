Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD9ECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 10:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiIAKnt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 06:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiIAKnn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 06:43:43 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9CDD769
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 03:43:40 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 13CDF240009
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 10:43:37 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 1/6] adapter: Keep track of whether the adapter is rfkill'ed
Date:   Thu,  1 Sep 2022 12:43:26 +0200
Message-Id: <20220901104331.174588-1-hadess@hadess.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Instead of only replying to D-Bus requests with an error saying the
adapter is blocked, keep track of the rfkill being enabled or disabled
so we know the rfkill state of the adapter at all times.
---
 src/adapter.c | 25 +++++++++++++++++--
 src/adapter.h |  1 +
 src/btd.h     |  1 +
 src/rfkill.c  | 68 +++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 51b099dae..7c11a688d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -250,6 +250,7 @@ struct btd_adapter {
 	uint32_t dev_class;		/* controller class of device */
 	char *name;			/* controller device name */
 	char *short_name;		/* controller short name */
+	bool blocked;			/* whether rfkill is enabled */
 	uint32_t supported_settings;	/* controller supported settings */
 	uint32_t pending_settings;	/* pending controller settings */
 	uint32_t current_settings;	/* current controller settings */
@@ -654,6 +655,8 @@ static void set_mode_complete(uint8_t status, uint16_t length,
 	if (status != MGMT_STATUS_SUCCESS) {
 		btd_error(adapter->dev_id, "Failed to set mode: %s (0x%02x)",
 						mgmt_errstr(status), status);
+		if (status == MGMT_STATUS_RFKILLED)
+			adapter->blocked = true;
 		adapter->pending_settings &= ~data->setting;
 		return;
 	}
@@ -2947,10 +2950,12 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 		btd_error(adapter->dev_id, "Failed to set mode: %s (0x%02x)",
 						mgmt_errstr(status), status);
 
-		if (status == MGMT_STATUS_RFKILLED)
+		if (status == MGMT_STATUS_RFKILLED) {
 			dbus_err = ERROR_INTERFACE ".Blocked";
-		else
+			adapter->blocked = true;
+		} else {
 			dbus_err = ERROR_INTERFACE ".Failed";
+		}
 
 		g_dbus_pending_property_error(data->id, dbus_err,
 							mgmt_errstr(status));
@@ -6681,6 +6686,7 @@ static void load_config(struct btd_adapter *adapter)
 static struct btd_adapter *btd_adapter_new(uint16_t index)
 {
 	struct btd_adapter *adapter;
+	int blocked;
 
 	adapter = g_try_new0(struct btd_adapter, 1);
 	if (!adapter)
@@ -6689,6 +6695,9 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 	adapter->dev_id = index;
 	adapter->mgmt = mgmt_ref(mgmt_primary);
 	adapter->pincode_requested = false;
+	blocked = rfkill_get_blocked(index);
+	if (blocked > 0)
+		adapter->blocked = true;
 
 	/*
 	 * Setup default configuration values. These are either adapter
@@ -6714,6 +6723,8 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 	DBG("Modalias: %s", adapter->modalias);
 	DBG("Discoverable timeout: %u seconds", adapter->discoverable_timeout);
 	DBG("Pairable timeout: %u seconds", adapter->pairable_timeout);
+	if (blocked > 0)
+		DBG("Blocked: yes");
 
 	adapter->auths = g_queue_new();
 	adapter->exps = queue_new();
@@ -7581,6 +7592,9 @@ int btd_cancel_authorization(guint id)
 
 int btd_adapter_restore_powered(struct btd_adapter *adapter)
 {
+	if (adapter->blocked)
+		adapter->blocked = false;
+
 	if (btd_adapter_get_powered(adapter))
 		return 0;
 
@@ -7589,6 +7603,13 @@ int btd_adapter_restore_powered(struct btd_adapter *adapter)
 	return 0;
 }
 
+int btd_adapter_set_blocked(struct btd_adapter *adapter)
+{
+	if (!adapter->blocked)
+		adapter->blocked = true;
+	return 0;
+}
+
 void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 							btd_adapter_pin_cb_t cb)
 {
diff --git a/src/adapter.h b/src/adapter.h
index f38f473b7..78eb069ae 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -144,6 +144,7 @@ guint btd_request_authorization_cable_configured(const bdaddr_t *src, const bdad
 int btd_cancel_authorization(guint id);
 
 int btd_adapter_restore_powered(struct btd_adapter *adapter);
+int btd_adapter_set_blocked(struct btd_adapter *adapter);
 
 typedef ssize_t (*btd_adapter_pin_cb_t) (struct btd_adapter *adapter,
 			struct btd_device *dev, char *out, bool *display,
diff --git a/src/btd.h b/src/btd.h
index c02b2691e..63be6d8d4 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -144,6 +144,7 @@ void plugin_cleanup(void);
 
 void rfkill_init(void);
 void rfkill_exit(void);
+int rfkill_get_blocked(uint16_t index);
 
 GKeyFile *btd_get_main_conf(void);
 bool btd_kernel_experimental_enabled(const char *uuid);
diff --git a/src/rfkill.c b/src/rfkill.c
index 2099c5ac5..511e351b8 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -55,12 +55,73 @@ struct rfkill_event {
 };
 #define RFKILL_EVENT_SIZE_V1    8
 
+int rfkill_get_blocked(uint16_t index)
+{
+	struct rfkill_event event = { 0 };
+	int fd;
+	ssize_t len;
+	int blocked = -1;
+
+	fd = open("/dev/rfkill", O_RDWR);
+	if (fd < 0) {
+		DBG("Failed to open RFKILL control device");
+		return -1;
+	}
+
+	while (1) {
+		char sysname[PATH_MAX];
+		int namefd, id;
+
+		len = read(fd, &event, sizeof(event));
+		if (len < 0) {
+			if (errno == EAGAIN)
+				return -1;
+			return -1;
+		}
+
+		if (len < RFKILL_EVENT_SIZE_V1)
+			return -1;
+
+		snprintf(sysname, sizeof(sysname) - 1,
+				"/sys/class/rfkill/rfkill%u/name", event.idx);
+
+		namefd = open(sysname, O_RDONLY);
+		if (namefd < 0)
+			continue;
+
+		memset(sysname, 0, sizeof(sysname));
+
+		if (read(namefd, sysname, sizeof(sysname) - 1) < 4) {
+			close(namefd);
+			continue;
+		}
+
+		close(namefd);
+
+		if (g_str_has_prefix(sysname, "hci") == FALSE)
+			continue;
+
+		id = atoi(sysname + 3);
+		if (id < 0)
+			continue;
+
+		if (index == id) {
+			blocked = event.soft || event.hard;
+			break;
+		}
+	}
+	close(fd);
+
+	return blocked;
+}
+
 static gboolean rfkill_event(GIOChannel *chan,
 				GIOCondition cond, gpointer data)
 {
 	struct rfkill_event event = { 0 };
 	struct btd_adapter *adapter;
 	char sysname[PATH_MAX];
+	bool blocked = false;
 	ssize_t len;
 	int fd, id;
 
@@ -84,7 +145,7 @@ static gboolean rfkill_event(GIOChannel *chan,
 						event.soft, event.hard);
 
 	if (event.soft || event.hard)
-		return TRUE;
+		blocked = true;
 
 	if (event.op != RFKILL_OP_CHANGE)
 		return TRUE;
@@ -122,7 +183,10 @@ static gboolean rfkill_event(GIOChannel *chan,
 
 	DBG("RFKILL unblock for hci%d", id);
 
-	btd_adapter_restore_powered(adapter);
+	if (blocked)
+		btd_adapter_set_blocked(adapter);
+	else
+		btd_adapter_restore_powered(adapter);
 
 	return TRUE;
 }
-- 
2.37.2

