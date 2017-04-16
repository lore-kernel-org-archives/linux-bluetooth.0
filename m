Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jakub Wilk <jwilk@jwilk.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] test: Fix misuse of flags in re.sub() call
Date: Sun, 16 Apr 2017 14:38:55 +0200
Message-Id: <20170416123855.4179-1-jwilk@jwilk.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The 4th argument of re.sub() is maximum number of substitutions,
not flags.

The string doesn't contain any newlines, only hex digits, so the
re.DOTALL flag wouldn't have any effect. Let's remove it.
---
 test/sap_client.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/sap_client.py b/test/sap_client.py
index 413424c05..ba4f6f544 100644
--- a/test/sap_client.py
+++ b/test/sap_client.py
@@ -311,7 +311,7 @@ class SAPMessage:
 
     def getContent(self):
         s = "%s(id=0x%.2X) " % (self.name,  self.id)
-        if len( self.buf): s = s + "[%s]" % re.sub("(.{2})", "0x\\1 " , self.buf.tostring().encode("hex").upper(), re.DOTALL)
+        if len( self.buf): s = s + "[%s]" % re.sub("(.{2})", "0x\\1 " , self.buf.tostring().encode("hex").upper())
         s = s + "\n\t"
         for p in self.params:
             s = s + "\t" + p.getContent()
-- 
2.11.0

