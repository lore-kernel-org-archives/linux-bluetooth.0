Return-Path: <cyrus@holtmann.org>
From: Rafael Fonseca <fonsecasantos.rafael@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Update comment in the audio.conf file.
Date: Wed,  6 Jun 2012 00:05:35 -0300
Message-Id: <1338951935-10388-1-git-send-email-fonsecasantos.rafael@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The config file erroneously said that all services were available by default.
Actually Gateway, Source and Socket are disabled.
---
 audio/audio.conf |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index fd6092a..b6e5507 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -8,7 +8,7 @@
 #Master=true
 
 # If we want to disable support for specific services
-# Defaults to supporting all implemented services
+# Defaults to supporting the services: HFP, Headset, Sink, Control and Media
 #Disable=Gateway,Source,Socket
 
 # SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
-- 
1.7.10.3

