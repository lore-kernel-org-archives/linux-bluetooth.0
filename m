Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 12/26] deviceinfo: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:42 -0300
Message-Id: <1368073016-28434-12-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate.
---
 profiles/deviceinfo/deviceinfo.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index e8cb5f7..39e4846 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdbool.h>
 #include <errno.h>
 
@@ -46,7 +47,7 @@
 struct deviceinfo {
 	struct btd_device	*dev;		/* Device reference */
 	GAttrib			*attrib;	/* GATT connection */
-	guint			attioid;	/* Att watcher id */
+	unsigned int			attioid;	/* Att watcher id */
 	struct att_range	*svc_range;	/* DeviceInfo range */
 	GSList			*chars;		/* Characteristics */
 };
@@ -86,7 +87,7 @@ static int cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
-static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
+static void read_pnpid_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
 	struct characteristic *ch = user_data;
@@ -120,7 +121,7 @@ static void process_deviceinfo_char(struct characteristic *ch)
 							read_pnpid_cb, ch);
 }
 
-static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
+static void configure_deviceinfo_cb(GSList *characteristics, uint8_t status,
 							gpointer user_data)
 {
 	struct deviceinfo *d = user_data;
-- 
1.8.2.2

