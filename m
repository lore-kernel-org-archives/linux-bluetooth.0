Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, Dohyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH BLUEZ 1/4] doc/health-api: Add Connected property to HealthChannel
Date: Mon, 20 Jul 2015 00:31:08 +0900
Message-Id: <1437319871-3004-2-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
References: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds Connected property description to HealthChannel.
It will be used to replace ChannelConnected and ChannelDeleted
signals. These Signals was not currently generated.
---
 doc/health-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/health-api.txt b/doc/health-api.txt
index 2c48ff2..8d4aa72 100644
--- a/doc/health-api.txt
+++ b/doc/health-api.txt
@@ -150,3 +150,9 @@ Properties	string Type [readonly]
 			Identifies the HealthApplication to which this channel
 			is related to (which indirectly defines its role and
 			data type).
+
+		boolean Connected [readonly]
+
+			Indicates if the HealthChannel is currently connected.
+			A PropertiesChanged signal indicate changes to this
+			status
\ No newline at end of file
-- 
1.8.1.2

