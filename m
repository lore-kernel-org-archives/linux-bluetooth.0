Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] neard: Fix passing negative error code to strerror
Date: Tue, 29 Jan 2013 09:54:30 +0100
Message-ID: <1359449671-14584-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

error_reply expects non-negative error code.
---
 plugins/neard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 380eddc..a68500a 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -636,7 +636,7 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 
 	agent = adapter_get_agent(adapter);
 	if (!agent)
-		return error_reply(msg, -ENONET);
+		return error_reply(msg, ENONET);
 
 	io_cap = agent_get_io_capability(agent);
 	agent_unref(agent);
-- 
1.8.1.1

