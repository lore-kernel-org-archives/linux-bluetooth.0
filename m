Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/14] neard: Adjust errors to latest API changes
Date: Thu, 7 Feb 2013 09:13:51 +0100
Message-ID: <1360224844-12280-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

neard Handover API was stripped of not really usefull error codes.
---
 plugins/neard.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index b0150e9..6272144 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -57,27 +57,14 @@ static gboolean agent_register_postpone = FALSE;
 
 static DBusMessage *error_reply(DBusMessage *msg, int error)
 {
-	switch (error) {
-	case ENOTSUP:
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotSupported",
-						"Operation is not supported");
+	const char *name;
 
-	case ENOENT:
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".NoSuchDevice",
-							"No such device");
-
-	case EINPROGRESS:
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
-						"Operation already in progress");
-
-	case ENONET:
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Disabled",
-							"Device disabled");
+	if (error == EINPROGRESS)
+		name = ERROR_INTERFACE ".InProgress";
+	else
+		name = ERROR_INTERFACE ".Failed";
 
-	default:
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"%s", strerror(error));
-	}
+	return g_dbus_create_error(msg, name , "%s", strerror(error));
 }
 
 static void register_agent_cb(DBusPendingCall *call, void *user_data)
-- 
1.8.1.1

