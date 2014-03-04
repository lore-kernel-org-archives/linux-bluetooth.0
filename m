Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] AVCTP: Fix sending wrong response format
Date: Tue,  4 Mar 2014 15:08:17 +0200
Message-Id: <1393938497-4522-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Reject and Not Implemented responses of PASS THROUGH commands shall
contain the data of the previous frame accourding to AVC Panel Subunit
specification page 87.
---
 android/avctp.c        | 4 ++--
 profiles/audio/avctp.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index abf9449..9232cfa 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -322,7 +322,7 @@ static ssize_t handle_panel_passthrough(struct avctp *session,
 
 	if (*code != AVC_CTYPE_CONTROL || *subunit != AVC_SUBUNIT_PANEL) {
 		*code = AVC_CTYPE_REJECTED;
-		return 0;
+		return operand_count;
 	}
 
 	if (operand_count == 0)
@@ -394,7 +394,7 @@ static ssize_t handle_panel_passthrough(struct avctp *session,
 		DBG("AV/C: unknown button 0x%02X %s",
 						operands[0] & 0x7F, status);
 		*code = AVC_CTYPE_NOT_IMPLEMENTED;
-		return 0;
+		return operand_count;
 	}
 
 done:
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 28c7685..f88e634 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -342,7 +342,7 @@ static size_t handle_panel_passthrough(struct avctp *session,
 
 	if (*code != AVC_CTYPE_CONTROL || *subunit != AVC_SUBUNIT_PANEL) {
 		*code = AVC_CTYPE_REJECTED;
-		return 0;
+		return operand_count;
 	}
 
 	if (operand_count == 0)
@@ -408,7 +408,7 @@ static size_t handle_panel_passthrough(struct avctp *session,
 		DBG("AV/C: unknown button 0x%02X %s",
 						operands[0] & 0x7F, status);
 		*code = AVC_CTYPE_NOT_IMPLEMENTED;
-		return 0;
+		return operand_count;
 	}
 
 done:
-- 
1.8.5.3

