Return-Path: <cyrus@holtmann.org>
From: Zhu Yanhai <yanhai.zhu@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Zhu Yanhai <yanhai.zhu@linux.intel.com>
Subject: [PATCH] Don't pass down NULL path to dbus if no modem.
Date: Mon, 11 Jan 2010 15:36:26 +0800
Message-Id: <1263195386-15072-1-git-send-email-yanhai.zhu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We shouldn't pass down NULL object path to dbus if there's no modem,
which is a common case on many netbooks.

Signed-off-by: Zhu Yanhai <yanhai.zhu@linux.intel.com>
---
 audio/telephony-ofono.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 2778cfc..2970e43 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -579,6 +579,11 @@ static void list_modem_reply(DBusPendingCall *call, void *user_data)
 						modem_obj_path);
 		dbus_message_iter_next(&sub);
 	}
+	if (modem_obj_path == NULL)
+	{
+		debug("no modem found.\n");	
+		goto done;
+	}
 
 	ret = get_registration_and_signal_status();
 	if (ret < 0)
-- 
1.6.2.2

