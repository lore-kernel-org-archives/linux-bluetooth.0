Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 08/13] Rename adapter_find_device to btd_adapter_find_device
Date: Mon, 25 Nov 2013 22:15:47 +0000
Message-Id: <1385417752-25664-9-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow this symbol to be exported and usable from external plugins.
---
 profiles/audio/avctp.c  |  2 +-
 profiles/audio/avdtp.c  |  2 +-
 profiles/input/device.c |  2 +-
 src/adapter.c           | 22 +++++++++++-----------
 src/adapter.h           |  2 +-
 src/attrib-server.c     |  2 +-
 src/profile.c           |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 29fe763..4de981c 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1371,7 +1371,7 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 
 	DBG("AVCTP: incoming connect from %s", address);
 
-	device = adapter_find_device(adapter_find(&src), &dst);
+	device = btd_adapter_find_device(adapter_find(&src), &dst);
 	if (!device)
 		return;
 
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 9386c44..f866b39 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2467,7 +2467,7 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 
 	DBG("AVDTP: incoming connect from %s", address);
 
-	device = adapter_find_device(adapter_find(&src), &dst);
+	device = btd_adapter_find_device(adapter_find(&src), &dst);
 	if (!device)
 		goto drop;
 
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 71fe04a..0c2089b 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -880,7 +880,7 @@ static struct input_device *find_device(const bdaddr_t *src,
 	struct btd_device *device;
 	struct btd_service *service;
 
-	device = adapter_find_device(adapter_find(src), dst);
+	device = btd_adapter_find_device(adapter_find(src), dst);
 	if (device == NULL)
 		return NULL;
 
diff --git a/src/adapter.c b/src/adapter.c
index a5a9ada..ea94753 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -690,7 +690,7 @@ int adapter_set_name(struct btd_adapter *adapter, const char *name)
 	return set_name(adapter, name);
 }
 
-struct btd_device *adapter_find_device(struct btd_adapter *adapter,
+struct btd_device *btd_adapter_find_device(struct btd_adapter *adapter,
 							const bdaddr_t *dst)
 {
 	struct btd_device *device;
@@ -1081,7 +1081,7 @@ struct btd_device *btd_adapter_get_device(struct btd_adapter *adapter,
 	if (!adapter)
 		return NULL;
 
-	device = adapter_find_device(adapter, addr);
+	device = btd_adapter_find_device(adapter, addr);
 	if (device)
 		return device;
 
@@ -4424,7 +4424,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	struct btd_device *device;
 	static guint id = 0;
 
-	device = adapter_find_device(adapter, dst);
+	device = btd_adapter_find_device(adapter, dst);
 	if (!device)
 		return 0;
 
@@ -4630,7 +4630,7 @@ int btd_adapter_pincode_reply(struct btd_adapter *adapter,
 
 		/* Since a pincode was requested, update the starting time to
 		 * the point where the pincode is provided. */
-		device = adapter_find_device(adapter, bdaddr);
+		device = btd_adapter_find_device(adapter, bdaddr);
 		device_bonding_restart_timer(device);
 
 		id = mgmt_reply(adapter->mgmt, MGMT_OP_PIN_CODE_REPLY,
@@ -4964,7 +4964,7 @@ static void bonding_complete(struct btd_adapter *adapter,
 	if (status == 0)
 		device = btd_adapter_get_device(adapter, bdaddr, addr_type);
 	else
-		device = adapter_find_device(adapter, bdaddr);
+		device = btd_adapter_find_device(adapter, bdaddr);
 
 	if (device != NULL)
 		device_bonding_complete(device, status);
@@ -4991,7 +4991,7 @@ static void bonding_attempt_complete(struct btd_adapter *adapter,
 	if (status == 0)
 		device = btd_adapter_get_device(adapter, bdaddr, addr_type);
 	else
-		device = adapter_find_device(adapter, bdaddr);
+		device = btd_adapter_find_device(adapter, bdaddr);
 
 	if (status == MGMT_STATUS_AUTH_FAILED && adapter->pincode_requested) {
 		/* On faliure, issue a bonding_retry if possible. */
@@ -5150,7 +5150,7 @@ static void dev_disconnected(struct btd_adapter *adapter,
 
 	DBG("Device %s disconnected, reason %u", dst, reason);
 
-	device = adapter_find_device(adapter, &addr->bdaddr);
+	device = btd_adapter_find_device(adapter, &addr->bdaddr);
 	if (device)
 		adapter_remove_connection(adapter, device);
 
@@ -5765,7 +5765,7 @@ static void device_blocked_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, addr);
 	DBG("hci%u %s blocked", index, addr);
 
-	device = adapter_find_device(adapter, &ev->addr.bdaddr);
+	device = btd_adapter_find_device(adapter, &ev->addr.bdaddr);
 	if (device)
 		device_block(device, TRUE);
 }
@@ -5786,7 +5786,7 @@ static void device_unblocked_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, addr);
 	DBG("hci%u %s unblocked", index, addr);
 
-	device = adapter_find_device(adapter, &ev->addr.bdaddr);
+	device = btd_adapter_find_device(adapter, &ev->addr.bdaddr);
 	if (device)
 		device_unblock(device, FALSE, TRUE);
 }
@@ -5808,7 +5808,7 @@ static void connect_failed_callback(uint16_t index, uint16_t length,
 
 	DBG("hci%u %s status %u", index, addr, ev->status);
 
-	device = adapter_find_device(adapter, &ev->addr.bdaddr);
+	device = btd_adapter_find_device(adapter, &ev->addr.bdaddr);
 	if (device) {
 		/* If the device is in a bonding process cancel any auth request
 		 * sent to the agent before proceeding, but keep the bonding
@@ -5854,7 +5854,7 @@ static void unpaired_callback(uint16_t index, uint16_t length,
 
 	DBG("hci%u addr %s", index, addr);
 
-	device = adapter_find_device(adapter, &ev->addr.bdaddr);
+	device = btd_adapter_find_device(adapter, &ev->addr.bdaddr);
 	if (!device) {
 		warn("No device object for unpaired device %s", addr);
 		return;
diff --git a/src/adapter.h b/src/adapter.h
index e982243..de5b07d 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -95,7 +95,7 @@ struct btd_device *btd_adapter_get_device(struct btd_adapter *adapter,
 					uint8_t addr_type);
 sdp_list_t *btd_adapter_get_services(struct btd_adapter *adapter);
 
-struct btd_device *adapter_find_device(struct btd_adapter *adapter,
+struct btd_device *btd_adapter_find_device(struct btd_adapter *adapter,
 							const bdaddr_t *dst);
 
 const char *adapter_get_path(struct btd_adapter *adapter);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 9231b5b..a6f1066 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1137,7 +1137,7 @@ guint attrib_channel_attach(GAttrib *attrib)
 
 	channel->server = server;
 
-	device = adapter_find_device(server->adapter, &channel->dst);
+	device = btd_adapter_find_device(server->adapter, &channel->dst);
 	if (device == NULL) {
 		error("Device object not found for attrib server");
 		g_free(channel);
diff --git a/src/profile.c b/src/profile.c
index 97cb1bc..3c0d27c 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1047,7 +1047,7 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 	GIOCondition cond;
 	char addr[18];
 
-	device = adapter_find_device(server->adapter, dst);
+	device = btd_adapter_find_device(server->adapter, dst);
 	if (device == NULL) {
 		ba2str(dst, addr);
 		error("%s device %s not found", server->ext->name, addr);
-- 
1.8.4.4

