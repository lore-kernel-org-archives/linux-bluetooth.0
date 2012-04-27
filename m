Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [BlueZ v3 03/10] gdbus: save copy of undecorated signature
Date: Fri, 27 Apr 2012 18:14:38 -0300
Message-Id: <1335561285-3332-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index e378074..6133d8c 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <assert.h>
 #include <stdio.h>
 #include <string.h>
 
@@ -46,7 +47,10 @@ struct generic_data {
 struct interface_data {
 	char *name;
 	const GDBusMethodTable *methods;
+	char **method_signatures;
+	char **reply_signatures;
 	const GDBusSignalTable *signals;
+	char **signal_signatures;
 	const GDBusPropertyTable *properties;
 	void *user_data;
 	GDBusDestroyFunction destroy;
@@ -501,6 +505,79 @@ static GDBusMethodTable introspect_methods[] = {
 	{ }
 };
 
+static char *undecorate_signature(const char *src)
+{
+	GString *dst = g_string_new(NULL);
+	size_t len;
+
+	for (len = 0; *src; src++) {
+		switch (*src) {
+		case '[':
+			assert(len > 0);
+			g_string_append_len(dst, src - len, len);
+
+			while (*src && *src != ']')
+				src++;
+
+			/* end of string without matching ']' */
+			assert(*src == ']');
+			len = 0;
+			break;
+		case ']':
+			/* ']' without '[' */
+			assert(0);
+			break;
+		default:
+			len++;
+		}
+	}
+
+	g_string_append_len(dst, src, len);
+
+	return g_string_free(dst, FALSE);
+}
+
+static void undecorate_signals(struct interface_data *iface)
+{
+	const GDBusSignalTable *s;
+	size_t n, i;
+	char **sigs;
+
+	for (s = iface->signals, n = 0; s && s->name; s++)
+		n++;
+
+	sigs = g_new(char *, n + 1);
+	sigs[n] = NULL;
+
+	for (s = iface->signals, i = 0; s && s->name; s++, i++)
+		sigs[i] = undecorate_signature(s->signature);
+
+	iface->signal_signatures = sigs;
+}
+
+static void undecorate_methods(struct interface_data *iface)
+{
+	const GDBusMethodTable *m;
+	size_t n, i;
+	char **sigs, **reply_sigs;
+
+	for (m = iface->methods, n = 0; m && m->name; m++)
+		n++;
+
+	sigs = g_new(char *, n + 1);
+	reply_sigs = g_new(char *, n + 1);
+	sigs[n] = NULL;
+	reply_sigs[n] = NULL;
+
+	for (m = iface->methods, i = 0; m && m->name; m++, i++) {
+		sigs[i] = undecorate_signature(m->signature);
+		reply_sigs[i] = undecorate_signature(m->reply);
+	}
+
+	iface->method_signatures = sigs;
+	iface->reply_signatures = reply_sigs;
+}
+
 static void add_interface(struct generic_data *data, const char *name,
 				const GDBusMethodTable *methods,
 				const GDBusSignalTable *signals,
@@ -513,7 +590,9 @@ static void add_interface(struct generic_data *data, const char *name,
 	iface = g_new0(struct interface_data, 1);
 	iface->name = g_strdup(name);
 	iface->methods = methods;
+	undecorate_methods(iface);
 	iface->signals = signals;
+	undecorate_signals(iface);
 	iface->properties = properties;
 	iface->user_data = user_data;
 	iface->destroy = destroy;
@@ -568,6 +647,9 @@ static gboolean remove_interface(struct generic_data *data, const char *name)
 		iface->destroy(iface->user_data);
 
 	g_free(iface->name);
+	g_strfreev(iface->method_signatures);
+	g_strfreev(iface->reply_signatures);
+	g_strfreev(iface->signal_signatures);
 	g_free(iface);
 
 	return TRUE;
-- 
1.7.10

