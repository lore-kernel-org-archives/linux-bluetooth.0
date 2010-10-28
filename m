Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Fix issue when setting limited discoverable mode
Date: Thu, 28 Oct 2010 11:00:55 +0300
Message-Id: <1288252859-10337-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When setting limited discoverable mode it will always switch to
discoverable on adapter_mode_changed which doesn't match the pending mode
requested.
---
 src/adapter.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4a9f34e..98d96e2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3225,9 +3225,10 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 					DBUS_TYPE_BOOLEAN, &pairable);
 
 	if (discoverable && adapter->pairable && adapter->discov_timeout > 0 &&
-						adapter->discov_timeout <= 60)
+						adapter->discov_timeout <= 60) {
+		adapter->mode = MODE_LIMITED;
 		adapter_set_limited_discoverable(adapter, TRUE);
-	else if (!discoverable)
+	} else if (!discoverable)
 		adapter_set_limited_discoverable(adapter, FALSE);
 
 	emit_property_changed(connection, path,
-- 
1.7.1

