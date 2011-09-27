Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 1/2] Remove magic numbers in l2cap decoding
Date: Tue, 27 Sep 2011 14:30:55 +0300
Message-Id: <1317123056-14235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 parser/l2cap.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 8d05314..d3d3b1c 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -346,13 +346,13 @@ static char *fcs2str(uint8_t fcs)
 static char *sar2str(uint8_t sar)
 {
 	switch (sar) {
-	case 0x00:
+	case L2CAP_SAR_UNSEGMENTED:
 		return "Unsegmented";
-	case 0x01:
+	case L2CAP_SAR_START:
 		return "Start";
-	case 0x02:
+	case L2CAP_SAR_END:
 		return "End";
-	case 0x03:
+	case L2CAP_SAR_CONTINUE:
 		return "Continuation";
 	default:
 		return "Bad SAR";
@@ -363,13 +363,13 @@ static char *sar2str(uint8_t sar)
 static char *supervisory2str(uint8_t supervisory)
 {
 	switch (supervisory) {
-	case 0x00:
+	case L2CAP_SUPER_RR:
 		return "Receiver Ready (RR)";
-	case 0x01:
+	case L2CAP_SUPER_REJ:
 		return "Reject (REJ)";
-	case 0x02:
+	case L2CAP_SUPER_RNR:
 		return "Receiver Not Ready (RNR)";
-	case 0x03:
+	case L2CAP_SUPER_SREJ:
 		return "Select Reject (SREJ)";
 	default:
 		return "Bad Supervisory";
-- 
1.7.4.1

