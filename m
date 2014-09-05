Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] core: Fix concurrent authorizations
Date: Fri,  5 Sep 2014 15:49:12 +0300
Message-Id: <1409921352-28485-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409921352-28485-1-git-send-email-luiz.dentz@gmail.com>
References: <1409921352-28485-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case multiple authorizations happen it can trigger a second call to
agent_authorize_service while the first is still ongoing causing all
authorization to fail.
---
 src/adapter.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index f9c58af..2192e90 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4964,6 +4964,16 @@ static void agent_auth_cb(struct agent *agent, DBusError *derr,
 
 	g_free(auth);
 
+	/* Stop processing if queue is empty */
+	if (g_queue_is_empty(adapter->auths)) {
+		if (adapter->auth_idle_id > 0)
+			g_source_remove(adapter->auth_idle_id);
+		return;
+	}
+
+	if (adapter->auth_idle_id > 0)
+		return;
+
 	adapter->auth_idle_id = g_idle_add(process_auth_queue, adapter);
 }
 
@@ -4991,6 +5001,10 @@ static gboolean process_auth_queue(gpointer user_data)
 			goto next;
 		}
 
+		/* If agent is set authorization is already ongoing */
+		if (auth->agent)
+			return FALSE;
+
 		auth->agent = agent_get(NULL);
 		if (auth->agent == NULL) {
 			warn("Authentication attempt without agent");
-- 
1.9.3

