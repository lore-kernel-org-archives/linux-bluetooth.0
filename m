Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 5/5] rfcomm: Remove bogus manual entry
Date: Fri, 31 May 2013 00:01:57 +0200
Message-Id: <1369951317-16789-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1369951317-16789-1-git-send-email-szymon.janc@gmail.com>
References: <1369951317-16789-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This was introduced in commit b1b5f09d40 "Include security parameters"
back in 2007. Those options are already descibed few lines below.
---
 tools/rfcomm.1 |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/tools/rfcomm.1 b/tools/rfcomm.1
index 51df284..a108609 100644
--- a/tools/rfcomm.1
+++ b/tools/rfcomm.1
@@ -49,20 +49,9 @@ Prints information about all configured RFCOMM devices.
 Switch TTY into raw mode (doesn't work with "bind").
 .TP
 .BI -i " <hciX> | <bdaddr>"
-The command is applied to device
-.BI -A
-Enable authentication.
-.BI -E
-Enable encryption.
-.BI -S
-Secure connection.
-.BI -M
-Become the master of a piconet.
-.I
-hciX
-, which must be the name or the address of an installed Bluetooth
-device. If not specified, the command will be use the first
-available Bluetooth device.
+The command is applied to device hciX, which must be the name or the address of
+an installed Bluetooth device. If not specified, the command will be use the
+first available Bluetooth device.
 .TP
 .BI -A
 Enable authentification
-- 
1.7.10.4

