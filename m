Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 4/9] device: Fix tab misuse
Date: Fri, 27 Apr 2012 10:36:47 -0400
Message-Id: <1335537412-26478-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 021b200..2a8812e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1005,7 +1005,7 @@ static void device_set_vendor_src(struct btd_device *device, uint16_t value)
 	device->vendor_src = value;
 
 	emit_property_changed(conn, device->path, DEVICE_INTERFACE,
-				"VendorSource",	DBUS_TYPE_UINT16, &value);
+				"VendorSource", DBUS_TYPE_UINT16, &value);
 }
 
 static void device_set_product(struct btd_device *device, uint16_t value)
-- 
1.7.5.4

