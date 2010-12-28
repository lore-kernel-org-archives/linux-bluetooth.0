Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 2/4] Refactoring common code in bluetooth.c
Date: Tue, 28 Dec 2010 10:17:48 +0100
Message-ID: <1293527868-12617-1-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <AANLkTi==TysBDUUXrDYy4bizr+3Nz20nn2fyc_g2g__U@mail.gmail.com>
References: <AANLkTi==TysBDUUXrDYy4bizr+3Nz20nn2fyc_g2g__U@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

in lib/bluetooth.c make "str2ba" using "strtoba", "ba2str" using "batostr"
add comments describe differences between these functions
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

