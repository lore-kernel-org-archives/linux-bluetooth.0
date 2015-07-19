Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, Dohyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH BLUEZ 3/4] doc/health-api: Remove ChannelConnected and ChannelDeleted signals
Date: Mon, 20 Jul 2015 00:31:10 +0900
Message-Id: <1437319871-3004-4-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
References: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These signals are no longer available since BlueZ uses ObjectManager
interface. Instead of these signals InterfaceAdded and PropertiesChanged
(connected) signals can be used.
---
 doc/health-api.txt | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/doc/health-api.txt b/doc/health-api.txt
index 8d4aa72..be82dd0 100644
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
@@ -155,4 +142,4 @@ Properties	string Type [readonly]
 
 			Indicates if the HealthChannel is currently connected.
 			A PropertiesChanged signal indicate changes to this
-			status
\ No newline at end of file
+			status
-- 
1.8.1.2

