Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Fix wrong parameter name in device.h
Date: Wed, 22 Sep 2010 18:33:46 +0200
Message-Id: <1285173226-15713-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/device.h b/src/device.h
index 21f67d0..2b45223 100644
--- a/src/device.h
+++ b/src/device.h
@@ -47,7 +47,7 @@ const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
-void device_get_address(struct btd_device *adapter, bdaddr_t *bdaddr);
+void device_get_address(struct btd_device *device, bdaddr_t *bdaddr);
 const gchar *device_get_path(struct btd_device *device);
 struct agent *device_get_agent(struct btd_device *device);
 gboolean device_is_busy(struct btd_device *device);
-- 
1.7.0.4

