Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Add checking for agent reply state in adapter
Date: Tue, 28 Sep 2010 12:17:50 +0300
Message-Id: <1285665470-5261-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added checking for agent reply state before cancelling agent in
session_free(..). This check is needed to ensure that memory for
agent request will be freed only once (In that case, free on this
request is called later in the end of agent_reply func)
---
 src/adapter.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0e9be5f..c122f82 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -82,6 +82,7 @@ struct session_req {
 	guint			id;		/* Listener id */
 	uint8_t			mode;		/* Requested mode */
 	int			refcount;	/* Session refcount */
+	gboolean		is_reply;	/* Agent reply is present */
 };
 
 struct service_auth {
@@ -757,7 +758,9 @@ static void session_free(struct session_req *req)
 
 	if (req->msg) {
 		dbus_message_unref(req->msg);
-		if (req->mode && req->adapter->agent)
+		/* if initial reply is present, we shouldn't cancel agent,
+		 * because it will be done later in agent_reply function */
+		if (!req->is_reply && req->mode && req->adapter->agent)
 			agent_cancel(req->adapter->agent);
 	}
 
@@ -794,6 +797,7 @@ static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
 	int err;
 	DBusMessage *reply;
 
+	req->is_reply = TRUE;
 	if (derr && dbus_error_is_set(derr)) {
 		reply = dbus_message_new_error(req->msg, derr->name,
 						derr->message);
-- 
1.7.0.4

