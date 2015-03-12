Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] hcidump: fix crash for LE meta event
Date: Thu, 12 Mar 2015 17:13:49 +0900
Message-id: <1426148029-11908-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

This patch fixes the crash when hcidump gets BT 4.1 meta event.
---
 tools/parser/hci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 33df542..0918eee 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -127,7 +127,7 @@ static char *event_str[EVENT_NUM + 1] = {
 	"AMP Status Change",
 };
 
-#define LE_EV_NUM 5
+#define LE_EV_NUM 11
 static char *ev_le_meta_str[LE_EV_NUM + 1] = {
 	"Unknown",
 	"LE Connection Complete",
@@ -135,6 +135,12 @@ static char *ev_le_meta_str[LE_EV_NUM + 1] = {
 	"LE Connection Update Complete",
 	"LE Read Remote Used Features Complete",
 	"LE Long Term Key Request",
+	"LE Remote Connection Parameter Request",
+	"LE Data Length Change",
+	"LE Read Local P-256 Public Key Complete",
+	"LE Generate DHKey Complete",
+	"LE Enhanced Connection Complete",
+	"LE Direct Advertising Report",
 };
 
 #define CMD_LINKCTL_NUM 60
@@ -3667,7 +3673,11 @@ static inline void le_meta_ev_dump(int level, struct frame *frm)
 	frm->len -= EVT_LE_META_EVENT_SIZE;
 
 	p_indent(level, frm);
-	printf("%s\n", ev_le_meta_str[subevent]);
+
+	if (subevent <= LE_EV_NUM)
+		printf("%s\n", ev_le_meta_str[subevent]);
+	else
+		printf("%s\n", ev_le_meta_str[0]);
 
 	switch (mevt->subevent) {
 	case EVT_LE_CONN_COMPLETE:
-- 
2.1.0

