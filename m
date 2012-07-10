Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 4/9] network: move it to profiles folder
Date: Tue, 10 Jul 2012 10:43:03 -0300
Message-Id: <1341927788-30287-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341927788-30287-1-git-send-email-gustavo@padovan.org>
References: <1341927788-30287-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am                                |   13 +++++++------
 {network => profiles/network}/common.c     |    0
 {network => profiles/network}/common.h     |    0
 {network => profiles/network}/connection.c |    0
 {network => profiles/network}/connection.h |    0
 {network => profiles/network}/main.c       |    0
 {network => profiles/network}/manager.c    |    0
 {network => profiles/network}/manager.h    |    0
 {network => profiles/network}/network.conf |    0
 {network => profiles/network}/server.c     |    0
 {network => profiles/network}/server.h     |    0
 11 files changed, 7 insertions(+), 6 deletions(-)
 rename {network => profiles/network}/common.c (100%)
 rename {network => profiles/network}/common.h (100%)
 rename {network => profiles/network}/connection.c (100%)
 rename {network => profiles/network}/connection.h (100%)
 rename {network => profiles/network}/main.c (100%)
 rename {network => profiles/network}/manager.c (100%)
 rename {network => profiles/network}/manager.h (100%)
 rename {network => profiles/network}/network.conf (100%)
 rename {network => profiles/network}/server.c (100%)
 rename {network => profiles/network}/server.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 99fabe9..c6ff327 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -193,11 +193,12 @@ endif
 
 if NETWORKPLUGIN
 builtin_modules += network
-builtin_sources += network/main.c \
-			network/manager.h network/manager.c \
-			network/common.h network/common.c \
-			network/server.h network/server.c \
-			network/connection.h network/connection.c
+builtin_sources += profiles/network/main.c \
+			profiles/network/manager.h profiles/network/manager.c \
+			profiles/network/common.h profiles/network/common.c \
+			profiles/network/server.h profiles/network/server.c \
+			profiles/network/connection.h \
+			profiles/network/connection.c
 endif
 
 if SERVICEPLUGIN
@@ -326,7 +327,7 @@ conf_DATA += src/main.conf
 endif
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf src/org.bluez.service \
-			src/main.conf network/network.conf \
+			src/main.conf profiles/network/network.conf \
 			profiles/input/input.conf proximity/proximity.conf \ \
 			audio/audio.conf audio/telephony-dummy.c \
 			audio/telephony-maemo5.c audio/telephony-ofono.c \
diff --git a/network/common.c b/profiles/network/common.c
similarity index 100%
rename from network/common.c
rename to profiles/network/common.c
diff --git a/network/common.h b/profiles/network/common.h
similarity index 100%
rename from network/common.h
rename to profiles/network/common.h
diff --git a/network/connection.c b/profiles/network/connection.c
similarity index 100%
rename from network/connection.c
rename to profiles/network/connection.c
diff --git a/network/connection.h b/profiles/network/connection.h
similarity index 100%
rename from network/connection.h
rename to profiles/network/connection.h
diff --git a/network/main.c b/profiles/network/main.c
similarity index 100%
rename from network/main.c
rename to profiles/network/main.c
diff --git a/network/manager.c b/profiles/network/manager.c
similarity index 100%
rename from network/manager.c
rename to profiles/network/manager.c
diff --git a/network/manager.h b/profiles/network/manager.h
similarity index 100%
rename from network/manager.h
rename to profiles/network/manager.h
diff --git a/network/network.conf b/profiles/network/network.conf
similarity index 100%
rename from network/network.conf
rename to profiles/network/network.conf
diff --git a/network/server.c b/profiles/network/server.c
similarity index 100%
rename from network/server.c
rename to profiles/network/server.c
diff --git a/network/server.h b/profiles/network/server.h
similarity index 100%
rename from network/server.h
rename to profiles/network/server.h
-- 
1.7.10.2

