Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 4/6] device: Rename device_att_connect to device_connect_le
Date: Fri, 25 Jan 2013 00:07:05 -0300
Message-Id: <1359083227-13122-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes it clearer that this (currently unused) function should
only be used with LE devices.
---
 src/device.c | 2 +-
 src/device.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 89df161..c76fb2b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3120,7 +3120,7 @@ static void att_success_cb(gpointer user_data)
 	g_slist_foreach(device->attios, attio_connected, device->attrib);
 }
 
-GIOChannel *device_att_connect(struct btd_device *dev)
+GIOChannel *device_connect_le(struct btd_device *dev)
 {
 	struct btd_adapter *adapter = dev->adapter;
 	struct att_callbacks *attcb;
diff --git a/src/device.h b/src/device.h
index 5438b0d..a86fd59 100644
--- a/src/device.h
+++ b/src/device.h
@@ -109,7 +109,7 @@ int device_unblock(struct btd_device *device, gboolean silent,
 void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 			uint16_t vendor, uint16_t product, uint16_t version);
 
-GIOChannel *device_att_connect(struct btd_device *dev);
+GIOChannel *device_connect_le(struct btd_device *dev);
 
 struct btd_profile;
 
-- 
1.8.1.1

