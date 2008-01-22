Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200801182017.36181.chick@computergeek.freeserve.co.uk>
References: <BAY102-W17970DD14D6076D3F44BCBF0420@phx.gbl>
	<200801182017.36181.chick@computergeek.freeserve.co.uk>
Content-Type: multipart/mixed; boundary="=-6CRS/FlkwioZKS6QspqZ"
Date: Tue, 22 Jan 2008 22:45:26 +0530
Message-Id: <1201022126.6065.5.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH][HFP] fixes supported features in AG's SDP
	record
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


--=-6CRS/FlkwioZKS6QspqZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan/Fredric, 

Here is the patch which fixes the "supported features" in AG's SDP
record. 

Let me know if anything needs to be changed. 

Thanks, 
Alok. 


--=-6CRS/FlkwioZKS6QspqZ
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/headset.h
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.h,v
retrieving revision 1.35
diff -u -5 -p -r1.35 headset.h
--- audio/headset.h	16 Jan 2008 09:08:27 -0000	1.35
+++ audio/headset.h	22 Jan 2008 17:12:32 -0000
@@ -45,11 +45,11 @@ typedef void (*headset_stream_cb_t) (str
 struct headset *headset_init(struct device *dev, sdp_record_t *record,
 				uint16_t svc);
 
 void headset_free(struct device *dev);
 
-int headset_config_init(GKeyFile *config);
+uint16_t headset_config_init(GKeyFile *config);
 
 void headset_update(struct device *dev, sdp_record_t *record, uint16_t svc);
 
 unsigned int headset_request_stream(struct device *dev, headset_stream_cb_t cb,
 					void *user_data);
Index: audio/headset.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.c,v
retrieving revision 1.160
diff -u -5 -p -r1.160 headset.c
--- audio/headset.c	22 Jan 2008 13:09:35 -0000	1.160
+++ audio/headset.c	22 Jan 2008 17:12:34 -0000
@@ -73,11 +73,11 @@
 #define AG_FEATURE_REJECT_A_CALL                 0x0020
 #define AG_FEATURE_ENHANCES_CALL_STATUS          0x0040
 #define AG_FEATURE_ENHANCES_CALL_CONTROL         0x0080
 #define AG_FEATURE_EXTENDED_ERROR_RESULT_CODES   0x0100
 /*Audio Gateway features.Default is In-band Ringtone*/
-static unsigned int ag_features;
+static uint32_t ag_features = 0;
 static gboolean sco_hci = TRUE;
 
 static char *str_state[] = {
 	"HEADSET_STATE_DISCONNECTED",
 	"HEADSET_STATE_CONNECT_IN_PROGRESS",
@@ -1672,19 +1672,19 @@ register_iface:
 	}
 
 	return hs;
 }
 
-int headset_config_init(GKeyFile *config)
+uint16_t headset_config_init(GKeyFile *config)
 {
 	GError *err = NULL;
 	gboolean value;
 	char *str;
 
 	/* Use the default values if there is no config file */
 	if (config == NULL)
-		return 0;
+		goto done;
 
 	str = g_key_file_get_string(config, "General", "SCORouting",
 					&err);
 	if (err) {
 		debug("audio.conf: %s", err->message);
@@ -1778,12 +1778,12 @@ int headset_config_init(GKeyFile *config
 		debug("audio.conf: %s", err->message);
 		g_error_free(err);
 		err = NULL;
 	} else if (value)
 		ag_features |= AG_FEATURE_EXTENDED_ERROR_RESULT_CODES;
-
-	return 0;
+done:
+	return (uint16_t) ag_features & 0xf;
 }
 
 void headset_free(struct device *dev)
 {
 	struct headset *hs = dev->headset;
Index: audio/manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/manager.c,v
retrieving revision 1.86
diff -u -5 -p -r1.86 manager.c
--- audio/manager.c	16 Jan 2008 09:08:27 -0000	1.86
+++ audio/manager.c	22 Jan 2008 17:12:34 -0000
@@ -1224,19 +1224,18 @@ static int hsp_ag_record(sdp_buf_t *buf,
 	sdp_list_free(record.pattern, free);
 
 	return ret;
 }
 
-static int hfp_ag_record(sdp_buf_t *buf, uint8_t ch)
+static int hfp_ag_record(sdp_buf_t *buf, uint8_t ch, uint16_t feat)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
 	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
 	uuid_t l2cap_uuid, rfcomm_uuid;
 	sdp_profile_desc_t profile;
 	sdp_list_t *aproto, *proto[2];
 	sdp_record_t record;
-	uint16_t u16 = 0x0009;
 	sdp_data_t *channel, *features;
 	uint8_t netid = 0x01;
 	sdp_data_t *network = sdp_data_alloc(SDP_UINT8, &netid);
 	int ret;
 
@@ -1265,11 +1264,11 @@ static int hfp_ag_record(sdp_buf_t *buf,
 	proto[1] = sdp_list_append(0, &rfcomm_uuid);
 	channel = sdp_data_alloc(SDP_UINT8, &ch);
 	proto[1] = sdp_list_append(proto[1], channel);
 	apseq = sdp_list_append(apseq, proto[1]);
 
-	features = sdp_data_alloc(SDP_UINT16, &u16);
+	features = sdp_data_alloc(SDP_UINT16, &feat);
 	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_FEATURES, features);
 
 	aproto = sdp_list_append(0, apseq);
 	sdp_set_access_protos(&record, aproto);
 
@@ -1539,10 +1538,11 @@ static int headset_server_init(DBusConne
 {
 	uint8_t chan = DEFAULT_HS_AG_CHANNEL;
 	sdp_buf_t buf;
 	gboolean no_hfp = FALSE;
 	GError *err = NULL;
+	uint16_t feat;
 
 	if (!(enabled.headset || enabled.gateway))
 		return 0;
 
 	hs_server = server_socket(&chan);
@@ -1583,11 +1583,13 @@ static int headset_server_init(DBusConne
 
 	hf_server = server_socket(&chan);
 	if (!hf_server)
 		return -1;
 
-	if (hfp_ag_record(&buf, chan) < 0) {
+	feat = headset_config_init(config);
+
+	if (hfp_ag_record(&buf, chan, feat) < 0) {
 		error("Unable to allocate new service record");
 		return -1;
 	}
 
 	hf_record_id = add_service_record(conn, &buf);
@@ -1683,13 +1685,10 @@ int audio_init(DBusConnection *conn, GKe
 		error("D-Bus failed to register %s path", AUDIO_MANAGER_PATH);
 		goto failed;
 	}
 
 	if (enabled.headset) {
-		if (headset_config_init(config) < 0)
-			goto failed;
-
 		if (headset_server_init(conn, config) < 0)
 			goto failed;
 	}
 
 	if (enabled.sink) {

--=-6CRS/FlkwioZKS6QspqZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-6CRS/FlkwioZKS6QspqZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-6CRS/FlkwioZKS6QspqZ--
