Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add support for OBEX Action command
Date: Mon, 13 Jun 2011 16:46:46 +0300
Message-Id: <1307972806-12723-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for parsing OBEX Action command and related headers.
---
 parser/obex.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/parser/obex.c b/parser/obex.c
index 1767efd..ede6748 100644
--- a/parser/obex.c
+++ b/parser/obex.c
@@ -52,7 +52,7 @@ static char *opcode2str(uint8_t opcode)
 	case 0x05:
 		return "SetPath";
 	case 0x06:
-		return "Reserved";
+		return "Action";
 	case 0x07:
 		return "Session";
 	case 0x7f:
@@ -181,6 +181,12 @@ static char *hi2str(uint8_t hi)
 		return "Session Parameters";
 	case 0x13:
 		return "Session Sequence Number";
+	case 0x14:
+		return "Action ID";
+	case 0x15:
+		return "DestName";
+	case 0x16:
+		return "Permission";
 	default:
 		return "Unknown";
 	}
-- 
1.7.5.4

