Return-Path: <cyrus@holtmann.org>
From: Ian Coolidge <icoolidge@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ian Coolidge <icoolidge@google.com>
Subject: [PATCH v2] android/log: Add missing libc includes.
Date: Mon,  2 Feb 2015 11:10:40 -0800
Message-Id: <1422904240-31160-1-git-send-email-icoolidge@google.com>
In-Reply-To: <1527070.LF3VyE4bnx@uw000953>
References: <1527070.LF3VyE4bnx@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bionic is moving to reduce the amount of transitive includes,
so they should not be relied upon.
---
 android/log.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/log.c b/android/log.c
index 09d226a..8013eba 100644
--- a/android/log.c
+++ b/android/log.c
@@ -25,7 +25,10 @@
 #endif
 
 #include <fcntl.h>
+#include <stdarg.h>
 #include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <stdbool.h>
 #include <time.h>
-- 
2.2.0.rc0.207.ga3a616c

