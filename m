Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 02/26] android: Fix missing include
Date: Mon, 26 May 2014 15:16:28 +0200
Message-ID: <1401110212-11526-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It's needed for getenv().
---
 android/cutils/properties.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/cutils/properties.h b/android/cutils/properties.h
index 8096b19..ef40f01 100644
--- a/android/cutils/properties.h
+++ b/android/cutils/properties.h
@@ -22,6 +22,7 @@
  */
 
 #include <unistd.h>
+#include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
 #include <sys/socket.h>
-- 
1.9.3

