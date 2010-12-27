Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 4/4] Better filtering input string contain bdaddr
Date: Mon, 27 Dec 2010 12:02:25 +0100
Message-ID: <1293447745-8697-4-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
References: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index 3a4e3f4..9333eeb 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -60,23 +60,64 @@ char *batostr(const bdaddr_t *ba)
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
+	unsigned int b;
+
+	length = strlen(str);
+	if (length <= 1 || length > 17)
+		goto err_bdaddr;
 
-	uint8_t *ba = bt_malloc(sizeof(bdaddr_t));
+	ba = bt_malloc(sizeof(bdaddr_t));
 	if (!ba)
 		return NULL;
 
-	for (i = 0; i < 6; i++) {
-		ba[i] = (uint8_t) strtol(ptr, NULL, 16);
-		if (i != 5 && !(ptr = strchr(ptr,':')))
-			ptr = ":00:00:00:00:00";
-		ptr++;
+	i = 0;
+	parts = 0;
+	while (*ptr) {
+		if (i == 2 && *ptr == ':') {
+			i = 0;
+			ba->b[parts] = strtol(ptr - 2, NULL, 16);
+			++parts;
+			++ptr;
+		}
+
+		if (((*ptr < 'A' || *ptr > 'F') &&
+			(*ptr < 'a' || *ptr > 'f') &&
+			(*ptr < '0' || *ptr > '9')) ||
+			( (ptr - str) == 2 && *ptr != ':')) {
+			bt_free(ba);
+			goto err_bdaddr;
+		}
+
+		++i;
+		++ptr;
 	}
 
-	return (bdaddr_t *) ba;
+	if (*(ptr - 1) == ':' || i == 1) {
+		bt_free(ba);
+		goto err_bdaddr;
+	}
+
+	ba->b[parts] = strtol(ptr - 2, NULL, 16);
+	for (i = parts + 1 ; i < 6 ; ++i) {
+		ba->b[i] = 0;
+	}
+
+	return ba;
+
+err_bdaddr:
+	fprintf(stderr, "Incorrect bdaddr format\n");
+	exit(1);
 }
 
 /* reverse bdaddr and do batostr */
-- 
1.7.0.4

