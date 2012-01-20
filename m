Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [RFC PATCH 3/3] Implement HID profile recommendation for keyboards
Date: Fri, 20 Jan 2012 15:05:44 -0800
Message-Id: <1327100744-28782-4-git-send-email-scott@netsplit.com>
In-Reply-To: <1327100744-28782-1-git-send-email-scott@netsplit.com>
References: <1327100744-28782-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth HID profile recommends that for keyboard devices we
generate the PIN ourselves and display it for the user and expecting
them to enter it into the keyboard being paired - rather than
requesting it so that they have to enter it into both devices.
---
 src/event.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/src/event.c b/src/event.c
index 5aa5ef9..26318bd 100644
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
@@ -130,6 +133,25 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure)
 		return 0;
 	}
 
+	if (device_is_bonding(device, NULL) &&
+			read_remote_class(sba, dba, &class) == 0) {
+		switch (BLUETOOTH_DEVICE_CLASS(class)) {
+		case BLUETOOTH_DEVICE_CLASS_PERIPHERAL_KEYBOARD:
+		case BLUETOOTH_DEVICE_CLASS_PERIPHERAL_KEYBOARD_POINTING:
+			/* Generate a PIN in the range 000000-999999 */
+			DBG("Generating pincode for keyboard");
+			srand(time(NULL));
+			snprintf(pin, sizeof pin, "%06d", rand() % 1000000);
+			btd_adapter_pincode_reply(adapter, dba,
+							pin, strlen(pin));
+			return device_request_authentication(device,
+					AUTH_TYPE_NOTIFY_PINCODE, pin,
+					secure, NULL);
+
+			break;
+		}
+	}
+
 	return device_request_authentication(device, AUTH_TYPE_PINCODE, NULL,
 							secure, pincode_cb);
 }
-- 
1.7.7.3

