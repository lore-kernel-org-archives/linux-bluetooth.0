Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/mcap: Fix possible uninitialized use
Date: Thu, 26 Jun 2014 16:45:32 +0300
Message-Id: <1403790332-27829-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In case of maximum number of retries has reached, base_time may be used
uninitialized. Fixes following warnings:

...
external/bluetooth/bluez/android/mcap-lib.c: In function
'sync_send_indication.part.35':
external/bluetooth/bluez/android/mcap-lib.c:2366:20: warning:
'base_time.tv_sec' may be used uninitialized in this function
[-Wuninitialized]
external/bluetooth/bluez/android/mcap-lib.c:2693:18: note:
'base_time.tv_sec' was declared here
external/bluetooth/bluez/android/mcap-lib.c:2366:46: warning:
'base_time.tv_nsec' may be used uninitialized in this function
[-Wuninitialized]
external/bluetooth/bluez/android/mcap-lib.c:2693:18: note:
'base_time.tv_nsec' was declared here
external/bluetooth/bluez/android/mcap-lib.c: In function
'sync_send_indication':
external/bluetooth/bluez/android/mcap-lib.c:2366:20: warning:
'base_time.tv_sec' may be used uninitialized in this function
[-Wuninitialized]
external/bluetooth/bluez/android/mcap-lib.c:2693:18: note:
'base_time.tv_sec' was declared here
external/bluetooth/bluez/android/mcap-lib.c:2366:46: warning:
'base_time.tv_nsec' may be used uninitialized in this function
[-Wuninitialized]
external/bluetooth/bluez/android/mcap-lib.c:2693:18: note:
'base_time.tv_nsec' was declared here
...
---
 android/mcap-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/mcap-lib.c b/android/mcap-lib.c
index 256abe1..dd688d9 100644
--- a/android/mcap-lib.c
+++ b/android/mcap-lib.c
@@ -2663,12 +2663,12 @@ static gboolean get_all_clocks(struct mcap_mcl *mcl, uint32_t *btclock,
 		if (clock_gettime(CLK, &t0) < 0)
 			return FALSE;
 
-		if (!read_btclock(mcl, btclock, &btres))
-			continue;
-
 		if (clock_gettime(CLK, base_time) < 0)
 			return FALSE;
 
+		if (!read_btclock(mcl, btclock, &btres))
+			continue;
+
 		/*
 		 * Tries to detect preemption between clock_gettime
 		 * and read_btclock by measuring transaction time
-- 
1.8.3.2

