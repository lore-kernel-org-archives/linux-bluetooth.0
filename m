Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 7/7] device: Make device_get_address return const pointer
Date: Fri, 5 Oct 2012 10:17:01 +0200
Message-ID: <1349425021-16766-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349425021-16766-1-git-send-email-szymon.janc@tieto.com>
References: <1349425021-16766-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    2 +-
 src/device.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 72cae3b..1c65b68 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2312,7 +2312,7 @@ struct btd_adapter *device_get_adapter(struct btd_device *device)
 	return device->adapter;
 }
 
-bdaddr_t *device_get_address(struct btd_device *device)
+const bdaddr_t *device_get_address(struct btd_device *device)
 {
 	return &device->bdaddr;
 }
diff --git a/src/device.h b/src/device.h
index f919af4..0c16c18 100644
--- a/src/device.h
+++ b/src/device.h
@@ -64,7 +64,7 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 void device_probe_profile(gpointer a, gpointer b);
 void device_remove_profile(gpointer a, gpointer b);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
-bdaddr_t *device_get_address(struct btd_device *device);
+const bdaddr_t *device_get_address(struct btd_device *device);
 void device_set_addr_type(struct btd_device *device, uint8_t bdaddr_type);
 uint8_t device_get_addr_type(struct btd_device *device);
 const gchar *device_get_path(struct btd_device *device);
-- 
1.7.9.5

