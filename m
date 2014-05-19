Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 2/3] device: Add function for checking if device is paired on any bearer
Date: Mon, 19 May 2014 12:16:05 +0200
Message-Id: <1400494566-8135-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400494566-8135-1-git-send-email-szymon.janc@tieto.com>
References: <1400494566-8135-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is for convenience checking if device is paired on any bearer
without need to know address type.
---
 src/device.c | 5 +++++
 src/device.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index 34a10d9..3ab813d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -564,6 +564,11 @@ bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type)
 	return state->paired;
 }
 
+bool device_is_paired_any(struct btd_device *device)
+{
+	return device->bredr_state.paired || device->le_state.paired;
+}
+
 bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
diff --git a/src/device.h b/src/device.h
index 133c9d1..03df66d 100644
--- a/src/device.h
+++ b/src/device.h
@@ -79,6 +79,7 @@ const bdaddr_t *device_get_address(struct btd_device *device);
 const char *device_get_path(const struct btd_device *device);
 gboolean device_is_temporary(struct btd_device *device);
 bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type);
+bool device_is_paired_any(struct btd_device *device);
 bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
 gboolean device_is_trusted(struct btd_device *device);
 void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type,
-- 
1.9.1

