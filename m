Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Samuel Ortiz <sameo@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] neard: Fix reading local OOB data when adapter is not powered
Date: Mon, 6 May 2013 15:20:52 +0200
Message-ID: <1367846452-23303-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1367846452-23303-1-git-send-email-szymon.janc@tieto.com>
References: <1367846452-23303-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Read Local OOB data only if adapter is powered. This fix replying with
error instead of CPS set to inactive when adapter is not powered.
---
 plugins/neard.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index dfe4f23..e4a4d71 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -790,7 +790,7 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 
 	store_params(adapter, device, &remote);
 
-	if (!remote.hash) {
+	if (!remote.hash || !btd_adapter_get_powered(adapter)) {
 		free_oob_params(&remote);
 		return create_request_oob_reply(adapter, NULL, NULL, msg);
 	}
@@ -798,6 +798,9 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 read_local:
 	free_oob_params(&remote);
 
+	if (!btd_adapter_get_powered(adapter))
+		return create_request_oob_reply(adapter, NULL, NULL, msg);
+
 	err = btd_adapter_read_local_oob_data(adapter);
 	if (err < 0)
 		return error_reply(msg, -err);
-- 
1.8.2.2

