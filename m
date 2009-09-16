Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Sep 2009 15:33:59 +0800
From: Yi Yang <yi.y.yang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH resent] bluez: correct udev rule for Dell mouse
Message-ID: <20090916073359.GA22265@yangyi-dev.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From dbcfcf5dfbdef2377f64c7cd737886e31ae17615 Mon Sep 17 00:00:00 2001
From: Yi Yang <yi.y.yang@intel.com>
Date: Wed, 16 Sep 2009 15:19:13 +0800
Subject: [PATCH] Correct udev rule for Dell mouse

Note: this rule should just for Dell bluetooth mouse, but it
does function for Dell general USB mouse, such as this one:

    ID 413c:3010 Dell Computer Corp. Optical Wheel Mouse

We should let it just function for Dell bluetooth mouse, udev
144 and later has included rules for hid2hci
extras/hid2hci/70-hid2hci.rules which has correct one, so we
should use that one
---
 scripts/bluetooth-hid2hci.rules |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/scripts/bluetooth-hid2hci.rules b/scripts/bluetooth-hid2hci.rules
index 1b231d1..eb63292 100644
--- a/scripts/bluetooth-hid2hci.rules
+++ b/scripts/bluetooth-hid2hci.rules
@@ -8,7 +8,8 @@
 #   413c:8154
 #   413c:8158
 #   413c:8162
-ACTION=="add", ENV{ID_VENDOR}=="413c", ENV{ID_CLASS}=="mouse", ATTRS{bmAttributes}=="e0", KERNEL=="mouse*", RUN+="/usr/sbin/hid2hci --method dell -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
+ATTR{bInterfaceClass}=="03", ATTR{bInterfaceSubClass}=="01", ATTR{bInterfaceProtocol}=="02", ATTRS{bDeviceClass}=="00", ATTRS{idVendor}=="413c", ATTRS{bmAttributes}=="e0", \
+    RUN+="hid2hci --method dell -v $attr{idVendor} -p $attr{idProduct} --mode hci"
 
 # Logitech devices
 ACTION=="add", ENV{ID_VENDOR}=="046d", ENV{ID_MODEL}=="c703" RUN+="/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-- 
1.6.0.6

