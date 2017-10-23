Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 3/8] tools/btmgmt: Fix segfault with remote-oob --help
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Message-ID: <0fec3984-dfc3-faa3-234c-7ded2b61ecd5@jp.fujitsu.com>
Date: Mon, 23 Oct 2017 17:26:45 +0900
MIME-Version: 1.0
In-Reply-To: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The command remote-oob may process an invalid value and hit the following
segfault since getopt_long() returns the character 'h' for hash option
when passing the option --help to remote-oob.

  (gdb) bt
  #0  strlen () at ../sysdeps/x86_64/strlen.S:106
  #1  0x0000000000415e25 in hex2bin (hexstr=0x0, buf=buf@entry=0x7ffd85c799f7 "", buflen=16) at tools/btmgmt.c:140
  #2  0x0000000000416caf in cmd_remote_oob (mgmt=0x1cc2010, index=<optimized out>, argc=2, argv=0x1cdff10) at tools/btmgmt.c:3213
  #3  0x000000000041465b in rl_handler (input=0x1cd6240 "remote-oob --help") at tools/btmgmt.c:4685
  #4  0x00007fd627fd96f5 in rl_callback_read_char () from /lib/x86_64-linux-gnu/libreadline.so.6
  #5  0x000000000040fc71 in prompt_read (io=<optimized out>, user_data=<optimized out>) at tools/btmgmt.c:4750
  #6  0x0000000000430089 in io_callback (fd=<optimized out>, events=1, user_data=0x1cc2bc0) at src/shared/io-mainloop.c:123
  #7  0x0000000000430d4b in mainloop_run () at src/shared/mainloop.c:157
  #8  0x0000000000402caf in main (argc=0, argv=0x7ffd85c79d50) at tools/btmgmt.c:4847
---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index ecb0692..319ee05 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3186,7 +3186,7 @@ static void remote_oob_usage(void)
 }
 
 static struct option remote_oob_opt[] = {
-	{ "help",	0, 0, 'h' },
+	{ "help",	0, 0, '?' },
 	{ "type",	1, 0, 't' },
 	{ 0, 0, 0, 0 }
 };
-- 
2.7.4

