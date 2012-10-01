Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] mgmt-api: Add missing error code descriptions
Date: Mon, 1 Oct 2012 09:49:22 +0200
Message-ID: <1349077763-26830-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 3d0b875..202c055 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -54,6 +54,8 @@ and Command Complete events:
 0x0D	Invalid Parameters
 0x0E	Disconnected
 0x0F	Not Powered
+0x10	Cancelled
+0x11	Invalid Index
 
 
 Read Management Version Information Command
-- 
1.7.9.5

