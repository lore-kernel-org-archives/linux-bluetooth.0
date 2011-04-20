Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Cleanup: remove header declared but not defined
Date: Wed, 20 Apr 2011 10:17:23 -0300
Message-Id: <1303305443-24135-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1303305443-24135-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1303305443-24135-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/src/device.h b/src/device.h
index 370382d..d59b8eb 100644
--- a/src/device.h
+++ b/src/device.h
@@ -71,11 +71,7 @@ gboolean device_is_paired(struct btd_device *device);
 gboolean device_is_trusted(struct btd_device *device);
 void device_set_paired(struct btd_device *device, gboolean paired);
 void device_set_temporary(struct btd_device *device, gboolean temporary);
-void device_set_cap(struct btd_device *device, uint8_t cap);
 void device_set_type(struct btd_device *device, device_type_t type);
-uint8_t device_get_cap(struct btd_device *device);
-void device_set_auth(struct btd_device *device, uint8_t auth);
-uint8_t device_get_auth(struct btd_device *device);
 gboolean device_is_connected(struct btd_device *device);
 DBusMessage *device_create_bonding(struct btd_device *device,
 				DBusConnection *conn, DBusMessage *msg,
-- 
1.7.5.rc1

