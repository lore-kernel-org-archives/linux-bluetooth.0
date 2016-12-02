Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: linux-bluetooth@vger.kernel.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH Bluez] main.conf: Fix adaper/adapter typo
Date: Fri,  2 Dec 2016 17:53:46 +0900
Message-Id: <20161202085346.28378-1-iwamatsu@nigauri.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/main.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.conf b/src/main.conf
index d9cd9e0..35698ca 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -1,6 +1,6 @@
 [General]
 
-# Default adaper name
+# Default adapter name
 # Defaults to 'BlueZ X.YZ'
 #Name = BlueZ
 
-- 
2.10.1

