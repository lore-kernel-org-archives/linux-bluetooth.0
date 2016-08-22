Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/device: Fix marking auto-connect flag
Date: Mon, 22 Aug 2016 13:08:38 +0300
Message-Id: <1471860518-28875-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device auto-connect shall be set only if the profile is able to accept
incoming connections, this fixes the wrong behavior or connecting LE
with dual mode devices immediatelly after probing service as profiles
may have auto-connect flag for outgoing connection (usually BR/EDR only).
---
 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index c103bb2..14de7e8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4080,7 +4080,10 @@ static struct btd_service *probe_service(struct btd_device *device,
 		return NULL;
 	}
 
-	if (profile->auto_connect)
+	/* Only set auto connect if profile has set the flag and can really
+	 * accept connections.
+	 */
+	if (profile->auto_connect && profile->accept)
 		device_set_auto_connect(device, TRUE);
 
 	return service;
-- 
2.7.4

