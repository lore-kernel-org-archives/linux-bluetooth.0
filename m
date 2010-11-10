Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Print LE link type on hcitool
Date: Wed, 10 Nov 2010 13:54:48 -0500
Message-Id: <1289415288-18470-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.h       |    1 +
 tools/hcitool.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 0cb120f..b51280b 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -205,6 +205,7 @@ enum {
 #define SCO_LINK	0x00
 #define ACL_LINK	0x01
 #define ESCO_LINK	0x02
+#define LE_LINK		0x03
 
 /* LMP features */
 #define LMP_3SLOT	0x01
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 1a53a38..570df10 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -72,6 +72,8 @@ static char *type2str(uint8_t type)
 		return "ACL";
 	case ESCO_LINK:
 		return "eSCO";
+	case LE_LINK:
+		return "LE";
 	default:
 		return "Unknown";
 	}
-- 
1.6.2.rc2

