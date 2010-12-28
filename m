Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 4/4] Better filtering input string contain bdaddr
Date: Tue, 28 Dec 2010 10:15:44 +0100
Message-ID: <1293527744-12532-1-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <AANLkTinXwbHZt4SSaz+tUUH+7QnQo7L4FKFKetmQm9Qx@mail.gmail.com>
References: <AANLkTinXwbHZt4SSaz+tUUH+7QnQo7L4FKFKetmQm9Qx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index 3a4e3f4..4e32a1d 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -60,23 +60,63 @@ char *batostr(const bdaddr_t *ba)
 	return str;
 }
 
+/* convert to bdaddr_t string describes with regular expression "(XX:){0,5}XX"
+ * where X is "[0-9A-Fa-f]"
+ * shorter address is filling with ":00" at the end
+ */
 bdaddr_t *strtoba(const char *str)
 {
 	const char *ptr = str;
 	int i;
+	int parts;
+	int length;
+	bdaddr_t *ba;
+
+	length = strlen(str);
+	if (length <= 1 || length > 17)
+		return NULL;
 
-	uint8_t *ba = bt_malloc(sizeof(bdaddr_t));
+	ba = bt_malloc(sizeof(bdaddr_t));
 	if (!ba)
 		return NULL;
 
-	for (i = 0; i < 6; i++) {
-		ba[i] = (uint8_t) strtol(ptr, NULL, 16);
-		if (i != 5 && !(ptr = strchr(ptr,':')))
-			ptr = ":00:00:00:00:00";
+	i = 0;
+	parts = 0;
+	while (*ptr) {
+		if (i == 2) {
+			if (*ptr == ':') {
+				i = 0;
+				ba->b[parts] = strtol(ptr - 2, NULL, 16);
+				parts++;
+				ptr++;
+			} else {
+				bt_free(ba);
+				return NULL;
+			}
+		}
+
+		if ((*ptr < 'A' || *ptr > 'F') &&
+			(*ptr < 'a' || *ptr > 'f') &&
+			(*ptr < '0' || *ptr > '9')) {
+			bt_free(ba);
+			return NULL;
+		}
+
+		i++;
 		ptr++;
 	}
 
-	return (bdaddr_t *) ba;
+	if (*(ptr - 1) == ':' || i == 1) {
+		bt_free(ba);
+		return NULL;
+	}
+
+	ba->b[parts] = strtol(ptr - 2, NULL, 16);
+	for (i = parts + 1 ; i < 6 ; i++) {
+		ba->b[i] = 0;
+	}
+
+	return ba;
 }
 
 /* reverse bdaddr and do batostr */
-- 
1.7.0.4

