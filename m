Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH] Add new S-frame types to l2cap parser
Date: Tue,  5 Jan 2010 19:18:37 -0200
Message-Id: <1262726317-13822-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/l2cap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 799d4b7..ad3b7ff 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -352,8 +352,9 @@ static char *supervisory2str(uint8_t supervisory)
 	case 0x01:
 		return "Reject (REJ)";
 	case 0x02:
+		return "Receiver Not Ready (RNR)";
 	case 0x03:
-		return "Reserved Supervisory";
+		return "Select Reject (SREJ)";
 	default:
 		return "Bad Supervisory";
 	}
-- 
1.6.4.4
