Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] shared/gatt-helpers: Fix reporting discovery failure
Date: Tue, 22 Sep 2015 20:09:10 +0200
Message-Id: <1442945350-24346-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If sending ATT request failed discovery should be reported as failed.
Due to missing goto success was overwritten with true value.
This regression was introduced in db24bf09d66325a.
---
 src/shared/gatt-helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index c773df7..008b8bc 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1490,6 +1490,7 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 			return;
 
 		success = false;
+		goto done;
 	}
 
 	success = true;
-- 
2.5.0

