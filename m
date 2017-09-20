Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 4/4] systemd: More lockdown
Date: Wed, 20 Sep 2017 13:48:19 +0200
Message-Id: <20170920114819.19929-4-hadess@hadess.net>
In-Reply-To: <20170920114819.19929-1-hadess@hadess.net>
References: <20170920114819.19929-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bluetoothd does not need to execute mapped memory, or real-time
access, so block those.
---
 src/bluetooth.service.in | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 7e55b5043..e8267b338 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -22,9 +22,15 @@ ProtectControlGroups=true
 ReadWritePaths=@statedir@
 ReadOnlyPaths=@confdir@
 
+# Execute Mappings
+MemoryDenyWriteExecute=true
+
 # Privilege escalation
 NoNewPrivileges=true
 
+# Real-time
+RestrictRealtime=true
+
 [Install]
 WantedBy=bluetooth.target
 Alias=dbus-org.bluez.service
-- 
2.14.1

