Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH] media: Fix some wrong interface names
Date: Thu,  6 Dec 2012 08:25:50 +0100
Message-Id: <1354778750-13214-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Trivially fix some wrong interface names introduced by commit
3aa15b56dca27a73f6bc34467ba0ce4c85ee2d9a.
---
 doc/media-api.txt      | 4 ++--
 profiles/audio/media.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index ce7502a..1865df9 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -128,7 +128,7 @@ MediaPlayer1 hierarchy
 
 Service		unique name (Target role)
 		org.bluez (Controller role)
-Interface	org.bluez.Media1Player1
+Interface	org.bluez.MediaPlayer1
 Object path	freely definable (Target role)
 		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
 		(Controller role)
@@ -223,7 +223,7 @@ MediaEndpoint1 hierarchy
 ========================
 
 Service		unique name
-Interface	org.bluez.Media1Endpoint1
+Interface	org.bluez.MediaEndpoint1
 Object path	freely definable
 
 Methods		void SetConfiguration(object transport, dict properties)
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 61c1f03..4c5d38b 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -47,7 +47,7 @@
 #include "manager.h"
 
 #define MEDIA_INTERFACE "org.bluez.Media1"
-#define MEDIA_ENDPOINT_INTERFACE "org.bluez.Media1Endpoint1"
+#define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
 
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
-- 
1.7.11.7

