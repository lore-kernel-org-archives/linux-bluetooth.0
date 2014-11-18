Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] doc: Remove invalid error from Add/Remove Remote OOB Data commands
Date: Tue, 18 Nov 2014 17:32:49 +0100
Message-Id: <1416328370-19305-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1416328370-19305-1-git-send-email-szymon.janc@tieto.com>
References: <1416328370-19305-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those commands are allowed to be executed when controller is not
powered.
---
 doc/mgmt-api.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 91cd0ab..32cb281 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1280,7 +1280,6 @@ Add Remote Out Of Band Data Command
 
 	Possible errors:	Failed
 				Invalid Parameters
-				Not Powered
 				Invalid Index
 
 
@@ -1312,7 +1311,6 @@ Remove Remote Out Of Band Data Command
 	or failure.
 
 	Possible errors:	Invalid Parameters
-				Not Powered
 				Invalid Index
 
 
-- 
1.9.1

