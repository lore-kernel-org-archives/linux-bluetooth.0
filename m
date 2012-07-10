Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 3/9] input: move it to profiles folder
Date: Tue, 10 Jul 2012 11:03:02 -0300
Message-Id: <1341928988-5116-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341928988-5116-1-git-send-email-gustavo@padovan.org>
References: <1341928988-5116-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am                            |   14 +++++++-------
 {input => profiles/input}/device.c     |    0
 {input => profiles/input}/device.h     |    0
 {input => profiles/input}/fakehid.c    |    0
 {input => profiles/input}/fakehid.h    |    0
 {input => profiles/input}/hog_device.c |    0
 {input => profiles/input}/hog_device.h |    0
 {input => profiles/input}/input.conf   |    0
 {input => profiles/input}/main.c       |    0
 {input => profiles/input}/manager.c    |    0
 {input => profiles/input}/manager.h    |    0
 {input => profiles/input}/server.c     |    0
 {input => profiles/input}/server.h     |    0
 {input => profiles/input}/sixpair.c    |    0
 14 files changed, 7 insertions(+), 7 deletions(-)
 rename {input => profiles/input}/device.c (100%)
 rename {input => profiles/input}/device.h (100%)
 rename {input => profiles/input}/fakehid.c (100%)
 rename {input => profiles/input}/fakehid.h (100%)
 rename {input => profiles/input}/hog_device.c (100%)
 rename {input => profiles/input}/hog_device.h (100%)
 rename {input => profiles/input}/input.conf (100%)
 rename {input => profiles/input}/main.c (100%)
 rename {input => profiles/input}/manager.c (100%)
 rename {input => profiles/input}/manager.h (100%)
 rename {input => profiles/input}/server.c (100%)
 rename {input => profiles/input}/server.h (100%)
 rename {input => profiles/input}/sixpair.c (100%)

diff --git a/Makefile.am b/Makefile.am
index d6e93dd..a696173 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -179,16 +179,16 @@ endif
 
 if INPUTPLUGIN
 builtin_modules += input
-builtin_sources += input/main.c \
-			input/manager.h input/manager.c \
-			input/server.h input/server.c \
-			input/device.h input/device.c \
-			input/fakehid.c input/fakehid.h
+builtin_sources += profiles/input/main.c \
+			profiles/input/manager.h profiles/input/manager.c \
+			profiles/input/server.h profiles/input/server.c \
+			profiles/input/device.h profiles/input/device.c \
+			profiles/input/fakehid.c profiles/input/fakehid.h
 endif
 
 if HOGPLUGIN
 builtin_modules += hog
-builtin_sources += input/hog_device.h input/hog_device.c
+builtin_sources += profiles/input/hog_device.h profiles/input/hog_device.c
 endif
 
 if NETWORKPLUGIN
@@ -327,7 +327,7 @@ endif
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf src/org.bluez.service \
 			src/main.conf network/network.conf \
-			input/input.conf proximity/proximity.conf \
+			profiles/input/input.conf proximity/proximity.conf \ \
 			audio/audio.conf audio/telephony-dummy.c \
 			audio/telephony-maemo5.c audio/telephony-ofono.c \
 			audio/telephony-maemo6.c sap/sap-dummy.c sap/sap-u8500.c
diff --git a/input/device.c b/profiles/input/device.c
similarity index 100%
rename from input/device.c
rename to profiles/input/device.c
diff --git a/input/device.h b/profiles/input/device.h
similarity index 100%
rename from input/device.h
rename to profiles/input/device.h
diff --git a/input/fakehid.c b/profiles/input/fakehid.c
similarity index 100%
rename from input/fakehid.c
rename to profiles/input/fakehid.c
diff --git a/input/fakehid.h b/profiles/input/fakehid.h
similarity index 100%
rename from input/fakehid.h
rename to profiles/input/fakehid.h
diff --git a/input/hog_device.c b/profiles/input/hog_device.c
similarity index 100%
rename from input/hog_device.c
rename to profiles/input/hog_device.c
diff --git a/input/hog_device.h b/profiles/input/hog_device.h
similarity index 100%
rename from input/hog_device.h
rename to profiles/input/hog_device.h
diff --git a/input/input.conf b/profiles/input/input.conf
similarity index 100%
rename from input/input.conf
rename to profiles/input/input.conf
diff --git a/input/main.c b/profiles/input/main.c
similarity index 100%
rename from input/main.c
rename to profiles/input/main.c
diff --git a/input/manager.c b/profiles/input/manager.c
similarity index 100%
rename from input/manager.c
rename to profiles/input/manager.c
diff --git a/input/manager.h b/profiles/input/manager.h
similarity index 100%
rename from input/manager.h
rename to profiles/input/manager.h
diff --git a/input/server.c b/profiles/input/server.c
similarity index 100%
rename from input/server.c
rename to profiles/input/server.c
diff --git a/input/server.h b/profiles/input/server.h
similarity index 100%
rename from input/server.h
rename to profiles/input/server.h
diff --git a/input/sixpair.c b/profiles/input/sixpair.c
similarity index 100%
rename from input/sixpair.c
rename to profiles/input/sixpair.c
-- 
1.7.10.2

