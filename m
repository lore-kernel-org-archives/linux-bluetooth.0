Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc: fix typo
Date: Fri, 22 Sep 2017 17:56:19 +0200
Message-Id: <20170922155619.13256-1-tduszyns@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

s/prevously/previously
---
 doc/advertising-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 36fe130d9..5fc012f06 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -124,7 +124,7 @@ Methods		RegisterAdvertisement(object advertisement, dict options)
 		UnregisterAdvertisement(object advertisement)
 
 			This unregisters an advertisement that has been
-			prevously registered.  The object path parameter must
+			previously registered.  The object path parameter must
 			match the same value that has been used on registration.
 
 			Possible errors: org.bluez.Error.InvalidArguments
-- 
2.14.1

