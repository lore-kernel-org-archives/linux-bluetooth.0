Return-Path: <cyrus@holtmann.org>
From: jprvita@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH BlueZ 3/3] audio: Remove unused constants
Date: Fri, 12 Apr 2013 19:34:24 -0300
Message-Id: <1365806064-12052-3-git-send-email-jprvita@gmail.com>
In-Reply-To: <1365806064-12052-1-git-send-email-jprvita@gmail.com>
References: <1365806064-12052-1-git-send-email-jprvita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: João Paulo Rechi Vita <jprvita@gmail.com>

Removes the never used constants AUDIO_SINK_INTERFACE and
AUDIO_SOURCE_INTERFACE which are defined to "org.bluez.AudioSink" and
"org.bluez.AudioSource", respectively.
---
 profiles/audio/sink.h   | 2 --
 profiles/audio/source.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index ba0dde8..7ec7610 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -22,8 +22,6 @@
  *
  */
 
-#define AUDIO_SINK_INTERFACE "org.bluez.AudioSink"
-
 typedef enum {
 	SINK_STATE_DISCONNECTED,
 	SINK_STATE_CONNECTING,
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index 61afd94..317db9a 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -23,8 +23,6 @@
  *
  */
 
-#define AUDIO_SOURCE_INTERFACE "org.bluez.AudioSource"
-
 typedef enum {
 	SOURCE_STATE_DISCONNECTED,
 	SOURCE_STATE_CONNECTING,
-- 
1.7.11.7

