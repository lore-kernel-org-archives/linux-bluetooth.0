Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] audio: Remove audio.conf
Date: Tue, 23 Jul 2013 18:01:26 +0300
Message-Id: <1374591686-22646-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1374591686-22646-1-git-send-email-luiz.dentz@gmail.com>
References: <1374591686-22646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With the audio plugin split there is no longer a need to have a .conf
file and anyway any configuration should be put in main.conf under
plugin name group.
---
 profiles/audio/audio.conf | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 profiles/audio/audio.conf

diff --git a/profiles/audio/audio.conf b/profiles/audio/audio.conf
deleted file mode 100644
index 067b3fc..0000000
--- a/profiles/audio/audio.conf
+++ /dev/null
@@ -1,8 +0,0 @@
-# Configuration file for the audio service
-
-# This section contains options which are not specific to any
-# particular interface
-[General]
-
-# Switch to master role for incoming connections (defaults to true)
-#Master=true
-- 
1.8.3.1

