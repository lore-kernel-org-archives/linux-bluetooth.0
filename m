Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] gatt: Fix wrong function exit
Date: Tue, 28 Oct 2014 17:20:01 +0200
Message-Id: <1414509602-2534-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 src/shared/gatt-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index d751d5a..4f53de3 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1029,7 +1029,7 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 		data = new_read_included(cur_result);
 		if (!data) {
 			success = false;
-			goto done;
+			goto failed;
 		}
 
 		read_included(data);
-- 
1.9.1

