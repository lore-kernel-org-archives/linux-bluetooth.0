Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/6] Remove obex_get_id
Date: Fri, 25 Nov 2011 13:33:46 +0200
Message-Id: <1322220828-10226-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1322220828-10226-1-git-send-email-luiz.dentz@gmail.com>
References: <1322220828-10226-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Plugins that need the peer address/name should use obex_getpeername which
uses the transport driver to resolve it.
---
 plugins/syncevolution.c |    8 +++++++-
 src/obex.c              |   17 -----------------
 src/obex.h              |    1 -
 3 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index e3b06f4..b0cd626 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -218,6 +218,7 @@ static void *synce_connect(struct obex_session *os, int *err)
 {
 	DBusConnection *conn;
 	struct synce_context *context;
+	char *address;
 
 	manager_register_session(os);
 
@@ -228,9 +229,14 @@ static void *synce_connect(struct obex_session *os, int *err)
 	context = g_new0(struct synce_context, 1);
 	context->dbus_conn = conn;
 	context->lasterr = -EAGAIN;
-	context->id = obex_get_id(os);
 	context->os = os;
 
+	if (obex_getpeername(os, &address) == 0) {
+		context->id = g_strdup_printf("%s+%d", address,
+							SYNCEVOLUTION_CHANNEL);
+		g_free(address);
+	}
+
 	if (err)
 		*err = 0;
 
diff --git a/src/obex.c b/src/obex.c
index 7f31c5d..a88306d 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -1524,23 +1524,6 @@ uint8_t obex_get_action_id(struct obex_session *os)
 	return os->action_id;
 }
 
-/* TODO: find a way to do this for tty or fix syncevolution */
-char *obex_get_id(struct obex_session *os)
-{
-	GError *gerr = NULL;
-	char address[18];
-	uint8_t channel;
-
-	bt_io_get(os->io, BT_IO_RFCOMM, &gerr,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_CHANNEL, &channel,
-			BT_IO_OPT_INVALID);
-	if (gerr)
-		return NULL;
-
-	return g_strdup_printf("%s+%d", address, channel);
-}
-
 ssize_t obex_get_apparam(struct obex_session *os, const uint8_t **buffer)
 {
 	*buffer = os->apparam;
diff --git a/src/obex.h b/src/obex.h
index 3ec49a9..7f07fd2 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -46,7 +46,6 @@ int obex_copy(struct obex_session *os, const char *source,
 int obex_move(struct obex_session *os, const char *source,
 						const char *destination);
 uint8_t obex_get_action_id(struct obex_session *os);
-char *obex_get_id(struct obex_session *os);
 ssize_t obex_get_apparam(struct obex_session *os, const uint8_t **buffer);
 ssize_t obex_get_non_header_data(struct obex_session *os,
 							const uint8_t **data);
-- 
1.7.7.3

