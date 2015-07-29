Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <dh79.pyun@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, Dohyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH BLUEZ v2 1/2] doc/health-api: Remove ChannelConnected and
 ChannelDeleted signals
Date: Wed, 29 Jul 2015 10:23:17 +0900
Message-id: <1438132998-13784-2-git-send-email-dh79.pyun@samsung.com>
In-reply-to: <1438132998-13784-1-git-send-email-dh79.pyun@samsung.com>
References: <1438132998-13784-1-git-send-email-dh79.pyun@samsung.com>
In-reply-to: <1437319871-3004-1-git-send-email-dh79.pyun () samsung ! com>
References: <1437319871-3004-1-git-send-email-dh79.pyun () samsung ! com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These signals are no longer available since BlueZ uses ObjectManager
interface. Instead of these signals InterfaceAdded and InterfaceRemoved
signals(org.bluez.HealthChannel1 interface) can be used.
---
 doc/health-api.txt | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/doc/health-api.txt b/doc/health-api.txt
index 2c48ff2..f7af4f2 100644
--- a/doc/health-api.txt
+++ b/doc/health-api.txt
@@ -87,19 +87,6 @@ Methods		boolean Echo()
 					 org.bluez.Error.NotFound
 				         org.bluez.Error.NotAllowed
 
-Signals		void ChannelConnected(object channel)
-
-			This signal is launched when a new data channel is
-			created or when a known data channel is reconnected.
-
-		void ChannelDeleted(object channel)
-
-			This signal is launched when a data channel is deleted.
-
-			After this signal the data channel path will not be
-			valid and its path can be reused for future data
-			channels.
-
 Properties	object MainChannel [readonly]
 
 			The first reliable channel opened. It is needed by
-- 
1.8.1.2

