Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/13] core: Append version to Agent interface
Date: Fri, 14 Dec 2012 11:13:01 +0200
Message-Id: <1355476387-2165-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/agent-api.txt  |  2 +-
 src/agent.c        | 19 ++++++++++---------
 src/bluetooth.conf |  2 +-
 test/simple-agent  | 24 ++++++++++++++----------
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index caed7f8..a1a8969 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -9,7 +9,7 @@ Agent hierarchy
 ===============
 
 Service		unique name
-Interface	org.bluez.Agent
+Interface	org.bluez.Agent1
 Object path	freely definable
 
 Methods		void Release()
diff --git a/src/agent.c b/src/agent.c
index ec183c0..b36738d 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -48,6 +48,7 @@
 #include "agent.h"
 
 #define REQUEST_TIMEOUT (60 * 1000)		/* 60 seconds */
+#define AGENT_INTERFACE "org.bluez.Agent1"
 
 typedef enum {
 	AGENT_REQUEST_PASSKEY,
@@ -91,7 +92,7 @@ static void agent_release(struct agent *agent)
 		agent_cancel(agent);
 
 	message = dbus_message_new_method_call(agent->name, agent->path,
-			"org.bluez.Agent", "Release");
+						AGENT_INTERFACE, "Release");
 	if (message == NULL) {
 		error("Couldn't allocate D-Bus message");
 		return;
@@ -108,7 +109,7 @@ static int send_cancel_request(struct agent_request *req)
 							req->agent->path);
 
 	message = dbus_message_new_method_call(req->agent->name, req->agent->path,
-						"org.bluez.Agent", "Cancel");
+						AGENT_INTERFACE, "Cancel");
 	if (message == NULL) {
 		error("Couldn't allocate D-Bus message");
 		return -ENOMEM;
@@ -301,7 +302,7 @@ static int agent_call_authorize_service(struct agent_request *req,
 	struct agent *agent = req->agent;
 
 	req->msg = dbus_message_new_method_call(agent->name, agent->path,
-				"org.bluez.Agent", "AuthorizeService");
+					AGENT_INTERFACE, "AuthorizeService");
 	if (!req->msg) {
 		error("Couldn't allocate D-Bus message");
 		return -ENOMEM;
@@ -413,7 +414,7 @@ static int pincode_request_new(struct agent_request *req, const char *device_pat
 		secure pin. */
 
 	req->msg = dbus_message_new_method_call(agent->name, agent->path,
-					"org.bluez.Agent", "RequestPinCode");
+					AGENT_INTERFACE, "RequestPinCode");
 	if (req->msg == NULL) {
 		error("Couldn't allocate D-Bus message");
 		return -ENOMEM;
@@ -507,7 +508,7 @@ static int passkey_request_new(struct agent_request *req,
 	struct agent *agent = req->agent;
 
 	req->msg = dbus_message_new_method_call(agent->name, agent->path,
-					"org.bluez.Agent", "RequestPasskey");
+					AGENT_INTERFACE, "RequestPasskey");
 	if (req->msg == NULL) {
 		error("Couldn't allocate D-Bus message");
 		return -ENOMEM;
@@ -563,7 +564,7 @@ static int confirmation_request_new(struct agent_request *req,
 	struct agent *agent = req->agent;
 
 	req->msg = dbus_message_new_method_call(agent->name, agent->path,
-				"org.bluez.Agent", "RequestConfirmation");
+				AGENT_INTERFACE, "RequestConfirmation");
 	if (req->msg == NULL) {
 		error("Couldn't allocate D-Bus message");
 		return -ENOMEM;
@@ -621,7 +622,7 @@ static int authorization_request_new(struct agent_request *req,
 	struct agent *agent = req->agent;
 
 	req->msg = dbus_message_new_method_call(agent->name, agent->path,
-				"org.bluez.Agent", "RequestAuthorization");
+				AGENT_INTERFACE, "RequestAuthorization");
 	if (req->msg == NULL) {
 		error("Couldn't allocate D-Bus message");
 		return -ENOMEM;
@@ -679,7 +680,7 @@ int agent_display_passkey(struct agent *agent, struct btd_device *device,
 	const gchar *dev_path = device_get_path(device);
 
 	message = dbus_message_new_method_call(agent->name, agent->path,
-				"org.bluez.Agent", "DisplayPasskey");
+					AGENT_INTERFACE, "DisplayPasskey");
 	if (!message) {
 		error("Couldn't allocate D-Bus message");
 		return -1;
@@ -754,7 +755,7 @@ static int display_pincode_request_new(struct agent_request *req,
 	struct agent *agent = req->agent;
 
 	req->msg = dbus_message_new_method_call(agent->name, agent->path,
-					"org.bluez.Agent", "DisplayPinCode");
+					AGENT_INTERFACE, "DisplayPinCode");
 	if (req->msg == NULL) {
 		error("Couldn't allocate D-Bus message");
 		return -ENOMEM;
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 0e45935..8dfdc77 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -10,7 +10,7 @@
   <policy user="root">
     <allow own="org.bluez"/>
     <allow send_destination="org.bluez"/>
-    <allow send_interface="org.bluez.Agent"/>
+    <allow send_interface="org.bluez.Agent1"/>
     <allow send_interface="org.bluez.HandsfreeAgent"/>
     <allow send_interface="org.bluez.MediaEndpoint1"/>
     <allow send_interface="org.bluez.MediaPlayer1"/>
diff --git a/test/simple-agent b/test/simple-agent
index 15f2a32..312202a 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -11,6 +11,10 @@ import dbus.mainloop.glib
 from optparse import OptionParser
 import bluezutils
 
+BUS_NAME = 'org.bluez'
+AGENT_INTERFACE = 'org.bluez.Agent1'
+AGENT_PATH = "/test/agent"
+
 bus = None
 device_obj = None
 dev_path = None
@@ -40,14 +44,14 @@ class Agent(dbus.service.Object):
 	def set_exit_on_release(self, exit_on_release):
 		self.exit_on_release = exit_on_release
 
-	@dbus.service.method("org.bluez.Agent",
+	@dbus.service.method(AGENT_INTERFACE,
 					in_signature="", out_signature="")
 	def Release(self):
 		print("Release")
 		if self.exit_on_release:
 			mainloop.quit()
 
-	@dbus.service.method("org.bluez.Agent",
+	@dbus.service.method(AGENT_INTERFACE,
 					in_signature="os", out_signature="")
 	def AuthorizeService(self, device, uuid):
 		print("AuthorizeService (%s, %s)" % (device, uuid))
@@ -56,14 +60,14 @@ class Agent(dbus.service.Object):
 			return
 		raise Rejected("Connection rejected by user")
 
-	@dbus.service.method("org.bluez.Agent",
+	@dbus.service.method(AGENT_INTERFACE,
 					in_signature="o", out_signature="s")
 	def RequestPinCode(self, device):
 		print("RequestPinCode (%s)" % (device))
 		set_trusted(device)
 		return ask("Enter PIN Code: ")
 
-	@dbus.service.method("org.bluez.Agent",
+	@dbus.service.method(AGENT_INTERFACE,
 					in_signature="o", out_signature="u")
 	def RequestPasskey(self, device):
 		print("RequestPasskey (%s)" % (device))
@@ -71,18 +75,18 @@ class Agent(dbus.service.Object):
 		passkey = ask("Enter passkey: ")
 		return dbus.UInt32(passkey)
 
-	@dbus.service.method("org.bluez.Agent",
+	@dbus.service.method(AGENT_INTERFACE,
 					in_signature="ouq", out_signature="")
 	def DisplayPasskey(self, device, passkey, entered):
 		print("DisplayPasskey (%s, %06u entered %u)" %
 						(device, passkey, entered))
 
-	@dbus.service.method("org.bluez.Agent",
+	@dbus.service.method(AGENT_INTERFACE,
 					in_signature="os", out_signature="")
 	def DisplayPinCode(self, device, pincode):
 		print("DisplayPinCode (%s, %s)" % (device, pincode))
 
-	@dbus.service.method("org.bluez.Agent",
+	@dbus.service.method(AGENT_INTERFACE,
 					in_signature="ou", out_signature="")
 	def RequestConfirmation(self, device, passkey):
 		print("RequestConfirmation (%s, %06d)" % (device, passkey))
@@ -92,7 +96,7 @@ class Agent(dbus.service.Object):
 			return
 		raise Rejected("Passkey doesn't match")
 
-	@dbus.service.method("org.bluez.Agent",
+	@dbus.service.method(AGENT_INTERFACE,
 					in_signature="o", out_signature="")
 	def RequestAuthorization(self, device):
 		print("RequestAuthorization (%s)" % (device))
@@ -101,7 +105,7 @@ class Agent(dbus.service.Object):
 			return
 		raise Rejected("Pairing rejected")
 
-	@dbus.service.method("org.bluez.Agent",
+	@dbus.service.method(AGENT_INTERFACE,
 					in_signature="s", out_signature="")
 	def ConfirmModeChange(self, mode):
 		print("ConfirmModeChange (%s)" % (mode))
@@ -110,7 +114,7 @@ class Agent(dbus.service.Object):
 			return
 		raise Rejected("Mode change by user")
 
-	@dbus.service.method("org.bluez.Agent",
+	@dbus.service.method(AGENT_INTERFACE,
 					in_signature="", out_signature="")
 	def Cancel(self):
 		print("Cancel")
-- 
1.7.11.7

