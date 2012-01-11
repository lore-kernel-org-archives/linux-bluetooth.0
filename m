Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd 1/2] Fix incorrect transfer path id during request
 authorization
Date: Wed, 11 Jan 2012 20:33:42 +0530
Message-id: <1326294222-21234-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Transfer is registered with id as cid, but authorize method
is called with id as pointer to obex session structure
---
 src/manager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 846f8a0..87010c4 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -539,7 +539,7 @@ int manager_request_authorization(struct obex_session *os, int32_t time,
 	if (err < 0)
 		return err;
 
-	path = g_strdup_printf("/transfer%u", GPOINTER_TO_UINT(os));
+	path = g_strdup_printf("/transfer%u", os->id);
 
 	msg = dbus_message_new_method_call(agent->bus_name, agent->path,
 					"org.openobex.Agent", "Authorize");
-- 
1.7.1

