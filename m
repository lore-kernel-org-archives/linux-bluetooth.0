Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] gitignore: Add test/bluezutils.pyc
Date: Fri, 7 Dec 2012 10:42:41 +0100
Message-ID: <1354873361-13940-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Python generates compiled module file when py module is used.
---
 .gitignore |    1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index a30d4a4..976c171 100644
--- a/.gitignore
+++ b/.gitignore
@@ -71,6 +71,7 @@ test/test-textfile
 test/uuidtest
 test/mpris-player
 test/sap_client.pyc
+test/bluezutils.pyc
 unit/test-eir
 tools/btattach
 tools/btmgmt
-- 
1.7.9.5

