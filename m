Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv2 6/8] Generate PIN for keyboard devices
Date: Mon, 23 Jan 2012 16:27:50 -0800
Message-Id: <1327364872-32313-7-git-send-email-scott@netsplit.com>
In-Reply-To: <1327364872-32313-1-git-send-email-scott@netsplit.com>
References: <1327364872-32313-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As recommended by the HID profile, generate a PIN for keyboard devices
and display on the host so that the user may enter it into the keyboard.

The new DisplayPinCode agent method is used, including its fallback to
RequestPinCode.

Generated PINs are numeric so that they may entered into Bluetooth
numeric keypads, and are zero-padded to six digits for compatibility
with Bluetooth 2.1 Secure Simple Pairing passkeys.
---
 src/event.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/src/event.c b/src/event.c
index 5aa5ef9..12c569f 100644
--- a/src/event.c
+++ b/src/event.c
@@ -27,6 +27,7 @@
 #endif
 
 #define _GNU_SOURCE
+#include <time.h>
 #include <stdio.h>
 #include <ctype.h>
 #include <errno.h>
@@ -49,6 +50,7 @@
 #include "agent.h"
 #include "storage.h"
 #include "event.h"
+#include "bt_ids.h"
 
 static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
 					struct btd_adapter **adapter,
@@ -119,6 +121,7 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure)
 	struct btd_device *device;
 	char pin[17];
 	ssize_t pinlen;
+	uint32_t class;
 
 	if (!get_adapter_and_device(sba, dba, &adapter, &device, TRUE))
 		return -ENODEV;
@@ -130,6 +133,22 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure)
 		return 0;
 	}
 
+	if (device_is_bonding(device, NULL) &&
+			read_remote_class(sba, dba, &class) == 0) {
+		switch (BT_CLASS(class)) {
+		case BT_CLASS_PERIPHERAL_KEYBOARD:
+		case BT_CLASS_PERIPHERAL_KEYBOARD_POINTING:
+			/* Generate a PIN in the range 000000-999999 */
+			DBG("Generating pincode for keyboard");
+			srand(time(NULL));
+			snprintf(pin, sizeof pin, "%06d", rand() % 1000000);
+
+			return device_request_authentication(device,
+					AUTH_TYPE_NOTIFY_PINCODE, pin,
+					secure, pincode_cb);
+		}
+	}
+
 	return device_request_authentication(device, AUTH_TYPE_PINCODE, NULL,
 							secure, pincode_cb);
 }
-- 
1.7.7.3

