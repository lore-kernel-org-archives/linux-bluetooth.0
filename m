Return-Path: <cyrus@holtmann.org>
Message-ID: <4A64254F.5080504@xyzw.org>
Date: Mon, 20 Jul 2009 01:05:35 -0700
From: Brian Rogers <brian@xyzw.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Disconnect hidraw device when an input device is disconnected
Content-Type: multipart/mixed;
 boundary="------------050502080300090508070405"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050502080300090508070405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050502080300090508070405
Content-Type: text/x-patch;
 name="0002-Bluetooth-Disconnect-hidraw-device-when-an-input-dev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-Bluetooth-Disconnect-hidraw-device-when-an-input-dev.pa";
 filename*1="tch"

>From 487bccfd500d161dadf7b92be1ca2f8cca2b7781 Mon Sep 17 00:00:00 2001
From: Brian Rogers <brian@xyzw.org>
Date: Sun, 19 Jul 2009 18:23:21 -0700
Subject: [PATCH 2/2] Bluetooth: Disconnect hidraw device when an input device is disconnected

hidraw didn't exist when Bluetooth code was adapted to use the HID subsystem.
Now that it does exist, hidp is responsible for disconnecting it. Without
doing this, old hidraw devices stick around forever.

Signed-off-by: Brian Rogers <brian@xyzw.org>
---
 net/bluetooth/hidp/core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a9f7afb..5def2db 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -40,6 +40,7 @@
 
 #include <linux/input.h>
 #include <linux/hid.h>
+#include <linux/hidraw.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -574,6 +575,8 @@ static int hidp_session(void *arg)
 	if (session->hid) {
 		if (session->hid->claimed & HID_CLAIMED_INPUT)
 			hidinput_disconnect(session->hid);
+		if (session->hid->claimed & HID_CONNECT_HIDRAW)
+			hidraw_disconnect(session->hid);
 		hid_destroy_device(session->hid);
 	}
 
-- 
1.6.3.3


--------------050502080300090508070405--
