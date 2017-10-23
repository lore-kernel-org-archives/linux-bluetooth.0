Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/8] tools/btmgmt: Fix segfault in interactive mode
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Message-ID: <72752c8a-3fb2-dfd9-cd52-8f7c33208b33@jp.fujitsu.com>
Date: Mon, 23 Oct 2017 17:26:21 +0900
MIME-Version: 1.0
In-Reply-To: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the interactive mode, if running a command, which is remote-oob/
conn-info/add-device/del-device/advsize/add-adv, with a option and
subsequently running any command, the following segfault may occur.

  (gdb) bt
  #0  0x00007f793a7dc4e2 in _getopt_internal_r (argc=argc@entry=1, argv=argv@entry=0x16bb260, optstring=0x434ac4 "t:r:R:h:H:", optstring@entry=0x434ac3 "+t:r:R:h:H:",
      longopts=longopts@entry=0x6508e0 <remote_oob_opt>, longind=longind@entry=0x0, long_only=long_only@entry=0, d=0x7f793aab9ea0 <getopt_data>, posixly_correct=0) at getopt.c:462
  #1  0x00007f793a7dd641 in _getopt_internal (argc=argc@entry=1, argv=argv@entry=0x16bb260, optstring=optstring@entry=0x434ac3 "+t:r:R:h:H:", longopts=longopts@entry=0x6508e0 <remote_oob_opt>,
      longind=longind@entry=0x0, long_only=long_only@entry=0, posixly_correct=0) at getopt.c:1175
  #2  0x00007f793a7dd6be in getopt_long (argc=argc@entry=1, argv=argv@entry=0x16bb260, options=options@entry=0x434ac3 "+t:r:R:h:H:", long_options=long_options@entry=0x6508e0 <remote_oob_opt>,
      opt_index=opt_index@entry=0x0) at getopt1.c:65
  #3  0x0000000000416c20 in cmd_remote_oob (mgmt=0x16a7010, index=<optimized out>, argc=1, argv=0x16bb260) at tools/btmgmt.c:3203
  #4  0x000000000041465b in rl_handler (input=0x16c5160 "remote-oob") at tools/btmgmt.c:4684
  #5  0x00007f793aae76f5 in rl_callback_read_char () from /lib/x86_64-linux-gnu/libreadline.so.6
  #6  0x000000000040fc71 in prompt_read (io=<optimized out>, user_data=<optimized out>) at tools/btmgmt.c:4749
  #7  0x0000000000430089 in io_callback (fd=<optimized out>, events=1, user_data=0x16a7bc0) at src/shared/io-mainloop.c:123
  #8  0x0000000000430d4b in mainloop_run () at src/shared/mainloop.c:157
  #9  0x0000000000402caf in main (argc=0, argv=0x7ffd7eae58f0) at tools/btmgmt.c:4846
---
 tools/btmgmt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 5762b2b..ecb0692 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3220,6 +3220,7 @@ static void cmd_remote_oob(struct mgmt *mgmt, uint16_t index,
 			break;
 		default:
 			remote_oob_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -3485,9 +3486,11 @@ static void cmd_conn_info(struct mgmt *mgmt, uint16_t index,
 			break;
 		case 'h':
 			conn_info_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			conn_info_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -3681,9 +3684,11 @@ static void cmd_add_device(struct mgmt *mgmt, uint16_t index,
 			break;
 		case 'h':
 			add_device_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			add_device_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -3751,9 +3756,11 @@ static void cmd_del_device(struct mgmt *mgmt, uint16_t index,
 			break;
 		case 'h':
 			del_device_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			del_device_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -4018,6 +4025,7 @@ static void cmd_advsize(struct mgmt *mgmt, uint16_t index,
 			break;
 		default:
 			advsize_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -4253,6 +4261,7 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 			/* fall through */
 		default:
 			add_adv_usage();
+			optind = 0;
 			goto done;
 		}
 	}
-- 
2.7.4

