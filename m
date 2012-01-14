Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <keybuk@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Scott James Remnant <keybuk@chromium.org>
Subject: [PATCH 2/2] agent: allow agent to reply to RequestPinCode with bytes
Date: Fri, 13 Jan 2012 17:52:37 -0800
Message-Id: <1326505957-27555-3-git-send-email-keybuk@chromium.org>
In-Reply-To: <1326505957-27555-1-git-send-email-keybuk@chromium.org>
References: <1326505957-27555-1-git-send-email-keybuk@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the specification allows the PIN to be a sequence of arbitrary
octets, and not a UTF-8 string, allow the userspace agent to reply
with such a sequence (as a D-Bus Array of Bytes).

This means a userspace agent can deal with devices that require their
BD_ADDR (or the host's) as a PIN, and take care of trying multiple of
such requirements.
---
 src/agent.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 4477210..3b9e849 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -353,7 +353,8 @@ static void pincode_reply(DBusPendingCall *call, void *user_data)
 	DBusMessage *message;
 	DBusError err;
 	bdaddr_t sba;
-	size_t len;
+	int32_t array_len;
+	ssize_t len;
 	char *pin;
 
 	adapter_get_address(adapter, &sba);
@@ -373,17 +374,24 @@ static void pincode_reply(DBusPendingCall *call, void *user_data)
 	}
 
 	dbus_error_init(&err);
-	if (!dbus_message_get_args(message, &err,
+	if (dbus_message_get_args(message, &err,
 				DBUS_TYPE_STRING, &pin,
 				DBUS_TYPE_INVALID)) {
+		len = strlen(pin);
+
+	} else if (dbus_message_get_args(message, &err,
+				DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &pin, &array_len,
+				DBUS_TYPE_INVALID)) {
+		/* convert int32_t to ssize_t (probably the same length) */
+		len = array_len;
+
+	} else {
 		error("Wrong passkey reply signature: %s", err.message);
 		cb(agent, &err, NULL, 0, req->user_data);
 		dbus_error_free(&err);
 		goto done;
 	}
 
-	len = strlen(pin);
-
 	dbus_error_init(&err);
 	if (len > 16 || len < 1) {
 		error("Invalid PIN length (%zu) from agent", len);
-- 
1.7.7.3

