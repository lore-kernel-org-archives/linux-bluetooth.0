Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 07/12] agent: Remove redundant D-Bus error initilizations
Date: Wed, 23 May 2012 21:27:27 +0530
Message-id: <1337788652-23697-8-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/agent.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index c628024..579b03e 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -272,7 +272,6 @@ static void simple_agent_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&err);
 	if (!dbus_message_get_args(message, &err, DBUS_TYPE_INVALID)) {
 		error("Wrong reply signature: %s", err.message);
 		cb(agent, &err, req->user_data);
@@ -373,7 +372,6 @@ static void pincode_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&err);
 	if (!dbus_message_get_args(message, &err,
 				DBUS_TYPE_STRING, &pin,
 				DBUS_TYPE_INVALID)) {
@@ -385,7 +383,6 @@ static void pincode_reply(DBusPendingCall *call, void *user_data)
 
 	len = strlen(pin);
 
-	dbus_error_init(&err);
 	if (len > 16 || len < 1) {
 		error("Invalid PIN length (%zu) from agent", len);
 		dbus_set_error_const(&err, "org.bluez.Error.InvalidArgs",
@@ -538,7 +535,6 @@ static void passkey_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&err);
 	if (!dbus_message_get_args(message, &err,
 				DBUS_TYPE_UINT32, &passkey,
 				DBUS_TYPE_INVALID)) {
@@ -733,7 +729,6 @@ static void display_pincode_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&err);
 	if (!dbus_message_get_args(message, &err, DBUS_TYPE_INVALID)) {
 		error("Wrong reply signature: %s", err.message);
 		cb(agent, &err, req->user_data);
-- 
1.7.4.1

