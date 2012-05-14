Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 2/5] Use defines instead of magic numbers
Date: Mon, 14 May 2012 17:33:01 +0200
Message-Id: <1337009584-17181-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The error-handling code should use the defines instead of magic numbers.
---
 src/device.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/src/device.c b/src/device.c
index 2a8812e..82dc2ca 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2303,48 +2303,48 @@ static DBusMessage *new_authentication_return(DBusMessage *msg, int status)
 	case 0x00: /* success */
 		return dbus_message_new_method_return(msg);
 
-	case 0x04: /* page timeout */
+	case HCI_PAGE_TIMEOUT:
 		return dbus_message_new_error(msg,
 				ERROR_INTERFACE ".ConnectionAttemptFailed",
 				"Page Timeout");
-	case 0x08: /* connection timeout */
+	case HCI_CONNECTION_TIMEOUT:
 		return dbus_message_new_error(msg,
 				ERROR_INTERFACE ".ConnectionAttemptFailed",
 				"Connection Timeout");
-	case 0x10: /* connection accept timeout */
-	case 0x22: /* LMP response timeout */
-	case 0x28: /* instant passed - is this a timeout? */
+	case HCI_HOST_TIMEOUT:
+	case HCI_LMP_RESPONSE_TIMEOUT:
+	case HCI_INSTANT_PASSED: /* is this a timeout? */
 		return dbus_message_new_error(msg,
 					ERROR_INTERFACE ".AuthenticationTimeout",
 					"Authentication Timeout");
-	case 0x17: /* too frequent pairing attempts */
+	case HCI_REPEATED_ATTEMPTS: /* too frequent pairing attempts */
 		return dbus_message_new_error(msg,
 					ERROR_INTERFACE ".RepeatedAttempts",
 					"Repeated Attempts");
 
-	case 0x06:
-	case 0x18: /* pairing not allowed (e.g. gw rejected attempt) */
+	case HCI_PIN_OR_KEY_MISSING:
+	case HCI_PAIRING_NOT_ALLOWED: /* e.g. gw rejected attempt */
 		return dbus_message_new_error(msg,
 					ERROR_INTERFACE ".AuthenticationRejected",
 					"Authentication Rejected");
 
-	case 0x07: /* memory capacity */
-	case 0x09: /* connection limit */
-	case 0x0a: /* synchronous connection limit */
-	case 0x0d: /* limited resources */
-	case 0x13: /* user ended the connection */
-	case 0x14: /* terminated due to low resources */
-	case 0x16: /* connection terminated */
+	case HCI_MEMORY_FULL:
+	case HCI_MAX_NUMBER_OF_CONNECTIONS:
+	case HCI_MAX_NUMBER_OF_SCO_CONNECTIONS:
+	case HCI_REJECTED_LIMITED_RESOURCES:
+	case HCI_OE_USER_ENDED_CONNECTION:
+	case HCI_OE_LOW_RESOURCES:
+	case HCI_CONNECTION_TERMINATED:
 		return dbus_message_new_error(msg,
 					ERROR_INTERFACE ".AuthenticationCanceled",
 					"Authentication Canceled");
 
-	case 0x05: /* authentication failure */
-	case 0x0E: /* rejected due to security reasons - is this auth failure? */
-	case 0x25: /* encryption mode not acceptable - is this auth failure? */
-	case 0x26: /* link key cannot be changed - is this auth failure? */
-	case 0x29: /* pairing with unit key unsupported - is this auth failure? */
-	case 0x2f: /* insufficient security - is this auth failure? */
+	case HCI_AUTHENTICATION_FAILURE:
+	case HCI_REJECTED_SECURITY: /* is this auth failure? */
+	case HCI_ENCRYPTION_MODE_NOT_ACCEPTED: /* is this auth failure? */
+	case HCI_UNIT_LINK_KEY_USED: /* is this auth failure? */
+	case HCI_PAIRING_NOT_SUPPORTED: /* is this auth failure? */
+	case HCI_INSUFFICIENT_SECURITY: /* is this auth failure? */
 	default:
 		return dbus_message_new_error(msg,
 					ERROR_INTERFACE ".AuthenticationFailed",
-- 
1.7.7.6

