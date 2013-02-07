Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/14] neard: Use bool instead of gboolean for agent_register_postpone
Date: Thu, 7 Feb 2013 09:14:01 +0100
Message-ID: <1360224844-12280-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to use gboolean as this flag is not used with any
glib function.
---
 plugins/neard.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 9351ac5..b3ba2b0 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -50,7 +50,7 @@
 
 static guint watcher_id = 0;
 static char *neard_path = NULL;
-static gboolean agent_register_postpone = FALSE;
+static bool agent_register_postpone = false;
 
 /* For NFC mimetype limits max OOB EIR size */
 #define NFC_OOB_EIR_MAX UINT8_MAX
@@ -242,7 +242,7 @@ static void read_local_complete(struct btd_adapter *adapter,
 		dbus_message_unref(msg);
 
 		if (agent_register_postpone) {
-			agent_register_postpone = FALSE;
+			agent_register_postpone = false;
 			register_agent();
 		}
 
@@ -274,7 +274,7 @@ static void bonding_complete(struct btd_adapter *adapter,
 		dbus_message_unref(msg);
 
 		if (agent_register_postpone) {
-			agent_register_postpone = FALSE;
+			agent_register_postpone = false;
 			register_agent();
 		}
 
@@ -829,7 +829,7 @@ static void neard_appeared(DBusConnection *conn, void *user_data)
 	adapter = btd_adapter_get_default();
 
 	if (adapter && btd_adapter_check_oob_handler(adapter))
-		agent_register_postpone = TRUE;
+		agent_register_postpone = true;
 	else
 		register_agent();
 }
-- 
1.8.1.1

