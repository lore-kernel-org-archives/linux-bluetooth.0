Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] hcidump: Correct len name
Date: Mon,  7 May 2012 16:49:26 +0300
Message-Id: <1336398567-27842-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 parser/hci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parser/hci.c b/parser/hci.c
index e459e9e..984b554 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -2602,7 +2602,7 @@ static inline void read_local_amp_assoc_dump(int level, struct frame *frm)
 	int i;
 
 	p_indent(level, frm);
-	printf("status 0x%2.2x handle 0x%2.2x length %d\n",
+	printf("status 0x%2.2x handle 0x%2.2x remaining len %d\n",
 			rp->status, rp->handle, len);
 	if (rp->status > 0) {
 		p_indent(level, frm);
-- 
1.7.9.5

