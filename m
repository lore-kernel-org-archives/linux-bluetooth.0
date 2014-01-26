Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 4/4] emulator: Fix crash if socket(AF_ALG) is not supported by the kernel
Date: Sat, 25 Jan 2014 21:44:02 -0400
Message-Id: <1390700642-10482-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1390700642-10482-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390512281-26541-1-git-send-email-anderson.lizardo@openbossa.org>
 <1390700642-10482-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In this situation, smp_stop() was being called with NULL pointer.

Crash detected by valgrind:

==7925== Invalid read of size 4
==7925==    at 0x8052F18: smp_stop (smp.c:480)
==7925==    by 0x8052542: bthost_stop (bthost.c:2073)
==7925==    by 0x805521D: hciemu_unref (hciemu.c:372)
==7925==    by 0x8058C65: test_post_teardown (android-tester.c:464)
==7925==    by 0x8055DE7: tester_teardown_complete (tester.c:533)
==7925==    by 0x8055501: teardown_callback (tester.c:312)
==7925==    by 0x408348F: g_idle_dispatch (gmain.c:5250)
==7925==    by 0x4086A75: g_main_context_dispatch (gmain.c:3065)
==7925==    by 0x4086E14: g_main_context_iterate.isra.23 (gmain.c:3712)
==7925==    by 0x40872FA: g_main_loop_run (gmain.c:3906)
==7925==    by 0x41744D2: (below main) (libc-start.c:226)
==7925==  Address 0x8 is not stack'd, malloc'd or (recently) free'd
---
 emulator/bthost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index c4603ae..3ff2a36 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2070,6 +2070,8 @@ bool bthost_connect_rfcomm(struct bthost *bthost, uint16_t handle,
 
 void bthost_stop(struct bthost *bthost)
 {
-	smp_stop(bthost->smp_data);
-	bthost->smp_data = NULL;
+	if (bthost->smp_data) {
+		smp_stop(bthost->smp_data);
+		bthost->smp_data = NULL;
+	}
 }
-- 
1.8.3.2

