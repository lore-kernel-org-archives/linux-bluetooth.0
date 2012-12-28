Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/11] gdbus: Introduce G_DBUS_FLAG_ENABLE_DEPRECATED
Date: Fri, 28 Dec 2012 14:51:04 +0200
Message-Id: <1356699069-5469-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
References: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This flag can be set using g_dbus_set_flags to enable deprecated
interfaces, default is unset.
---
 gdbus/gdbus.h  |  3 ++-
 gdbus/object.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 87fd185..c22c472 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -89,7 +89,8 @@ typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
 						GDBusPendingReply pending);
 
 enum GDBusFlags {
-	G_DBUS_FLAG_ENABLE_EXPERIMENTAL = (1 << 0),
+	G_DBUS_FLAG_ENABLE_DEPRECATED   = (1 << 0),
+	G_DBUS_FLAG_ENABLE_EXPERIMENTAL = (1 << 1),
 };
 
 enum GDBusMethodFlags {
diff --git a/gdbus/object.c b/gdbus/object.c
index d5eb267..364cc60 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -127,6 +127,14 @@ static gboolean check_experimental(int flags, int flag)
 	return !(global_flags & G_DBUS_FLAG_ENABLE_EXPERIMENTAL);
 }
 
+static gboolean check_deprecated(int flags, int flag)
+{
+	if (!(flags & flag))
+		return FALSE;
+
+	return !(global_flags & G_DBUS_FLAG_ENABLE_DEPRECATED);
+}
+
 static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 {
 	const GDBusMethodTable *method;
@@ -143,6 +151,10 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 					G_DBUS_METHOD_FLAG_EXPERIMENTAL))
 			continue;
 
+		if (check_deprecated(method->flags,
+					G_DBUS_METHOD_FLAG_DEPRECATED))
+			continue;
+
 		if (!deprecated && !noreply &&
 				!(method->in_args && method->in_args->name) &&
 				!(method->out_args && method->out_args->name))
@@ -175,6 +187,10 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL))
 			continue;
 
+		if (check_deprecated(signal->flags,
+					G_DBUS_SIGNAL_FLAG_DEPRECATED))
+			continue;
+
 		if (!deprecated && !(signal->args && signal->args->name))
 			g_string_append_printf(gstr,
 						"\t\t<signal name=\"%s\"/>\n",
@@ -202,6 +218,10 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
 			continue;
 
+		if (check_deprecated(property->flags,
+					G_DBUS_PROPERTY_FLAG_DEPRECATED))
+			continue;
+
 		g_string_append_printf(gstr, "\t\t<property name=\"%s\""
 					" type=\"%s\" access=\"%s%s\"",
 					property->name,	property->type,
@@ -567,6 +587,10 @@ static void append_properties(struct interface_data *data,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
 			continue;
 
+		if (check_deprecated(p->flags,
+					G_DBUS_PROPERTY_FLAG_DEPRECATED))
+			continue;
+
 		if (p->get == NULL)
 			continue;
 
@@ -775,6 +799,10 @@ static inline const GDBusPropertyTable *find_property(const GDBusPropertyTable *
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
 			break;
 
+		if (check_deprecated(p->flags,
+					G_DBUS_PROPERTY_FLAG_DEPRECATED))
+			break;
+
 		return p;
 	}
 
@@ -1062,6 +1090,10 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 					G_DBUS_METHOD_FLAG_EXPERIMENTAL))
 			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
+		if (check_deprecated(method->flags,
+					G_DBUS_METHOD_FLAG_DEPRECATED))
+			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
 		if (g_dbus_args_have_signature(method->in_args,
 							message) == FALSE)
 			continue;
@@ -1191,18 +1223,30 @@ static gboolean add_interface(struct generic_data *data,
 		if (!check_experimental(method->flags,
 					G_DBUS_METHOD_FLAG_EXPERIMENTAL))
 			goto done;
+
+		if (!check_deprecated(method->flags,
+					G_DBUS_METHOD_FLAG_DEPRECATED))
+			goto done;
 	}
 
 	for (signal = signals; signal && signal->name; signal++) {
 		if (!check_experimental(signal->flags,
 					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL))
 			goto done;
+
+		if (!check_deprecated(signal->flags,
+					G_DBUS_SIGNAL_FLAG_DEPRECATED))
+			goto done;
 	}
 
 	for (property = properties; property && property->name; property++) {
 		if (!check_experimental(property->flags,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
 			goto done;
+
+		if (!check_deprecated(property->flags,
+					G_DBUS_PROPERTY_FLAG_DEPRECATED))
+			goto done;
 	}
 
 	/* Nothing to register */
-- 
1.8.0.1

