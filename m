Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Andr=C3=A9=20Dieb=20Martins?= <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Dieb=20Martins?= <andre.dieb@signove.com>
Subject: [PATCH 1/2] Fix time intervals dumping of LE commands.
Date: Mon, 24 Jan 2011 16:32:38 -0300
Message-Id: <1295897559-5540-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add missing btohs() convertions and spec. constants for converting time
intervals for LE Set Scan Parameters and LE Set Advertising Parameters.
---
 parser/hci.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index d9bac9b..41a19b4 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -1582,7 +1582,8 @@ static inline void le_set_advertising_parameters_dump(int level, struct frame *f
 	le_set_advertising_parameters_cp *cp = frm->ptr;
 
 	p_indent(level, frm);
-	printf("min 0x%04xms max 0x%04xms\n", cp->min_interval, cp->max_interval);
+	printf("min %.3fms, max %.3fms\n", btohs(cp->min_interval) * 0.625,
+			btohs(cp->max_interval) * 0.625);
 
 	p_indent(level, frm);
 	printf("type 0x%02x (%s) ownbdaddr 0x%02x (%s)\n", cp->advtype,
@@ -1608,7 +1609,8 @@ static inline void le_set_scan_parameters_dump(int level, struct frame *frm)
 		cp->type == 0x00 ? "passive" : "active");
 
 	p_indent(level, frm);
-	printf("interval %04xms window %04xms\n", cp->interval, cp->window);
+	printf("interval %.3fms window %.3fms\n", btohs(cp->interval) * 0.625,
+		btohs(cp->window) * 0.625);
 
 	p_indent(level, frm);
 	printf("own address: 0x%02x (%s) policy: %s\n", cp->own_bdaddr_type,
-- 
1.7.1

