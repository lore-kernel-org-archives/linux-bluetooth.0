Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/14] neard: Check if adapter is powered in PushOOB
Date: Thu, 7 Feb 2013 09:13:56 +0100
Message-ID: <1360224844-12280-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For PushOOB adapter needs to be powered as bluetoothd daemon is
expected to perform action on success.
---
 plugins/neard.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/neard.c b/plugins/neard.c
index 131e8bd..0418430 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -629,6 +629,9 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 	if (err < 0)
 		return error_reply(msg, -err);
 
+	if (!btd_adapter_get_powered(adapter))
+		return error_reply(msg, ENONET);
+
 	agent = adapter_get_agent(adapter);
 	if (!agent)
 		return error_reply(msg, ENONET);
-- 
1.8.1.1

