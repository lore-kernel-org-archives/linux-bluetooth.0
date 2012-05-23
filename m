Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 10/12] adapter: Remove unwanted if check and code
Date: Wed, 23 May 2012 21:27:30 +0530
Message-id: <1337788652-23697-11-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here the variable agent never be NULL, so no need to check it
against NULL.
---
 src/adapter.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 18dd5b6..16d379c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1618,9 +1618,6 @@ static DBusMessage *register_agent(DBusConnection *conn, DBusMessage *msg,
 
 	agent = agent_create(adapter, name, path, cap,
 				(agent_remove_cb) agent_removed, adapter);
-	if (!agent)
-		return btd_error_failed(msg, "Failed to create a new agent");
-
 	adapter->agent = agent;
 
 	DBG("Agent registered for hci%d at %s:%s", adapter->dev_id, name,
-- 
1.7.4.1

