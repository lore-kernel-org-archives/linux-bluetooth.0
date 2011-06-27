Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 6/6] Code clean-up: remove unnecessary brackets
Date: Tue, 28 Jun 2011 00:39:41 +0300
Message-Id: <1309210781-2674-7-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1309210781-2674-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1309210781-2674-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/session.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/client/session.c b/client/session.c
index d8e3bf2..ae7e213 100644
--- a/client/session.c
+++ b/client/session.c
@@ -241,9 +241,8 @@ static void session_free(struct session_data *session)
 	if (session->path)
 		session_unregistered(session);
 
-	if (session->conn) {
+	if (session->conn)
 		dbus_connection_unref(session->conn);
-	}
 
 	if (session->conn_system)
 		dbus_connection_unref(session->conn_system);
-- 
1.7.4.1

