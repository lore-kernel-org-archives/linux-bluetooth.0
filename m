Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-hoognPwrjH0Tabl36OOH"
Date: Mon, 21 Apr 2008 18:01:52 +0530
Message-Id: <1208781112.28663.9.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [Gateway][PATCH] Initial setup.
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


--=-hoognPwrjH0Tabl36OOH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Johan, 

Attaching the modified gateway patch.
Let me know if anything needs to be changed.  

-Alok.

--=-hoognPwrjH0Tabl36OOH
Content-Disposition: attachment; filename=patch1
Content-Type: text/x-patch; name=patch1; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/manager.c,v
retrieving revision 1.97
diff -u -5 -p -r1.97 manager.c
--- audio/manager.c	14 Apr 2008 14:41:42 -0000	1.97
+++ audio/manager.c	21 Apr 2008 12:24:08 -0000
@@ -101,15 +101,19 @@ static DBusConnection *connection = NULL
 static struct device *default_hs = NULL;
 static struct device *default_dev = NULL;
 
 static GSList *devices = NULL;
 
-static uint32_t hs_record_id = 0;
-static uint32_t hf_record_id = 0;
+static uint32_t hsp_ag_record_id = 0;
+static uint32_t hfp_ag_record_id = 0;
 
-static GIOChannel *hs_server = NULL;
-static GIOChannel *hf_server = NULL;
+static uint32_t hsp_hs_record_id = 0;
+
+static GIOChannel *hsp_ag_server = NULL;
+static GIOChannel *hfp_ag_server = NULL;
+
+static GIOChannel *hsp_hs_server = NULL;
 
 static struct enabled_interfaces enabled = {
 	.headset	= TRUE,
 	.gateway	= FALSE,
 	.sink		= TRUE,
@@ -225,14 +229,20 @@ gboolean server_is_enabled(uint16_t svc)
 {
 	gboolean ret;
 
 	switch (svc) {
 	case HEADSET_SVCLASS_ID:
-		ret = (hs_server != NULL);
+		ret = (hsp_ag_server != NULL);
+		break;
+	case HEADSET_AGW_SVCLASS_ID:
+		ret = (hsp_hs_server != NULL);
 		break;
 	case HANDSFREE_SVCLASS_ID:
-		ret = (hf_server != NULL);
+		ret = (hfp_ag_server != NULL);
+		break;
+	case HANDSFREE_AGW_SVCLASS_ID:
+		ret = FALSE;
 		break;
 	case AUDIO_SINK_SVCLASS_ID:
 		return enabled.sink;
 	case AV_REMOTE_TARGET_SVCLASS_ID:
 	case AV_REMOTE_SVCLASS_ID:
@@ -1220,10 +1230,66 @@ static sdp_record_t *hsp_ag_record(uint8
 	sdp_list_free(svclass_id, 0);
 
 	return record;
 }
 
+static sdp_record_t *hsp_hs_record(uint8_t ch)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
+	uuid_t l2cap_uuid, rfcomm_uuid;
+	sdp_profile_desc_t profile;
+	sdp_record_t *record;
+	sdp_list_t *aproto, *proto[2];
+	sdp_data_t *channel;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&svclass_uuid, HEADSET_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &svclass_uuid);
+	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
+	profile.version = 0x0100;
+	pfseq = sdp_list_append(0, &profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[1] = sdp_list_append(0, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &ch);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "Headset", 0, 0);
+
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(pfseq, 0);
+	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
+
+	return record;
+}
+
 static sdp_record_t *hfp_ag_record(uint8_t ch, uint32_t feat)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
 	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
 	uuid_t l2cap_uuid, rfcomm_uuid;
@@ -1358,11 +1424,11 @@ static gboolean ag_io_cb(GIOChannel *cha
 	if (cli_sk < 0) {
 		error("accept: %s (%d)", strerror(errno), errno);
 		return TRUE;
 	}
 
-	if (chan == hs_server) {
+	if (chan == hsp_ag_server) {
 		hfp_active = FALSE;
 		uuid = HSP_AG_UUID;
 	} else {
 		hfp_active = TRUE;
 		uuid = HFP_AG_UUID;
@@ -1404,10 +1470,16 @@ failed:
 	headset_close_rfcomm(device);
 
 	return TRUE;
 }
 
+static gboolean hs_io_cb(GIOChannel *chan, GIOCondition cond, void *data)
+{
+	/*Stub*/
+	return TRUE;
+}
+
 static GIOChannel *server_socket(uint8_t *channel, gboolean master)
 {
 	int sock, lm;
 	struct sockaddr_rc addr;
 	socklen_t sa_len;
@@ -1467,11 +1539,11 @@ static int headset_server_init(DBusConne
 	sdp_record_t *record;
 	gboolean hfp = TRUE, master = TRUE;
 	GError *err = NULL;
 	uint32_t features;
 
-	if (!(enabled.headset || enabled.gateway))
+	if (!enabled.headset)
 		return 0;
 
 	if (config) {
 		gboolean tmp;
 
@@ -1492,12 +1564,12 @@ static int headset_server_init(DBusConne
 			err = NULL;
 		} else
 			hfp = tmp;
 	}
 
-	hs_server = server_socket(&chan, master);
-	if (!hs_server)
+	hsp_ag_server = server_socket(&chan, master);
+	if (!hsp_ag_server)
 		return -1;
 
 	record = hsp_ag_record(chan);
 	if (!record) {
 		error("Unable to allocate new service record");
@@ -1505,28 +1577,28 @@ static int headset_server_init(DBusConne
 	}
 
 	if (add_record_to_server(BDADDR_ANY, record) < 0) {
 		error("Unable to register HS AG service record");
 		sdp_record_free(record);
-		g_io_channel_unref(hs_server);
-		hs_server = NULL;
+		g_io_channel_unref(hsp_ag_server);
+		hsp_ag_server = NULL;
 		return -1;
 	}
-	hs_record_id = record->handle;
+	hsp_ag_record_id = record->handle;
 
-	g_io_add_watch(hs_server, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+	g_io_add_watch(hsp_ag_server, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				(GIOFunc) ag_io_cb, NULL);
 
 	features = headset_config_init(config);
 
 	if (!hfp)
 		return 0;
 
 	chan = DEFAULT_HF_AG_CHANNEL;
 
-	hf_server = server_socket(&chan, master);
-	if (!hf_server)
+	hfp_ag_server = server_socket(&chan, master);
+	if (!hfp_ag_server)
 		return -1;
 
 	record = hfp_ag_record(chan, features);
 	if (!record) {
 		error("Unable to allocate new service record");
@@ -1534,42 +1606,99 @@ static int headset_server_init(DBusConne
 	}
 
 	if (add_record_to_server(BDADDR_ANY, record) < 0) {
 		error("Unable to register HF AG service record");
 		sdp_record_free(record);
-		g_io_channel_unref(hf_server);
-		hf_server = NULL;
+		g_io_channel_unref(hfp_ag_server);
+		hfp_ag_server = NULL;
 		return -1;
 	}
-	hf_record_id = record->handle;
+	hfp_ag_record_id = record->handle;
 
-	g_io_add_watch(hf_server, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+	g_io_add_watch(hfp_ag_server, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 			(GIOFunc) ag_io_cb, NULL);
 
 	return 0;
 }
 
+static int gateway_server_init(DBusConnection *conn, GKeyFile *config)
+{
+	uint8_t chan = DEFAULT_HSP_HS_CHANNEL;
+	sdp_record_t *record;
+	gboolean master = TRUE;
+	GError *err = NULL;
+
+	if (!enabled.gateway)
+		return 0;
+
+	if (config) {
+		gboolean tmp;
+
+		tmp = g_key_file_get_boolean(config, "General", "Master",
+						&err);
+		if (err) {
+			debug("audio.conf: %s", err->message);
+			g_error_free(err);
+			err = NULL;
+		} else
+			master = tmp;
+	}
+
+	hsp_hs_server = server_socket(&chan, master);
+	if (!hsp_hs_server)
+		return -1;
+
+	record = hsp_hs_record(chan);
+	if (!record) {
+		error("Unable to allocate new service record");
+		return -1;
+	}
+
+	if (add_record_to_server(BDADDR_ANY, record) < 0) {
+		error("Unable to register HSP HS service record");
+		sdp_record_free(record);
+		g_io_channel_unref(hsp_hs_server);
+		hsp_hs_server = NULL;
+		return -1;
+	}
+	hsp_hs_record_id = record->handle;
+
+	g_io_add_watch(hsp_hs_server, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				(GIOFunc) hs_io_cb, NULL);
+	return 0;
+}
+
 static void server_exit(void)
 {
-	if (hs_record_id) {
-		remove_record_from_server(hs_record_id);
-		hs_record_id = 0;
+	if (hsp_ag_record_id) {
+		remove_record_from_server(hsp_ag_record_id);
+		hsp_ag_record_id = 0;
 	}
 
-	if (hs_server) {
-		g_io_channel_unref(hs_server);
-		hs_server = NULL;
+	if (hsp_ag_server) {
+		g_io_channel_unref(hsp_ag_server);
+		hsp_ag_server = NULL;
 	}
 
-	if (hf_record_id) {
-		remove_record_from_server(hf_record_id);
-		hf_record_id = 0;
+	if (hsp_hs_record_id) {
+		remove_record_from_server(hsp_hs_record_id);
+		hsp_hs_record_id = 0;
 	}
 
-	if (hf_server) {
-		g_io_channel_unref(hf_server);
-		hf_server = NULL;
+	if (hsp_hs_server) {
+		g_io_channel_unref(hsp_hs_server);
+		hsp_hs_server = NULL;
+	}
+
+	if (hfp_ag_record_id) {
+		remove_record_from_server(hfp_ag_record_id);
+		hfp_ag_record_id = 0;
+	}
+
+	if (hfp_ag_server) {
+		g_io_channel_unref(hfp_ag_server);
+		hfp_ag_server = NULL;
 	}
 }
 
 int audio_manager_init(DBusConnection *conn, GKeyFile *config)
 {
@@ -1629,10 +1758,15 @@ int audio_manager_init(DBusConnection *c
 	if (enabled.headset) {
 		if (headset_server_init(conn, config) < 0)
 			goto failed;
 	}
 
+	if (enabled.gateway) {
+		if (gateway_server_init(conn, config) < 0)
+			goto failed;
+	}
+
 	if (enabled.source || enabled.sink) {
 		if (a2dp_init(conn, config) < 0)
 			goto failed;
 	}
 
Index: audio/gateway.h
===================================================================
RCS file: /cvsroot/bluez/utils/audio/gateway.h,v
retrieving revision 1.8
diff -u -5 -p -r1.8 gateway.h
--- audio/gateway.h	2 Feb 2008 03:37:05 -0000	1.8
+++ audio/gateway.h	21 Apr 2008 12:24:08 -0000
@@ -22,10 +22,13 @@
  *
  */
 
 #define AUDIO_GATEWAY_INTERFACE "org.bluez.audio.Gateway"
 
+#define DEFAULT_HSP_HS_CHANNEL 6
+#define DEFAULT_HFP_HS_CHANNEL 7
+
 int gateway_init(DBusConnection *conn, gboolean disable_hfp, gboolean sco_hci);
 
 void gateway_exit(void);
 
 gboolean gateway_is_enabled(uint16_t svc);

--=-hoognPwrjH0Tabl36OOH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--=-hoognPwrjH0Tabl36OOH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-hoognPwrjH0Tabl36OOH--
