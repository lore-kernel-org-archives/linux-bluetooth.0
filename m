Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] obexd/src/manager: Fix the double check for agent
Date: Fri, 19 Sep 2014 18:15:19 +0530
Message-id: <1411130719-15832-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removes the check for NULL agent and fix the 
coding style for enum.
---
agent_free() function contains the NULL check already.
---
 obexd/src/manager.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 326e56f..9c6623e 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -64,7 +64,7 @@ struct agent {
 };
 
 enum {
-	TRANSFER_STATUS_QUEUED = 0,
+	TRANSFER_STATUS_QUEUED = 	0,
 	TRANSFER_STATUS_ACTIVE,
 	TRANSFER_STATUS_COMPLETE,
 	TRANSFER_STATUS_ERROR
@@ -521,8 +521,7 @@ void manager_cleanup(void)
 
 	/* FIXME: Release agent? */
 
-	if (agent)
-		agent_free(agent);
+	agent_free(agent);
 
 	g_dbus_detach_object_manager(connection);
 
-- 
1.9.1

