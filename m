Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v2] MAP: Skeleton of application parameters support
Date: Mon,  5 Dec 2011 13:21:25 +0100
Message-Id: <1323087685-9528-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This introduces skeleton of functions for supporting processing of
Message Access Profile specific OBEX application parameters. The code is
usable in both MSE (server) and MCE (client), thus the patch enables
linking the code to obexd and obex-client.
---
Changes as per comments to first version.

 Makefile.am  |    6 ++-
 src/map_ap.c |   89 +++++++++++++++++++++++++++++++++++++++++++++
 src/map_ap.h |  115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 src/map_ap.c
 create mode 100644 src/map_ap.h

diff --git a/Makefile.am b/Makefile.am
index af03f2e..bdb961f 100644
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
@@ -121,7 +122,8 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
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
index 0000000..9d13adf
--- /dev/null
+++ b/src/map_ap.c
@@ -0,0 +1,89 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation
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
+map_ap_t *map_ap_decode(const uint8_t *buffer, size_t length)
+{
+	return NULL;
+}
+
+uint8_t *map_ap_encode(map_ap_t *ap, size_t *length)
+{
+	*length = 0;
+
+	return NULL;
+}
+
+gboolean map_ap_get_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t *val)
+{
+	return FALSE;
+}
+
+gboolean map_ap_get_u16(map_ap_t *ap, enum map_ap_tag tag, uint16_t *val)
+{
+	return FALSE;
+}
+
+gboolean map_ap_get_u32(map_ap_t *ap, enum map_ap_tag tag, uint32_t *val)
+{
+	return FALSE;
+}
+
+const char *map_ap_get_string(map_ap_t *ap, enum map_ap_tag tag)
+{
+	return NULL;
+}
+
+gboolean map_ap_set_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t val)
+{
+	return FALSE;
+}
+
+gboolean map_ap_set_u16(map_ap_t *ap, enum map_ap_tag tag, uint16_t val)
+{
+	return FALSE;
+}
+
+gboolean map_ap_set_u32(map_ap_t *ap, enum map_ap_tag tag, uint32_t val)
+{
+	return FALSE;
+}
+
+gboolean map_ap_set_string(map_ap_t *ap, enum map_ap_tag tag, const char *val)
+{
+	return FALSE;
+}
diff --git a/src/map_ap.h b/src/map_ap.h
new file mode 100644
index 0000000..9743b54
--- /dev/null
+++ b/src/map_ap.h
@@ -0,0 +1,115 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation
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
+void map_ap_free(map_ap_t *ap);
+
+/* Parses given buffer that is a payload of OBEX application parameter header
+ * with a given length. Returned value can be used in calls to map_ap_get_*()
+ * and map_ap_set_*(). It has to be freed using map_ap_free(). It also takes
+ * care of converting all the data to host byte order, so this is the byte order
+ * used in map_ap_get_*()/map_ap_set_*().
+ *
+ * Returns NULL in case of failure.
+ */
+map_ap_t *map_ap_decode(const uint8_t *buffer, size_t length);
+
+/* Takes all parameters currently set and packs them into a buffer with OBEX
+ * application parameters header payload format.
+ *
+ * Returns newly allocated buffer of size 'length'. Free with g_free().
+ */
+uint8_t *map_ap_encode(map_ap_t *ap, size_t *length);
+
+/* Following family of functions reads value of MAP parameter with given tag.
+ * Use the one with appropriate type for a given tag, as noted above in
+ * map_ap_tag declaration comments.
+ *
+ * Returns TRUE when value is present. FALSE if it is not or the function is
+ * used get a parameter of a different type. When FALSE is returned, variable
+ * pointed by 'val' is left intact.
+ */
+gboolean map_ap_get_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t *val);
+gboolean map_ap_get_u16(map_ap_t *ap, enum map_ap_tag tag, uint16_t *val);
+gboolean map_ap_get_u32(map_ap_t *ap, enum map_ap_tag tag, uint32_t *val);
+
+/* Reads value of MAP parameter with given tag that is of a string type.
+ *
+ * Returns NULL if parameter is not present in ap or given tag is not of a
+ * string type.
+ */
+const char *map_ap_get_string(map_ap_t *ap, enum map_ap_tag tag);
+
+/* Following family of functions sets the value of MAP parameter with given tag.
+ * Use the one with appropriate type for a given tag, as noted above in
+ * map_ap_tag declaration comments.
+ *
+ * If there is already a parameter with given tag present, it will be replaced.
+ * map_ap_set_string() makes its own copy of given string.
+ *
+ * Returns TRUE on success (the tag is known and the function chosen matches the
+ * type of tag).
+ */
+gboolean map_ap_set_u8(map_ap_t *ap, enum map_ap_tag tag, uint8_t val);
+gboolean map_ap_set_u16(map_ap_t *ap, enum map_ap_tag tag, uint16_t val);
+gboolean map_ap_set_u32(map_ap_t *ap, enum map_ap_tag tag, uint32_t val);
+gboolean map_ap_set_string(map_ap_t *ap, enum map_ap_tag tag, const char *val);
-- 
1.7.4.1

