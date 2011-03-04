Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] Make strtoba use str2ba for string conversion
Date: Fri, 4 Mar 2011 19:34:05 +0100
Message-ID: <1299263645-25329-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1299263645-25329-1-git-send-email-szymon.janc@tieto.com>
References: <1299263645-25329-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index d943fdc..aac9bdc 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -63,21 +63,15 @@ char *batostr(const bdaddr_t *ba)
 
 bdaddr_t *strtoba(const char *str)
 {
-	const char *ptr = str;
-	int i;
-
-	uint8_t *ba = bt_malloc(sizeof(bdaddr_t));
-	if (!ba)
-		return NULL;
+	bdaddr_t b;
+	bdaddr_t *ba = bt_malloc(sizeof(*ba));
 
-	for (i = 0; i < 6; i++) {
-		ba[i] = (uint8_t) strtol(ptr, NULL, 16);
-		if (i != 5 && !(ptr = strchr(ptr,':')))
-			ptr = ":00:00:00:00:00";
-		ptr++;
+	if (ba) {
+		str2ba(str, &b);
+		baswap(ba, &b);
 	}
 
-	return (bdaddr_t *) ba;
+	return ba;
 }
 
 int ba2str(const bdaddr_t *ba, char *str)
-- 
1.7.0.4

