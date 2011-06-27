Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 5/6] Add FindAdapter method call to obex-client
Date: Tue, 28 Jun 2011 00:39:40 +0300
Message-Id: <1309210781-2674-6-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1309210781-2674-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1309210781-2674-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/session.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/client/session.c b/client/session.c
index 423eb8c..d8e3bf2 100644
--- a/client/session.c
+++ b/client/session.c
@@ -848,11 +848,21 @@ proceed:
 	callback->func = function;
 	callback->data = user_data;
 
-	req = send_method_call(session->conn_system,
+	if (source) {
+		req = send_method_call(session->conn_system,
+				BT_BUS_NAME, BT_PATH,
+				BT_MANAGER_IFACE, "FindAdapter",
+				manager_reply, callback,
+				DBUS_TYPE_STRING, &source,
+				DBUS_TYPE_INVALID);
+	} else {
+		req = send_method_call(session->conn_system,
 				BT_BUS_NAME, BT_PATH,
 				BT_MANAGER_IFACE, "DefaultAdapter",
 				manager_reply, callback,
 				DBUS_TYPE_INVALID);
+	}
+
 	if (!req) {
 		session_unref(session);
 		g_free(callback);
-- 
1.7.4.1

