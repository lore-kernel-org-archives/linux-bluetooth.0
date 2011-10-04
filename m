Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix EIR parsing in evt_le_advertising_report_dump
Date: Tue,  4 Oct 2011 19:55:07 -0300
Message-Id: <1317768907-24106-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only the first EIR data structure from the LE advertising report
event is dumped. This patch fix this, so all EIR data structure
present in that event is dumped.
---
 parser/hci.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 610177b..698a301 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -3534,6 +3534,7 @@ static inline void evt_le_advertising_report_dump(int level, struct frame *frm)
 	while (num_reports--) {
 		char addr[18];
 		le_advertising_info *info = frm->ptr;
+		int offset = 0;
 
 		p_ba2str(&info->bdaddr, addr);
 
@@ -3544,9 +3545,12 @@ static inline void evt_le_advertising_report_dump(int level, struct frame *frm)
 		printf("bdaddr %s (%s)\n", addr,
 					bdaddrtype2str(info->bdaddr_type));
 
-		if (info->length > 0) {
-			ext_inquiry_data_dump(level, frm,
-					((uint8_t *) &info->length) + 1);
+		while (offset < info->length) {
+			int eir_data_len = info->data[offset];
+
+			ext_inquiry_data_dump(level, frm, &info->data[offset]);
+
+			offset += eir_data_len + 1;
 		}
 
 		frm->ptr += LE_ADVERTISING_INFO_SIZE + info->length;
-- 
1.7.5.2

