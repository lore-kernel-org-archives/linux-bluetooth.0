Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2009 12:40:57 -0500
Message-ID: <21b895620909101040qeb5973axbba6c5a44f6e5b6a@mail.gmail.com>
Subject: [PATCH 2/3] bluetooth: hidp+hidraw write support
From: SephirXV <sephirxv@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christopher Olson <sephirxv@gmail.com>

somewhere before .28, non-compliant HIDP devices would connect, and
could be read from, but writing to the device had no effect.

Signed-off-by: Christopher Olson <sephirxv@gmail.com>

---

--- net/bluetooth/hidp/core.c   2009-09-10 09:32:20.000000000 -0500
+++ net/bluetooth/hidp/core.c.2 2009-09-10 09:41:37.000000000 -0500
@@ -40,6 +40,7 @@

 #include <linux/input.h>
 #include <linux/hid.h>
+#include <linux/hidraw.h>

 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -513,6 +514,11 @@ static void hidp_process_transmit(struct
                kfree_skb(skb);
        }
 }
+
+static int hidp_output_raw_report(struct hid_device *hid, __u8 *buf,
size_t count)
+{
+        return hidp_send_ctrl_message(hid->driver_data, buf[0], buf +
1, count - 1);
+}

 static int hidp_session(void *arg)
 {
@@ -781,6 +787,7 @@ static int hidp_setup_hid(struct hidp_se

        hid->dev.parent = hidp_get_device(session);
        hid->ll_driver = &hidp_hid_driver;
+       hid->hid_output_raw_report = hidp_output_raw_report;

        ret = hid_add_device(hid);
        if (ret)
