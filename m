Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Fix possible crash on startup
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-WTzUht7T7rmg9SPQdVWK"
Date: Sun, 12 Oct 2008 00:03:22 +0100
Message-Id: <1223766202.31961.868.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-WTzUht7T7rmg9SPQdVWK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I can provide the file that caused the crash, if needed.

Cheers

--=-WTzUht7T7rmg9SPQdVWK
Content-Disposition: attachment; filename="0001-Fix-possible-crash-on-startup.patch"
Content-Type: text/x-patch; name="0001-Fix-possible-crash-on-startup.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 8515a34842a0aee14d7d0c5725caf15d9d2d7308 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sun, 12 Oct 2008 00:01:43 +0100
Subject: [PATCH] Fix possible crash on startup

0  0x0000000000a5cf71 in sdp_data_get (rec=0x0, attrId=0) at sdp.c:1444
1  0x000000008c704721 in hid_device_probe (device=0x7f1bed2a80b0, uuids=0x7f1bed29fa90) at manager.c:70
2  0x00007f1becb5bc33 in device_probe_drivers (device=0x7f1bed2a80b0, uuids=0x7f1bed2a2980) at device.c:647
3  0x00007f1becb58a23 in create_stored_device_from_profiles (key=0x7f1bed2a7360 "00:1E:45:AD:F1:96",
   value=0x7f1bed2a7aa0 "00000002-0000-1000-8000-0002ee000002 00001101-0000-1000-8000-00805f9b34fb 00001103-0000-1000-8000-00805f9b34fb 00001104-0000-1000-8000-00805f9b34fb 00001105-0000-1000-8000-00805f9b34fb 00001106-0000-1"..., user_data=0x7f1bed29edd0) at adapter.c:2296
4  0x00007f1becb61d12 in textfile_foreach (pathname=0x7ffff4b6f2a0 "/var/lib/bluetooth/00:13:EF:F1:42:B7/profiles", func=0x7f1becb58955 <create_stored_device_from_profiles>, data=0x7f1bed29edd0) at textfile.c:447
5  0x00007f1becb58b36 in load_devices (adapter=0x7f1bed29edd0) at adapter.c:2327
6  0x00007f1becb58fa0 in adapter_up (adapter=0x7f1bed29edd0, dd=18) at adapter.c:2462
7  0x00007f1becb59479 in adapter_start (adapter=0x7f1bed29edd0) at adapter.c:2569
8  0x00007f1becb5427f in manager_start_adapter (id=0) at manager.c:424
9  0x00007f1becb48e02 in device_devup_setup (dev_id=0) at main.c:481
10 0x00007f1becb48f35 in init_all_devices (ctl=7) at main.c:512
11 0x00007f1becb496d0 in main (argc=1, argv=0x7ffff4b70788) at main.c:748

The HID device's SDP record can be NULL, so don't crash when that happens
---
 input/manager.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/input/manager.c b/input/manager.c
index 51634e3..25b64e4 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -65,6 +65,9 @@ static int hid_device_probe(struct btd_device *device, GSList *uuids)
 
 	DBG("path %s", path);
 
+	if (!rec)
+		return -1;
+
 	adapter_get_address(adapter, &src);
 	device_get_address(device, &dst);
 	pdlist = sdp_data_get(rec, SDP_SERVER_RECORD_HANDLE);
-- 
1.5.5.2


--=-WTzUht7T7rmg9SPQdVWK--

