Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH] Add new S-frame types to l2cap parser
Date: Tue, 30 Mar 2010 15:52:23 -0300
Message-Id: <1269975143-9951-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269972441-24242-1-git-send-email-jprvita@gmail.com>
References: <1269972441-24242-1-git-send-email-jprvita@gmail.com>
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
