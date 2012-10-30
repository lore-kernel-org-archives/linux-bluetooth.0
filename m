Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 6/6] hcitool: Retrieve names from cache directory
Date: Tue, 30 Oct 2012 18:05:28 +0100
Message-Id: <1351616728-10075-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351616728-10075-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351616728-10075-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools  |    2 +-
 tools/hcitool.c |   31 ++++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index ec79cea..f7c85ef 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -28,7 +28,7 @@ tools_hciconfig_LDADD = lib/libbluetooth-private.la
 
 tools_hcitool_SOURCES = tools/hcitool.c src/oui.h src/oui.c \
 						src/textfile.h src/textfile.c
-tools_hcitool_LDADD = lib/libbluetooth-private.la
+tools_hcitool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
 
 tools_sdptool_SOURCES = tools/sdptool.c src/sdp-xml.h src/sdp-xml.c
 tools_sdptool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
diff --git a/tools/hcitool.c b/tools/hcitool.c
index aefbd68..a05e31f 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -40,6 +40,8 @@
 #include <sys/socket.h>
 #include <signal.h>
 
+#include <glib.h>
+
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
@@ -409,13 +411,32 @@ static char *major_classes[] = {
 
 static char *get_device_name(const bdaddr_t *local, const bdaddr_t *peer)
 {
-	char filename[PATH_MAX + 1], addr[18];
+	char filename[PATH_MAX + 1];
+	char local_addr[18], peer_addr[18];
+	GKeyFile *key_file;
+	char *str = NULL;
+	int len;
+
+	ba2str(local, local_addr);
+	ba2str(peer, peer_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local_addr,
+			peer_addr);
+	filename[PATH_MAX] = '\0';
+	key_file = g_key_file_new();
+
+	if (g_key_file_load_from_file(key_file, filename, 0, NULL)) {
+		str = g_key_file_get_string(key_file, "General", "Name", NULL);
+		if (str) {
+			len = strlen(str);
+			if (len > HCI_MAX_NAME_LENGTH)
+				str[HCI_MAX_NAME_LENGTH] = '\0';
+		}
+	}
 
-	ba2str(local, addr);
-	create_name(filename, PATH_MAX, STORAGEDIR, addr, "names");
+	g_key_file_free(key_file);
 
-	ba2str(peer, addr);
-	return textfile_get(filename, addr);
+	return str;
 }
 
 /* Display local devices */
-- 
1.7.9.5

