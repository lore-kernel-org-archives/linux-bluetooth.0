Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, marcel@hotmann.org, hadess@hadess.net,
	Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv3 5/8] Add display parameter to plugin pincode callback
Date: Thu,  5 Apr 2012 15:29:37 -0700
Message-Id: <1333664980-29165-6-git-send-email-scott@netsplit.com>
In-Reply-To: <1333664980-29165-1-git-send-email-scott@netsplit.com>
References: <1333664980-29165-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pass a display parameter to the plugin pincode callback, a plugin
may set this to TRUE to indicate the PIN it generates should be
displayed on the screen for entry into the remote device.
---
 plugins/wiimote.c |    2 +-
 src/adapter.c     |    4 ++--
 src/adapter.h     |    4 ++--
 src/event.c       |    3 ++-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index 568bfd5..9c69c6d 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -57,7 +57,7 @@
  */
 
 static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
-								char *pinbuf)
+						char *pinbuf, gboolean *display)
 {
 	uint16_t vendor, product;
 	bdaddr_t sba, dba;
diff --git a/src/adapter.c b/src/adapter.c
index d5c1a04..d10db10 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3345,7 +3345,7 @@ void btd_adapter_unregister_pin_cb(struct btd_adapter *adapter,
 }
 
 ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
-								char *pin_buf)
+					char *pin_buf, gboolean *display)
 {
 	GSList *l;
 	btd_adapter_pin_cb_t cb;
@@ -3354,7 +3354,7 @@ ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
 
 	for (l = adapter->pin_callbacks; l != NULL; l = g_slist_next(l)) {
 		cb = l->data;
-		ret = cb(adapter, dev, pin_buf);
+		ret = cb(adapter, dev, pin_buf, display);
 		if (ret > 0)
 			return ret;
 	}
diff --git a/src/adapter.h b/src/adapter.h
index c47d180..196713e 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -172,13 +172,13 @@ int btd_adapter_switch_offline(struct btd_adapter *adapter);
 void btd_adapter_enable_auto_connect(struct btd_adapter *adapter);
 
 typedef ssize_t (*btd_adapter_pin_cb_t) (struct btd_adapter *adapter,
-					struct btd_device *dev, char *out);
+			struct btd_device *dev, char *out, gboolean *display);
 void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 						btd_adapter_pin_cb_t cb);
 void btd_adapter_unregister_pin_cb(struct btd_adapter *adapter,
 						btd_adapter_pin_cb_t cb);
 ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
-								char *pin_buf);
+					char *pin_buf, gboolean *display);
 
 typedef void (*bt_hci_result_t) (uint8_t status, gpointer user_data);
 
diff --git a/src/event.c b/src/event.c
index a4a60d0..b37f411 100644
--- a/src/event.c
+++ b/src/event.c
@@ -119,12 +119,13 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure)
 	struct btd_device *device;
 	char pin[17];
 	ssize_t pinlen;
+	gboolean display = FALSE;
 
 	if (!get_adapter_and_device(sba, dba, &adapter, &device, TRUE))
 		return -ENODEV;
 
 	memset(pin, 0, sizeof(pin));
-	pinlen = btd_adapter_get_pin(adapter, device, pin);
+	pinlen = btd_adapter_get_pin(adapter, device, pin, &display);
 	if (pinlen > 0 && (!secure || pinlen == 16)) {
 		btd_adapter_pincode_reply(adapter, dba, pin, pinlen);
 		return 0;
-- 
1.7.7.3

