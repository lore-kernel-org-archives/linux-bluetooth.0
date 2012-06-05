Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 05/23] core: Change agent interface to org.bluez.obex.Agent
Date: Tue,  5 Jun 2012 13:57:03 +0300
Message-Id: <1338893841-14234-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/syncevolution.c |    3 +--
 src/manager.c           |    5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index b0cd626..0778608 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -365,8 +365,7 @@ static ssize_t synce_read(void *object, void *buf, size_t count)
 
 	append_dict_entry(&dict, "id", DBUS_TYPE_STRING, context->id);
 
-	snprintf(transport, sizeof(transport), "%s.obexd",
-					OPENOBEX_SERVICE);
+	snprintf(transport, sizeof(transport), "%s.obexd", OBEXD_SERVICE);
 	append_dict_entry(&dict, "transport", DBUS_TYPE_STRING, transport);
 
 	snprintf(transport_description, sizeof(transport_description),
diff --git a/src/manager.c b/src/manager.c
index 5033881..bd19288 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -49,6 +49,7 @@
 #define ERROR_INTERFACE OBEXD_SERVICE ".Error"
 #define TRANSFER_INTERFACE OBEXD_SERVICE ".Transfer"
 #define SESSION_INTERFACE OBEXD_SERVICE ".Session"
+#define AGENT_INTERFACE OBEXD_SERVICE ".Agent"
 
 #define TIMEOUT 60*1000 /* Timeout for user response (miliseconds) */
 
@@ -461,7 +462,7 @@ static void agent_cancel(void)
 		return;
 
 	msg = dbus_message_new_method_call(agent->bus_name, agent->path,
-					"org.openobex.Agent", "Cancel");
+						AGENT_INTERFACE, "Cancel");
 
 	g_dbus_send_message(connection, msg);
 }
@@ -547,7 +548,7 @@ int manager_request_authorization(struct obex_session *os, int32_t time,
 	path = g_strdup_printf("/transfer%u", os->id);
 
 	msg = dbus_message_new_method_call(agent->bus_name, agent->path,
-					"org.openobex.Agent", "Authorize");
+						AGENT_INTERFACE, "Authorize");
 
 	dbus_message_append_args(msg,
 			DBUS_TYPE_OBJECT_PATH, &path,
-- 
1.7.10.2

