Return-Path: <cyrus@holtmann.org>
Message-ID: <54D08B3F.5080202@mozilla.com>
Date: Tue, 03 Feb 2015 09:47:59 +0100
From: Thomas Zimmermann <tzimmermann@mozilla.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Documentation: HAL IPC uses 4 octects for socket channel
Content-Type: multipart/mixed;
 boundary="------------060002000501010405080903"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060002000501010405080903
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

The documentations says that the HAL IPC uses 2 octets for socket
channels, while |struct hal_cmd_socket_{listen,connect}| contain 4
octets. This patch fixes the documentation accordingly.

--------------060002000501010405080903
Content-Type: text/x-patch;
 name="0001-Documentation-HAL-IPC-uses-4-octects-for-socket-chan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Documentation-HAL-IPC-uses-4-octects-for-socket-chan.pa";
 filename*1="tch"

>From 53c14fc8c07bf4196b61b3b7809dbe02313c49a7 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tdz@users.sourceforge.net>
Date: Tue, 3 Feb 2015 09:37:47 +0100
Subject: [PATCH] Documentation: HAL IPC uses 4 octects for socket channel

The documentations says that the HAL IPC uses 2 octets for socket
channels, while |struct hal_cmd_socket_{listen,connect}| contain 4
octets. This patch fixes the documentation accordingly.

Signed-off-by: Thomas Zimmermann <tdz@users.sourceforge.net>
---
 android/hal-ipc-api.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index f15c12e..515cf4e 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -456,7 +456,7 @@ Commands and responses:
 		Command parameters: Socket type (1 octet)
 		                    Service name (256 octets)
 		                    Service UUID (16 octets)
-		                    Channel (2 octets)
+		                    Channel (4 octets)
 		                    Socket flags (1 octet)
 		Response parameters: File descriptor (inline)
 
@@ -474,7 +474,7 @@ Commands and responses:
 		Command parameters: Remote address (6 octets)
 		                    Socket type (1 octet)
 		                    Service UUID (16 octets)
-		                    Channel (2 octets)
+		                    Channel (4 octets)
 		                    Socket flags (1 octet)
 		Response parameters: File descriptor (inline)
 
-- 
1.7.10.4


--------------060002000501010405080903--
