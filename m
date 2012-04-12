Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH obexd 2/4] src: Use goto for avoiding code duplication
Date: Thu, 12 Apr 2012 20:33:13 +0530
Message-id: <1334243001-17016-23-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/manager.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 87010c4..b9786ad 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -607,8 +607,7 @@ void manager_register_session(struct obex_session *os)
 				session_methods, NULL,
 				NULL, os, NULL)) {
 		error("Cannot register Session interface.");
-		g_free(path);
-		return;
+		goto done;
 	}
 
 	g_dbus_emit_signal(connection, OPENOBEX_MANAGER_PATH,
@@ -616,6 +615,7 @@ void manager_register_session(struct obex_session *os)
 			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_INVALID);
 
+done:
 	g_free(path);
 }
 
-- 
1.7.4.1

