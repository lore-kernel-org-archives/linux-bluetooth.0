Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] obexd: Fix using the same prefix for client and server sessions
Date: Wed, 10 Apr 2013 17:17:10 +0300
Message-Id: <1365603430-29030-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1365603430-29030-1-git-send-email-luiz.dentz@gmail.com>
References: <1365603430-29030-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoids using the same path for different sessions which fail since
it cannot register a second time causing an unexpected error.
---
 doc/obex-api.txt       | 17 +++++++++--------
 obexd/client/session.c |  2 +-
 obexd/src/manager.c    |  9 ++++++---
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 759c4d8..22449c4 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -44,7 +44,8 @@ Session hierarchy
 
 Service		org.bluez.obex
 Interface	org.bluez.obex.Session1
-Object path	/org/bluez/obex/session{0, 1, 2, ...}
+Object path	/org/bluez/obex/server/session{0, 1, 2, ...} or
+		/org/bluez/obex/client/session{0, 1, 2, ...}
 
 Methods		string GetCapabilities()
 
@@ -79,7 +80,7 @@ Transfer hierarchy
 
 Service		org.bluez.obex
 Interface	org.bluez.obex.Transfer1
-Object path	/org/bluez/obex/session{0, 1, 2, ...}/transfer{0, 1, 2, ...}
+Object path	[Session object path]/transfer{0, 1, 2, ...}
 
 Methods		void Cancel()
 
@@ -141,7 +142,7 @@ Object Push hierarchy
 
 Service		org.bluez.obex
 Interface	org.bluez.obex.ObjectPush1
-Object path	/org/bluez/obex/session{0, 1, 2, ...}
+Object path	[Session object path]
 
 Methods		object, dict SendFile(string sourcefile)
 
@@ -201,7 +202,7 @@ File Transfer hierarchy
 
 Service		org.bluez.obex
 Interface	org.bluez.obex.FileTransfer
-Object path	/org/bluez/obex/session{0, 1, 2, ...}
+Object path	[Session object path]
 
 Methods		void ChangeFolder(string folder)
 
@@ -298,7 +299,7 @@ Phonebook Access hierarchy
 
 Service		org.bluez.obex
 Interface	org.bluez.obex.PhonebookAccess1
-Object path	/org/bluez/obex/session{0, 1, 2, ...}
+Object path	[Session object path]
 
 Methods		void Select(string location, string phonebook)
 
@@ -448,7 +449,7 @@ Synchronization hierarchy
 
 Service		org.bluez.obex
 Interface	org.bluez.obex.Synchronization1
-Object path	/org/bluez/obex/session{0, 1, 2, ...}
+Object path	[Session object path]
 
 Methods		void SetLocation(string location)
 
@@ -503,7 +504,7 @@ Message Access hierarchy
 
 Service		org.bluez.obex
 Interface	org.bluez.obex.MessageAccess1
-Object path	[variable prefix]/{session0,session1,...}
+Object path	[Session object path]
 
 Methods		void SetFolder(string name)
 
@@ -715,7 +716,7 @@ Message hierarchy
 
 Service		org.bluez.obex
 Interface	org.bluez.obex.Message1
-Object path	[variable prefix]/{session0,session1,...}/{message0,...}
+Object path	[Session object path]/{message0,...}
 
 Methods		object, dict Get(string targetfile, boolean attachment)
 
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 2e8b113..7d16c26 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -47,7 +47,7 @@
 
 #define SESSION_INTERFACE "org.bluez.obex.Session1"
 #define ERROR_INTERFACE "org.bluez.obex.Error"
-#define SESSION_BASEPATH "/org/bluez/obex"
+#define SESSION_BASEPATH "/org/bluez/obex/client"
 
 #define OBEX_IO_ERROR obex_io_error_quark()
 #define OBEX_IO_ERROR_FIRST (0xff + 1)
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index c0887ca..b67567b 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -45,6 +45,7 @@
 #include "service.h"
 
 #define OBEX_BASE_PATH "/org/bluez/obex"
+#define SESSION_BASE_PATH OBEX_BASE_PATH "/server"
 #define OBEX_MANAGER_INTERFACE OBEXD_SERVICE ".AgentManager1"
 #define ERROR_INTERFACE OBEXD_SERVICE ".Error"
 #define TRANSFER_INTERFACE OBEXD_SERVICE ".Transfer1"
@@ -354,7 +355,7 @@ static gboolean transfer_get_session(const GDBusPropertyTable *property,
 	if (session == NULL)
 		return FALSE;
 
-	path = g_strdup_printf("%s/session%u", OBEX_BASE_PATH, session->id);
+	path = g_strdup_printf("%s/session%u", SESSION_BASE_PATH, session->id);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 
@@ -614,7 +615,7 @@ struct obex_transfer *manager_register_transfer(struct obex_session *os)
 
 	transfer = g_new0(struct obex_transfer, 1);
 	transfer->path = g_strdup_printf("%s/session%u/transfer%u",
-					OBEX_BASE_PATH, os->id, id++);
+					SESSION_BASE_PATH, os->id, id++);
 	transfer->session = os;
 
 	if (!g_dbus_register_interface(connection, transfer->path,
@@ -800,7 +801,9 @@ static const GDBusMethodTable session_methods[] = {
 
 void manager_register_session(struct obex_session *os)
 {
-	char *path = g_strdup_printf("%s/session%u", OBEX_BASE_PATH, os->id);
+	char *path;
+
+	path = g_strdup_printf("%s/session%u", SESSION_BASE_PATH, os->id);
 
 	if (!g_dbus_register_interface(connection, path,
 				SESSION_INTERFACE,
-- 
1.8.1.4

