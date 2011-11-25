Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] MAP: Skeleton of application parameters support
Date: Fri, 25 Nov 2011 13:40:23 +0100
Message-Id: <1322224823-27366-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This introduces skeleton of functions for supporting processing of
Message Access Profile specific OBEX application parameters. The code is
usable in both MSE (server) and MCE (client), thus the patch enables
linking the code to obexd and obex-client.
---
 Makefile.am  |    6 ++-
 src/map_ap.c |   61 +++++++++++++++++++++++++++++++++
 src/map_ap.h |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 2 deletions(-)
 create mode 100644 src/map_ap.c
 create mode 100644 src/map_ap.h

diff --git a/Makefile.am b/Makefile.am
index 2582651..9a636ef 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -61,7 +61,8 @@ builtin_sources += plugins/pbap.c plugins/phonebook.h \
 			plugins/vcard.h plugins/vcard.c
 
 builtin_modules += mas
-builtin_sources += plugins/mas.c plugins/messages.h
+builtin_sources += plugins/mas.c plugins/messages.h \
+			src/map_ap.c src/map_ap.h
 
 builtin_modules += irmc
 builtin_sources += plugins/irmc.c
@@ -122,7 +123,8 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/opp.h client/opp.c \
 				client/transfer.h client/transfer.c \
 				client/agent.h client/agent.c \
-				client/driver.h client/driver.c
+				client/driver.h client/driver.c \
+				src/map_ap.h src/map_ap.c
 
 client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
 endif
diff --git a/src/map_ap.c b/src/map_ap.c
new file mode 100644
index 0000000..9c8e3ec
--- /dev/null
+++ b/src/map_ap.c
@@ -0,0 +1,61 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation
+ *
+ *  Author: Slawomir Bochenski <lkslawek@gmail.com>
+ *
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
+#include <inttypes.h>
+
+#include "map_ap.h"
+
+map_ap_t *map_ap_new(void)
+{
+	return NULL;
+}
+
+void map_ap_free(map_ap_t *ap)
+{
+}
+
+map_ap_t *map_ap_parse(const uint8_t *buffer, uint32_t len)
+{
+	return NULL;
+}
+
+GString *map_ap_output(map_ap_t *ap)
+{
+	return NULL;
+}
+
+gboolean map_ap_get(map_ap_t *ap, enum map_ap_tag tag, void *value)
+{
+	return FALSE;
+}
+
+gboolean map_ap_set(map_ap_t *ap, enum map_ap_tag tag, void *value)
+{
+	return FALSE;
+}
diff --git a/src/map_ap.h b/src/map_ap.h
new file mode 100644
index 0000000..1f23669
--- /dev/null
+++ b/src/map_ap.h
@@ -0,0 +1,106 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation
+ *
+ *  Author: Slawomir Bochenski <lkslawek@gmail.com>
+ *
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
+#include <glib.h>
+#include <inttypes.h>
+
+/* List of OBEX application parameters tags as per MAP specification. */
+enum map_ap_tag {
+	MAP_AP_MAXLISTCOUNT		= 0x01,		/* uint16_t	*/
+	MAP_AP_STARTOFFSET		= 0x02,		/* uint16_t	*/
+	MAP_AP_FILTERMESSAGETYPE	= 0x03,		/* uint8_t	*/
+	MAP_AP_FILTERPERIODBEGIN	= 0x04,		/* char *	*/
+	MAP_AP_FILTERPERIODEND		= 0x05,		/* char *	*/
+	MAP_AP_FILTERREADSTATUS		= 0x06,		/* uint8_t	*/
+	MAP_AP_FILTERRECIPIENT		= 0x07,		/* char *	*/
+	MAP_AP_FILTERORIGINATOR		= 0x08,		/* char *	*/
+	MAP_AP_FILTERPRIORITY		= 0x09,		/* uint8_t	*/
+	MAP_AP_ATTACHMENT		= 0x0A,		/* uint8_t	*/
+	MAP_AP_TRANSPARENT		= 0x0B,		/* uint8_t	*/
+	MAP_AP_RETRY			= 0x0C,		/* uint8_t	*/
+	MAP_AP_NEWMESSAGE		= 0x0D,		/* uint8_t	*/
+	MAP_AP_NOTIFICATIONSTATUS	= 0x0E,		/* uint8_t	*/
+	MAP_AP_MASINSTANCEID		= 0x0F,		/* uint8_t	*/
+	MAP_AP_PARAMETERMASK		= 0x10,		/* uint32_t	*/
+	MAP_AP_FOLDERLISTINGSIZE	= 0x11,		/* uint16_t	*/
+	MAP_AP_MESSAGESLISTINGSIZE	= 0x12,		/* uint16_t	*/
+	MAP_AP_SUBJECTLENGTH		= 0x13,		/* uint8_t	*/
+	MAP_AP_CHARSET			= 0x14,		/* uint8_t	*/
+	MAP_AP_FRACTIONREQUEST		= 0x15,		/* uint8_t	*/
+	MAP_AP_FRACTIONDELIVER		= 0x16,		/* uint8_t	*/
+	MAP_AP_STATUSINDICATOR		= 0x17,		/* uint8_t	*/
+	MAP_AP_STATUSVALUE		= 0x18,		/* uint8_t	*/
+	MAP_AP_MSETIME			= 0x19,		/* char *	*/
+	MAP_AP_INVALID			= 0x100,
+};
+
+/* Data type representing MAP application parameters. Consider opaque. */
+typedef GHashTable map_ap_t;
+
+/* Creates a new empty MAP application parameters object. */
+map_ap_t *map_ap_new(void);
+
+/* Frees all the memory used by MAP application parameters object. */
+void map_ap_free(map_ap_t *aparams);
+
+/* Parses given buffer that is a payload of OBEX application parameter header
+ * with a given length. Returned value can be used in calls to map_ap_get() and
+ * map_ap_set(). It has to be freed using map_ap_free(). It also takes care of
+ * converting all the data to host byte order, so this is the byte order used in
+ * map_ap_get()/map_ap_set().
+ *
+ * Returns NULL in case of failure.
+ */
+map_ap_t *map_ap_parse(const uint8_t *buffer, uint32_t length);
+
+/* Takes all parameters currently set and packs them into a buffer with OBEX
+ * application parameters header payload format.
+ *
+ * Returns newly allocated GString. Free with g_string_free().
+ */
+GString *map_ap_output(map_ap_t *ap);
+
+/* Reads value of MAP parameter with given tag. Provide pointer to a variable of
+ * appropriate type, as noted above in map_ap_tag declaration comments. In case
+ * of 'char *' parameters, the pointer to newly allocated buffer will be stored.
+ * Free it with g_free().
+ *
+ * You can also give NULL for value in case you only want to check if parameter
+ * is present.
+ *
+ * Returns TRUE when value is present. FALSE if it is not - value parameter is
+ * unchanged in this case.
+ */
+gboolean map_ap_get(map_ap_t *ap, enum map_ap_tag tag, void *value);
+
+/* Sets the value of MAP parameter with given tag. Provide pointer to a variable
+ * of appropriate type, as noted above in map_ap_tag declaration comments.
+ * Function makes its own copy of 'char *' buffers. If there is already a
+ * parameter with given tag present, it will be replaced. If you give NULL for
+ * value pointer, the given parameter will be removed.
+ *
+ * Returns TRUE on success.
+ */
+gboolean map_ap_set(map_ap_t *ap, enum map_ap_tag tag, void *value);
-- 
1.7.4.1

