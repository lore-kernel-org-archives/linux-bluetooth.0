Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH hcidump] Add support for parsing SRM headers
Date: Thu, 11 Aug 2011 00:15:49 +0530
Message-Id: <1313001949-29686-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/obex.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/parser/obex.c b/parser/obex.c
index ede6748..d745d89 100644
--- a/parser/obex.c
+++ b/parser/obex.c
@@ -187,6 +187,10 @@ static char *hi2str(uint8_t hi)
 		return "DestName";
 	case 0x16:
 		return "Permission";
+	case 0x17:
+		return "Single Response Mode";
+	case 0x18:
+		return "Single Response Mode Parameter";
 	default:
 		return "Unknown";
 	}
-- 
1.7.4.1

