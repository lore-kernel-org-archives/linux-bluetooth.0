Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/13] audio: Move to profiles directory
Date: Tue, 13 Nov 2012 15:21:19 +0200
Message-Id: <1352812880-7306-16-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
References: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am                             | 32 ++++++++++++++++----------------
 {audio => profiles/audio}/a2dp-codecs.h |  0
 {audio => profiles/audio}/a2dp.c        |  0
 {audio => profiles/audio}/a2dp.h        |  0
 {audio => profiles/audio}/audio.conf    |  0
 {audio => profiles/audio}/avctp.c       |  0
 {audio => profiles/audio}/avctp.h       |  0
 {audio => profiles/audio}/avdtp.c       |  0
 {audio => profiles/audio}/avdtp.h       |  0
 {audio => profiles/audio}/avrcp.c       |  0
 {audio => profiles/audio}/avrcp.h       |  0
 {audio => profiles/audio}/control.c     |  0
 {audio => profiles/audio}/control.h     |  0
 {audio => profiles/audio}/device.c      |  0
 {audio => profiles/audio}/device.h      |  0
 {audio => profiles/audio}/main.c        |  0
 {audio => profiles/audio}/manager.c     |  0
 {audio => profiles/audio}/manager.h     |  0
 {audio => profiles/audio}/media.c       |  0
 {audio => profiles/audio}/media.h       |  0
 {audio => profiles/audio}/player.c      |  0
 {audio => profiles/audio}/player.h      |  0
 {audio => profiles/audio}/rtp.h         |  0
 {audio => profiles/audio}/sink.c        |  0
 {audio => profiles/audio}/sink.h        |  0
 {audio => profiles/audio}/source.c      |  0
 {audio => profiles/audio}/source.h      |  0
 {audio => profiles/audio}/transport.c   |  0
 {audio => profiles/audio}/transport.h   |  0
 29 files changed, 16 insertions(+), 16 deletions(-)
 rename {audio => profiles/audio}/a2dp-codecs.h (100%)
 rename {audio => profiles/audio}/a2dp.c (100%)
 rename {audio => profiles/audio}/a2dp.h (100%)
 rename {audio => profiles/audio}/audio.conf (100%)
 rename {audio => profiles/audio}/avctp.c (100%)
 rename {audio => profiles/audio}/avctp.h (100%)
 rename {audio => profiles/audio}/avdtp.c (100%)
 rename {audio => profiles/audio}/avdtp.h (100%)
 rename {audio => profiles/audio}/avrcp.c (100%)
 rename {audio => profiles/audio}/avrcp.h (100%)
 rename {audio => profiles/audio}/control.c (100%)
 rename {audio => profiles/audio}/control.h (100%)
 rename {audio => profiles/audio}/device.c (100%)
 rename {audio => profiles/audio}/device.h (100%)
 rename {audio => profiles/audio}/main.c (100%)
 rename {audio => profiles/audio}/manager.c (100%)
 rename {audio => profiles/audio}/manager.h (100%)
 rename {audio => profiles/audio}/media.c (100%)
 rename {audio => profiles/audio}/media.h (100%)
 rename {audio => profiles/audio}/player.c (100%)
 rename {audio => profiles/audio}/player.h (100%)
 rename {audio => profiles/audio}/rtp.h (100%)
 rename {audio => profiles/audio}/sink.c (100%)
 rename {audio => profiles/audio}/sink.h (100%)
 rename {audio => profiles/audio}/source.c (100%)
 rename {audio => profiles/audio}/source.h (100%)
 rename {audio => profiles/audio}/transport.c (100%)
 rename {audio => profiles/audio}/transport.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 84ae237..10c811a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -105,20 +105,20 @@ endif
 
 if AUDIOPLUGIN
 builtin_modules += audio
-builtin_sources += audio/main.c \
-			audio/manager.h audio/manager.c \
-			audio/control.h audio/control.c \
-			audio/avctp.h audio/avctp.c \
-			audio/avrcp.h audio/avrcp.c \
-			audio/device.h audio/device.c \
-			audio/source.h audio/source.c \
-			audio/sink.h audio/sink.c \
-			audio/a2dp.h audio/a2dp.c \
-			audio/avdtp.h audio/avdtp.c \
-			audio/media.h audio/media.c \
-			audio/transport.h audio/transport.c \
-			audio/player.h audio/player.c \
-			audio/a2dp-codecs.h
+builtin_sources += profiles/audio/main.c \
+			profiles/audio/manager.h profiles/audio/manager.c \
+			profiles/audio/control.h profiles/audio/control.c \
+			profiles/audio/avctp.h profiles/audio/avctp.c \
+			profiles/audio/avrcp.h profiles/audio/avrcp.c \
+			profiles/audio/device.h profiles/audio/device.c \
+			profiles/audio/source.h profiles/audio/source.c \
+			profiles/audio/sink.h profiles/audio/sink.c \
+			profiles/audio/a2dp.h profiles/audio/a2dp.c \
+			profiles/audio/avdtp.h profiles/audio/avdtp.c \
+			profiles/audio/media.h profiles/audio/media.c \
+			profiles/audio/transport.h profiles/audio/transport.c \
+			profiles/audio/player.h profiles/audio/player.c \
+			profiles/audio/a2dp-codecs.h
 endif
 
 if SAPPLUGIN
@@ -305,7 +305,7 @@ endif
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf src/org.bluez.service \
 			src/main.conf profiles/network/network.conf \
 			profiles/input/input.conf profiles/proximity/proximity.conf \
-			audio/audio.conf \
+			profiles/audio/audio.conf \
 			profiles/sap/sap-dummy.c profiles/sap/sap-u8500.c
 
 include Makefile.tools
@@ -347,7 +347,7 @@ EXTRA_DIST += doc/manager-api.txt \
 AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
 AM_CPPFLAGS = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
-			-I$(srcdir)/audio -I$(srcdir)/gdbus \
+			-I$(srcdir)/profiles/audio -I$(srcdir)/gdbus \
 			-I$(srcdir)/attrib -I$(srcdir)/btio -I$(srcdir)/tools \
 			-I$(builddir)/tools -I$(srcdir)/monitor
 
diff --git a/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
similarity index 100%
rename from audio/a2dp-codecs.h
rename to profiles/audio/a2dp-codecs.h
diff --git a/audio/a2dp.c b/profiles/audio/a2dp.c
similarity index 100%
rename from audio/a2dp.c
rename to profiles/audio/a2dp.c
diff --git a/audio/a2dp.h b/profiles/audio/a2dp.h
similarity index 100%
rename from audio/a2dp.h
rename to profiles/audio/a2dp.h
diff --git a/audio/audio.conf b/profiles/audio/audio.conf
similarity index 100%
rename from audio/audio.conf
rename to profiles/audio/audio.conf
diff --git a/audio/avctp.c b/profiles/audio/avctp.c
similarity index 100%
rename from audio/avctp.c
rename to profiles/audio/avctp.c
diff --git a/audio/avctp.h b/profiles/audio/avctp.h
similarity index 100%
rename from audio/avctp.h
rename to profiles/audio/avctp.h
diff --git a/audio/avdtp.c b/profiles/audio/avdtp.c
similarity index 100%
rename from audio/avdtp.c
rename to profiles/audio/avdtp.c
diff --git a/audio/avdtp.h b/profiles/audio/avdtp.h
similarity index 100%
rename from audio/avdtp.h
rename to profiles/audio/avdtp.h
diff --git a/audio/avrcp.c b/profiles/audio/avrcp.c
similarity index 100%
rename from audio/avrcp.c
rename to profiles/audio/avrcp.c
diff --git a/audio/avrcp.h b/profiles/audio/avrcp.h
similarity index 100%
rename from audio/avrcp.h
rename to profiles/audio/avrcp.h
diff --git a/audio/control.c b/profiles/audio/control.c
similarity index 100%
rename from audio/control.c
rename to profiles/audio/control.c
diff --git a/audio/control.h b/profiles/audio/control.h
similarity index 100%
rename from audio/control.h
rename to profiles/audio/control.h
diff --git a/audio/device.c b/profiles/audio/device.c
similarity index 100%
rename from audio/device.c
rename to profiles/audio/device.c
diff --git a/audio/device.h b/profiles/audio/device.h
similarity index 100%
rename from audio/device.h
rename to profiles/audio/device.h
diff --git a/audio/main.c b/profiles/audio/main.c
similarity index 100%
rename from audio/main.c
rename to profiles/audio/main.c
diff --git a/audio/manager.c b/profiles/audio/manager.c
similarity index 100%
rename from audio/manager.c
rename to profiles/audio/manager.c
diff --git a/audio/manager.h b/profiles/audio/manager.h
similarity index 100%
rename from audio/manager.h
rename to profiles/audio/manager.h
diff --git a/audio/media.c b/profiles/audio/media.c
similarity index 100%
rename from audio/media.c
rename to profiles/audio/media.c
diff --git a/audio/media.h b/profiles/audio/media.h
similarity index 100%
rename from audio/media.h
rename to profiles/audio/media.h
diff --git a/audio/player.c b/profiles/audio/player.c
similarity index 100%
rename from audio/player.c
rename to profiles/audio/player.c
diff --git a/audio/player.h b/profiles/audio/player.h
similarity index 100%
rename from audio/player.h
rename to profiles/audio/player.h
diff --git a/audio/rtp.h b/profiles/audio/rtp.h
similarity index 100%
rename from audio/rtp.h
rename to profiles/audio/rtp.h
diff --git a/audio/sink.c b/profiles/audio/sink.c
similarity index 100%
rename from audio/sink.c
rename to profiles/audio/sink.c
diff --git a/audio/sink.h b/profiles/audio/sink.h
similarity index 100%
rename from audio/sink.h
rename to profiles/audio/sink.h
diff --git a/audio/source.c b/profiles/audio/source.c
similarity index 100%
rename from audio/source.c
rename to profiles/audio/source.c
diff --git a/audio/source.h b/profiles/audio/source.h
similarity index 100%
rename from audio/source.h
rename to profiles/audio/source.h
diff --git a/audio/transport.c b/profiles/audio/transport.c
similarity index 100%
rename from audio/transport.c
rename to profiles/audio/transport.c
diff --git a/audio/transport.h b/profiles/audio/transport.h
similarity index 100%
rename from audio/transport.h
rename to profiles/audio/transport.h
-- 
1.7.11.7

