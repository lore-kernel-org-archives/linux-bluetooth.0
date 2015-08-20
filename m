Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  1/2] test: Add sample media player properties
Date: Thu, 20 Aug 2015 14:33:09 +0530
Message-id: <1440061390-32664-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Polulates media player properties with player name, type,
sub-type and features with sample values.
---
 test/simple-player | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/test/simple-player b/test/simple-player
index a8ae0b1..a89767a 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -43,6 +43,10 @@ class Player(dbus.service.Object):
 
 			self.properties = dbus.Dictionary({
 					"PlaybackStatus" : "playing",
+					"DisplayName" : "SimplePlayer",
+					"Type" : "Audio",
+					"SubType" : "Audio Book",
+					"Features" : "0000000000b701ef0200000000000000",
 					"LoopStatus" : "None",
 					"Rate" : dbus.Double(1.0),
 					"Shuffle" : dbus.Boolean(False),
-- 
1.9.1

