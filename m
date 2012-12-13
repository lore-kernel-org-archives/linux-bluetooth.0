Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] mgmt-api: Remove not needed restriction on add/remove OOB data
Date: Thu, 13 Dec 2012 15:10:52 +0100
Message-ID: <1355407852-22047-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those commands don't send any HCI commands to controller so there is no
need to restrict them to only powered up controller. This also clarify
that provided OOB data is persistent over power down/up toggles.
---
 doc/mgmt-api.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 202c055..60f4da4 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -701,7 +701,7 @@ Add Remote Out Of Band Data Command
 	Return Parameters:	Address (6 Octets)
 				Address_Type (1 Octet)
 
-	This command can only be used when the controller is powered.
+	Provided Out Of Band data is persistent over power down/up toggles.
 
 	This command generates a Command Complete event on success
 	or failure.
@@ -717,8 +717,6 @@ Remove Remote Out Of Band Data Command
 	Return Parameters:	Address (6 Octets)
 				Address_Type (1 Octet)
 
-	This command can only be used when the controller is powered.
-
 	This command generates a Command Complete event on success
 	or failure.
 
-- 
1.8.0

