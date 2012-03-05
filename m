Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH 1/3] mgmtops: When settings discoverable also set connectable if not set yet
Date: Mon,  5 Mar 2012 20:05:23 +0100
Message-Id: <1330974325-4071-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Otherwise command would be rejected e.g. when setting discoverable at
bluetoothd startup.
---
 plugins/mgmtops.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 89355ad..afed165 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -317,12 +317,15 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 
 	info = &controllers[index];
 
-	if (on_mode == MODE_DISCOVERABLE && !mgmt_discoverable(settings))
+	if (on_mode == MODE_DISCOVERABLE && !mgmt_discoverable(settings)) {
+		if(!mgmt_connectable(settings))
+			mgmt_set_connectable(index, TRUE);
 		mgmt_set_discoverable(index, TRUE, discoverable_timeout);
-	else if (on_mode == MODE_CONNECTABLE && !mgmt_connectable(settings))
+	} else if (on_mode == MODE_CONNECTABLE && !mgmt_connectable(settings)) {
 		mgmt_set_connectable(index, TRUE);
-	else if (mgmt_powered(settings))
+	} else if (mgmt_powered(settings)) {
 		adapter_mode_changed(adapter, create_mode(settings));
+	}
 
 	if (mgmt_pairable(settings) != pairable)
 		mgmt_set_pairable(index, pairable);
-- 
1.7.9.1


