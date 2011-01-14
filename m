Return-Path: <cyrus@holtmann.org>
From: lkslawek@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCHv2] Fix plugin close & disconnect functions call order
Date: Fri, 14 Jan 2011 11:04:05 +0100
Message-Id: <1294999445-3768-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Slawomir Bochenski <lkslawek@gmail.com>

Normally during an OBEX session, calling sequence

service->connect - [driver->open - driver->close]* - service->disconnect

is kept. The only exception to this when the connection is reset
(when no ABORT was sent) during transfer. Then the sequence is:

service->connect - [driver->open - driver->close]* - driver->open -
service->disconnect - driver->close

This patch fixes it, so memory managament of session/transfer data in
service plugin can be easier.
---
 src/obex.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 65f17fc..e45ed74 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -317,8 +317,6 @@ static void obex_session_free(struct obex_session *os)
 {
 	sessions = g_slist_remove(sessions, os);
 
-	os_reset_session(os);
-
 	if (os->io)
 		g_io_channel_unref(os->io);
 
@@ -1231,6 +1229,8 @@ static void obex_handle_destroy(void *user_data)
 
 	os = OBEX_GetUserData(obex);
 
+	os_reset_session(os);
+
 	if (os->service && os->service->disconnect)
 		os->service->disconnect(os, os->service_data);
 
-- 
1.7.1

