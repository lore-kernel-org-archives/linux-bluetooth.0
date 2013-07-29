Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/5] scanparam: Fix handle range check on descriptor discovery
Date: Mon, 29 Jul 2013 09:59:28 -0400
Message-Id: <1375106372-2255-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When discovering descriptors, if there is only a single descriptor, the
start handle will be equal to the end handle. It is valid to issue the
Find Information Request on this case.

Before this fix, notification for Scan Refresh characteristic was never
enabled.
---
 profiles/scanparam/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index f5db5ed..0ad2e17 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -158,7 +158,7 @@ static void refresh_discovered_cb(GSList *chars, guint8 status,
 	start = chr->value_handle + 1;
 	end = scan->range.end;
 
-	if (start >= end)
+	if (start > end)
 		return;
 
 	scan->refresh_handle = chr->value_handle;
-- 
1.7.9.5

