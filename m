Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hciconfig: Retrieve linkey from device info file
Date: Wed,  5 Dec 2012 11:20:12 +0100
Message-Id: <1354702812-21080-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Skip 2 first bytes of Key entry as it begins with "0x"
---
 Makefile.tools    |    2 +-
 tools/hciconfig.c |   37 ++++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 1cbd876..e820301 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -23,7 +23,7 @@ tools_hciattach_LDADD = lib/libbluetooth-private.la
 
 tools_hciconfig_SOURCES = tools/hciconfig.c tools/csr.h tools/csr.c \
 						src/textfile.h src/textfile.c
-tools_hciconfig_LDADD = lib/libbluetooth-private.la
+tools_hciconfig_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
 
 tools_hcitool_SOURCES = tools/hcitool.c src/oui.h src/oui.c \
 						src/textfile.h src/textfile.c
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 045e9a8..3700198 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -38,6 +38,8 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
+#include <glib.h>
+
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
@@ -1018,26 +1020,43 @@ static void cmd_voice(int ctl, int hdev, char *opt)
 static int get_link_key(const bdaddr_t *local, const bdaddr_t *peer,
 			uint8_t *key)
 {
-	char filename[PATH_MAX + 1], addr[18], tmp[3], *str;
+	char filename[PATH_MAX + 1];
+	char local_addr[18], peer_addr[18];
+	GKeyFile *key_file;
+	char tmp[3], *str;
 	int i;
+	int err = 0;
+
+	ba2str(local, local_addr);
+	ba2str(peer, peer_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", local_addr,
+			peer_addr);
+	filename[PATH_MAX] = '\0';
+	key_file = g_key_file_new();
 
-	ba2str(local, addr);
-	create_name(filename, PATH_MAX, STORAGEDIR, addr, "linkkeys");
+	if (!g_key_file_load_from_file(key_file, filename, 0, NULL)) {
+		err = -EIO;
+		goto failed;
+	}
 
-	ba2str(peer, addr);
-	str = textfile_get(filename, addr);
-	if (!str)
-		return -EIO;
+	str = g_key_file_get_string(key_file, "LinkKey", "Key", NULL);
+	if (!str) {
+		err = -EIO;
+		goto failed;
+	}
 
 	memset(tmp, 0, sizeof(tmp));
 	for (i = 0; i < 16; i++) {
-		memcpy(tmp, str + (i * 2), 2);
+		memcpy(tmp, str + 2 + (i * 2), 2);
 		key[i] = (uint8_t) strtol(tmp, NULL, 16);
 	}
 
 	free(str);
 
-	return 0;
+failed:
+	g_key_file_free(key_file);
+
+	return err;
 }
 
 static void cmd_putkey(int ctl, int hdev, char *opt)
-- 
1.7.9.5

