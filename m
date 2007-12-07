Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <47595288.5020200@access-company.com>
Date: Fri, 07 Dec 2007 15:02:48 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4757DCBD.40602@access-company.com>	<1196941226.12292.192.camel@violet>
	<47581231.3010505@access-company.com>
In-Reply-To: <47581231.3010505@access-company.com>
Content-Type: multipart/mixed; boundary="------------030107070604090403080604"
Subject: Re: [Bluez-devel]
	[Patch]	org.bluez.audio.headset.Connect()	to	handsfree
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

This is a multi-part message in MIME format.
--------------030107070604090403080604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Here is an updated patch. It adds a parameter to headset_init() to 
> know whether hfp is enabled or not.
>
> Marcel Holtmann wrote:
>> Hi Frederic,
>>
>>   
>>> As of today, when calling org.bluez.audio.headset.Connect(), the hfp 
>> So this must depend on the config setting
Updated again, do not remove the static attribute in front of 
server_is_enabled().

Frederic


--------------030107070604090403080604
Content-Type: text/x-patch;
 name="handsfreeconnect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="handsfreeconnect.patch"

diff --git a/audio/headset.c b/audio/headset.c
index 97419a6..7bb1746 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -99,6 +99,7 @@ struct headset {
 	int data_start;
 	int data_length;
 
+	int enable_hfp;
 	headset_type_t type;
 
 	headset_state_t state;
@@ -111,6 +112,7 @@ struct headset {
 };
 
 static int rfcomm_connect(struct device *device, struct pending_connect *c);
+static int get_handles(struct device *device, struct pending_connect *c);
 
 static void pending_connect_free(struct pending_connect *c)
 {
@@ -640,11 +642,21 @@ static void get_record_reply(DBusPendingCall *call, void *data)
 		goto failed_not_supported;
 	}
 
-	if ((uuid.type == SDP_UUID32 &&
+	if (hs->type == SVC_HEADSET &&
+			((uuid.type == SDP_UUID32 &&
 			uuid.value.uuid32 != HEADSET_SVCLASS_ID) ||
 			(uuid.type == SDP_UUID16 &&
-			 uuid.value.uuid16 != HEADSET_SVCLASS_ID)) {
-		error("Service classes did not contain the expected UUID");
+			 uuid.value.uuid16 != HEADSET_SVCLASS_ID))) {
+		error("Service classes did not contain the expected UUID hsp");
+		goto failed_not_supported;
+	}
+
+	if (hs->type == SVC_HANDSFREE &&
+			((uuid.type == SDP_UUID32 &&
+			uuid.value.uuid32 != HANDSFREE_SVCLASS_ID) ||
+			(uuid.type == SDP_UUID16 &&
+			 uuid.value.uuid16 != HANDSFREE_SVCLASS_ID))) {
+		error("Service classes did not contain the expected UUID hfp");
 		goto failed_not_supported;
 	}
 
@@ -750,7 +762,17 @@ static void get_handles_reply(DBusPendingCall *call, void *data)
 	}
 
 	if (array_len < 1) {
-		debug("No record handles found");
+
+		if(hs->type == SVC_HANDSFREE) {
+			debug("No record handles found for hfp");
+			hs->type = SVC_HEADSET;
+			get_handles(device, c);
+			dbus_message_unref(reply);
+			return;
+		}
+
+		debug("No record handles found for hsp");
+
 		if (c->msg)
 			error_not_supported(device->conn, c->msg);
 		goto failed;
@@ -862,7 +884,7 @@ static int rfcomm_connect(struct device *device, struct pending_connect *c)
 		if (!g_slist_find(hs->pending, c))
 			hs->pending = g_slist_append(hs->pending, c);
 
-		hs->type = hs->hfp_handle ? SVC_HANDSFREE : SVC_HEADSET;
+		hs->type = hs->enable_hfp ? SVC_HANDSFREE : SVC_HEADSET;
 
 		if (hs->state == HEADSET_STATE_DISCONNECTED)
 			return get_handles(device, c);
@@ -1368,8 +1390,8 @@ void headset_update(struct device *dev, sdp_record_t *record, uint16_t svc)
 	headset_set_channel(headset, record);
 }
 
-struct headset *headset_init(struct device *dev, sdp_record_t *record,
-				uint16_t svc)
+struct headset *headset_init(struct device *dev, int enable_hfp,
+				sdp_record_t *record, uint16_t svc)
 {
 	struct headset *hs;
 
@@ -1377,6 +1399,7 @@ struct headset *headset_init(struct device *dev, sdp_record_t *record,
 	hs->rfcomm_ch = -1;
 	hs->sp_gain = -1;
 	hs->mic_gain = -1;
+	hs->enable_hfp = enable_hfp;
 
 	if (!record)
 		goto register_iface;
diff --git a/audio/headset.h b/audio/headset.h
index 5e19cd9..b151dbd 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -54,8 +54,8 @@ typedef enum {
 
 typedef void (*headset_stream_cb_t) (struct device *dev, void *user_data);
 
-struct headset *headset_init(struct device *dev, sdp_record_t *record,
-				uint16_t svc);
+struct headset *headset_init(struct device *dev, int enable_hfp,
+				sdp_record_t *record, uint16_t svc);
 
 void headset_free(struct device *dev);
 
diff --git a/audio/manager.c b/audio/manager.c
index 507f60a..cfadec4 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -108,6 +108,7 @@ static GIOChannel *hs_server = NULL;
 static GIOChannel *hf_server = NULL;
 
 static const struct enabled_interfaces *enabled;
+static gboolean enable_hfp = FALSE;
 
 static void get_next_record(struct audio_sdp_data *data);
 static DBusHandlerResult get_handles(const char *uuid,
@@ -254,6 +255,7 @@ static void handle_record(sdp_record_t *record, struct device *device)
 			headset_update(device, record, uuid16);
 		else
 			device->headset = headset_init(device,
+							enable_hfp,
 							record, uuid16);
 		break;
 	case HEADSET_AGW_SVCLASS_ID:
@@ -265,6 +267,7 @@ static void handle_record(sdp_record_t *record, struct device *device)
 			headset_update(device, record, uuid16);
 		else
 			device->headset = headset_init(device,
+							enable_hfp,
 							record, uuid16);
 		break;
 	case HANDSFREE_AGW_SVCLASS_ID:
@@ -645,7 +648,7 @@ struct device *manager_device_connected(bdaddr_t *bda, const char *uuid)
 		if (device->headset)
 			return device;
 
-		device->headset = headset_init(device, NULL, 0);
+		device->headset = headset_init(device, enable_hfp, NULL, 0);
 
 		if (!device->headset)
 			return NULL;
@@ -1070,7 +1073,7 @@ static void parse_stored_devices(char *key, char *value, void *data)
 	bacpy(&device->store, src);
 
 	if (enabled->headset && strstr(value, "headset"))
-		device->headset = headset_init(device, NULL, 0);
+		device->headset = headset_init(device, enable_hfp, NULL, 0);
 	if (enabled->sink && strstr(value, "sink"))
 		device->sink = sink_init(device);
 	if (enabled->control && strstr(value, "control"))
@@ -1561,6 +1564,8 @@ static int headset_server_init(DBusConnection *conn, gboolean no_hfp)
 	if (no_hfp)
 		return 0;
 
+	enable_hfp = TRUE;
+
 	chan = DEFAULT_HF_AG_CHANNEL;
 
 	hf_server = server_socket(&chan);

--------------030107070604090403080604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--------------030107070604090403080604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030107070604090403080604--
