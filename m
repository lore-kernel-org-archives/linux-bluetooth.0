Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org,
	marcel@holtmann.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH 2/6] plugins: Extend the pin code callback with the call number
Date: Wed, 20 Mar 2013 21:10:04 -0700
Message-Id: <1363839008-8405-3-git-send-email-deymo@chromium.org>
In-Reply-To: <1363839008-8405-1-git-send-email-deymo@chromium.org>
References: <1363839008-8405-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The plugin's pin code callback doesn't know about the pairing process. It
just provides a pin code based on the information provided to this function.
Although limited state could be added trough other new callbacks, this fix
achieves this by providing more information to the callbacks itself. The
new argument "count" states the pin callback attempt of the particular
plugin for the current pairing of the device. This allows a plugin to try
different pincodes for the same device until it returns 0.
---
 plugins/wiimote.c | 7 ++++++-
 src/adapter.c     | 2 +-
 src/adapter.h     | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index 90d6d7b..4c514c6 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -70,12 +70,17 @@ static const char *wii_names[] = {
 };
 
 static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
-						char *pinbuf, gboolean *display)
+				char *pinbuf, gboolean *display, uint32_t count)
 {
 	uint16_t vendor, product;
 	char addr[18], name[25];
 	unsigned int i;
 
+	/* Only try the pin code once per device. If it's not correct then it's
+	 * an unknown device. */
+	if (count > 0)
+		return 0;
+
 	ba2str(device_get_address(device), addr);
 
 	vendor = btd_device_get_vendor(device);
diff --git a/src/adapter.c b/src/adapter.c
index b5e49b4..adf2e66 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4804,7 +4804,7 @@ static ssize_t pincb_iter_next(struct pincb_iter* iter,
 
 	while (iter->it != NULL) {
 		cb = iter->it->data;
-		ret = cb(adapter, device, pin_buf, display);
+		ret = cb(adapter, device, pin_buf, display, iter->count);
 		iter->count++;
 		if (ret > 0)
 			return ret;
diff --git a/src/adapter.h b/src/adapter.h
index d158334..ba57b15 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -132,7 +132,8 @@ int btd_cancel_authorization(guint id);
 int btd_adapter_restore_powered(struct btd_adapter *adapter);
 
 typedef ssize_t (*btd_adapter_pin_cb_t) (struct btd_adapter *adapter,
-			struct btd_device *dev, char *out, gboolean *display);
+			struct btd_device *dev, char *out, gboolean *display,
+								uint32_t count);
 void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 						btd_adapter_pin_cb_t cb);
 void btd_adapter_unregister_pin_cb(struct btd_adapter *adapter,
-- 
1.8.1.3
