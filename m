Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC941DC06B
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237398; cv=none; b=JNq2+2ejoI7DjOEAANzIph9ANO7cPovydFXehRndhmlIXD8fr3XnHnQKN/WfecIAiew4m+ip3AwyJB0DoHwNlS/tRkLzsa0dKHKq7jeXiDwpPUw8y/hPvHjr5grK7olqFQamM+sKjw1W2BHa+aaeXvOao6c9zkPl74QKEREDj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237398; c=relaxed/simple;
	bh=U7DCJRiyMiEr8CHP/5wFRFlkMQbul1q3FpaoBTPy93U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dFI4yez2m/wrux8/NCxjXGt5RFRaMaPfVWfEk5LA/Ql+iNniJjsQJa8Pr+yznRlr1Pp0/xkEYsbp0eSlK4MYM2ZDtUv+94Zrh3jrj+zz5rH2NP+2uND/ubKU5QUDpKnuQBuj1ce0UGdHs6w1rOvmUOivp5M0n5FAbG/eevNjJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbKAUqIA; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbKAUqIA"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-851f5d3001fso1559825241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730237394; x=1730842194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zykRVC45Y3P/A477HU6i4aicjwJ2AKp+pg7OPX8Q1RI=;
        b=GbKAUqIARvytYJoPMoLf4YTCFSL2jPVEvK/+v6BJNWJfOHbAGrawoaooT8KZRtArzB
         GaVlOs0TYFcX0bFXUdEYk5/roOG0XkqiOhJuUFEEqqLXmRniUCGKWTDOHMQrT6hMJAmW
         09GPgnCZ09LhQqruVGcasSOzhk8igMA366LOiiptRlB5WuZ34wZT6J8MH70aHzSbxAgG
         0pG0A6ZHQHJx+lSvGk1DiIFbwgnfRachPkelWl4npUXDFdBeAeIprLIycZPBE3/ZDa8g
         8Iv0beXZCEMeigwYw3U4DwNZ6/WeK3U44LRm9mSaXaolpLXaaTfF3gF6KE4oV7G4mrwf
         4+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237394; x=1730842194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zykRVC45Y3P/A477HU6i4aicjwJ2AKp+pg7OPX8Q1RI=;
        b=dXor7abXtvr17oGVW452FiXuIH1XKf9U/5+bjJJYUtxNX0lTua02L38N8sRGzWlGr0
         UrhQiGfl2vxlulyW+Ftl+/HMopAj+gGE7XY1i9J/yivj/Zyl9reY9n6WGB8PN+UKwbfQ
         M1mIArJSww5bUWWAwcX6D41gDMHTwQ44L3MnGw68oozugiq0yloloFLEivWdru6E+Yuu
         6WpyIa327tbnmn2YTn0kiSMWY+NnBdAdRY+tXxWVKYDqbPXdQ5sr3rFye2Ik7QvzNVe1
         +O0bB32XH5ejIgwVrA87nf+nuHjgQE6qJjsjaWNs41GqL8bEGQr3RuKQMj+1QtWvwT6z
         BVgA==
X-Gm-Message-State: AOJu0Yy5uTHzE8PPWtlhQQVER+Nm8n8bcn3JQEiZ0aBSKFVU+K+iMVFu
	h0/+WPYPXlI8zL3Ss0sR0k6FIx9o/RB3iE2+ebOJq2EX7u7KLPieJHWWaA==
X-Google-Smtp-Source: AGHT+IEXGM3YN/dauWffLj0jjqgK/2So+uG9W6Xi66hJHfeTLpMC1iEqffa7MafHi5viBbh/+lgRyA==
X-Received: by 2002:a05:6122:1d43:b0:50d:869a:e542 with SMTP id 71dfb90a1353d-5105d0d2dd4mr1066652e0c.9.1730237394278;
        Tue, 29 Oct 2024 14:29:54 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51004777927sm1283579e0c.36.2024.10.29.14.29.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:29:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] gdbus: Add g_dbus_set_debug
Date: Tue, 29 Oct 2024 17:29:48 -0400
Message-ID: <20241029212949.3674826-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds g_dbus_set_debug which can be used to set a debug function to
be invoked on incoming/outgoing message.
---
 gdbus/gdbus.h  |   6 +++
 gdbus/object.c | 106 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 103 insertions(+), 9 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index d7be17661149..24006a0d54d6 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -234,6 +234,12 @@ struct GDBusSecurityTable {
 void g_dbus_set_flags(int flags);
 int g_dbus_get_flags(void);
 
+typedef void (*g_dbus_destroy_func_t)(void *user_data);
+typedef void (*g_dbus_debug_func_t)(const char *str, void *user_data);
+
+void g_dbus_set_debug(g_dbus_debug_func_t cb, void *user_data,
+				g_dbus_destroy_func_t destroy);
+
 gboolean g_dbus_register_interface(DBusConnection *connection,
 					const char *path, const char *name,
 					const GDBusMethodTable *methods,
diff --git a/gdbus/object.c b/gdbus/object.c
index 72d2d46e30ef..1c19355cdbfe 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -20,6 +20,7 @@
 #include <dbus/dbus.h>
 
 #include "gdbus.h"
+#include "src/shared/util.h"
 
 #define info(fmt...)
 #define error(fmt...)
@@ -72,9 +73,16 @@ struct property_data {
 	DBusMessage *message;
 };
 
+struct debug_data {
+	g_dbus_debug_func_t func;
+	g_dbus_destroy_func_t destroy;
+	void *data;
+};
+
 static int global_flags = 0;
 static struct generic_data *root;
 static GSList *pending = NULL;
+static struct debug_data debug = { NULL, NULL, NULL };
 
 static gboolean process_changes(gpointer user_data);
 static void process_properties_from_interface(struct generic_data *data,
@@ -124,6 +132,20 @@ static bool check_testing(int flags, int flag)
 	return !(global_flags & G_DBUS_FLAG_ENABLE_TESTING);
 }
 
+static void g_dbus_debug(const char *format, ...)
+{
+	va_list va;
+	char str[MAX_INPUT];
+
+	if (!format || !debug.func)
+		return;
+
+	va_start(va, format);
+	vsnprintf(str, sizeof(str), format, va);
+	debug.func(str, debug.data);
+	va_end(va);
+}
+
 static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 {
 	const GDBusMethodTable *method;
@@ -565,6 +587,22 @@ static void append_interface(gpointer data, gpointer user_data)
 	dbus_message_iter_close_container(array, &entry);
 }
 
+static const char *dbus_message_type_string(DBusMessage *msg)
+{
+	return dbus_message_type_to_string(dbus_message_get_type(msg));
+}
+
+static void g_dbus_send_unref(DBusConnection *conn, DBusMessage *msg)
+{
+	g_dbus_debug("[%s] %s.%s",
+			dbus_message_type_string(msg),
+			dbus_message_get_interface(msg),
+			dbus_message_get_member(msg));
+
+	dbus_connection_send(conn, msg, NULL);
+	dbus_message_unref(msg);
+}
+
 static void emit_interfaces_added(struct generic_data *data)
 {
 	DBusMessage *signal;
@@ -605,9 +643,8 @@ static void emit_interfaces_added(struct generic_data *data)
 
 	dbus_message_iter_close_container(&iter, &array);
 
-	/* Use dbus_connection_send to avoid recursive calls to g_dbus_flush */
-	dbus_connection_send(data->conn, signal, NULL);
-	dbus_message_unref(signal);
+	/* Use g_dbus_send_unref to avoid recursive calls to g_dbus_flush */
+	g_dbus_send_unref(data->conn, signal);
 }
 
 static struct interface_data *find_interface(GSList *interfaces,
@@ -1002,9 +1039,8 @@ static void emit_interfaces_removed(struct generic_data *data)
 
 	dbus_message_iter_close_container(&iter, &array);
 
-	/* Use dbus_connection_send to avoid recursive calls to g_dbus_flush */
-	dbus_connection_send(data->conn, signal, NULL);
-	dbus_message_unref(signal);
+	/* Use g_dbus_send_unref to avoid recursive calls to g_dbus_flush */
+	g_dbus_send_unref(data->conn, signal);
 }
 
 static void remove_pending(struct generic_data *data)
@@ -1069,6 +1105,13 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 	const GDBusMethodTable *method;
 	const char *interface;
 
+	g_dbus_debug("[%s:%s] > %s.%s [#%d]",
+			dbus_message_get_sender(message),
+			dbus_message_type_string(message),
+			dbus_message_get_interface(message),
+			dbus_message_get_member(message),
+			dbus_message_get_serial(message));
+
 	interface = dbus_message_get_interface(message);
 
 	iface = find_interface(data->interfaces, interface);
@@ -1559,6 +1602,35 @@ gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
 	/* Flush pending signal to guarantee message order */
 	g_dbus_flush(connection);
 
+	switch (dbus_message_get_type(message)) {
+	case DBUS_MESSAGE_TYPE_METHOD_RETURN:
+		g_dbus_debug("[%s:%s] < [#%d]",
+				dbus_message_get_destination(message),
+				dbus_message_type_string(message),
+				dbus_message_get_reply_serial(message));
+		break;
+	case DBUS_MESSAGE_TYPE_ERROR:
+		g_dbus_debug("[%s:%s] < %s [#%d]",
+				dbus_message_get_destination(message),
+				dbus_message_type_string(message),
+				dbus_message_get_error_name(message),
+				dbus_message_get_reply_serial(message));
+		break;
+	case DBUS_MESSAGE_TYPE_SIGNAL:
+		g_dbus_debug("[%s] %s.%s",
+				dbus_message_type_string(message),
+				dbus_message_get_interface(message),
+				dbus_message_get_member(message));
+		break;
+	default:
+		g_dbus_debug("[%s:%s] < %s.%s",
+				dbus_message_get_destination(message),
+				dbus_message_type_string(message),
+				dbus_message_get_interface(message),
+				dbus_message_get_member(message));
+		break;
+	}
+
 	result = dbus_connection_send(connection, message, NULL);
 
 out:
@@ -1584,6 +1656,12 @@ gboolean g_dbus_send_message_with_reply(DBusConnection *connection,
 		return FALSE;
 	}
 
+	g_dbus_debug("[%s:%s] < %s.%s",
+			dbus_message_get_destination(message),
+			dbus_message_type_string(message),
+			dbus_message_get_interface(message),
+			dbus_message_get_member(message));
+
 	return ret;
 }
 
@@ -1756,9 +1834,8 @@ static void process_properties_from_interface(struct generic_data *data,
 	g_slist_free(iface->pending_prop);
 	iface->pending_prop = NULL;
 
-	/* Use dbus_connection_send to avoid recursive calls to g_dbus_flush */
-	dbus_connection_send(data->conn, signal, NULL);
-	dbus_message_unref(signal);
+	/* Use g_dbus_send_unref to avoid recursive calls to g_dbus_flush */
+	g_dbus_send_unref(data->conn, signal);
 }
 
 static void process_property_changes(struct generic_data *data)
@@ -1885,3 +1962,14 @@ int g_dbus_get_flags(void)
 {
 	return global_flags;
 }
+
+void g_dbus_set_debug(g_dbus_debug_func_t cb, void *user_data,
+				g_dbus_destroy_func_t destroy)
+{
+	if (debug.destroy)
+		debug.destroy(debug.data);
+
+	debug.func = cb;
+	debug.destroy = destroy;
+	debug.data = user_data;
+}
-- 
2.47.0

