Return-Path: <cyrus@holtmann.org>
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>
Subject: [PATCH] Print pkt_type when decoding Setup Synchronous Connection command.
Date: Tue,  9 Feb 2010 17:07:29 -0800
Message-Id: <1265764049-2709-1-git-send-email-npelly@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/parser/hci.c b/parser/hci.c
index c0ca27e..958cd38 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -917,8 +917,9 @@ static inline void setup_sync_conn_dump(int level, struct frame *frm)
 	setup_sync_conn_cp *cp = frm->ptr;
 
 	p_indent(level, frm);
-	printf("handle %d voice setting 0x%4.4x\n", btohs(cp->handle),
-						btohs(cp->voice_setting));
+	printf("handle %d voice setting 0x%4.4x pkt_type 0x%4.4x\n",
+		btohs(cp->handle), btohs(cp->voice_setting),
+		btohs(cp->pkt_type));
 }
 
 static inline void hold_mode_dump(int level, struct frame *frm)
-- 
1.6.5.3

