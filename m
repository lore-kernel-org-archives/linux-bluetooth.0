Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47595288.5020200@access-company.com>
References: <4757DCBD.40602@access-company.com>
	<1196941226.12292.192.camel@violet>
	<47581231.3010505@access-company.com>
	<47595288.5020200@access-company.com>
Content-Type: multipart/mixed; boundary="=-4EqoTPFVaW9NubMzVGqP"
Date: Tue, 11 Dec 2007 21:14:04 +0530
Message-Id: <1197387845.26216.22.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [Patch] Service Level Connection for HFP.
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


--=-4EqoTPFVaW9NubMzVGqP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello, 

I am sending a patch for Service Level Connection(SLC) Establishment for
the HandsFree Profile. This patch includes: 

1. String table mechanism for headset/handsfree events. 

2. Callbacks in form of function pointers for the events. 

3. Basic event handling for SLC and complete event handling for
   Headset. 

4. Modification in get_record_reply for HFP.

Currently there are no extra signals/methods, for the sake of
simplicity.   

This patch requires Fredric's 1st patch(dated:07 Dec 2007) to be applied
first. 

Please let me know if any changes are required. 

Thanks, 
Alok.

--=-4EqoTPFVaW9NubMzVGqP
Content-Disposition: attachment; filename=SLC.patch
Content-Type: text/x-patch; name=SLC.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

diff --git a/audio/headset.c b/audio/headset.c
index 7bb1746..98c4d4c 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -108,9 +108,27 @@ struct headset {
 	int sp_gain;
 	int mic_gain;
 
+	unsigned int hfp_features;
 	headset_lock_t lock;
 };
 
+struct event {
+	const char *cmd;
+	 int(*callback) (struct device *device, const char *buf);
+};
+
+static struct event event_callbacks[] = {
+	{"ATA", hf_answer_call},
+	{"AT+VG", hs_signal_gain_setting},
+	{"AT+BRSF", hf_supported_features},
+	{"AT+CIND", hf_report_indicators},
+	{"AT+CMER", hf_event_reporting},
+	{"AT+CHLD", hf_call_hold},
+	{"AT+CHUP", hf_terminate_call},
+	{"AT+CKPD", hf_answer_call},
+	{0}
+};
+
 static int rfcomm_connect(struct device *device, struct pending_connect *c);
 static int get_handles(struct device *device, struct pending_connect *c);
 
@@ -130,70 +148,114 @@ static void pending_connect_free(struct pending_connect *c)
 	g_free(c);
 }
 
-static void hs_signal_gain_setting(struct device *device, const char *buf)
+int handle_event(struct device *device, const char *buf)
+{
+	struct event *pt;
+	debug("Received %s", buf);
+	for (pt = event_callbacks; pt->cmd; pt++) {
+		if (!strncmp(buf, pt->cmd, strlen(pt->cmd)))
+			return pt->callback(device, buf);
+	}
+	debug("Invalid Event");
+	return -1;
+}
+
+int hf_supported_features(struct device *device, const char *buf)
+{
+	struct headset *hs = device->headset;
+
+	hs->hfp_features = strtoul(&buf[8], NULL, 10);
+	headset_send(hs, "\r\n+BRSF:0\r\n");
+	headset_send(device->headset, "\r\nOK\r\n");
+	return 0;
+}
+
+int hf_report_indicators(struct device *device, const char *buf)
+{
+	struct headset *hs = device->headset;
+
+	if (buf[7] == '=')
+		headset_send(hs, "\r\n+CIND:(\"service\",(0,1)),(\"call\",(0,1)),(\"callsetup\",(0-3))\r\n");
+	else
+		headset_send(hs, "\r\n+CIND:1, 0, 0\r\n");
+	headset_send(device->headset, "\r\nOK\r\n");
+	return 0;
+}
+
+int hf_event_reporting(struct device *device, const char *buf)
+{
+	struct headset *hs = device->headset;
+
+	headset_send(device->headset, "\r\nOK\r\n");
+	return 0;	
+}
+
+int hf_call_hold(struct device *device, const char *buf)
+{
+	struct headset *hs = device->headset;
+
+	headset_send(hs, "\r\n+CHLD:(0,1,1x,2,2x,3,4)\r\n");
+	headset_send(device->headset, "\r\nOK\r\n");
+	return 0;
+}
+
+int hf_answer_call(struct device *device, const char *buf)
+{
+	struct headset *hs = device->headset;
+
+	dbus_connection_emit_signal(device->conn,
+				    device->path, AUDIO_HEADSET_INTERFACE, "AnswerRequested", DBUS_TYPE_INVALID);
+	headset_send(device->headset, "\r\nOK\r\n");
+	return 0;
+}
+
+int hf_terminate_call(struct device *device, const char *buf)
+{
+	headset_send(device->headset, "\r\nOK\r\n");
+	return 0;
+}
+
+
+int hs_signal_gain_setting(struct device *device, const char *buf)
 {
 	const char *name;
 	dbus_uint16_t gain;
 
-	if (strlen(buf) < 6) {
+	if (strlen(buf) < 8) {
 		error("Too short string for Gain setting");
-		return;
+		return -1;
 	}
 
-	gain = (dbus_uint16_t) strtol(&buf[5], NULL, 10);
+	gain = (dbus_uint16_t) strtol(&buf[7], NULL, 10);
 
 	if (gain > 15) {
 		error("Invalid gain value received: %u", gain);
-		return;
+		return -1;
 	}
 
-	switch (buf[3]) {
+	switch (buf[5]) {
 	case HEADSET_GAIN_SPEAKER:
 		if (device->headset->sp_gain == gain)
-			return;
+			break;
 		name = "SpeakerGainChanged";
 		device->headset->sp_gain = gain;
 		break;
 	case HEADSET_GAIN_MICROPHONE:
 		if (device->headset->mic_gain == gain)
-			return;
+			break;
 		name = "MicrophoneGainChanged";
 		device->headset->mic_gain = gain;
 		break;
 	default:
 		error("Unknown gain setting");
-		return;
-	}
-
-	dbus_connection_emit_signal(device->conn, device->path,
-					AUDIO_HEADSET_INTERFACE, name,
-					DBUS_TYPE_UINT16, &gain,
-					DBUS_TYPE_INVALID);
-}
-
-static headset_event_t parse_headset_event(const char *buf, char *rsp,
-						int rsp_len)
-{
-	printf("Received: %s\n", buf);
-
-	/* Return an error if this is not a proper AT command */
-	if (strncmp(buf, "AT", 2)) {
-		snprintf(rsp, rsp_len, "\r\nERROR\r\n");
-		return HEADSET_EVENT_INVALID;
+		return -1;
 	}
 
-	buf += 2;
-
-	if (!strncmp(buf, "+CKPD", 5)) {
-		snprintf(rsp, rsp_len, "\r\nOK\r\n");
-		return HEADSET_EVENT_KEYPRESS;
-	} else if (!strncmp(buf, "+VG", 3)) {
-		snprintf(rsp, rsp_len, "\r\nOK\r\n");
-		return HEADSET_EVENT_GAIN;
-	} else {
-		snprintf(rsp, rsp_len, "\r\nERROR\r\n");
-		return HEADSET_EVENT_UNKNOWN;
-	}
+	dbus_connection_emit_signal(device->conn,
+				    device->path,
+				    AUDIO_HEADSET_INTERFACE, name, DBUS_TYPE_UINT16, &gain, DBUS_TYPE_INVALID);
+	headset_send(device->headset, "\r\nOK\r\n");
+	return 0;
 }
 
 static void close_sco(struct device *device)
@@ -214,9 +276,9 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 {
 	struct headset *hs;
 	unsigned char buf[BUF_SIZE];
-	char *cr, rsp[BUF_SIZE];
+	char *cr;
 	gsize bytes_read = 0;
-	gsize free_space, count, bytes_written, total_bytes_written;
+	gsize free_space;
 	GIOError err;
 	off_t cmd_len;
 
@@ -256,46 +318,8 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 	cmd_len	= 1 + (off_t) cr - (off_t) &hs->buf[hs->data_start];
 	*cr = '\0';
 
-	memset(rsp, 0, sizeof(rsp));
-
-	switch (parse_headset_event(&hs->buf[hs->data_start], rsp,
-					sizeof(rsp))) {
-	case HEADSET_EVENT_GAIN:
-		hs_signal_gain_setting(device, &hs->buf[hs->data_start] + 2);
-		break;
-
-	case HEADSET_EVENT_KEYPRESS:
-		if (hs->ring_timer) {
-			g_source_remove(hs->ring_timer);
-			hs->ring_timer = 0;
-		}
-
-		dbus_connection_emit_signal(device->conn, device->path,
-						AUDIO_HEADSET_INTERFACE,
-						"AnswerRequested",
-						DBUS_TYPE_INVALID);
-		break;
-
-	case HEADSET_EVENT_INVALID:
-	case HEADSET_EVENT_UNKNOWN:
-	default:
-		debug("Unknown headset event");
-		break;
-	}
-
-	count = strlen(rsp);
-	total_bytes_written = bytes_written = 0;
-	err = G_IO_ERROR_NONE;
-
-	while (err == G_IO_ERROR_NONE && total_bytes_written < count) {
-		err = g_io_channel_write(hs->rfcomm,
-						rsp + total_bytes_written, 
-						count - total_bytes_written,
-						&bytes_written);
-		if (err != G_IO_ERROR_NONE)
-			error("Error while writting to the audio output channel");
-		total_bytes_written += bytes_written;
-	};
+	if(handle_event(device, &hs->buf[hs->data_start]) == -1)
+		error("Error in event");
 
 	hs->data_start += cmd_len;
 	hs->data_length -= cmd_len;
@@ -593,6 +617,7 @@ static void get_record_reply(DBusPendingCall *call, void *data)
 	struct device *device = data;
 	struct headset *hs = device->headset;
 	struct pending_connect *c;
+	unsigned int SVCLASS_ID;
 
 	c = hs->pending->data;
 
@@ -642,21 +667,11 @@ static void get_record_reply(DBusPendingCall *call, void *data)
 		goto failed_not_supported;
 	}
 
-	if (hs->type == SVC_HEADSET &&
-			((uuid.type == SDP_UUID32 &&
-			uuid.value.uuid32 != HEADSET_SVCLASS_ID) ||
-			(uuid.type == SDP_UUID16 &&
-			 uuid.value.uuid16 != HEADSET_SVCLASS_ID))) {
-		error("Service classes did not contain the expected UUID hsp");
-		goto failed_not_supported;
-	}
+	SVCLASS_ID = hs->enable_hfp ? HANDSFREE_SVCLASS_ID : HEADSET_SVCLASS_ID;
 
-	if (hs->type == SVC_HANDSFREE &&
-			((uuid.type == SDP_UUID32 &&
-			uuid.value.uuid32 != HANDSFREE_SVCLASS_ID) ||
-			(uuid.type == SDP_UUID16 &&
-			 uuid.value.uuid16 != HANDSFREE_SVCLASS_ID))) {
-		error("Service classes did not contain the expected UUID hfp");
+	if ((uuid.type == SDP_UUID32 && uuid.value.uuid32 != SVCLASS_ID)
+	    || (uuid.type == SDP_UUID16 && uuid.value.uuid16 != SVCLASS_ID)) {
+		error("Service classes did not contain the expected UUID");
 		goto failed_not_supported;
 	}
 
diff --git a/audio/headset.h b/audio/headset.h
index b151dbd..86be42e 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -28,13 +28,6 @@
 #define DEFAULT_HF_AG_CHANNEL 13
 
 typedef enum {
-	HEADSET_EVENT_KEYPRESS,
-	HEADSET_EVENT_GAIN,
-	HEADSET_EVENT_UNKNOWN,
-	HEADSET_EVENT_INVALID
-} headset_event_t;
-
-typedef enum {
 	HEADSET_STATE_DISCONNECTED,
 	HEADSET_STATE_CONNECT_IN_PROGRESS,
 	HEADSET_STATE_CONNECTED,
@@ -84,3 +77,12 @@ gboolean headset_lock(struct device *dev, headset_lock_t lock);
 gboolean headset_unlock(struct device *dev, headset_lock_t lock);
 gboolean headset_suspend(struct device *dev, void *data);
 gboolean headset_play(struct device *dev, void *data);
+static GIOError headset_send(struct headset *hs, const char *str);
+int hs_signal_gain_setting(struct device *device, const char *buf);
+int hf_supported_features(struct device *device, const char *buf);
+int hf_report_indicators(struct device *device, const char *buf);
+int hf_event_reporting(struct device *device, const char *buf);
+int hf_answer_call(struct device *device, const char *buf);
+int hf_call_hold(struct device *device, const char *buf);
+int hf_terminate_call(struct device *device, const char *buf);
+int hf_answer_call(struct device *device, const char *buf);

--=-4EqoTPFVaW9NubMzVGqP
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
--=-4EqoTPFVaW9NubMzVGqP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-4EqoTPFVaW9NubMzVGqP--
