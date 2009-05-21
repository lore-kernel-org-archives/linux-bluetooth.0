Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Add case for Enhanced Retransmission and Streaming modes
Date: Thu, 21 May 2009 02:06:01 -0300
Message-Id: <1242882363-410-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just add return values on mode2str for the new modes on L2CAP
---
 parser/l2cap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index a906f42..4ab4123 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -306,6 +306,10 @@ static char *mode2str(uint8_t mode)
 		return "Retransmission";
 	case 0x02:
 		return "Flow control";
+	case 0x03:
+		return "Enhanced Retransmission";
+	case 0x04:
+		return "Streaming";
 	default:
 		return "Reserved";
 	}
-- 
1.6.0.6

