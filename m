Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/4] Reverse order of calls in os_reset_session
Date: Wed,  5 Oct 2011 16:32:37 +0200
Message-Id: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This replaces:
service->get/put, mime->open, ..., service->reset, mime->close
logic, with a more appropriate:
service->get/put, mime->open, ..., mime->close, service->reset
---
 src/obex.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index d8f4648..938937c 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -284,8 +284,6 @@ static void os_session_mark_aborted(struct obex_session *os)
 static void os_reset_session(struct obex_session *os)
 {
 	os_session_mark_aborted(os);
-	if (os->service && os->service->reset)
-		os->service->reset(os, os->service_data);
 
 	if (os->object) {
 		os->driver->set_io_watch(os->object, NULL, NULL);
@@ -297,6 +295,9 @@ static void os_reset_session(struct obex_session *os)
 			os->driver->remove(os->path);
 	}
 
+	if (os->service && os->service->reset)
+		os->service->reset(os, os->service_data);
+
 	if (os->name) {
 		g_free(os->name);
 		os->name = NULL;
-- 
1.7.4.1

