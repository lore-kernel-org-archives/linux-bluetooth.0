Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v3] obexd/src/manager: Fix the double check for agent
Date: Mon, 22 Sep 2014 12:42:08 +0530
Message-id: <1411369928-14307-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removes the check for NULL agent.
---
agent_free() function contains the NULL check already.
---
 obexd/src/manager.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 326e56f..97ae278 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -521,8 +521,7 @@ void manager_cleanup(void)
 
 	/* FIXME: Release agent? */
 
-	if (agent)
-		agent_free(agent);
+	agent_free(agent);
 
 	g_dbus_detach_object_manager(connection);
 
-- 
1.9.1

