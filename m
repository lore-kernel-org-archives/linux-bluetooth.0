Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] doc/gatt-api: Add encryption flags
Date: Mon, 27 Apr 2015 16:14:28 +0300
Message-Id: <1430140475-20349-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
References: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add encryption flags which can be used when registering a service to
require encryption when accessing a characteristic.
---
 doc/gatt-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 088d285..8db35f2 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -148,6 +148,10 @@ Properties	string UUID [read-only]
 				"authenticated-signed-writes"
 				"reliable-write"
 				"writable-auxiliaries"
+				"encrypt-read"
+				"encrypt-write"
+				"encrypt-authenticated-read"
+				"encrypt-authenticated-write"
 
 		array{object} Descriptors [read-only]
 
-- 
2.1.0

