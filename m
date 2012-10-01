Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 1/2] audio: Fix crash if gateway closed before reply
Date: Mon,  1 Oct 2012 17:24:05 +0200
Message-Id: <1349105046-20035-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1349105046-20035-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1349105046-20035-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Any pending call to the agent needs to be cancelled in gateway_close(),
to make sure newconnection_reply() never gets called.

Otherwise, the audio gateway can be closed (dev->gateway == NULL) before
the reply from the agent has been received, resulting in the following
crash as reproduced while removing (unpairing) a device:

bluetoothd[2219]: src/mgmt.c:mgmt_unpair_device() index 0 addr 38:16:D1:C5:D1:A2
bluetoothd[2219]: audio/gateway.c:path_unregister() Unregistered interface org.bluez.HandsfreeGateway on path /org/bluez/2219/hci0/dev_38_16_D1_C5_D1_A2
bluetoothd[2219]: audio/media.c:gateway_state_changed()
bluetoothd[2219]: audio/media.c:gateway_state_changed() Clear endpoint 0x555555820640
bluetoothd[2219]: audio/source.c:path_unregister() Unregistered interface org.bluez.AudioSource on path /org/bluez/2219/hci0/dev_38_16_D1_C5_D1_A2
bluetoothd[2219]: src/device.c:btd_device_unref() 0x555555833e70: ref=1
bluetoothd[2219]: src/adapter.c:adapter_get_device() 38:16:D1:C5:D1:A2
bluetoothd[2219]: src/adapter.c:adapter_create_device() 38:16:D1:C5:D1:A2
bluetoothd[2219]: src/device.c:device_create() Creating device /org/bluez/2219/hci0/dev_38_16_D1_C5_D1_A2
bluetoothd[2219]: src/device.c:device_free() 0x55555581f9c0
bluetoothd[2219]: Unable to get btd_device object for 38:16:D1:C5:D1:A2
bluetoothd[2219]: src/device.c:btd_device_unref() 0x555555833e70: ref=0
bluetoothd[2219]: src/device.c:device_free() 0x555555833e70
bluetoothd[2219]: src/mgmt.c:mgmt_event() cond 1
bluetoothd[2219]: src/mgmt.c:mgmt_event() Received 16 bytes from management socket
bluetoothd[2219]: src/mgmt.c:mgmt_cmd_complete()
bluetoothd[2219]: src/mgmt.c:mgmt_cmd_complete() unpair_device complete

Program received signal SIGSEGV, Segmentation fault.
0x000055555556fa26 in newconnection_reply (call=<optimized out>, data=0x555555824dd0) at audio/gateway.c:285
285		if (!dev->gateway->rfcomm) {

Additionally, this patch makes it unnecessary to check if RFCOMM got
disconnected before newconnection_reply, since RFCOMM disconnection also
triggers gateway_close() and thus the agent's call will be cancelled.
---
 audio/gateway.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 45b25a1..9e96296 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -54,6 +54,7 @@ struct hf_agent {
 	char *name;	/* Bus id */
 	char *path;	/* D-Bus path */
 	guint watch;	/* Disconnect watch */
+	DBusPendingCall *call;
 };
 
 struct connect_cb {
@@ -110,6 +111,9 @@ static void agent_free(struct hf_agent *agent)
 	if (!agent)
 		return;
 
+	if (agent->call)
+		dbus_pending_call_unref(agent->call);
+
 	g_free(agent->name);
 	g_free(agent->path);
 	g_free(agent);
@@ -152,6 +156,16 @@ void gateway_set_state(struct audio_device *dev, gateway_state_t new_state)
 	}
 }
 
+static void agent_cancel(struct hf_agent *agent)
+{
+	if (!agent->call)
+		return;
+
+	dbus_pending_call_cancel(agent->call);
+	dbus_pending_call_unref(agent->call);
+	agent->call = NULL;
+}
+
 static void agent_disconnect(struct audio_device *dev, struct hf_agent *agent)
 {
 	DBusMessage *msg;
@@ -160,6 +174,8 @@ static void agent_disconnect(struct audio_device *dev, struct hf_agent *agent)
 			"org.bluez.HandsfreeAgent", "Release");
 
 	g_dbus_send_message(btd_get_dbus_connection(), msg);
+
+	agent_cancel(agent);
 }
 
 static gboolean agent_sendfd(struct hf_agent *agent, int fd,
@@ -168,7 +184,9 @@ static gboolean agent_sendfd(struct hf_agent *agent, int fd,
 	struct audio_device *dev = data;
 	struct gateway *gw = dev->gateway;
 	DBusMessage *msg;
-	DBusPendingCall *call;
+
+	if (agent->call)
+		return FALSE;
 
 	msg = dbus_message_new_method_call(agent->name, agent->path,
 			"org.bluez.HandsfreeAgent", "NewConnection");
@@ -178,13 +196,12 @@ static gboolean agent_sendfd(struct hf_agent *agent, int fd,
 					DBUS_TYPE_INVALID);
 
 	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), msg,
-							&call, -1) == FALSE) {
+						&agent->call, -1) == FALSE) {
 		dbus_message_unref(msg);
 		return FALSE;
 	}
 
-	dbus_pending_call_set_notify(call, notify, dev, NULL);
-	dbus_pending_call_unref(call);
+	dbus_pending_call_set_notify(agent->call, notify, dev, NULL);
 	dbus_message_unref(msg);
 
 	return TRUE;
@@ -279,13 +296,12 @@ static void newconnection_reply(DBusPendingCall *call, void *data)
 {
 	struct audio_device *dev = data;
 	struct gateway *gw = dev->gateway;
+	struct hf_agent *agent = gw->agent;
 	DBusMessage *reply = dbus_pending_call_steal_reply(call);
 	DBusError derr;
 
-	if (!dev->gateway->rfcomm) {
-		DBG("RFCOMM disconnected from server before agent reply");
-		goto done;
-	}
+	dbus_pending_call_unref(agent->call);
+	agent->call = NULL;
 
 	dbus_error_init(&derr);
 	if (!dbus_set_error_from_message(&derr, reply)) {
@@ -581,6 +597,9 @@ int gateway_close(struct audio_device *device)
 		gw->sco = NULL;
 	}
 
+	if (gw->agent)
+		agent_cancel(gw->agent);
+
 	change_state(device, GATEWAY_STATE_DISCONNECTED);
 	g_set_error(&gerr, GATEWAY_ERROR,
 			GATEWAY_ERROR_DISCONNECTED, "Disconnected");
-- 
1.7.11.4

