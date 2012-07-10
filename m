Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 5/9] time: move to the profiles folder
Date: Tue, 10 Jul 2012 11:03:04 -0300
Message-Id: <1341928988-5116-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341928988-5116-1-git-send-email-gustavo@padovan.org>
References: <1341928988-5116-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am                       |    5 +++--
 {time => profiles/time}/main.c    |    0
 {time => profiles/time}/manager.c |    0
 {time => profiles/time}/manager.h |    0
 {time => profiles/time}/server.c  |    0
 {time => profiles/time}/server.h  |    0
 6 files changed, 3 insertions(+), 2 deletions(-)
 rename {time => profiles/time}/main.c (100%)
 rename {time => profiles/time}/manager.c (100%)
 rename {time => profiles/time}/manager.h (100%)
 rename {time => profiles/time}/server.c (100%)
 rename {time => profiles/time}/server.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 9f0d343..037ded5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -223,8 +223,9 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/thermometer/thermometer.c \
 			profiles/alert/main.c profiles/alert/server.h \
 			profiles/alert/server.c \
-			time/main.c time/server.h time/server.c \
-			time/manager.h time/manager.c \
+			profiles/time/main.c profiles/time/server.h \
+			profiles/time/server.c profiles/time/manager.c \
+			profiles/time/manager.h \
 			plugins/gatt-example.c \
 			proximity/main.c proximity/manager.h proximity/manager.c \
 			proximity/monitor.h proximity/monitor.c \
diff --git a/time/main.c b/profiles/time/main.c
similarity index 100%
rename from time/main.c
rename to profiles/time/main.c
diff --git a/time/manager.c b/profiles/time/manager.c
similarity index 100%
rename from time/manager.c
rename to profiles/time/manager.c
diff --git a/time/manager.h b/profiles/time/manager.h
similarity index 100%
rename from time/manager.h
rename to profiles/time/manager.h
diff --git a/time/server.c b/profiles/time/server.c
similarity index 100%
rename from time/server.c
rename to profiles/time/server.c
diff --git a/time/server.h b/profiles/time/server.h
similarity index 100%
rename from time/server.h
rename to profiles/time/server.h
-- 
1.7.10.2

