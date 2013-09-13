Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/8] gitignore: Add tools/btinfo
Date: Fri, 13 Sep 2013 13:30:45 +0200
Message-ID: <1379071852-10094-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index d1c31f4..8a25a3e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -62,6 +62,7 @@ tools/mpris-player
 tools/bluetooth-player
 tools/l2cap-tester
 tools/sco-tester
+tools/btinfo
 test/sap_client.pyc
 test/bluezutils.pyc
 unit/test-eir
-- 
1.8.4

