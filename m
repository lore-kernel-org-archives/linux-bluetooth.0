Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 1/2] build: Fix typo in AM_CFLAGS
Date: Wed,  9 May 2012 09:06:16 -0300
Message-Id: <1336565177-1532-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 44e82c0..1d8eea2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -348,7 +348,7 @@ audio_libasound_module_ctl_bluetooth_la_SOURCES = audio/ctl_bluetooth.c \
 audio_libasound_module_ctl_bluetooth_la_LDFLAGS = -module -avoid-version #-export-symbols-regex [_]*snd_ctl_.*
 audio_libasound_module_ctl_bluetooth_la_LIBADD = \
 					lib/libbluetooth-private.la @ALSA_LIBS@
-audio_libasound_module_ctl_bluetooth_la_CFLAGS = $(AM_CLAGS) @ALSA_CFLAGS@
+audio_libasound_module_ctl_bluetooth_la_CFLAGS = $(AM_CFLAGS) @ALSA_CFLAGS@
 
 if DATAFILES
 alsaconfdir = $(datadir)/alsa
-- 
1.7.10.1

