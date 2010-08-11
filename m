Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not unmarking temporary flag when a new key is created
Date: Wed, 11 Aug 2010 16:49:27 +0300
Message-Id: <1281534567-26666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Device may have been marked as temporary so when a new key is generated
that meets the requirements to be stored it should unmark temporary flag
so the device is not removed when disconnected.
---
 src/dbus-hci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 22f378d..8c1e10c 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -746,8 +746,7 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 	else if (!bonding && old_key_type == 0xff)
 		hcid_dbus_bonding_process_complete(local, peer, 0);
 
-	if (temporary)
-		device_set_temporary(device, TRUE);
+	device_set_temporary(device, temporary);
 
 	return 0;
 }
-- 
1.7.0.4

