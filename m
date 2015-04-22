Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] doc/gatt-api: Add encryption flag
Date: Wed, 22 Apr 2015 09:14:54 +0200
Message-Id: <1429686894-29667-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add encryption flag which can be used when registering a service to
require encryption when accessing a characteristic.
---
 doc/gatt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 088d285..92118fd 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -148,6 +148,7 @@ Properties	string UUID [read-only]
 				"authenticated-signed-writes"
 				"reliable-write"
 				"writable-auxiliaries"
+				"encryption"
 
 		array{object} Descriptors [read-only]
 
-- 
2.1.0

