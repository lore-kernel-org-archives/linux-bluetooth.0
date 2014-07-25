Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/5] android/tester-ng: Remove not needed include
Date: Fri, 25 Jul 2014 12:45:05 +0200
Message-Id: <1406285106-14588-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406285106-14588-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406285106-14588-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-socket.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/android/tester-socket.c b/android/tester-socket.c
index f462bb0..c44fa28 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -21,8 +21,6 @@
 #include "emulator/bthost.h"
 #include "tester-main.h"
 
-#include "src/shared/util.h"
-
 static struct queue *list; /* List of socket test cases */
 
 static bt_bdaddr_t bdaddr_dummy = {
-- 
1.9.1

