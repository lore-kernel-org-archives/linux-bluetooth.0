Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Prabhu Chawandi <foss.chaws@gmail.com>
Date: Fri, 15 Jul 2016 12:05:25 +0530
Message-ID: <CAKafyqrK5=MtdkdSAxx0YSu0-m2SMZ8K+goTO8RFwTAC05KPpg@mail.gmail.com>
Subject: [PATCH Bluez] Fix missing on device found event for the known devices
 on a new le scan session
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Device found events not sent for the known devices on a new LE scan
session. Below patch is to clear the cached entries when new le scan
session is started.

--- a/android/bluetooth.c 2016-07-15 11:12:53.486029274 +0530
+++ b/android/bluetooth.c 2016-07-15 11:30:42.224366877 +0530
@@ -4029,6 +4029,9 @@
  return true;
  }

+    g_slist_foreach(bonded_devices, clear_device_found, NULL);
+    g_slist_foreach(cached_devices, clear_device_found, NULL);
+
  if (start_discovery(SCAN_TYPE_LE))
  return true;

Thanks & Regards,
Prabhu
