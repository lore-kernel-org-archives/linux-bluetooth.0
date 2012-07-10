Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 2/9] health: move it to profiles
Date: Tue, 10 Jul 2012 10:43:01 -0300
Message-Id: <1341927788-30287-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341927788-30287-1-git-send-email-gustavo@padovan.org>
References: <1341927788-30287-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am                                 |   14 +++++++-------
 {health => profiles/health}/hdp.c           |    0
 {health => profiles/health}/hdp.h           |    0
 {health => profiles/health}/hdp_main.c      |    0
 {health => profiles/health}/hdp_manager.c   |    0
 {health => profiles/health}/hdp_manager.h   |    0
 {health => profiles/health}/hdp_types.h     |    0
 {health => profiles/health}/hdp_util.c      |    0
 {health => profiles/health}/hdp_util.h      |    0
 {health => profiles/health}/mcap.c          |    0
 {health => profiles/health}/mcap.h          |    0
 {health => profiles/health}/mcap_internal.h |    0
 {health => profiles/health}/mcap_lib.h      |    0
 {health => profiles/health}/mcap_sync.c     |    0
 14 files changed, 7 insertions(+), 7 deletions(-)
 rename {health => profiles/health}/hdp.c (100%)
 rename {health => profiles/health}/hdp.h (100%)
 rename {health => profiles/health}/hdp_main.c (100%)
 rename {health => profiles/health}/hdp_manager.c (100%)
 rename {health => profiles/health}/hdp_manager.h (100%)
 rename {health => profiles/health}/hdp_types.h (100%)
 rename {health => profiles/health}/hdp_util.c (100%)
 rename {health => profiles/health}/hdp_util.h (100%)
 rename {health => profiles/health}/mcap.c (100%)
 rename {health => profiles/health}/mcap.h (100%)
 rename {health => profiles/health}/mcap_internal.h (100%)
 rename {health => profiles/health}/mcap_lib.h (100%)
 rename {health => profiles/health}/mcap_sync.c (100%)

diff --git a/Makefile.am b/Makefile.am
index ef97e4e..9e0e6ad 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -127,9 +127,9 @@ builtin_nodist =
 mcap_sources =
 
 if MCAP
-mcap_sources += health/mcap_lib.h health/mcap_internal.h \
-		health/mcap.h health/mcap.c \
-		health/mcap_sync.c
+mcap_sources += profiles/health/mcap_lib.h profiles/health/mcap_internal.h \
+		ptofiles/health/mcap.h profiles/health/mcap.c \
+		profiles/health/mcap_sync.c
 endif
 
 if PNATPLUGIN
@@ -207,10 +207,10 @@ endif
 
 if HEALTHPLUGIN
 builtin_modules += health
-builtin_sources += health/hdp_main.c health/hdp_types.h \
-			health/hdp_manager.h health/hdp_manager.c \
-			health/hdp.h health/hdp.c \
-			health/hdp_util.h health/hdp_util.c
+builtin_sources += profiles/health/hdp_main.c profiles/health/hdp_types.h \
+		profiles/health/hdp_manager.h profiles/health/hdp_manager.c \
+		profiles/health/hdp.h profiles/health/hdp.c \
+		profiles/health/hdp_util.h profiles/health/hdp_util.c
 endif
 
 if GATTMODULES
diff --git a/health/hdp.c b/profiles/health/hdp.c
similarity index 100%
rename from health/hdp.c
rename to profiles/health/hdp.c
diff --git a/health/hdp.h b/profiles/health/hdp.h
similarity index 100%
rename from health/hdp.h
rename to profiles/health/hdp.h
diff --git a/health/hdp_main.c b/profiles/health/hdp_main.c
similarity index 100%
rename from health/hdp_main.c
rename to profiles/health/hdp_main.c
diff --git a/health/hdp_manager.c b/profiles/health/hdp_manager.c
similarity index 100%
rename from health/hdp_manager.c
rename to profiles/health/hdp_manager.c
diff --git a/health/hdp_manager.h b/profiles/health/hdp_manager.h
similarity index 100%
rename from health/hdp_manager.h
rename to profiles/health/hdp_manager.h
diff --git a/health/hdp_types.h b/profiles/health/hdp_types.h
similarity index 100%
rename from health/hdp_types.h
rename to profiles/health/hdp_types.h
diff --git a/health/hdp_util.c b/profiles/health/hdp_util.c
similarity index 100%
rename from health/hdp_util.c
rename to profiles/health/hdp_util.c
diff --git a/health/hdp_util.h b/profiles/health/hdp_util.h
similarity index 100%
rename from health/hdp_util.h
rename to profiles/health/hdp_util.h
diff --git a/health/mcap.c b/profiles/health/mcap.c
similarity index 100%
rename from health/mcap.c
rename to profiles/health/mcap.c
diff --git a/health/mcap.h b/profiles/health/mcap.h
similarity index 100%
rename from health/mcap.h
rename to profiles/health/mcap.h
diff --git a/health/mcap_internal.h b/profiles/health/mcap_internal.h
similarity index 100%
rename from health/mcap_internal.h
rename to profiles/health/mcap_internal.h
diff --git a/health/mcap_lib.h b/profiles/health/mcap_lib.h
similarity index 100%
rename from health/mcap_lib.h
rename to profiles/health/mcap_lib.h
diff --git a/health/mcap_sync.c b/profiles/health/mcap_sync.c
similarity index 100%
rename from health/mcap_sync.c
rename to profiles/health/mcap_sync.c
-- 
1.7.10.2

