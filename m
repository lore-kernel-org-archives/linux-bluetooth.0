Return-Path: <konrad.zapalowicz@canonical.com>
From: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
To: marcel@holtmann.org
Cc: luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org,
	=?UTF-8?q?Konrad=20Zapa=C5=82owicz?= <konrad.zapalowicz@canonical.com>
Subject: [PATCH] tools: add logitech diNovo rules for hid2hci
Date: Mon,  8 May 2017 13:00:10 +0200
Message-Id: <1494241210-27307-1-git-send-email-bergo.torino@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Konrad Zapałowicz <konrad.zapalowicz@canonical.com>

It has been reported that th Lenovo diNovo set of BT wireless devices
works only when is managed by hidraw instead of hiddev. This patch adds
vendor and product ids for these devices so that it is possible to use.

This patch is based on work provided by:
 * Tommy <mesilliac@gmail.com>
 * Martin G Miller <mgmiller@optonline.net>
---
 tools/hid2hci.rules | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/hid2hci.rules b/tools/hid2hci.rules
index db6bb03..7273167 100644
--- a/tools/hid2hci.rules
+++ b/tools/hid2hci.rules
@@ -13,6 +13,12 @@ ATTR{bInterfaceClass}=="03", ATTR{bInterfaceSubClass}=="01", ATTR{bInterfaceProt
 # Logitech devices
 KERNEL=="hiddev*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c70[345abce]|c71[34bc]", \
   RUN+="hid2hci --method=logitech-hid --devpath=%p"
+# Logitech, Inc. diNovo Edge Keyboard
+KERNEL=="hidraw*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c714", \
+  RUN+="hid2hci --method=logitech-hid --devpath=%p"
+# Logitech, Inc. diNovo 2
+KERNEL=="hidraw*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c704", \
+  RUN+="hid2hci --method=logitech-hid --devpath=%p"
 
 ENV{DEVTYPE}!="usb_device", GOTO="hid2hci_end"
 
-- 
2.7.4
