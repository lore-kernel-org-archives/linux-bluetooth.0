Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core: Remove ConfirmModeChange method
Date: Thu, 13 Dec 2012 22:00:40 +0200
Message-Id: <1355428840-27065-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355428840-27065-1-git-send-email-luiz.dentz@gmail.com>
References: <1355428840-27065-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This method was only used by RequestSession which is now removed.
---
 doc/agent-api.txt |  9 ---------
 src/agent.c       | 55 -------------------------------------------------------
 src/agent.h       |  4 ----
 3 files changed, 68 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index bd8d8ff..caed7f8 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -119,15 +119,6 @@ Methods		void Release()
 			Possible errors: org.bluez.Error.Rejected
 			                 org.bluez.Error.Canceled
 
-		void ConfirmModeChange(string mode)
-
-			This method gets called if a mode change is requested
-			that needs to be confirmed by the user. An example
-			would be leaving flight mode.
-
-			Possible errors: org.bluez.Error.Rejected
-			                 org.bluez.Error.Canceled
-
 		void Cancel()
 
 			This method gets called to indicate that the agent
diff --git a/src/agent.c b/src/agent.c
index 7ecf19a..ec183c0 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -459,61 +459,6 @@ failed:
 	return err;
 }
 
-static int confirm_mode_change_request_new(struct agent_request *req,
-						const char *mode)
-{
-	struct agent *agent = req->agent;
-
-	req->msg = dbus_message_new_method_call(agent->name, agent->path,
-				"org.bluez.Agent", "ConfirmModeChange");
-	if (req->msg == NULL) {
-		error("Couldn't allocate D-Bus message");
-		return -ENOMEM;
-	}
-
-	dbus_message_append_args(req->msg,
-				DBUS_TYPE_STRING, &mode,
-				DBUS_TYPE_INVALID);
-
-	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), req->msg,
-					&req->call, REQUEST_TIMEOUT) == FALSE) {
-		error("D-Bus send failed");
-		return -EIO;
-	}
-
-	dbus_pending_call_set_notify(req->call, simple_agent_reply, req, NULL);
-	return 0;
-}
-
-int agent_confirm_mode_change(struct agent *agent, const char *new_mode,
-				agent_cb cb, void *user_data,
-				GDestroyNotify destroy)
-{
-	struct agent_request *req;
-	int err;
-
-	if (agent->request)
-		return -EBUSY;
-
-	DBG("Calling Agent.ConfirmModeChange: name=%s, path=%s, mode=%s",
-			agent->name, agent->path, new_mode);
-
-	req = agent_request_new(agent, AGENT_REQUEST_CONFIRM_MODE,
-				cb, user_data, destroy);
-
-	err = confirm_mode_change_request_new(req, new_mode);
-	if (err < 0)
-		goto failed;
-
-	agent->request = req;
-
-	return 0;
-
-failed:
-	agent_request_free(req, FALSE);
-	return err;
-}
-
 static void passkey_reply(DBusPendingCall *call, void *user_data)
 {
 	struct agent_request *req = user_data;
diff --git a/src/agent.h b/src/agent.h
index 2b011b7..3957317 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -49,10 +49,6 @@ int agent_request_pincode(struct agent *agent, struct btd_device *device,
 				agent_pincode_cb cb, gboolean secure,
 				void *user_data, GDestroyNotify destroy);
 
-int agent_confirm_mode_change(struct agent *agent, const char *new_mode,
-				agent_cb cb, void *user_data,
-				GDestroyNotify destroy);
-
 int agent_request_passkey(struct agent *agent, struct btd_device *device,
 				agent_passkey_cb cb, void *user_data,
 				GDestroyNotify destroy);
-- 
1.7.11.7

