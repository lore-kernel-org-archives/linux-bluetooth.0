Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH] control: Remove duplicated documentation entry
Date: Thu, 29 Nov 2012 10:38:55 -0300
Message-Id: <1354196335-3366-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/control-api.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/doc/control-api.txt b/doc/control-api.txt
index a16ee7d..e0ed04a 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -32,10 +32,6 @@ Methods		void Play()
 
 			Previous item.
 
-		void VolumeDown()
-
-			Adjust remote volume one step down
-
 		void VolumeUp()
 
 			Adjust remote volume one step up
-- 
1.7.11.7

