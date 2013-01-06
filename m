Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Bluetooth: Fix incorrect strncpy() in hidp_setup_hid()
Date: Sun,  6 Jan 2013 18:28:53 -0400
Message-Id: <1357511333-5276-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The length parameter should be sizeof(req->name) - 1 because there is no
guarantee that string provided by userspace will contain the trailing
'\0'.

Can be easily reproduced by manually setting req->name to 128 non-zero
bytes prior to ioctl(HIDPCONNADD) and checking the device name setup on
input subsystem:

$ cat /sys/devices/pnp0/00\:04/tty/ttyS0/hci0/hci0\:1/input8/name
AAAAAA[...]AAAAAAAAf0:af:f0:af:f0:af

("f0:af:f0:af:f0:af" is the device bluetooth address, taken from "phys"
field in struct hid_device due to overflow.)

Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
---
 net/bluetooth/hidp/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 0c00284..33600b4 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -931,7 +931,7 @@ static int hidp_setup_hid(struct hidp_session *session,
 	hid->version = req->version;
 	hid->country = req->country;
 
-	strncpy(hid->name, req->name, 128);
+	strncpy(hid->name, req->name, sizeof(req->name) - 1);
 
 	snprintf(hid->phys, sizeof(hid->phys), "%pMR",
 		 &bt_sk(session->ctrl_sock->sk)->src);
-- 
1.7.9.5

