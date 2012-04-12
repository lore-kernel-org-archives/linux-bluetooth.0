Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Makefile.am: Fix indentation
Date: Thu, 12 Apr 2012 12:04:48 -0400
Message-Id: <1334246688-23488-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only these two lines were using spaces instead of tabs.
---
 Makefile.am |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

I know it is trivial, but it just stands out while modifying the file.

diff --git a/Makefile.am b/Makefile.am
index b770fc5..4368593 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -221,8 +221,8 @@ builtin_sources += thermometer/main.c \
 			thermometer/thermometer.h thermometer/thermometer.c \
 			alert/main.c alert/server.h alert/server.c \
 			time/main.c time/server.h time/server.c \
-            plugins/gatt-example.c \
-            proximity/main.c proximity/manager.h proximity/manager.c \
+			plugins/gatt-example.c \
+			proximity/main.c proximity/manager.h proximity/manager.c \
 			proximity/monitor.h proximity/monitor.c \
 			proximity/reporter.h proximity/reporter.c \
 			proximity/linkloss.h proximity/linkloss.c \
-- 
1.7.5.4

