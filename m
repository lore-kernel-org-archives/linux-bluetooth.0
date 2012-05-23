Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 08/12] Remove redundant D-Bus error initilization in
 maemo6 plugin
Date: Wed, 23 May 2012 21:27:28 +0530
Message-id: <1337788652-23697-9-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/maemo6.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/maemo6.c b/plugins/maemo6.c
index 6c34116..4819af4 100644
--- a/plugins/maemo6.c
+++ b/plugins/maemo6.c
@@ -130,7 +130,6 @@ static void read_radio_states_cb(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&derr);
 	if (dbus_message_get_args(reply, &derr,
 				DBUS_TYPE_UINT32, &radio_states,
 				DBUS_TYPE_INVALID) == FALSE) {
-- 
1.7.4.1

