Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/2] neard: Refactor request_oob function
Date: Sat, 18 Jan 2014 13:43:00 +0100
Message-Id: <1390048980-16670-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390048980-16670-1-git-send-email-szymon.janc@gmail.com>
References: <1390048980-16670-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes function flow easier to follow.
---
 plugins/neard.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index da6e37c..b546750 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -768,42 +768,39 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 	if (err < 0)
 		return error_reply(msg, -err);
 
-	if (bacmp(&remote.address, BDADDR_ANY) == 0)
-		goto read_local;
-
-	device = btd_adapter_get_device(adapter, &remote.address,
-								BDADDR_BREDR);
+	if (bacmp(&remote.address, BDADDR_ANY) == 0) {
+		if (btd_adapter_get_powered(adapter))
+			goto read_local;
 
-	err = check_device(device);
-	if (err < 0) {
-		free_oob_params(&remote);
+		goto done;
+	}
 
-		if (err == -EALREADY)
-			return create_request_oob_reply(adapter, NULL, NULL,
-									msg);
+	device = btd_adapter_get_device(adapter, &remote.address, BDADDR_BREDR);
 
-		return error_reply(msg, -err);
-	}
+	err = check_device(device);
+	if (err < 0)
+		goto done;
 
 	if (!btd_adapter_get_pairable(adapter)) {
-		free_oob_params(&remote);
-
-		return error_reply(msg, ENONET);
+		err = -ENONET;
+		goto done;
 	}
 
 	store_params(adapter, device, &remote);
 
-	if (!remote.hash || !btd_adapter_get_powered(adapter)) {
-		free_oob_params(&remote);
-		return create_request_oob_reply(adapter, NULL, NULL, msg);
-	}
+	if (remote.hash && btd_adapter_get_powered(adapter))
+		goto read_local;
+done:
+	free_oob_params(&remote);
+
+	if (err < 0 && err != -EALREADY)
+		return error_reply(msg, -err);
+
+	return create_request_oob_reply(adapter, NULL, NULL, msg);
 
 read_local:
 	free_oob_params(&remote);
 
-	if (!btd_adapter_get_powered(adapter))
-		return create_request_oob_reply(adapter, NULL, NULL, msg);
-
 	err = btd_adapter_read_local_oob_data(adapter);
 	if (err < 0)
 		return error_reply(msg, -err);
-- 
1.8.5.3

