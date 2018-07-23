Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH BlueZ] tools: Fix btmon-logger service unit
Date: Mon, 23 Jul 2018 22:31:58 +0200
Message-Id: <20180723203158.12264-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth sockets can be only created in initial network namespace thus
btmon-logger will fail to open monitor socket with PrivateNetwork=true
since this sets up new network namespace for created process.
---
 tools/bluetooth-logger.service.in | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/bluetooth-logger.service.in b/tools/bluetooth-logger.service.in
index 210bf59ac..026a2f130 100644
--- a/tools/bluetooth-logger.service.in
+++ b/tools/bluetooth-logger.service.in
@@ -12,7 +12,6 @@ ProtectHome=true
 ProtectSystem=full
 PrivateTmp=true
 PrivateDevices=true
-PrivateNetwork=true
 
 [Install]
 WantedBy=bluetooth.target
-- 
2.18.0

