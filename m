Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/4] android: Fix typo
Date: Wed, 15 Jan 2014 22:01:37 +0100
Message-Id: <1389819699-12055-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389819699-12055-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389819699-12055-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetoothd-snoop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/bluetoothd-snoop.c b/android/bluetoothd-snoop.c
index 23e0bfd..9312c11 100644
--- a/android/bluetoothd-snoop.c
+++ b/android/bluetoothd-snoop.c
@@ -37,7 +37,7 @@
 #include "monitor/mainloop.h"
 #include "src/shared/btsnoop.h"
 
-#define DEAULT_SNOOP_FILE "/sdcard/btsnoop_hci.log"
+#define DEFAULT_SNOOP_FILE "/sdcard/btsnoop_hci.log"
 
 #define MAX_PACKET_SIZE (1486 + 4)
 
@@ -196,7 +196,7 @@ int main(int argc, char *argv[])
 	if (argc > 1)
 		path = argv[1];
 	else
-		path = DEAULT_SNOOP_FILE;
+		path = DEFAULT_SNOOP_FILE;
 
 	mainloop_init();
 
-- 
1.8.5.2

