Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH v2 2/4] Add actual service for Message Access Profile
Date: Fri, 11 Mar 2011 08:46:50 +0100
Message-Id: <1299829612-3704-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1299829612-3704-1-git-send-email-lkslawek@gmail.com>
References: <1299829612-3704-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds basic service functionality in MAP code, accompanied by proper
record for SDP.

RFCOMM channel of choice is 16 which is in accordance with
doc/assigned-numbers.txt.
---
 plugins/mas.c |  189 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 189 insertions(+), 0 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 0eab43b..aefd291 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -25,18 +25,207 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+#include <glib.h>
+#include <openobex/obex.h>
+
 #include "plugin.h"
 #include "log.h"
+#include "obex.h"
+#include "service.h"
+#include "dbus.h"
 
 #include "messages.h"
 
+/* Channel number according to bluez doc/assigned-numbers.txt */
+#define MAS_CHANNEL	16
+
+#define MAS_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>		\
+<record>								\
+  <attribute id=\"0x0001\">						\
+    <sequence>								\
+      <uuid value=\"0x1132\"/>						\
+    </sequence>								\
+  </attribute>								\
+									\
+  <attribute id=\"0x0004\">						\
+    <sequence>								\
+      <sequence>							\
+        <uuid value=\"0x0100\"/>					\
+      </sequence>							\
+      <sequence>							\
+        <uuid value=\"0x0003\"/>					\
+        <uint8 value=\"%u\" name=\"channel\"/>				\
+      </sequence>							\
+      <sequence>							\
+        <uuid value=\"0x0008\"/>					\
+      </sequence>							\
+    </sequence>								\
+  </attribute>								\
+									\
+  <attribute id=\"0x0009\">						\
+    <sequence>								\
+      <sequence>							\
+        <uuid value=\"0x1134\"/>					\
+        <uint16 value=\"0x0100\" name=\"version\"/>			\
+      </sequence>							\
+    </sequence>								\
+  </attribute>								\
+									\
+  <attribute id=\"0x0100\">						\
+    <text value=\"%s\" name=\"name\"/>					\
+  </attribute>								\
+									\
+  <attribute id=\"0x0315\">						\
+    <uint8 value=\"0x00\"/>						\
+  </attribute>								\
+									\
+  <attribute id=\"0x0316\">						\
+    <uint8 value=\"0x0F\"/>						\
+  </attribute>								\
+</record>"
+
+struct mas_session {
+	struct mas_request *request;
+};
+
+static const uint8_t MAS_TARGET[TARGET_SIZE] = {
+			0xbb, 0x58, 0x2b, 0x40, 0x42, 0x0c, 0x11, 0xdb,
+			0xb0, 0xde, 0x08, 0x00, 0x20, 0x0c, 0x9a, 0x66  };
+
+static void mas_clean(struct mas_session *mas)
+{
+	g_free(mas);
+}
+
+static void *mas_connect(struct obex_session *os, int *err)
+{
+	struct mas_session *mas;
+
+	DBG("");
+
+	*err = 0;
+
+	mas = g_new0(struct mas_session, 1);
+
+	manager_register_session(os);
+
+	return mas;
+}
+
+static void mas_disconnect(struct obex_session *os, void *user_data)
+{
+	struct mas_session *mas = user_data;
+
+	DBG("");
+
+	manager_unregister_session(os);
+
+	mas_clean(mas);
+}
+
+static int mas_get(struct obex_session *os, obex_object_t *obj,
+					gboolean *stream, void *user_data)
+{
+	struct mas_session *mas = user_data;
+	const char *type = obex_get_type(os);
+	const char *name = obex_get_name(os);
+	int ret;
+
+	DBG("GET: name %s type %s mas %p",
+			name, type, mas);
+
+	if (type == NULL)
+		return -EBADR;
+
+	*stream = FALSE;
+
+	ret = obex_get_stream_start(os, name);
+	if (ret < 0)
+		goto failed;
+
+	return 0;
+
+failed:
+	return ret;
+}
+
+static int mas_put(struct obex_session *os, obex_object_t *obj, void *user_data)
+{
+	struct mas_session *mas = user_data;
+	const char *type = obex_get_type(os);
+	const char *name = obex_get_name(os);
+	int ret;
+
+	DBG("PUT: name %s type %s mas %p", name, type, mas);
+
+	if (type == NULL)
+		return -EBADR;
+
+	ret = obex_put_stream_start(os, name);
+	if (ret < 0)
+		goto failed;
+
+	return 0;
+
+failed:
+	return ret;
+}
+
+static int mas_setpath(struct obex_session *os, obex_object_t *obj,
+		void *user_data)
+{
+	const char *name;
+	uint8_t *nonhdr;
+
+	if (OBEX_ObjectGetNonHdrData(obj, &nonhdr) != 2) {
+		error("Set path failed: flag and constants not found!");
+		return -EBADR;
+	}
+
+	name = obex_get_name(os);
+
+	DBG("SETPATH: name %s nonhdr 0x%x%x", name, nonhdr[0], nonhdr[1]);
+
+	if ((nonhdr[0] & 0x02) != 0x02) {
+		DBG("Error: requested directory creation");
+		return -EBADR;
+	}
+
+	return 0;
+}
+
+static struct obex_service_driver mas = {
+	.name = "Message Access server",
+	.service = OBEX_MAS,
+	.channel = MAS_CHANNEL,
+	.record = MAS_RECORD,
+	.target = MAS_TARGET,
+	.target_size = TARGET_SIZE,
+	.connect = mas_connect,
+	.get = mas_get,
+	.put = mas_put,
+	.setpath = mas_setpath,
+	.disconnect = mas_disconnect,
+};
+
 static int mas_init(void)
 {
+	int err;
+
+	err = obex_service_driver_register(&mas);
+	if (err < 0)
+		goto failed_mas_reg;
+
 	return 0;
+
+failed_mas_reg:
+	return err;
 }
 
 static void mas_exit(void)
 {
+	obex_service_driver_unregister(&mas);
 }
 
 OBEX_PLUGIN_DEFINE(mas, mas_init, mas_exit)
-- 
1.7.1

