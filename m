Return-Path: <cyrus@holtmann.org>
From: William Douglas <william.douglas@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Correct the dbus service file's systemd unit name for bluez.
Date: Wed, 13 Feb 2013 10:57:01 -0800
Message-ID: <87ehgkxcsi.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Even though dbus-org.bluez.service is set as an alias for the
bluetooth.service systemd unit file, systemd will not be able to load
the bluetooth daemon without the daemon being enabled (and the
dbus-org.bluez.service file linked to bluetooth.service). This patch
allows the daemon to be loaded by other services on demand.

Signed-off-by: William Douglas <william.douglas@intel.com>
---
 src/org.bluez.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/org.bluez.service b/src/org.bluez.service
index dd7ae8f..2a3b057 100644
--- a/src/org.bluez.service
+++ b/src/org.bluez.service
@@ -2,4 +2,4 @@
 Name=org.bluez
 Exec=/bin/false
 User=root
-SystemdService=dbus-org.bluez.service
+SystemdService=bluetooth.service
-- 
1.8.1.2

-- 
William Douglas, Intel Open Source Technology Center
