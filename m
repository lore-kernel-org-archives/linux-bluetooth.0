Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Craig Andrews <candrews@integralblue.com>
Subject: [PATCH 2/4] systemd: Add PrivateTmp and NoNewPrivileges options
Date: Wed, 20 Sep 2017 13:48:17 +0200
Message-Id: <20170920114819.19929-2-hadess@hadess.net>
In-Reply-To: <20170920114819.19929-1-hadess@hadess.net>
References: <20170920114819.19929-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Craig Andrews <candrews@integralblue.com>

PrivateTmp makes bluetoothd's /tmp and /var/tmp be inside a different
namespace. This is useful to secure access to temporary files of the
process.

NoNewPrivileges ensures that service process and all its children
can never gain new privileges through execve(), lowering the risk of
possible privilege escalations.
---
 src/bluetooth.service.in | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index f799f65f0..a6f3030f9 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -12,8 +12,14 @@ NotifyAccess=main
 #Restart=on-failure
 CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
 LimitNPROC=1
+
+# Filesystem lockdown
 ProtectHome=true
 ProtectSystem=full
+PrivateTmp=true
+
+# Privilege escalation
+NoNewPrivileges=true
 
 [Install]
 WantedBy=bluetooth.target
-- 
2.14.1

