Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc: fix typos
Date: Mon, 25 Sep 2017 17:53:52 +0200
Message-Id: <20170925155352.21203-1-tduszyns@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

s/parser/parsed
s/prevously/previously
---
 doc/advertising-api.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 36fe130d9..7cc183043 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -107,7 +107,7 @@ Methods		RegisterAdvertisement(object advertisement, dict options)
 			InvalidLength error indicates that the data
 			provided generates a data packet which is too long.
 
-			The properties of this object are parser when it is
+			The properties of this object are parsed when it is
 			registered, and any changes are ignored.
 
 			If the same object is registered twice it will result in
@@ -124,7 +124,7 @@ Methods		RegisterAdvertisement(object advertisement, dict options)
 		UnregisterAdvertisement(object advertisement)
 
 			This unregisters an advertisement that has been
-			prevously registered.  The object path parameter must
+			previously registered.  The object path parameter must
 			match the same value that has been used on registration.
 
 			Possible errors: org.bluez.Error.InvalidArguments
-- 
2.14.1

