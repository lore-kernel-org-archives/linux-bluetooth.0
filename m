Return-Path: <cyrus@holtmann.org>
From: Wu Zheng <wu.zheng@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Wu Zheng <wu.zheng@intel.com>
Subject: [PATCH 2/2] obexd:Add get_address property to transfer properties
Date: Tue, 24 Sep 2013 15:37:30 +0800
Message-Id: <1380008250-30536-1-git-send-email-wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sometime, address is needed by the Bluetooth OBEX APP.
Therefore, add the property to transfer properties
---
 obexd/src/manager.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 96976ec..b338a72 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -551,6 +551,41 @@ static gboolean transfer_get_operation(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean transfer_address_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct obex_transfer *transfer = data;
+	struct obex_session *session = transfer->session;
+	char *address;
+	int err;
+
+	err = obex_getpeername(session, &address);
+	if (err < 0)
+		return FALSE;
+
+	g_free(address);
+
+	return TRUE;
+}
+
+static gboolean transfer_get_address(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obex_transfer *transfer = data;
+	struct obex_session *session = transfer->session;
+	char *address;
+	int err;
+
+	err = obex_getpeername(session, &address);
+	if (err < 0)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &address);
+	g_free(address);
+
+	return TRUE;
+}
+
 static gboolean transfer_get_transferred(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -587,6 +622,8 @@ static const GDBusPropertyTable transfer_properties[] = {
 						transfer_filename_exists },
 	{ "Operation", "s", transfer_get_operation, NULL,
 						transfer_operation_exists },
+	{ "Address", "s", transfer_get_address, NULL,
+						transfer_address_exists },
 	{ "Transferred", "t", transfer_get_transferred },
 	{ }
 };
-- 
1.7.7

