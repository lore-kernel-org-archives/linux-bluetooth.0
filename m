Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [RFC PATCH 1/3] lib: add header of device class constants
Date: Fri, 20 Jan 2012 15:05:42 -0800
Message-Id: <1327100744-28782-2-git-send-email-scott@netsplit.com>
In-Reply-To: <1327100744-28782-1-git-send-email-scott@netsplit.com>
References: <1327100744-28782-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am  |    2 +-
 lib/bt_ids.h |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 1 deletions(-)
 create mode 100644 lib/bt_ids.h

diff --git a/Makefile.am b/Makefile.am
index 102ee62..8dbe603 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -59,7 +59,7 @@ plugin_LTLIBRARIES =
 
 lib_headers = lib/bluetooth.h lib/hci.h lib/hci_lib.h lib/mgmt.h \
 		lib/sco.h lib/l2cap.h lib/sdp.h lib/sdp_lib.h lib/uuid.h \
-		lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h
+		lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h lib/bt_ids.h
 local_headers = $(foreach file,$(lib_headers), lib/bluetooth/$(notdir $(file)))
 
 BUILT_SOURCES = $(local_headers) src/builtin.h
diff --git a/lib/bt_ids.h b/lib/bt_ids.h
new file mode 100644
index 0000000..6aa0848
--- /dev/null
+++ b/lib/bt_ids.h
@@ -0,0 +1,133 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Google Inc.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __BT_IDS_H
+#define __BT_IDS_H
+
+/* Service classes */
+#define BLUETOOTH_SERVICE_CLASS_BITMASK                 0xFFE000
+#define BLUETOOTH_SERVICE_CLASS_LIMITED_DISCOVERABILITY 0x002000
+#define BLUETOOTH_SERVICE_CLASS_POSITIONING             0x010000
+#define BLUETOOTH_SERVICE_CLASS_NETWORKING              0x020000
+#define BLUETOOTH_SERVICE_CLASS_RENDER                  0x040000
+#define BLUETOOTH_SERVICE_CLASS_CAPTURE                 0x080000
+#define BLUETOOTH_SERVICE_CLASS_OBJECT_TRANSFER         0x100000
+#define BLUETOOTH_SERVICE_CLASS_AUDIO                   0x200000
+#define BLUETOOTH_SERVICE_CLASS_TELEPHONE               0x400000
+#define BLUETOOTH_SERVICE_CLASS_INFORMATION             0x800000
+
+#define BLUETOOTH_SERVICE_CLASS(_class) \
+                                ((_class) & BLUETOOTH_SERVICE_CLASS_BITMASK)
+
+/* Major device classes */
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_BITMASK       0x1F00
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_MISC          0x0000
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_COMPUTER      0x0100
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_PHONE         0x0200
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_NETWORKING    0x0300
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_AUDIO_VIDEO   0x0400
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_PERIPHERAL    0x0500
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_IMAGING       0x0600
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_WEARABLE      0x0700
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_TOY           0x0800
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_HEATLH        0x0900
+#define BLUETOOTH_MAJOR_DEVICE_CLASS_UNCATEGORIZED 0x1F00
+
+#define BLUETOOTH_MAJOR_DEVICE_CLASS(_class) \
+                        ((_class) & BLUETOOTH_MAJOR_DEVICE_CLASS_BITMASK)
+
+/* Minor device classes (includes major class) */
+#define BLUETOOTH_DEVICE_CLASS_BITMASK 0x1FFC
+
+#define BLUETOOTH_DEVICE_CLASS(_class) \
+                                ((_class) & BLUETOOTH_DEVICE_CLASS_BITMASK)
+
+/* Devices in the COMPUTER major class */
+#define BLUETOOTH_DEVICE_CLASS_COMPUTER_UNCATEGORIZED    0x0100
+#define BLUETOOTH_DEVICE_CLASS_COMPUTER_DESKTOP          0x0104
+#define BLUETOOTH_DEVICE_CLASS_COMPUTER_SERVER           0x0108
+#define BLUETOOTH_DEVICE_CLASS_COMPUTER_LAPTOP           0x010C
+#define BLUETOOTH_DEVICE_CLASS_COMPUTER_HANDHELD_PC_PDA  0x0110
+#define BLUETOOTH_DEVICE_CLASS_COMPUTER_PALM_SIZE_PC_PDA 0x0114
+#define BLUETOOTH_DEVICE_CLASS_COMPUTER_WEARABLE         0x0118
+
+/* Devices in the PHONE major class */
+#define BLUETOOTH_DEVICE_CLASS_PHONE_UNCATEGORIZED    0x0200
+#define BLUETOOTH_DEVICE_CLASS_PHONE_CELLULAR         0x0204
+#define BLUETOOTH_DEVICE_CLASS_PHONE_CORDLESS         0x0208
+#define BLUETOOTH_DEVICE_CLASS_PHONE_SMART            0x020C
+#define BLUETOOTH_DEVICE_CLASS_PHONE_MODEM_OR_GATEWAY 0x0210
+#define BLUETOOTH_DEVICE_CLASS_PHONE_ISDN             0x0214
+
+/* Devices in the AUDIO_VIDEO major class */
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_UNCATEGORIZED      0x0400
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_WEARABLE_HEADSET   0x0404
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_HANDSFREE          0x0408
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_MICROPHONE         0x0410
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_LOUDSPEAKER        0x0414
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_HEADPHONES         0x0418
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_PORTABLE_AUDIO     0x041C
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_CAR_AUDIO          0x0420
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_SET_TOP_BOX        0x0424
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_HIFI_AUDIO         0x0428
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_VCR                0x042C
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_VIDEO_CAMERA       0x0430
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_CAMCORDER          0x0434
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_VIDEO_MONITOR      0x0438
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_VIDEO_DISPLAY_AND_LOUDSPEAKER 0x043C
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_VIDEO_CONFERENCING 0x0440
+#define BLUETOOTH_DEVICE_CLASS_AUDIO_VIDEO_VIDEO_GAMING_TOY   0x0448
+
+/* Devices in the WEARABLE major class */
+#define BLUETOOTH_DEVICE_CLASS_WEARABLE_UNCATEGORIZED 0x0700
+#define BLUETOOTH_DEVICE_CLASS_WEARABLE_WRIST_WATCH   0x0704
+#define BLUETOOTH_DEVICE_CLASS_WEARABLE_PAGER         0x0708
+#define BLUETOOTH_DEVICE_CLASS_WEARABLE_JACKET        0x070C
+#define BLUETOOTH_DEVICE_CLASS_WEARABLE_HELMET        0x0710
+#define BLUETOOTH_DEVICE_CLASS_WEARABLE_GLASSES       0x0714
+
+/* Devices in the TOY major class */
+#define BLUETOOTH_DEVICE_CLASS_TOY_UNCATEGORIZED      0x0800
+#define BLUETOOTH_DEVICE_CLASS_TOY_ROBOT              0x0804
+#define BLUETOOTH_DEVICE_CLASS_TOY_VEHICLE            0x0808
+#define BLUETOOTH_DEVICE_CLASS_TOY_DOLL_ACTION_FIGURE 0x080C
+#define BLUETOOTH_DEVICE_CLASS_TOY_CONTROLLER         0x0810
+#define BLUETOOTH_DEVICE_CLASS_TOY_GAME               0x0814
+
+/* Devices in the HEALTH major class */
+#define BLUETOOTH_DEVICE_CLASS_HEALTH_UNCATEGORIZED  0x0900
+#define BLUETOOTH_DEVICE_CLASS_HEALTH_BLOOD_PRESSURE 0x0904
+#define BLUETOOTH_DEVICE_CLASS_HEALTH_THERMOMETER    0x0908
+#define BLUETOOTH_DEVICE_CLASS_HEALTH_WEIGHING       0x090C
+#define BLUETOOTH_DEVICE_CLASS_HEALTH_GLUCOSE        0x0910
+#define BLUETOOTH_DEVICE_CLASS_HEALTH_PULSE_OXIMETER 0x0914
+#define BLUETOOTH_DEVICE_CLASS_HEALTH_PULSE_RATE     0x0918
+#define BLUETOOTH_DEVICE_CLASS_HEALTH_DATA_DISPLAY   0x091C
+
+/* Devices in the PERIPHERAL major class */
+#define BLUETOOTH_DEVICE_CLASS_PERIPHERAL_NON_KEYBOARD_NON_POINTING 0x0500
+#define BLUETOOTH_DEVICE_CLASS_PERIPHERAL_KEYBOARD                  0x0540
+#define BLUETOOTH_DEVICE_CLASS_PERIPHERAL_POINTING                  0x0580
+#define BLUETOOTH_DEVICE_CLASS_PERIPHERAL_KEYBOARD_POINTING         0x05C0
+
+#endif /* __BT_IDS_H */
-- 
1.7.7.3

