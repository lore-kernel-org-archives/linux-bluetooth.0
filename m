Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] doc: Update Remote OOB Management commands description
Date: Tue, 18 Nov 2014 17:32:48 +0100
Message-Id: <1416328370-19305-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those commands accept only BR/EDR type of device.
---
 doc/mgmt-api.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 6374b61..91cd0ab 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1254,8 +1254,8 @@ Add Remote Out Of Band Data Command
 
 	Possible values for the Address_Type parameter:
 		0	BR/EDR
-		1	LE Public
-		2	LE Random
+		1	Reserved (not in use)
+		2	Reserved (not in use)
 
 	Provided Out Of Band data is persistent over power down/up toggles.
 
@@ -1299,8 +1299,8 @@ Remove Remote Out Of Band Data Command
 
 	Possible values for the Address_Type parameter:
 		0	BR/EDR
-		1	LE Public
-		2	LE Random
+		1	Reserved (not in use)
+		2	Reserved (not in use)
 
 	When the Address parameter is 00:00:00:00:00:00, then all
 	previously added data will be removed.
-- 
1.9.1

