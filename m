Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Write discoverable mode on storage after HCI response
Date: Wed, 08 Aug 2012 22:03:10 +0900
Message-id: <1344430990-4080-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

Right after HCI mode command is sent, Bluez writes mode value
on the storage. but in case of DiscoverableTimeout, storage value
is not updated like adapter->mode value. So this logic is moved.
---
 src/adapter.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index acb845e..1b8e3b0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -302,7 +302,6 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
 
 done:
 	modestr = mode2str(new_mode);
-	write_device_mode(&adapter->bdaddr, modestr);
 
 	DBG("%s", modestr);
 
@@ -2244,6 +2243,12 @@ static void set_mode_complete(struct btd_adapter *adapter)
 		adapter->mode_sessions = NULL;
 	}
 
+	modestr = mode2str(adapter->mode);
+
+	DBG("%s", modestr);
+
+	write_device_mode(&adapter->bdaddr, modestr);
+
 	if (adapter->pending_mode == NULL)
 		return;
 
@@ -2268,10 +2273,6 @@ static void set_mode_complete(struct btd_adapter *adapter)
 		g_dbus_send_message(connection, reply);
 	}
 
-	modestr = mode2str(adapter->mode);
-
-	DBG("%s", modestr);
-
 	/* restore if the mode doesn't matches the pending */
 	if (err != 0) {
 		write_device_mode(&adapter->bdaddr, modestr);
-- 
1.7.9.5

