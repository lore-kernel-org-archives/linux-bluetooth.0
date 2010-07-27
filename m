Return-Path: <cyrus@holtmann.org>
Message-Id: <201008121013.o7CADR8r004125@joshua.mesa.nl>
From: Marcel Mol <marcel@mesa.nl>
Date: Tue, 27 Jul 2010 19:04:11 +0200
Subject: [PATCH] IrMC sync server support
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A reasonable working IrMC SYNC server (only full phonebook sync support)
Support for cal and note by just returning nothing.
---
 Makefile.am    |    3 +
 plugins/irmc.c |  488 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/main.c     |   12 ++-
 src/obex.h     |    1 +
 4 files changed, 502 insertions(+), 2 deletions(-)
 create mode 100644 plugins/irmc.c

diff --git a/Makefile.am b/Makefile.am
index 73e2f28..ce8c675 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -58,6 +58,9 @@ builtin_sources += plugins/pbap.c plugins/phonebook.h \
 builtin_modules += syncevolution
 builtin_sources += plugins/syncevolution.c
 
+builtin_modules += irmc
+builtin_sources += plugins/irmc.c plugins/phonebook.h
+
 builtin_nodist += plugins/phonebook.c
 
 libexec_PROGRAMS += src/obexd
diff --git a/plugins/irmc.c b/plugins/irmc.c
new file mode 100644
index 0000000..96fd807
--- /dev/null
+++ b/plugins/irmc.c
@@ -0,0 +1,488 @@
+/*
+ *
+ *  OBEX IrMC Sync Server
+ *
+ *  Copyright (C) 2010  Marcel Mol <marcel@mesa.nl>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <glib.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include <openobex/obex.h>
+#include <openobex/obex_const.h>
+
+#include "plugin.h"
+#include "log.h"
+#include "obex.h"
+#include "service.h"
+#include "phonebook.h"
+#include "mimetype.h"
+#include "filesystem.h"
+#include "dbus.h"
+
+#define IRMC_CHANNEL	17
+
+#define IRMC_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>	\
+<record>								\
+  <attribute id=\"0x0001\">						\
+    <sequence>								\
+      <uuid value=\"0x1104\"/>						\
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
+        <uuid value=\"0x1104\"/>					\
+        <uint16 value=\"0x0100\" name=\"version\"/>			\
+      </sequence>							\
+    </sequence>								\
+  </attribute>								\
+									\
+  <attribute id=\"0x0100\">						\
+    <text value=\"%s\" name=\"name\"/>					\
+  </attribute>								\
+									\
+  <attribute id=\"0x0301\">						\
+    <sequence>								\
+      <uint8 value=\"0x01\"/>						\
+    </sequence>								\
+  </attribute>								\
+</record>"
+
+
+struct aparam_header {
+	uint8_t tag;
+	uint8_t len;
+	uint8_t val[0];
+} __attribute__ ((packed));
+
+#define DIDLEN 18
+struct irmc_session {
+	struct obex_session *os;
+	struct apparam_field *params;
+	uint16_t entries;
+	GString *buffer;
+	char sn[DIDLEN];
+	char did[DIDLEN];
+	char manu[DIDLEN];
+	char model[DIDLEN];
+};
+
+#define IRMC_TARGET_SIZE 9
+
+static const guint8 IRMC_TARGET[IRMC_TARGET_SIZE] = {
+			0x49, 0x52, 0x4d, 0x43,  0x2d, 0x53, 0x59, 0x4e, 0x43 };
+
+static void phonebook_size_result(const char *buffer, size_t bufsize,
+				int vcards, int missed, void *user_data)
+{
+	struct irmc_session *irmc = user_data;
+
+	DBG("vcards %d", vcards);
+
+	irmc->params->maxlistcount = vcards;
+}
+
+static void query_result(const char *buffer, size_t bufsize, int vcards,
+					int missed, void *user_data)
+{
+	struct irmc_session *irmc = user_data;
+	const char *s;
+	char *t;
+
+	DBG("bufsize %d vcards %d missed %d", bufsize, vcards, missed);
+
+	// first create an empty 'owner' vcard
+	t = "BEGIN:VCARD\r\n"
+		"VERSION:2.1\r\n"
+		"N:\r\n"
+		"TEL:\r\n"
+		"X-IRMX-LUID:0\r\n"
+		"END:VCARDi\r\n";
+	if (!irmc->buffer)
+		irmc->buffer = g_string_new_len(t, strlen(t));
+	else
+		irmc->buffer = g_string_append_len(irmc->buffer, t, strlen(t));
+
+	// loop around buffer and add X-IRMC-LUID attribs
+	s = buffer;
+	while ((t = strstr(s, "UID:")) != NULL) {
+		// add upto UID: into buffer
+		irmc->buffer = g_string_append_len(irmc->buffer, s, t-s);
+		// add UID: line into buffer
+		// Not sure if UID is still needed if X-IRMC-LUID is there
+		s = t;
+		t = strstr(s, "\r\n");
+		t += 2;
+		irmc->buffer = g_string_append_len(irmc->buffer, s, t-s);
+		// add X-IRMC-LUID with same number as UID
+		irmc->buffer = g_string_append_len(irmc->buffer,
+							"X-IRMC-LUID:", 12);
+		s += 4; // point to uid number
+		irmc->buffer = g_string_append_len(irmc->buffer, s, t-s);
+		s = t;
+	}
+	// add remaining bit of buffer
+	irmc->buffer = g_string_append_len(irmc->buffer, s,
+							bufsize - (s-buffer));
+
+	obex_object_set_io_flags(irmc, G_IO_IN, 0);
+}
+
+static void *irmc_connect(struct obex_session *os, int *err)
+{
+	struct irmc_session *irmc;
+	struct apparam_field *param;
+
+	DBG("");
+
+	manager_register_session(os);
+
+	irmc = g_new0(struct irmc_session, 1);
+	irmc->os = os;
+
+	/*
+	 * ideally get capabilities info here and use that to define
+	 * IrMC DID and SN etc parameters.
+	 * For now lets used hostname and some 'random' value
+	 */
+	gethostname(irmc->did, DIDLEN);
+	strncpy(irmc->sn, "12345", DIDLEN);
+	strncpy(irmc->manu, "obex", DIDLEN);
+	strncpy(irmc->model, "mymodel", DIDLEN);
+
+	/*
+         *  we need to know the number of contact/cal/nt entries
+         *  somewhere so why not do it now.
+         */
+	param = g_new0(struct apparam_field, 1);
+	param->maxlistcount = 0; // to count the number of vcards...
+	param->filter = 0x200085; // UID TEL N VERSION
+	irmc->params = param;
+	phonebook_pull("telecom/pb.vcf", irmc->params, phonebook_size_result,
+									irmc);
+
+	if (err)
+		*err = 0;
+
+	return irmc;
+}
+
+static int irmc_get(struct obex_session *os, obex_object_t *obj,
+		gboolean *stream, void *user_data)
+{
+	struct irmc_session *irmc = user_data;
+	const char *type = obex_get_type(os);
+	const char *name = obex_get_name(os);
+	char *path;
+	int ret;
+
+	DBG("name %s type %s irmc %p", name, type ? type : "NA", irmc);
+
+	path = g_strdup(name);
+	*stream = TRUE;
+
+	ret = obex_get_stream_start(os, path);
+
+	g_free(path);
+
+	return ret;
+}
+
+static void irmc_disconnect(struct obex_session *os, void *user_data)
+{
+	struct irmc_session *irmc = user_data;
+
+	DBG("");
+
+	manager_unregister_session(os);
+
+        if (irmc->params) {
+                if (irmc->params->searchval)
+			g_free(irmc->params->searchval);
+                g_free(irmc->params);
+        }
+	if (irmc->buffer) {
+		string_free(irmc->buffer);
+		irmc->buffer = NULL;
+	}
+
+	g_free(irmc);
+}
+
+static int irmc_chkput(struct obex_session *os, void *user_data)
+{
+	DBG("");
+	/* Reject all PUTs */
+	return -EBADR;
+}
+
+static void *irmc_open_devinfo(struct irmc_session *irmc, int *err)
+{
+	char mybuf[1024];
+
+	sprintf(mybuf, "MANU:%s\r\n"
+			"MOD:%s\r\n"
+			"SN:%s\r\n"
+			"PB-TYPE-TX:VCARD2.1\r\n",
+			irmc->manu, irmc->model, irmc->sn);
+
+	if (!irmc->buffer)
+		irmc->buffer = g_string_new(mybuf);
+	else
+		irmc->buffer = g_string_append(irmc->buffer, mybuf);
+
+	return irmc;
+}
+
+static void *irmc_open_pb(const char *name,
+		 struct irmc_session *irmc, int *err)
+{
+	char mybuf[1024];
+	int ret;
+
+	if (!g_strcmp0(name, ".vcf")) {
+		// how can we tell if the vcard count call already finished?
+		ret = phonebook_pull("telecom/pb.vcf", irmc->params,
+							query_result, irmc);
+		if (ret < 0) {
+			DBG("phonebook_pull failed...");
+			goto fail;
+		}
+		return irmc;
+	}
+
+	if (!g_strcmp0(name, "/info.log")) {
+		sprintf(mybuf, "Total-Records:%d\r\n"
+				"Maximum-Records:%d\r\n"
+				"DID:%s\r\n",
+				irmc->params->maxlistcount,
+				irmc->params->maxlistcount, irmc->did);
+	}
+	else if (!strncmp(name, "/luid/", 6)) {
+		name += 6;
+		if (!g_strcmp0(name, "cc.log"))
+			sprintf(mybuf, "%d\r\n", irmc->params->maxlistcount);
+		else {
+			int l = strlen(name);
+			/* FIXME
+			 * reply the same to any *.log so we hopefully force a
+			 * full phonebook dump.
+			 * Is IEL:2 ok?
+			 */
+			if (l > 4 && !g_strcmp0(name + l - 4, ".log")) {
+				DBG("changelog request, force whole book");
+				sprintf(mybuf, "SN:%s\r\n"
+						"IEL:2\r\n"
+						"DID:%s\r\n"
+						"Total-Records:%d\r\n"
+						"Maximum-Records:%d\r\n"
+						"*\r\n",
+					irmc->sn, irmc->did,
+					irmc->params->maxlistcount,
+					irmc->params->maxlistcount);
+			}
+			else {
+				ret = -EBADR;
+				goto fail;
+			}
+		}
+	}
+	else {
+		ret = -EBADR;
+		goto fail;
+	}
+
+	if (!irmc->buffer)
+		irmc->buffer = g_string_new(mybuf);
+	else
+		irmc->buffer = g_string_append(irmc->buffer, mybuf);
+
+	return irmc;
+
+fail:
+	if (err)
+		*err = ret;
+
+	return NULL;
+}
+
+static void *irmc_open_cal(const char *name,
+		 struct irmc_session *irmc, int *err)
+{
+	// no suport yet. Just return an empty buffer
+	//cal.vcs
+	DBG("unsupported, returning empty buffer");
+	if (!irmc->buffer)
+		irmc->buffer = g_string_new("");
+	else
+		irmc->buffer = g_string_append(irmc->buffer, "");
+
+	return irmc;
+}
+
+static void *irmc_open_nt(const char *name,
+		 struct irmc_session *irmc, int *err)
+{
+	// no suport yet. Just return an empty buffer
+	//nt.vnt
+	DBG("unsupported, returning empty buffer");
+	if (!irmc->buffer)
+		irmc->buffer = g_string_new("");
+	else
+		irmc->buffer = g_string_append(irmc->buffer, "");
+
+	return irmc;
+}
+
+static void *irmc_open(const char *name, int oflag, mode_t mode,
+		void *context, size_t *size, int *err)
+{
+	struct irmc_session *irmc = context;
+	int ret;
+	const char *p;
+
+	DBG("name %s context %p", name, context);
+	if (oflag != O_RDONLY) {
+		ret = -EPERM;
+		goto fail;
+	}
+	if (strncmp(name, "telecom/", 8) != NULL) {
+		ret = -EBADR;
+		goto fail;
+	}
+
+	p = name + 8;
+	if (!g_strcmp0(p, "devinfo.txt"))
+		return irmc_open_devinfo(irmc, err);
+	else if (!strncmp(p, "pb", 2))
+		return irmc_open_pb(p+2, irmc, err);
+	else if (!strncmp(p, "cal", 3))
+		return irmc_open_cal(p+3, irmc, err);
+	else if (!strncmp(p, "nt", 2))
+		return irmc_open_nt(p+2, irmc, err);
+
+fail:
+	if (err)
+		*err = ret;
+
+	return NULL;
+}
+
+static int irmc_close(void *object)
+{
+	struct irmc_session *irmc = object;
+
+	DBG("");
+	if (irmc->buffer) {
+		string_free(irmc->buffer);
+		irmc->buffer = NULL;
+	}
+
+	return 0;
+}
+
+static ssize_t irmc_read(void *object, void *buf, size_t count, uint8_t *hi)
+{
+	struct irmc_session *irmc = object;
+        int len;
+
+	DBG("buffer %p count %d", irmc->buffer, count);
+	if (!irmc->buffer)
+                return -EAGAIN;
+
+        *hi = OBEX_HDR_BODY;
+	len = string_read(irmc->buffer, buf, count);
+	DBG("returning %d bytes", len);
+	return len;
+}
+
+static struct obex_mime_type_driver irmc_driver = {
+	.target = IRMC_TARGET,
+	.target_size = IRMC_TARGET_SIZE,
+	.open = irmc_open,
+	.close = irmc_close,
+	.read = irmc_read,
+};
+
+static struct obex_service_driver irmc = {
+	.name = "IRMC Sync server",
+	.service = OBEX_IRMC,
+	.channel = IRMC_CHANNEL,
+	.record = IRMC_RECORD,
+	.target = IRMC_TARGET,
+	.target_size = IRMC_TARGET_SIZE,
+	.connect = irmc_connect,
+	.get = irmc_get,
+	.disconnect = irmc_disconnect,
+	.chkput = irmc_chkput
+};
+
+static int irmc_init(void)
+{
+	int err;
+
+	DBG("");
+	err = phonebook_init();
+	if (err < 0)
+		return err;
+
+	err = obex_mime_type_driver_register(&irmc_driver);
+	if (err < 0)
+		return err;
+
+	return obex_service_driver_register(&irmc);
+}
+
+static void irmc_exit(void)
+{
+	DBG("");
+	obex_service_driver_unregister(&irmc);
+	obex_mime_type_driver_unregister(&irmc_driver);
+	phonebook_exit();
+}
+
+OBEX_PLUGIN_DEFINE(irmc, irmc_init, irmc_exit)
diff --git a/src/main.c b/src/main.c
index 649acf9..96523a6 100644
--- a/src/main.c
+++ b/src/main.c
@@ -83,6 +83,7 @@ static gboolean option_pbap = FALSE;
 static gboolean option_pcsuite = FALSE;
 static gboolean option_symlinks = FALSE;
 static gboolean option_syncevolution = FALSE;
+static gboolean option_irmc = FALSE;
 
 static gboolean parse_debug(const char *key, const char *value,
 				gpointer user_data, GError **error)
@@ -122,6 +123,8 @@ static GOptionEntry options[] = {
 				"Enable PC Suite Services server" },
 	{ "syncevolution", 'e', 0, G_OPTION_ARG_NONE, &option_syncevolution,
 				"Enable OBEX server for SyncEvolution" },
+	{ "irmc", 'i', 0, G_OPTION_ARG_NONE, &option_irmc,
+				"Enable IrMCSync server" },
 	{ NULL },
 };
 
@@ -208,9 +211,10 @@ int main(int argc, char *argv[])
 
 	if (option_opp == FALSE && option_ftp == FALSE &&
 				option_pbap == FALSE &&
-				option_syncevolution == FALSE) {
+				option_syncevolution == FALSE &&
+				option_irmc == FALSE) {
 		fprintf(stderr, "No server selected (use either "
-				"--opp, --ftp, --pbap or --syncevolution)\n");
+				"--opp, --ftp, --pbap --syncevolution or --irmc)\n");
 		exit(EXIT_FAILURE);
 	}
 
@@ -270,6 +274,10 @@ int main(int argc, char *argv[])
 		obex_server_init(OBEX_SYNCEVOLUTION, NULL, TRUE, FALSE,
 							FALSE, NULL);
 
+	if (option_irmc == TRUE)
+		obex_server_init(OBEX_IRMC, NULL, TRUE, FALSE, FALSE,
+				option_capability);
+
 	if (!root_folder_setup(option_root, option_root_setup)) {
 		error("Unable to setup root folder %s", option_root);
 		exit(EXIT_FAILURE);
diff --git a/src/obex.h b/src/obex.h
index 9424b6b..cfe9159 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -35,6 +35,7 @@
 #define OBEX_PBAP	(1 << 4)
 #define OBEX_PCSUITE	(1 << 5)
 #define OBEX_SYNCEVOLUTION	(1 << 6)
+#define OBEX_IRMC	(1 << 7)
 
 #define TARGET_SIZE 16
 
-- 
1.7.2

