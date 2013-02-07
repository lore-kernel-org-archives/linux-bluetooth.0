Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/14] neard: Move pairable check from check_adapter
Date: Thu, 7 Feb 2013 09:13:54 +0100
Message-ID: <1360224844-12280-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If device is already paired there is no need to fail with handover
if adapter is not pairable.
---
 plugins/neard.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 668c46f..131e8bd 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -579,9 +579,6 @@ static int check_adapter(struct btd_adapter *adapter)
 	if (btd_adapter_check_oob_handler(adapter))
 		return -EINPROGRESS;
 
-	if (!btd_adapter_get_pairable(adapter))
-		return -ENONET;
-
 	if (!btd_adapter_ssp_enabled(adapter))
 		return -ENOTSUP;
 
@@ -664,6 +661,12 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 		return error_reply(msg, -err);
 	}
 
+	if (!btd_adapter_get_pairable(adapter)) {
+		free_oob_params(&remote);
+
+		return error_reply(msg, ENONET);
+	}
+
 	store_params(adapter, device, &remote);
 
 	free_oob_params(&remote);
@@ -722,6 +725,12 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 		return error_reply(msg, -err);
 	}
 
+	if (!btd_adapter_get_pairable(adapter)) {
+		free_oob_params(&remote);
+
+		return error_reply(msg, ENONET);
+	}
+
 	store_params(adapter, device, &remote);
 
 	if (!remote.hash) {
-- 
1.8.1.1

