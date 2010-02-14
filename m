Return-Path: <cyrus@holtmann.org>
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Stefan Seyfried <seife@sphairon.com>
Subject: [PATCH 1/2] Fix compilation with bluez 4.61's changed hci.h
Date: Sun, 14 Feb 2010 12:33:31 +0100
Message-Id: <1266147212-32461-2-git-send-email-stefan.seyfried@googlemail.com>
In-Reply-To: <1266147212-32461-1-git-send-email-stefan.seyfried@googlemail.com>
References: <1266147212-32461-1-git-send-email-stefan.seyfried@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Stefan Seyfried <seife@sphairon.com>

---
 parser/hci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index f1507fc..e4fc473 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -1973,7 +1973,7 @@ static inline void read_ext_inquiry_response_dump(int level, struct frame *frm)
 
 static inline void read_inquiry_transmit_power_level_dump(int level, struct frame *frm)
 {
-	read_inquiry_transmit_power_level_rp *rp = frm->ptr;
+	read_inq_response_tx_power_level_rp *rp = frm->ptr;
 
 	p_indent(level, frm);
 	printf("status 0x%2.2x level %d\n", rp->status, rp->level);
@@ -2325,7 +2325,7 @@ static inline void cmd_complete_dump(int level, struct frame *frm)
 		case OCF_READ_EXT_INQUIRY_RESPONSE:
 			read_ext_inquiry_response_dump(level, frm);
 			return;
-		case OCF_READ_INQUIRY_TRANSMIT_POWER_LEVEL:
+		case OCF_READ_INQ_RESPONSE_TX_POWER_LEVEL:
 			read_inquiry_transmit_power_level_dump(level, frm);
 			return;
 		case OCF_READ_DEFAULT_ERROR_DATA_REPORTING:
-- 
1.6.6.1
