Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] obexd: Re-add D-Bus session properties
Date: Fri, 28 Jun 2013 12:16:07 +0200
Message-Id: <1372414567-994-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This got lost when switching to org.freedesktop.DBus.Properties.
---
 obexd/client/session.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 8d32ed0..d971982 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -856,7 +856,8 @@ const char *obc_session_register(struct obc_session *session,
 
 	if (g_dbus_register_interface(session->conn, session->path,
 					SESSION_INTERFACE, session_methods,
-					NULL, NULL, session, destroy) == FALSE)
+					NULL, session_properties, session,
+					destroy) == FALSE)
 		goto fail;
 
 	if (session->driver->probe && session->driver->probe(session) < 0) {
-- 
1.8.3.1

