Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.dieb@signove.com
Subject: [PATCH v2 4/6] Fix handle formatting for ATT Handle Notify
Date: Wed, 30 Mar 2011 11:01:32 -0300
Message-Id: <1301493694-10957-4-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1301493694-10957-1-git-send-email-andre.dieb@signove.com>
References: <1301493694-10957-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 5bff925..a1cd9af 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -512,7 +512,7 @@ static void att_handle_notify_dump(int level, struct frame *frm)
 	uint16_t handle = btohs(htons(get_u16(frm)));
 
 	p_indent(level, frm);
-	printf("handle 0x%2.2x\n", handle);
+	printf("handle 0x%4.4x\n", handle);
 
 	p_indent(level, frm);
 	printf("value ");
-- 
1.7.1

