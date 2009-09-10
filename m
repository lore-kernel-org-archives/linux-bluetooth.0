Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2009 12:40:53 -0500
Message-ID: <21b895620909101040r6887d4c3w511ff975c0e6aca@mail.gmail.com>
Subject: [PATCH 1/3] bluetooth: hidp+hidraw disconnect
From: SephirXV <sephirxv@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christopher Olson <sephirxv@gmail.com>

Somewhere between 2.6.26 and 2.6.28, hidraw began connecting to HIDP
devices which don't strictly define their behavior in the HID usage
table, and without any patching on my part. These non-compliant
devices wouldn't automatically disconnect, leaving hidraw files which
did nothing.

Signed-off-by: Christopher Olson <sephirxv@gmail.com>

---

--- net/bluetooth/hidp/core.c   2009-09-10 09:32:20.000000000 -0500
+++ net/bluetooth/hidp/core.c.1 2009-09-10 09:31:37.000000000 -0500
@@ -40,6 +40,7 @@

 #include <linux/input.h>
 #include <linux/hid.h>
+#include <linux/hidraw.h>

 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -736,6 +737,8 @@ static void hidp_stop(struct hid_device

        if (hid->claimed & HID_CLAIMED_INPUT)
                hidinput_disconnect(hid);
+       if (hid->claimed & HID_CLAIMED_HIDRAW)
+               hidraw_disconnect(hid);
        hid->claimed = 0;
 }
