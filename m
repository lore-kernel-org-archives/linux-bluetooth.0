Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] doc/mgmt-api: Add Authentication Failure code to Disconnected event
Date: Fri, 24 Jun 2016 11:59:16 +0200
Message-Id: <1466762356-4171-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This error code will be set if authentication (enabling encryption)
failed with 'PIN or Key Missing' error. This will allow userspace
to take actions (eg ask user for consent for rebonding) when remote
device lost bond.
---
 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 8393bbf..9384f70 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3061,6 +3061,7 @@ Device Disconnected Event
 		1	Connection timeout
 		2	Connection terminated by local host
 		3	Connection terminated by remote host
+		4	Connection terminated due to authentication failure
 
 	Note that the local/remote distinction just determines which side
 	terminated the low-level connection, regardless of the
-- 
2.7.4

On behalf of SCHILLER Medical SAS.
