Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 6/9] proximity: move to the profiles folder
Date: Tue, 10 Jul 2012 10:43:05 -0300
Message-Id: <1341927788-30287-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341927788-30287-1-git-send-email-gustavo@padovan.org>
References: <1341927788-30287-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am                                      |   15 ++++++++++-----
 {proximity => profiles/proximity}/immalert.c     |    0
 {proximity => profiles/proximity}/immalert.h     |    0
 {proximity => profiles/proximity}/linkloss.c     |    0
 {proximity => profiles/proximity}/linkloss.h     |    0
 {proximity => profiles/proximity}/main.c         |    0
 {proximity => profiles/proximity}/manager.c      |    0
 {proximity => profiles/proximity}/manager.h      |    0
 {proximity => profiles/proximity}/monitor.c      |    0
 {proximity => profiles/proximity}/monitor.h      |    0
 {proximity => profiles/proximity}/proximity.conf |    0
 {proximity => profiles/proximity}/reporter.c     |    0
 {proximity => profiles/proximity}/reporter.h     |    0
 13 files changed, 10 insertions(+), 5 deletions(-)
 rename {proximity => profiles/proximity}/immalert.c (100%)
 rename {proximity => profiles/proximity}/immalert.h (100%)
 rename {proximity => profiles/proximity}/linkloss.c (100%)
 rename {proximity => profiles/proximity}/linkloss.h (100%)
 rename {proximity => profiles/proximity}/main.c (100%)
 rename {proximity => profiles/proximity}/manager.c (100%)
 rename {proximity => profiles/proximity}/manager.h (100%)
 rename {proximity => profiles/proximity}/monitor.c (100%)
 rename {proximity => profiles/proximity}/monitor.h (100%)
 rename {proximity => profiles/proximity}/proximity.conf (100%)
 rename {proximity => profiles/proximity}/reporter.c (100%)
 rename {proximity => profiles/proximity}/reporter.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 4b05b20..82b6ffd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -227,11 +227,16 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/time/server.c profiles/time/manager.c \
 			profiles/time/manager.h \
 			plugins/gatt-example.c \
-			proximity/main.c proximity/manager.h proximity/manager.c \
-			proximity/monitor.h proximity/monitor.c \
-			proximity/reporter.h proximity/reporter.c \
-			proximity/linkloss.h proximity/linkloss.c \
-			proximity/immalert.h proximity/immalert.c \
+			profiles/proximity/main.c profiles/proximity/manager.h \
+		       	profiles/proximity/manager.c \
+			profiles/proximity/monitor.h \
+			profiles/proximity/monitor.c \
+			profiles/proximity/reporter.h \
+			profiles/proximity/reporter.c \
+			profiles/proximity/linkloss.h \
+			profiles/proximity/linkloss.c \
+			profiles/proximity/immalert.h \
+			profiles/proximity/immalert.c \
 			profiles/deviceinfo/main.c \
 			profiles/deviceinfo/manager.h \
 			profiles/deviceinfo/manager.c \
diff --git a/proximity/immalert.c b/profiles/proximity/immalert.c
similarity index 100%
rename from proximity/immalert.c
rename to profiles/proximity/immalert.c
diff --git a/proximity/immalert.h b/profiles/proximity/immalert.h
similarity index 100%
rename from proximity/immalert.h
rename to profiles/proximity/immalert.h
diff --git a/proximity/linkloss.c b/profiles/proximity/linkloss.c
similarity index 100%
rename from proximity/linkloss.c
rename to profiles/proximity/linkloss.c
diff --git a/proximity/linkloss.h b/profiles/proximity/linkloss.h
similarity index 100%
rename from proximity/linkloss.h
rename to profiles/proximity/linkloss.h
diff --git a/proximity/main.c b/profiles/proximity/main.c
similarity index 100%
rename from proximity/main.c
rename to profiles/proximity/main.c
diff --git a/proximity/manager.c b/profiles/proximity/manager.c
similarity index 100%
rename from proximity/manager.c
rename to profiles/proximity/manager.c
diff --git a/proximity/manager.h b/profiles/proximity/manager.h
similarity index 100%
rename from proximity/manager.h
rename to profiles/proximity/manager.h
diff --git a/proximity/monitor.c b/profiles/proximity/monitor.c
similarity index 100%
rename from proximity/monitor.c
rename to profiles/proximity/monitor.c
diff --git a/proximity/monitor.h b/profiles/proximity/monitor.h
similarity index 100%
rename from proximity/monitor.h
rename to profiles/proximity/monitor.h
diff --git a/proximity/proximity.conf b/profiles/proximity/proximity.conf
similarity index 100%
rename from proximity/proximity.conf
rename to profiles/proximity/proximity.conf
diff --git a/proximity/reporter.c b/profiles/proximity/reporter.c
similarity index 100%
rename from proximity/reporter.c
rename to profiles/proximity/reporter.c
diff --git a/proximity/reporter.h b/profiles/proximity/reporter.h
similarity index 100%
rename from proximity/reporter.h
rename to profiles/proximity/reporter.h
-- 
1.7.10.2

