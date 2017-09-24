Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc: fix typo
Date: Sun, 24 Sep 2017 14:28:14 +0200
Message-Id: <20170924122814.29703-1-tduszyns@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

s/parser/parsed
---
 doc/advertising-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 36fe130d9..e432fb074 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -107,7 +107,7 @@ Methods		RegisterAdvertisement(object advertisement, dict options)
 			InvalidLength error indicates that the data
 			provided generates a data packet which is too long.
 
-			The properties of this object are parser when it is
+			The properties of this object are parsed when it is
 			registered, and any changes are ignored.
 
 			If the same object is registered twice it will result in
-- 
2.14.1

