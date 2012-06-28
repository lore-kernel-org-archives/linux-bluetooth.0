Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 12/12] audio: Add SAP GW to org.bluez.Telephony
Date: Thu, 28 Jun 2012 10:03:36 +0200
Message-Id: <1340870617-13532-13-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1340870617-13532-1-git-send-email-frederic.danis@linux.intel.com>
References: <1340870617-13532-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony.c |  235 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 234 insertions(+), 1 deletion(-)

diff --git a/audio/telephony.c b/audio/telephony.c
index 1bcad6d..53fa50d 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -61,6 +61,7 @@
 #define DEFAULT_HS_AG_CHANNEL 12
 #define DEFAULT_HF_HS_CHANNEL 7
 #define DEFAULT_HF_AG_CHANNEL 13
+#define DEFAULT_SAP_GW_CHANNEL 8
 
 struct tel_agent;
 
@@ -79,6 +80,7 @@ struct tel_device {
 struct default_agent {
 	const char		*uuid;		/* agent property UUID */
 	uint8_t			channel;
+	BtIOSecLevel		sec_level;
 	const char		*r_uuid;
 	uint16_t		r_class;
 	uint16_t		r_profile;
@@ -430,6 +432,168 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
+static gboolean sap_dev_disconnect_cb(GIOChannel *chan, GIOCondition cond,
+						struct tel_device *dev)
+{
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	telephony_device_disconnect(dev);
+
+	return FALSE;
+}
+
+static void sap_newconnection_reply(DBusPendingCall *call, void *user_data)
+{
+	struct tel_device *dev = user_data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	if (!dev->rfcomm) {
+		DBG("RFCOMM disconnected from server before agent reply");
+		goto done;
+	}
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply)) {
+		DBG("Agent reply: file descriptor passed successfully");
+		g_io_add_watch(dev->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) sap_dev_disconnect_cb, dev);
+		goto done;
+	}
+
+	DBG("Agent reply: %s", derr.message);
+
+	dbus_error_free(&derr);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void sap_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct dun_client *sap = user_data;
+	char hs_address[18];
+	void *agent;
+
+	if (err) {
+		error("%s", err->message);
+		goto done;
+	}
+
+	ba2str(&sap->dst, hs_address);
+
+	agent = telephony_agent_by_uuid(device_get_adapter(sap->btd_dev),
+								SAP_UUID);
+	telephony_device_connecting(chan, sap->btd_dev, sap, agent);
+
+	DBG("%s: Connected to %s", device_get_path(sap->btd_dev), hs_address);
+
+done:
+	g_free(sap);
+
+	return;
+}
+
+static void sap_auth_cb(DBusError *derr, void *user_data)
+{
+	struct dun_client *sap = user_data;
+	GError *err = NULL;
+
+	if (sap->preauth_id) {
+		g_source_remove(sap->preauth_id);
+		sap->preauth_id = 0;
+	}
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		g_free(sap);
+		return;
+	}
+
+	if (!bt_io_accept(sap->rfcomm, sap_connect_cb, sap, NULL, &err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
+		g_free(sap);
+		return;
+	}
+}
+
+static gboolean sap_preauth_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	struct dun_client *sap = user_data;
+
+	DBG("SAP Gateway disconnected during authorization");
+
+	btd_cancel_authorization(&sap->src, &sap->dst);
+
+	g_free(sap);
+
+	return FALSE;
+}
+
+static void sap_confirm(GIOChannel *chan, gpointer data)
+{
+	struct tel_agent *agent = data;
+	struct dun_client *sap;
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+	char addr[18];
+	int perr;
+	GError *err = NULL;
+	uint8_t ch;
+
+	sap = g_new0(struct dun_client, 1);
+
+	bt_io_get(chan, BT_IO_RFCOMM, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &sap->src,
+			BT_IO_OPT_DEST_BDADDR, &sap->dst,
+			BT_IO_OPT_CHANNEL, &ch,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	ba2str(&sap->src, addr);
+
+	adapter = manager_find_adapter(&sap->src);
+	if (!adapter) {
+		error("Unable to get a btd_adapter object for %s", addr);
+		goto drop;
+	}
+
+	ba2str(&sap->dst, addr);
+
+	device = adapter_get_device(connection, adapter, addr);
+	if (!device) {
+		error("Unable to get btd_device object for %s", addr);
+		goto drop;
+	}
+
+	sap->btd_dev = device;
+	sap->rfcomm = g_io_channel_ref(chan);
+
+	perr = btd_request_authorization(&sap->src, &sap->dst,
+						agent->properties->uuid,
+						sap_auth_cb, sap);
+	if (perr < 0) {
+		DBG("Authorization denied: %s", strerror(-perr));
+		return;
+	}
+
+	sap->preauth_id = g_io_add_watch(chan,
+					G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+					sap_preauth_cb, sap);
+
+	return;
+
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+}
+
 static gboolean hs_dev_disconnect_cb(GIOChannel *chan, GIOCondition cond,
 						struct tel_device *dev)
 {
@@ -821,6 +985,61 @@ static sdp_record_t *hfp_hs_record(struct tel_agent * agent)
 	return record;
 }
 
+static sdp_record_t *sap_gw_record(struct tel_agent * agent)
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
+	ch = sdp_data_alloc(SDP_UINT8, &agent->properties->channel);
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
 	struct audio_device *device = user_data;
@@ -1180,6 +1399,7 @@ drop:
 static struct default_agent default_properties[] = {
 	{ DUN_GW_UUID,
 		DEFAULT_DUN_GW_CHANNEL,
+		BT_IO_SEC_MEDIUM,
 		NULL,
 		0,
 		0,
@@ -1188,6 +1408,7 @@ static struct default_agent default_properties[] = {
 		dun_newconnection_reply },
 	{ HSP_AG_UUID,
 		DEFAULT_HS_AG_CHANNEL,
+		BT_IO_SEC_MEDIUM,
 		HSP_HS_UUID,
 		HEADSET_SVCLASS_ID,
 		HEADSET_PROFILE_ID,
@@ -1196,6 +1417,7 @@ static struct default_agent default_properties[] = {
 		hs_newconnection_reply },
 	{ HFP_HS_UUID,
 		DEFAULT_HF_HS_CHANNEL,
+		BT_IO_SEC_MEDIUM,
 		HFP_AG_UUID,
 		HANDSFREE_AGW_SVCLASS_ID,
 		HANDSFREE_PROFILE_ID,
@@ -1204,12 +1426,22 @@ static struct default_agent default_properties[] = {
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
+		sap_confirm,
+		sap_newconnection_reply },
 };
 
 static void agent_disconnect_cb(DBusConnection *conn, void *user_data)
@@ -1308,7 +1540,8 @@ static DBusMessage *register_agent(DBusConnection *conn,
 				agent, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_CHANNEL, agent->properties->channel,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_SEC_LEVEL,
+				agent->properties->sec_level,
 				BT_IO_OPT_MASTER, master,
 				BT_IO_OPT_INVALID);
 	if (agent->io == NULL) {
-- 
1.7.9.5

