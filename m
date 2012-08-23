Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v18 14/16] audio: Add SAP GW to org.bluez.Telephony
Date: Thu, 23 Aug 2012 16:39:03 +0200
Message-Id: <1345732745-28706-15-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
References: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony.c        |   72 +++++++++++++++++++++++++++++++++++++++++++++-
 doc/assigned-numbers.txt |    1 +
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/audio/telephony.c b/audio/telephony.c
index 745949b..4c0cba1 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -62,6 +62,7 @@
 #define DEFAULT_HS_AG_CHANNEL 12
 #define DEFAULT_HF_HS_CHANNEL 7
 #define DEFAULT_HF_AG_CHANNEL 13
+#define DEFAULT_SAP_GW_CHANNEL 8
 
 struct telephony_agent;
 
@@ -79,6 +80,7 @@ struct telephony_agent;
 struct profile_config {
 	const char		*uuid;		/* agent property UUID */
 	uint8_t			channel;
+	BtIOSecLevel		sec_level;
 	const char		*r_uuid;
 	uint16_t		r_class;
 	uint16_t		r_profile;
@@ -923,6 +925,61 @@ static sdp_record_t *hfp_hs_record(struct telephony_agent *agent)
 	return record;
 }
 
+static sdp_record_t *sap_gw_record(struct telephony_agent *agent)
+{
+	sdp_list_t *apseq, *aproto, *profiles, *proto[2], *root, *svclass_id;
+	uuid_t sap_uuid, gt_uuid, root_uuid, l2cap, rfcomm;
+	sdp_profile_desc_t profile;
+	sdp_record_t *record;
+	sdp_data_t *ch;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+	sdp_list_free(root, NULL);
+
+	sdp_uuid16_create(&sap_uuid, SAP_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &sap_uuid);
+	sdp_uuid16_create(&gt_uuid, GENERIC_TELEPHONY_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &gt_uuid);
+
+	sdp_set_service_classes(record, svclass_id);
+	sdp_list_free(svclass_id, NULL);
+
+	sdp_uuid16_create(&profile.uuid, SAP_PROFILE_ID);
+	profile.version = agent->version;
+	profiles = sdp_list_append(NULL, &profile);
+	sdp_set_profile_descs(record, profiles);
+	sdp_list_free(profiles, NULL);
+
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
+	proto[1] = sdp_list_append(NULL, &rfcomm);
+	ch = sdp_data_alloc(SDP_UINT8, &agent->config->channel);
+	proto[1] = sdp_list_append(proto[1], ch);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "SIM Access Server", NULL, NULL);
+
+	sdp_data_free(ch);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(aproto, NULL);
+
+	return record;
+}
+
 static void gateway_auth_cb(DBusError *derr, void *user_data)
 {
 	struct audio_device *au_dev = user_data;
@@ -1280,6 +1337,7 @@ drop:
 static struct profile_config default_configs[] = {
 	{ DUN_GW_UUID,
 		DEFAULT_DUN_GW_CHANNEL,
+		BT_IO_SEC_MEDIUM,
 		NULL,
 		0,
 		0,
@@ -1288,6 +1346,7 @@ static struct profile_config default_configs[] = {
 		client_newconnection_reply },
 	{ HSP_AG_UUID,
 		DEFAULT_HS_AG_CHANNEL,
+		BT_IO_SEC_MEDIUM,
 		HSP_HS_UUID,
 		HEADSET_SVCLASS_ID,
 		HEADSET_PROFILE_ID,
@@ -1296,6 +1355,7 @@ static struct profile_config default_configs[] = {
 		hs_newconnection_reply },
 	{ HFP_HS_UUID,
 		DEFAULT_HF_HS_CHANNEL,
+		BT_IO_SEC_MEDIUM,
 		HFP_AG_UUID,
 		HANDSFREE_AGW_SVCLASS_ID,
 		HANDSFREE_PROFILE_ID,
@@ -1304,12 +1364,22 @@ static struct profile_config default_configs[] = {
 		ag_newconnection_reply },
 	{ HFP_AG_UUID,
 		DEFAULT_HF_AG_CHANNEL,
+		BT_IO_SEC_MEDIUM,
 		HFP_HS_UUID,
 		HANDSFREE_SVCLASS_ID,
 		HANDSFREE_PROFILE_ID,
 		hfp_ag_record,
 		ag_confirm,
 		hs_newconnection_reply },
+	{ SAP_UUID,
+		DEFAULT_SAP_GW_CHANNEL,
+		BT_IO_SEC_HIGH,
+		NULL,
+		0,
+		0,
+		sap_gw_record,
+		client_confirm,
+		client_newconnection_reply },
 };
 
 static void agent_disconnect_cb(DBusConnection *conn, void *user_data)
@@ -1409,7 +1479,7 @@ static DBusMessage *register_agent(DBusConnection *conn,
 				agent, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_CHANNEL, agent->config->channel,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_SEC_LEVEL, agent->config->sec_level,
 				BT_IO_OPT_MASTER, master,
 				BT_IO_OPT_INVALID);
 	if (agent->io == NULL) {
diff --git a/doc/assigned-numbers.txt b/doc/assigned-numbers.txt
index 120d7ea..bc85cf6 100644
--- a/doc/assigned-numbers.txt
+++ b/doc/assigned-numbers.txt
@@ -10,6 +10,7 @@ Profile		Channel
 DUN		1
 HSP HS		6
 HFP HF		7
+SAP		8
 OPP		9
 FTP		10
 BIP		11
-- 
1.7.9.5

