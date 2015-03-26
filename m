Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 2/3] tools/btmgmt: Fix crash in add-adv data parsing
Date: Wed, 25 Mar 2015 20:07:11 -0700
Message-Id: <1427339232-27053-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1427339232-27053-1-git-send-email-armansito@chromium.org>
References: <1427339232-27053-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes an invalid free in parse_byte when an invalid data
string is given:

0  0x00007ffff78204b7 in raise () from /usr/lib/libc.so.6
1  0x00007ffff782188a in abort () from /usr/lib/libc.so.6
2  0x00007ffff785e993 in __libc_message () from /usr/lib/libc.so.6
3  0x00007ffff7863dee in malloc_printerr () from /usr/lib/libc.so.6
4  0x00007ffff78645cb in _int_free () from /usr/lib/libc.so.6
5  0x00000000004034f4 in parse_bytes (optarg=0x67ee30 "-l", bytes=bytes@entry=0x7fffffffe8f0, len=len@entry=0x7fffffffe900) at tools/btmgmt.c:3739
6  0x0000000000404182 in cmd_add_adv (mgmt=0x635010, index=65535, argc=4, argv=0x67eae0) at tools/btmgmt.c:3814
7  0x00000000004057f8 in rl_handler (input=0x67eb10 "add-adv -d -l 1") at tools/btmgmt.c:4237
8  0x00007ffff7bbe25e in rl_callback_read_char () from /usr/lib/libreadline.so.6
9  0x0000000000403339 in prompt_read (io=<optimized out>, user_data=<optimized out>) at tools/btmgmt.c:4302
10 0x000000000041c7c9 in io_callback (fd=<optimized out>, events=1, user_data=0x635bc0) at src/shared/io-mainloop.c:123
11 0x000000000041cff3 in mainloop_run () at src/shared/mainloop.c:157
12 0x0000000000402630 in main (argc=0, argv=<optimized out>) at tools/btmgmt.c:4389
---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 58a5926..7ec2b23 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3746,7 +3746,7 @@ static bool parse_bytes(char *optarg, uint8_t **bytes, size_t *len)
 	for (i = 0; i < *len; i++) {
 		if (sscanf(optarg + (i * 2), "%2hhx", *bytes + i) != 1) {
 			error("Invalid data");
-			free(bytes);
+			free(*bytes);
 			*bytes = NULL;
 			return false;
 		}
-- 
2.2.0.rc0.207.ga3a616c

