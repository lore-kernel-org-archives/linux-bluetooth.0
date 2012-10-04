Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] mgmt: Add string for Passkey Notify Event
Date: Thu, 04 Oct 2012 22:14:07 +0900
Message-id: <1349356447-8369-4-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1349356447-8369-1-git-send-email-chanyeol.park@samsung.com>
References: <1349356447-8369-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 lib/mgmt.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 3432f94..6c7e44a 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -522,6 +522,7 @@ static const char *mgmt_ev[] = {
 	"Device Blocked",
 	"Device Unblocked",
 	"Device Unpaired",
+	"Passkey Notify",
 };
 
 static const char *mgmt_status[] = {
-- 
1.7.9.5

