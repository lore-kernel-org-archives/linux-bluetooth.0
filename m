Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Fix small typo
Date: Tue,  8 Feb 2011 17:37:57 -0200
Message-Id: <1297193877-26625-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/health-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/health-api.txt b/doc/health-api.txt
index a0a1685..3d0a717 100644
--- a/doc/health-api.txt
+++ b/doc/health-api.txt
@@ -18,7 +18,7 @@ Methods:
 
 		Returns the path of the new registered application.
 
-		Dict is defined as bellow:
+		Dict is defined as below:
 		{
 			"DataType": uint16, (mandatory)
 			"Role" : ("Source" or "Sink"), (mandatory)
-- 
1.7.1

