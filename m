Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 5/5] Fix handle formatting for ATT Handle Notify
Date: Wed, 23 Mar 2011 11:46:41 -0300
Message-Id: <1300891601-11412-5-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1300891601-11412-1-git-send-email-andre.dieb@signove.com>
References: <1300891601-11412-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 4141f99..5e589c4 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -512,7 +512,7 @@ static inline void att_handle_notify_dump(int level, struct frame *frm)
 	uint16_t handle = btohs(htons(get_u16(frm)));
 
 	p_indent(level, frm);
-	printf("handle 0x%2.2x\n", handle);
+	printf("handle 0x%4.4x\n", handle);
 
 	p_indent(level, frm);
 	printf("value ");
-- 
1.7.1

