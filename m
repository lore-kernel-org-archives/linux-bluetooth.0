Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <tkrat.091a3ceefb96c3e3@bencohen.org>
References: <tkrat.091a3ceefb96c3e3@bencohen.org>
Content-Type: multipart/mixed; boundary="=-NP7LyDWWWVQqaSlMMTW4"
Date: Tue, 08 Jan 2008 00:28:23 +0530
Message-Id: <1199732303.24000.4.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] headset.c fixes
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-NP7LyDWWWVQqaSlMMTW4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan/Fredric,

Here is the patch which fixes headset.c issues discussed on #bluez
yesterday.

Let me know if anything needs to be changed. 

Alok. 





--=-NP7LyDWWWVQqaSlMMTW4
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

diff --git a/audio/headset.c b/audio/headset.c
index c669b51..2919fc7 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -111,8 +111,8 @@ struct headset {
 	int data_start;
 	int data_length;
 
-	int enable_hfp;
-	headset_type_t type;
+	gboolean hfp_active;
+	gboolean search_hfp;
 
 	headset_state_t state;
 	GSList *pending;
@@ -604,6 +604,11 @@ static gboolean rfcomm_connect_cb(GIOChannel *chan, GIOCondition cond,
 	hs->rfcomm = chan;
 	c->io = NULL;
 
+	if (server_is_enabled(HANDSFREE_SVCLASS_ID) && hs->hfp_handle != 0)
+		hs->hfp_active = TRUE;
+	else
+		hs->hfp_active = FALSE;
+
 	headset_set_state(device, HEADSET_STATE_CONNECTED);
 
 	debug("%s: Connected to %s", device->path, hs_address);
@@ -699,7 +704,7 @@ static void get_record_reply(DBusPendingCall *call, void *data)
 		goto failed_not_supported;
 	}
 
-	id = hs->enable_hfp ? HANDSFREE_SVCLASS_ID : HEADSET_SVCLASS_ID;
+	id = server_is_enabled(HANDSFREE_SVCLASS_ID) ? HANDSFREE_SVCLASS_ID : HEADSET_SVCLASS_ID;
 
 	if ((uuid.type == SDP_UUID32 && uuid.value.uuid32 != id)
 		|| (uuid.type == SDP_UUID16 && uuid.value.uuid16 != id)) {
@@ -810,9 +815,9 @@ static void get_handles_reply(DBusPendingCall *call, void *data)
 
 	if (array_len < 1) {
 
-		if(hs->type == SVC_HANDSFREE) {
+		if (hs->search_hfp) {
 			debug("No record handles found for hfp");
-			hs->type = SVC_HEADSET;
+			hs->search_hfp = FALSE;
 			get_handles(device, c);
 			dbus_message_unref(reply);
 			return;
@@ -892,10 +897,10 @@ static int get_handles(struct device *device, struct pending_connect *c)
 		return -EINVAL;
 	}
 
-	if (hs->type == SVC_HEADSET)
-		hs_svc = "hsp";
-	else
+	if (hs->search_hfp)
 		hs_svc = "hfp";
+	else
+		hs_svc = "hsp";
 
 	ba2str(&device->dst, hs_address);
 	addr_ptr = hs_address;
@@ -931,8 +936,6 @@ static int rfcomm_connect(struct device *device, struct pending_connect *c)
 		if (!g_slist_find(hs->pending, c))
 			hs->pending = g_slist_append(hs->pending, c);
 
-		hs->type = hs->enable_hfp ? SVC_HANDSFREE : SVC_HEADSET;
-
 		if (hs->state == HEADSET_STATE_DISCONNECTED)
 			return get_handles(device, c);
 		else
@@ -1440,8 +1443,8 @@ void headset_update(struct device *dev, sdp_record_t *record, uint16_t svc)
 	headset_set_channel(headset, record);
 }
 
-struct headset *headset_init(struct device *dev, int enable_hfp,
-				sdp_record_t *record, uint16_t svc)
+struct headset *headset_init(struct device *dev, sdp_record_t *record,
+				uint16_t svc)
 {
 	struct headset *hs;
 
@@ -1449,7 +1452,8 @@ struct headset *headset_init(struct device *dev, int enable_hfp,
 	hs->rfcomm_ch = -1;
 	hs->sp_gain = -1;
 	hs->mic_gain = -1;
-	hs->enable_hfp = enable_hfp;
+	hs->search_hfp = server_is_enabled(HANDSFREE_SVCLASS_ID);
+	hs->hfp_active = FALSE;
 
 	if (!record)
 		goto register_iface;
@@ -1561,18 +1565,16 @@ error:
 	return 0;
 }
 
-headset_type_t headset_get_type(struct device *dev)
+gboolean get_hfp_active(struct device *dev)
 {
 	struct headset *hs = dev->headset;
-
-	return hs->type;
+	return hs->hfp_active;
 }
 
-void headset_set_type(struct device *dev, headset_type_t type)
+void set_hfp_active(struct device *dev, gboolean active)
 {
 	struct headset *hs = dev->headset;
-
-	hs->type = type;
+	hs->hfp_active = active;
 }
 
 int headset_connect_rfcomm(struct device *dev, int sock)
diff --git a/audio/headset.h b/audio/headset.h
index 179c8a4..4869bb3 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -36,19 +36,14 @@ typedef enum {
 } headset_state_t;
 
 typedef enum {
-	SVC_HEADSET,
-	SVC_HANDSFREE
-} headset_type_t;
-
-typedef enum {
 	HEADSET_LOCK_READ = 1,
 	HEADSET_LOCK_WRITE = 1 << 1,
 } headset_lock_t;
 
 typedef void (*headset_stream_cb_t) (struct device *dev, void *user_data);
 
-struct headset *headset_init(struct device *dev, int enable_hfp,
-				sdp_record_t *record, uint16_t svc);
+struct headset *headset_init(struct device *dev, sdp_record_t *record,
+				uint16_t svc);
 
 void headset_free(struct device *dev);
 
@@ -58,8 +53,8 @@ unsigned int headset_request_stream(struct device *dev, headset_stream_cb_t cb,
 					void *user_data);
 gboolean headset_cancel_stream(struct device *dev, unsigned int id);
 
-headset_type_t headset_get_type(struct device *dev);
-void headset_set_type(struct device *dev, headset_type_t type);
+gboolean get_hfp_active(struct device *dev);
+void set_hfp_active(struct device *dev, gboolean active);
 
 int headset_connect_rfcomm(struct device *dev, int sock);
 int headset_close_rfcomm(struct device *dev);
@@ -77,4 +72,3 @@ gboolean headset_lock(struct device *dev, headset_lock_t lock);
 gboolean headset_unlock(struct device *dev, headset_lock_t lock);
 gboolean headset_suspend(struct device *dev, void *data);
 gboolean headset_play(struct device *dev, void *data);
-
diff --git a/audio/manager.c b/audio/manager.c
index cfadec4..a24b00e 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -108,7 +108,6 @@ static GIOChannel *hs_server = NULL;
 static GIOChannel *hf_server = NULL;
 
 static const struct enabled_interfaces *enabled;
-static gboolean enable_hfp = FALSE;
 
 static void get_next_record(struct audio_sdp_data *data);
 static DBusHandlerResult get_handles(const char *uuid,
@@ -214,7 +213,7 @@ done:
 	return uuid16;
 }
 
-static gboolean server_is_enabled(uint16_t svc)
+gboolean server_is_enabled(uint16_t svc)
 {
 	gboolean ret;
 
@@ -255,7 +254,6 @@ static void handle_record(sdp_record_t *record, struct device *device)
 			headset_update(device, record, uuid16);
 		else
 			device->headset = headset_init(device,
-							enable_hfp,
 							record, uuid16);
 		break;
 	case HEADSET_AGW_SVCLASS_ID:
@@ -267,7 +265,6 @@ static void handle_record(sdp_record_t *record, struct device *device)
 			headset_update(device, record, uuid16);
 		else
 			device->headset = headset_init(device,
-							enable_hfp,
 							record, uuid16);
 		break;
 	case HANDSFREE_AGW_SVCLASS_ID:
@@ -648,7 +645,7 @@ struct device *manager_device_connected(bdaddr_t *bda, const char *uuid)
 		if (device->headset)
 			return device;
 
-		device->headset = headset_init(device, enable_hfp, NULL, 0);
+		device->headset = headset_init(device, NULL, 0);
 
 		if (!device->headset)
 			return NULL;
@@ -1073,7 +1070,7 @@ static void parse_stored_devices(char *key, char *value, void *data)
 	bacpy(&device->store, src);
 
 	if (enabled->headset && strstr(value, "headset"))
-		device->headset = headset_init(device, enable_hfp, NULL, 0);
+		device->headset = headset_init(device, NULL, 0);
 	if (enabled->sink && strstr(value, "sink"))
 		device->sink = sink_init(device);
 	if (enabled->control && strstr(value, "control"))
@@ -1383,10 +1380,10 @@ static void auth_cb(DBusPendingCall *call, void *data)
 	DBusError err;
 	const char *uuid;
 
-	if (headset_get_type(device) == SVC_HEADSET)
-		uuid = HSP_AG_UUID;
-	else
+	if (get_hfp_active(device))
 		uuid = HFP_AG_UUID;
+	else
+		uuid = HSP_AG_UUID;
 
 	dbus_error_init(&err);
 	if (dbus_set_error_from_message(&err, reply)) {
@@ -1419,7 +1416,7 @@ static gboolean ag_io_cb(GIOChannel *chan, GIOCondition cond, void *data)
 	socklen_t size;
 	const char *uuid;
 	struct device *device;
-	headset_type_t type;
+	gboolean active;
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -1441,10 +1438,10 @@ static gboolean ag_io_cb(GIOChannel *chan, GIOCondition cond, void *data)
 	}
 
 	if (chan == hs_server) {
-		type = SVC_HEADSET;
+		active = FALSE;
 		uuid = HSP_AG_UUID;
 	} else {
-		type = SVC_HANDSFREE;
+		active = TRUE;
 		uuid = HFP_AG_UUID;
 	}
 
@@ -1466,7 +1463,7 @@ static gboolean ag_io_cb(GIOChannel *chan, GIOCondition cond, void *data)
 		return TRUE;
 	}
 
-	headset_set_type(device, type);
+	set_hfp_active(device, active);
 
 	if (!manager_authorize(&device->dst, uuid, auth_cb, device, NULL))
 		goto failed;
@@ -1564,8 +1561,6 @@ static int headset_server_init(DBusConnection *conn, gboolean no_hfp)
 	if (no_hfp)
 		return 0;
 
-	enable_hfp = TRUE;
-
 	chan = DEFAULT_HF_AG_CHANNEL;
 
 	hf_server = server_socket(&chan);
diff --git a/audio/manager.h b/audio/manager.h
index cbcf167..85fe488 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -44,6 +44,7 @@ void audio_exit(void);
 
 uint32_t add_service_record(DBusConnection *conn, sdp_buf_t *buf);
 int remove_service_record(DBusConnection *conn, uint32_t rec_id);
+gboolean server_is_enabled(uint16_t svc);
 
 struct device *manager_find_device(bdaddr_t *bda, const char *interface,
 					gboolean connected);

--=-NP7LyDWWWVQqaSlMMTW4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--=-NP7LyDWWWVQqaSlMMTW4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-NP7LyDWWWVQqaSlMMTW4--
