Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE0C64E90
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 01:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E823221E2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 01:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgLBBV1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgLBBV1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 20:21:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34104C0617A6
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 17:20:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z83so4555ybz.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 17:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6pyupNcvveO4t8XnezNMMHGw0gv8ugjrbsJmIdpQHb0=;
        b=OroDrcFxqjYcKjHI4ITsaV578Puc43ce20JMGd89ot/NVmg6HNH7BxmZ9zhKf0C8Uy
         TSJpZIetM8EsLEM84WHTDzf+YvxfUGWbsVbajfc0o9wgfXKG/BC7rmDzdmVFZWFR5T9G
         5CpYWVLUuogugywtQjzp+QdXXfs7RQMUW/9g7Lv2tzMHC4SO3KP39mfsCDM01m7Zrb6Z
         jNjxpnmaGKPLRI6NvOcwLW79kknPvsFjMWI7mi0QEw62kv4+TbsSoWSsmTiplYf+tx1b
         ZXsP2d8wnUpHsFth9CNOceQeKo79GME45uEMgFdfpjaGbe35py2laaRqlZ+mBEHFVcHk
         tEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6pyupNcvveO4t8XnezNMMHGw0gv8ugjrbsJmIdpQHb0=;
        b=nUnzYWjr39s62N3inzPLFaFLODlOzIxl9x/49T8ZX1L7qtqjzMBV7kPLtS1vLClmPL
         qR5P+3zR5sWY1rqqX+B+g070ScQDY5x7kvOtAE6B9oukcZLa9+0viP1fJy0f3/1AcPcp
         TStynCAZr3k7JCsH63fvsUzbUi5dfxtuU8+4bW5LmZjpa0S7+lZU3PtftNjS/MjbiOOO
         P7QXnaGmqensj2bCmRUJH9kpbOzZKQX8GLsRSEV5usreggk+0lW6HmX2NIrb9eeqP+gx
         jKOqUZlDDueepTbtqtarUYphra1SZXwd2r8SvxFJo8SJA97x/oGSBY9Ot0fNYXaaEi0V
         PZ9g==
X-Gm-Message-State: AOAM533hg1I5OVSABcUagL16qt1K7oWY7lIoqZ/vLZ6cbgcOCXkAjzcA
        sDr07e7FNeq2RlAo0ALJyjmX+cW8f5T1Ww==
X-Google-Smtp-Source: ABdhPJyi+IKUnH7OCAgNR4iqVXo8xg43wnC7uGhib5ktOATGBhn5xYc/n+3hl5cKcJRSCs/c4kq6RhMQ7IzxLQ==
Sender: "mmandlik via sendgmr" <mmandlik@mmandlik.mtv.corp.google.com>
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:e50e])
 (user=mmandlik job=sendgmr) by 2002:a25:7642:: with SMTP id
 r63mr277997ybc.61.1606872046336; Tue, 01 Dec 2020 17:20:46 -0800 (PST)
Date:   Tue,  1 Dec 2020 17:19:29 -0800
In-Reply-To: <20201202011930.2130671-1-mmandlik@google.com>
Message-Id: <20201201171838.bluez.v1.2.Ia29ecb3a2ddfd9e2939c94feca9eca0f06655ad9@changeid>
Mime-Version: 1.0
References: <20201202011930.2130671-1-mmandlik@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [bluez PATCH v1 2/3] gdbus: Emit InterfacesAdded/Removed at app root path
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>, sonnysasaka@chromium.org,
        howardchung@google.com, mcchou@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bluetoothctl shares the gdbus library implementation with bluetoothd.
When bluetoothctl starts, it registers itself with the dbus with root
path same as the bluez root path i.e. '/'.

When advertisement monitor objects are created or removed,
InterfacesAdded/InterfacesRemoved signals are emitted. These signals
are emitted at the registered root path by default.

However, these signals need to be emitted at the app root path
registered using the "RegisterMonitor" method while registering the
client app with bluetoothd.

This patch adds support in the gdbus library to emit signals at the app
root path.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: sonnysasaka@chromium.org
Reviewed-by: howardchung@google.com
Reviewed-by: mcchou@chromium.org

---

 gdbus/gdbus.h  | 15 +++++++++++++++
 gdbus/object.c | 39 ++++++++++++++++++++++++++++++---------
 2 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 28b802296..3bddaf9e6 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -210,6 +210,13 @@ struct GDBusSecurityTable {
 void g_dbus_set_flags(int flags);
 int g_dbus_get_flags(void);
 
+/* Note that, when new interface is registered, InterfacesAdded signal is
+ * emitted. This signal is by default emitted at root path "/" registered
+ * while registering a client using g_dbus_client_new(). If this behavior
+ * is undesired, use g_dbus_register_interface_full() with a desired root
+ * path to ensure InterfacesAdded / InterfacesRemoved signals get emitted
+ * at the correct path.
+ */
 gboolean g_dbus_register_interface(DBusConnection *connection,
 					const char *path, const char *name,
 					const GDBusMethodTable *methods,
@@ -217,6 +224,14 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 					const GDBusPropertyTable *properties,
 					void *user_data,
 					GDBusDestroyFunction destroy);
+gboolean g_dbus_register_interface_full(DBusConnection *connection,
+					const char *path, const char *name,
+					const char *root_path,
+					const GDBusMethodTable *methods,
+					const GDBusSignalTable *signals,
+					const GDBusPropertyTable *properties,
+					void *user_data,
+					GDBusDestroyFunction destroy);
 gboolean g_dbus_unregister_interface(DBusConnection *connection,
 					const char *path, const char *name);
 
diff --git a/gdbus/object.c b/gdbus/object.c
index 50a8b4ff1..0d8a0696e 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -38,6 +38,7 @@ struct generic_data {
 	unsigned int refcount;
 	DBusConnection *conn;
 	char *path;
+	char *root_path;
 	GSList *interfaces;
 	GSList *objects;
 	GSList *added;
@@ -551,9 +552,10 @@ static void emit_interfaces_added(struct generic_data *data)
 	if (root == NULL || data == root)
 		return;
 
-	signal = dbus_message_new_signal(root->path,
-					DBUS_INTERFACE_OBJECT_MANAGER,
-					"InterfacesAdded");
+	signal = dbus_message_new_signal(
+				data->root_path ? data->root_path : root->path,
+				DBUS_INTERFACE_OBJECT_MANAGER,
+				"InterfacesAdded");
 	if (signal == NULL)
 		return;
 
@@ -953,9 +955,10 @@ static void emit_interfaces_removed(struct generic_data *data)
 	if (root == NULL || data == root)
 		return;
 
-	signal = dbus_message_new_signal(root->path,
-					DBUS_INTERFACE_OBJECT_MANAGER,
-					"InterfacesRemoved");
+	signal = dbus_message_new_signal(
+				data->root_path ? data->root_path : root->path,
+				DBUS_INTERFACE_OBJECT_MANAGER,
+				"InterfacesRemoved");
 	if (signal == NULL)
 		return;
 
@@ -1026,6 +1029,7 @@ static void generic_unregister(DBusConnection *connection, void *user_data)
 
 	dbus_connection_unref(data->conn);
 	g_free(data->introspect);
+	g_free(data->root_path);
 	g_free(data->path);
 	g_free(data);
 }
@@ -1222,7 +1226,8 @@ done:
 }
 
 static struct generic_data *object_path_ref(DBusConnection *connection,
-							const char *path)
+							const char *path,
+							const char *root_path)
 {
 	struct generic_data *data;
 
@@ -1237,6 +1242,8 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 	data = g_new0(struct generic_data, 1);
 	data->conn = dbus_connection_ref(connection);
 	data->path = g_strdup(path);
+	if (root_path)
+		data->root_path = g_strdup(root_path);
 	data->refcount = 1;
 
 	data->introspect = g_strdup(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE "<node></node>");
@@ -1245,6 +1252,7 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 						&generic_table, data)) {
 		dbus_connection_unref(data->conn);
 		g_free(data->path);
+		g_free(data->root_path);
 		g_free(data->introspect);
 		g_free(data);
 		return NULL;
@@ -1330,6 +1338,19 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 					const GDBusPropertyTable *properties,
 					void *user_data,
 					GDBusDestroyFunction destroy)
+{
+	return g_dbus_register_interface_full(connection, path, name, NULL,
+			methods, signals, properties, user_data, destroy);
+}
+
+gboolean g_dbus_register_interface_full(DBusConnection *connection,
+					const char *path, const char *name,
+					const char *root_path,
+					const GDBusMethodTable *methods,
+					const GDBusSignalTable *signals,
+					const GDBusPropertyTable *properties,
+					void *user_data,
+					GDBusDestroyFunction destroy)
 {
 	struct generic_data *data;
 
@@ -1343,7 +1364,7 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 		return FALSE;
 	}
 
-	data = object_path_ref(connection, path);
+	data = object_path_ref(connection, path, root_path);
 	if (data == NULL)
 		return FALSE;
 
@@ -1811,7 +1832,7 @@ gboolean g_dbus_attach_object_manager(DBusConnection *connection)
 {
 	struct generic_data *data;
 
-	data = object_path_ref(connection, "/");
+	data = object_path_ref(connection, "/", NULL);
 	if (data == NULL)
 		return FALSE;
 
-- 
2.29.2.454.gaff20da3a2-goog

