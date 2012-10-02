Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] agent: Remote not used variables from pincode_reply
Date: Tue, 2 Oct 2012 11:33:12 +0200
Message-ID: <1349170392-16498-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349170392-16498-1-git-send-email-szymon.janc@tieto.com>
References: <1349170392-16498-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

adapter and sba are not used later in function code.

---
 src/agent.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 8cf37b1..e206c56 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -355,16 +355,12 @@ static void pincode_reply(DBusPendingCall *call, void *user_data)
 {
 	struct agent_request *req = user_data;
 	struct agent *agent = req->agent;
-	struct btd_adapter *adapter = agent->adapter;
 	agent_pincode_cb cb = req->cb;
 	DBusMessage *message;
 	DBusError err;
-	bdaddr_t sba;
 	size_t len;
 	char *pin;
 
-	adapter_get_address(adapter, &sba);
-
 	/* steal_reply will always return non-NULL since the callback
 	 * is only called after a reply has been received */
 	message = dbus_pending_call_steal_reply(call);
-- 
1.7.9.5

