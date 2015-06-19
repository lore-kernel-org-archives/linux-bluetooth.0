Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH ] obexd/opp: Fix OPP GET request path
Date: Fri, 19 Jun 2015 12:28:50 +0530
Message-id: <1434697130-5593-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The default path is /etc/bluetooth/vcard.vcf which obexd
is not able to access.

obexd[11654]: obexd/src/obex.c:cmd_get() session 0x64edff0
obexd[11654]: GET(0x3), (null)(0xffffffff)
obexd[11654]: obexd/src/obex.c:parse_type() TYPE: text/x-vcard
obexd[11654]: open(/etc/bluetooth/vcard.vcf): Operation not permitted (1)
obexd[11654]: GET(0x3), NOT_FOUND(0x44)

After making this path as obex root folder,
it is able to succeed.

obexd[12246]: obexd/src/obex.c:cmd_get() session 0x64ed830
obexd[12246]: GET(0x3), (null)(0xffffffff)
obexd[12246]: obexd/src/obex.c:parse_type() TYPE: text/x-vcard
obexd[12246]: obexd/src/obex.c:driver_get_headers() name=(null) type=text/x-vcard object=0x8
obexd[12246]: GET(0x3), CONTINUE(0x10)
obexd[12246]: obexd/src/obex.c:send_data() name=(null) type=text/x-vcard file=0x8 size=3061
obexd[12246]: obexd/src/obex.c:driver_read() 73 read
obexd[12246]: obexd/src/obex.c:send_data() name=(null) type=text/x-vcard file=0x8 size=3066
obexd[12246]: obexd/src/obex.c:driver_read() 0 read
obexd[12246]: obexd/src/obex.c:transfer_complete()
---
 obexd/plugins/opp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
index 445688d..5bb7667 100644
--- a/obexd/plugins/opp.c
+++ b/obexd/plugins/opp.c
@@ -42,7 +42,6 @@
 #include "filesystem.h"
 
 #define VCARD_TYPE "text/x-vcard"
-#define VCARD_FILE CONFIGDIR "/vcard.vcf"
 
 static void *opp_connect(struct obex_session *os, int *err)
 {
@@ -132,6 +131,8 @@ static int opp_put(struct obex_session *os, void *user_data)
 static int opp_get(struct obex_session *os, void *user_data)
 {
 	const char *type;
+	char *folder, *path;
+	int err = 0;
 
 	if (obex_get_name(os))
 		return -EPERM;
@@ -141,14 +142,19 @@ static int opp_get(struct obex_session *os, void *user_data)
 	if (type == NULL)
 		return -EPERM;
 
+	folder = g_strdup(obex_option_root_folder());
+	path = g_build_filename(folder, "/vcard.vcf", NULL);
+
 	if (g_ascii_strcasecmp(type, VCARD_TYPE) == 0) {
-		if (obex_get_stream_start(os, VCARD_FILE) < 0)
-			return -ENOENT;
+		if (obex_get_stream_start(os, path) < 0)
+			err = -ENOENT;
 
 	} else
-		return -EPERM;
+		err = -EPERM;
 
-	return 0;
+	g_free(folder);
+	g_free(path);
+	return err;
 }
 
 static void opp_disconnect(struct obex_session *os, void *user_data)
-- 
1.9.1

