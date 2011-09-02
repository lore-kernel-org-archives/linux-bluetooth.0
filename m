Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 08/11] Notify unlocked event when using maemo6 plugin
Date: Fri,  2 Sep 2011 18:38:38 -0300
Message-Id: <1314999521-11261-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Inform the adapter that the system has been unlocked when the MCE
sends the tklock_mode_ind signal. This signal will trigger the
automatic re-connections for bonded devices.
---
 plugins/maemo6.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/maemo6.c b/plugins/maemo6.c
index 0247f20..8d203df 100644
--- a/plugins/maemo6.c
+++ b/plugins/maemo6.c
@@ -73,6 +73,9 @@ static void mce_tklock_mode_cb(DBusConnection *connection,
 
 	dbus_message_iter_get_basic(&args, &sigvalue);
 	DBG("got signal with value %s", sigvalue);
+
+	if (g_strcmp0("unlocked", sigvalue) == 0)
+		btd_adapter_system_unlocked(adapter);
 }
 
 static gboolean mce_signal_callback(DBusConnection *connection,
-- 
1.7.6

