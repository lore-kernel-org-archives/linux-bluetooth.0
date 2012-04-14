Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Cc: chanyeol.park@samsung.com
Subject: [PATCH 1/1] Fix default disabled values in audio.conf
Date: Sat, 14 Apr 2012 14:43:24 +0900
Message-id: <1334382204-17937-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

Disabled features in audio.conf should be the same with source code
"audio/manager.c:struct enabled_interfaces enabled".
---
 audio/audio.conf |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index 1bcc85c..fd6092a 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -9,7 +9,7 @@
 
 # If we want to disable support for specific services
 # Defaults to supporting all implemented services
-#Disable=Control,Source
+#Disable=Gateway,Source,Socket
 
 # SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
 # Defaults to HCI
-- 
1.7.5.4

