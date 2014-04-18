Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] android/hidhost: Don't use sscanf in hex2buf
Date: Fri, 18 Apr 2014 15:40:05 +0200
Message-Id: <1397828406-29951-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397828406-29951-1-git-send-email-szymon.janc@tieto.com>
References: <1397828406-29951-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add cheaper version (based on similar code in oFono) that doesn't
require sscanf.
---
 android/hidhost.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index ea83733..ab7f7a8 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -30,6 +30,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <ctype.h>
 
 #include <glib.h>
 
@@ -162,12 +163,37 @@ static void hid_device_remove(struct hid_device *dev)
 	hid_device_free(dev);
 }
 
-static void hex2buf(const uint8_t *hex, uint8_t *buf, int num)
+static bool hex2buf(const uint8_t *hex, uint8_t *buf, int buf_size)
 {
-	int i;
+	int i, j;
+	char c;
+	uint8_t b;
 
-	for (i = 0; i < num; i++)
-		sscanf((const char *)(hex + (i * 2)), "%02hhX", &buf[i]);
+	for (i = 0, j = 0; i < buf_size; i++, j++) {
+		c = toupper(hex[j]);
+
+		if (c >= '0' && c <= '9')
+			b = c - '0';
+		else if (c >= 'A' && c <= 'F')
+			b = 10 + c - 'A';
+		else
+			return false;
+
+		j++;
+
+		c = toupper(hex[j]);
+
+		if (c >= '0' && c <= '9')
+			b = b * 16 + c - '0';
+		else if (c >= 'A' && c <= 'F')
+			b = b * 16 + 10 + c - 'A';
+		else
+			return false;
+
+		buf[i] = b;
+	}
+
+	return true;
 }
 
 static void handle_uhid_output(struct hid_device *dev,
-- 
1.9.1

