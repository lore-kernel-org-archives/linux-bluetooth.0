Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 02/16] doc: Add missing documentation in FindAdapter
Date: Thu, 15 Nov 2012 16:09:05 +0100
Message-Id: <1352992159-11559-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The method supports the string "any" to return the any adapter object,
so update the documentation accordingly.
---
 doc/manager-api.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index 3add587..8497141 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -24,7 +24,9 @@ Object path	/
 		object FindAdapter(string pattern)
 
 			Returns object path for the specified adapter. Valid
-			patterns are "hci0" or "00:11:22:33:44:55".
+			patterns are "hci0" or "00:11:22:33:44:55". Other
+			supported values are:
+				"any"
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NoSuchAdapter
-- 
1.7.11.7

