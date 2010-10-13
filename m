Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Adjust mce_bt_set flag to gboolean type values
Date: Wed, 13 Oct 2010 15:08:20 +0200
Message-Id: <1286975300-2832-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes assignment to mce_bt_set flag more readable and makes
sure that it takes only TRUE or FALSE value from gboolean type.
---
 plugins/maemo6.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/maemo6.c b/plugins/maemo6.c
index c396db0..0a1e551 100644
--- a/plugins/maemo6.c
+++ b/plugins/maemo6.c
@@ -71,7 +71,8 @@ static gboolean mce_signal_callback(DBusConnection *connection,
 
 		/* set the adapter according to the mce signal
 		   and remember the value */
-		mce_bt_set = !!(sigvalue & MCE_RADIO_STATE_BLUETOOTH);
+		mce_bt_set = sigvalue & MCE_RADIO_STATE_BLUETOOTH ?
+								TRUE : FALSE;
 
 		if (mce_bt_set)
 			btd_adapter_switch_online(adapter);
@@ -111,7 +112,7 @@ static void read_radio_states_cb(DBusPendingCall *call, void *user_data)
 
 	DBG("radio_states: %d", radio_states);
 
-	mce_bt_set = radio_states & MCE_RADIO_STATE_BLUETOOTH;
+	mce_bt_set = radio_states & MCE_RADIO_STATE_BLUETOOTH ? TRUE : FALSE;
 
 	/* check if the adapter has not completed the initial power
 	 * cycle, if so delay action to mce_notify_powered */
-- 
1.6.3.3

