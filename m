Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] systemd: Enable ProtectHome and ProtectSystem options
Date: Fri,  8 Apr 2016 15:18:48 +0300
Message-Id: <1460117928-9998-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These options protect from unintended access to the filesystem see
SYSTEMD.EXEC(5) for mode detail.
---
 src/bluetooth.service.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 83e4732..f799f65 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -12,6 +12,8 @@ NotifyAccess=main
 #Restart=on-failure
 CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
 LimitNPROC=1
+ProtectHome=true
+ProtectSystem=full
 
 [Install]
 WantedBy=bluetooth.target
-- 
2.5.0

