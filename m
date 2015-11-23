Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] HACKING: Add suppression file in valgrind cmd
Date: Mon, 23 Nov 2015 20:08:07 +0530
Message-id: <1448289487-2841-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without --suppressions=./tools/valgrind.supp in valgrind cmd,
bluetoothd throws following error:

==1237== Syscall param socketcall.bind(my_addr.rc_bdaddr) points to uninitialised byte(s)
==1237==    at 0x588B227: bind (syscall-template.S:81)
==1237==    by 0x451545: logging_open (log.c:76)
==1237==    by 0x451545: __btd_log_init (log.c:314)
==1237==    by 0x40B035: main (main.c:610)
==1237==  Address 0xfff0003b6 is on thread 1's stack
==1237==  in frame #1, created by __btd_log_init (log.c:306)
==1237==  Uninitialised value was created by a stack allocation
==1237==    at 0x451490: __btd_log_init (log.c:306)
==1237==
==1237== Syscall param socketcall.bind(my_addr.rc_channel) points to uninitialised byte(s)
==1237==    at 0x588B227: bind (syscall-template.S:81)
==1237==    by 0x451545: logging_open (log.c:76)
==1237==    by 0x451545: __btd_log_init (log.c:314)
==1237==    by 0x40B035: main (main.c:610)
==1237==  Address 0xfff0003b8 is on thread 1's stack
==1237==  in frame #1, created by __btd_log_init (log.c:306)
==1237==  Uninitialised value was created by a stack allocation
==1237==    at 0x451490: __btd_log_init (log.c:306)
---
 HACKING | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/HACKING b/HACKING
index ffca598..a8fb403 100644
--- a/HACKING
+++ b/HACKING
@@ -89,8 +89,9 @@ automatically includes this option.
     # sudo ./src/bluetoothd -n -d
 
   Run daemon with valgrind
-   # sudo valgrind --trace-children=yes --track-origins=yes --track-fds=yes
-   --show-possibly-lost=no --leak-check=full ./src/bluetoothd -n -d
+   # sudo valgrind --trace-children=yes --track-origins=yes --track-fds=yes \
+   --show-possibly-lost=no --leak-check=full --suppressions=./tools/valgrind.supp \
+   ./src/bluetoothd -n -d
 
 For production installations or distribution packaging it is important that
 the "--enable-maintainer-mode" option is NOT used.
-- 
1.9.1

