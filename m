Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 2/4] Two merges very similar functions in bluetooth.c
Date: Mon, 27 Dec 2010 12:02:23 +0100
Message-ID: <1293447745-8697-2-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
References: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

in lib/bluetooth.c merge "str2ba" and "strtoba", "ba2str" and "batostr"
---
 lib/bluetooth.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index 4af2ef6..3a4e3f4 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -55,8 +55,7 @@ char *batostr(const bdaddr_t *ba)
 		return NULL;
 
 	sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-		ba->b[0], ba->b[1], ba->b[2],
-		ba->b[3], ba->b[4], ba->b[5]);
+		ba->b[0], ba->b[1], ba->b[2], ba->b[3], ba->b[4], ba->b[5]);
 
 	return str;
 }
@@ -80,29 +79,30 @@ bdaddr_t *strtoba(const char *str)
 	return (bdaddr_t *) ba;
 }
 
+/* reverse bdaddr and do batostr */
 int ba2str(const bdaddr_t *ba, char *str)
 {
-	uint8_t b[6];
-
-	baswap((bdaddr_t *) b, ba);
-	return sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-		b[0], b[1], b[2], b[3], b[4], b[5]);
+	bdaddr_t b;
+	char *bastr;
+
+	baswap(&b, ba);
+	bastr = batostr(&b);
+	strcpy(str, bastr);
+	bt_free(bastr);
+	return *str && 1;
 }
 
+/*  do strtoba and return reverse bdaddr */
 int str2ba(const char *str, bdaddr_t *ba)
 {
-	uint8_t b[6];
-	const char *ptr = str;
+	bdaddr_t *b;
 	int i;
 
-	for (i = 0; i < 6; i++) {
-		b[i] = (uint8_t) strtol(ptr, NULL, 16);
-		if (i != 5 && !(ptr = strchr(ptr, ':')))
-			ptr = ":00:00:00:00:00";
-		ptr++;
-	}
-
-	baswap(ba, (bdaddr_t *) b);
+	b = strtoba(str);
+	if (b == NULL)
+		return 0;
+	baswap(ba, b);
+	bt_free(b);
 
 	return 0;
 }
-- 
1.7.0.4

