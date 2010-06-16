Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>
Date: Wed, 16 Jun 2010 11:53:38 +0300
Subject: [PATCH] Don't handle Changed Combination Link Key for a temporary
 keys.
Message-ID: <99B09243E1A5DA4898CDD8B70011144809696FDFB0@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patch on behalf of ST-Ericsson SA

This patch prevents from storing Changed Combination Link Key type
for temporary keys.  Getting Changed Combination Link Key remote
auth requirements are already set to 0xff (bonding has finished)
and that lets the system to store the key type of Changed
Combination (0x06). For temporary keys we don't have to care about
Change Link Key event.
---
 src/dbus-hci.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 19748a7..a3fd557 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -681,12 +681,19 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 			old_key_type = 0x03;
 		if (old_key_type != 0xff)
 			new_key_type = old_key_type;
+		else
+			/* This is Changed Combination Link Key for
+			 * a temporary link key.*/
+			return 0;
 	}
 
 	get_auth_requirements(local, peer, &local_auth);
 	remote_auth = device_get_auth(device);
 	bonding = device_is_bonding(device, NULL);
 
+	DBG("key type 0x%02x old key type 0x%02x new key type 0x%02x",
+					key_type, old_key_type, new_key_type);
+
 	DBG("local auth 0x%02x and remote auth 0x%02x",
 					local_auth, remote_auth);
 
-- 
1.7.0.4
 
