Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 08/11] Set auto connect from maemo6 plugin
Date: Mon, 26 Sep 2011 14:48:25 -0300
Message-Id: <1317059308-20038-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Inform the adapter that the system has been unlocked when the MCE
sends the tklock_mode_ind signal. This signal will trigger the
automatic re-connections for the devices selected by the profiles.
Profiles register ATTIO callbacks to indicate that ATT connection
is required.
---
 plugins/maemo6.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/maemo6.c b/plugins/maemo6.c
index e380acd..6c34116 100644
--- a/plugins/maemo6.c
+++ b/plugins/maemo6.c
@@ -57,6 +57,7 @@ static gboolean mce_bt_on = FALSE;
 static gboolean mce_tklock_mode_cb(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
+	struct btd_adapter *adapter = user_data;
 	DBusMessageIter args;
 	const char *sigvalue;
 
@@ -68,6 +69,9 @@ static gboolean mce_tklock_mode_cb(DBusConnection *connection,
 
 		dbus_message_iter_get_basic(&args, &sigvalue);
 		DBG("got signal with value %s", sigvalue);
+
+		if (g_strcmp0("unlocked", sigvalue) == 0 && mce_bt_on)
+			btd_adapter_enable_auto_connect(adapter);
 	}
 
 	return TRUE;
-- 
1.7.6.1

