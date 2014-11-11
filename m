Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ] shared/att: bugfix for BT_ATT_ALL_REQUESTS
Date: Mon, 10 Nov 2014 16:10:56 -0800
Message-Id: <1415664656-36676-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

opcode can now be zero, since that is BT_ATT_ALL_REQUESTS

---
 src/shared/att.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index aa80cef..48c36ac 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1115,7 +1115,7 @@ unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
 {
 	struct att_notify *notify;
 
-	if (!att || !opcode || !callback || !att->io)
+	if (!att || !callback || !att->io)
 		return 0;
 
 	notify = new0(struct att_notify, 1);
-- 
2.1.0.rc2.206.gedb03e5

