Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Fix Discoverable mode is not updated on storage.
Date: Mon, 27 Aug 2012 18:19:52 +0900
Message-id: <1346059192-6114-1-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <50321EA8.5000504@samsung.com>
References: <50321EA8.5000504@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

This patch fixes the problem that storage's Discoverable value is
not updated like hciconfig when BlueZ receives the MGMT adapter mode
changed event after DiscoverableTimeout has been expired.
---
 src/adapter.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 69ec821..673cee8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2249,6 +2249,11 @@ static void set_mode_complete(struct btd_adapter *adapter)
 		adapter->mode_sessions = NULL;
 	}
 
+	modestr = mode2str(adapter->mode);
+	write_device_mode(&adapter->bdaddr, modestr);
+
+	DBG("%s", modestr);
+
 	if (adapter->pending_mode == NULL)
 		return;
 
@@ -2273,10 +2278,6 @@ static void set_mode_complete(struct btd_adapter *adapter)
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

