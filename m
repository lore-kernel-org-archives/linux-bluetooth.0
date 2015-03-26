Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] tools/btmgmt: Fix crash in interactive mode
Date: Thu, 26 Mar 2015 22:59:24 +0100
Message-Id: <1427407164-20354-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Optind needs to be reset to 0 so getopt_long do reinitialization on new
parsing. Otherwise we got crash:

[hci1]# find --help
Usage: find [-l|-b]>
[hci1]# find --help
==16382== Invalid read of size 1
==16382==    at 0x513CA96: _getopt_internal_r (getopt.c:429)
==16382==    by 0x513DBFA: _getopt_internal (getopt.c:1177)
==16382==    by 0x513DC82: getopt_long (getopt1.c:66)
==16382==    by 0x406721: cmd_find (btmgmt.c:2111)
==16382==    by 0x40C712: rl_handler (btmgmt.c:4275)
==16382==    by 0x4E5A727: rl_callback_read_char (in
/lib/x86_64-linux-gnu/libreadline.so.6.2)
==16382==    by 0x402ED8: prompt_read (btmgmt.c:4340)
==16382==    by 0x41D117: io_callback (io-mainloop.c:123)
==16382==    by 0x41D9F3: mainloop_run (mainloop.c:157)
==16382==    by 0x4026C2: main (btmgmt.c:4427)
==16382==  Address 0x567e576 is 6 bytes inside a block of size 101
free'd
==16382==    at 0x4C2A82E: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==16382==    by 0x5158DE8: wordfree (wordexp.c:2235)
==16382==    by 0x40C71A: rl_handler (btmgmt.c:4304)
==16382==    by 0x4E5A727: rl_callback_read_char (in
/lib/x86_64-linux-gnu/libreadline.so.6.2)
==16382==    by 0x402ED8: prompt_read (btmgmt.c:4340)
==16382==    by 0x41D117: io_callback (io-mainloop.c:123)
==16382==    by 0x41D9F3: mainloop_run (mainloop.c:157)
==16382==    by 0x4026C2: main (btmgmt.c:4427)
==16382==
---
 tools/btmgmt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 36a8681..d7af7f0 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1879,9 +1879,11 @@ static void cmd_disconnect(struct mgmt *mgmt, uint16_t index, int argc,
 			break;
 		case 'h':
 			disconnect_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			disconnect_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -2027,11 +2029,13 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 		case 'u':
 			if (count == MAX_UUIDS) {
 				print("Max %u UUIDs supported", MAX_UUIDS);
+				optind = 0;
 				return noninteractive_quit(EXIT_FAILURE);
 			}
 
 			if (bt_string2uuid(&uuid, optarg) < 0) {
 				print("Invalid UUID: %s", optarg);
+				optind = 0;
 				return noninteractive_quit(EXIT_FAILURE);
 			}
 			cp = (void *) buf;
@@ -2045,9 +2049,11 @@ static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
 			break;
 		case 'h':
 			find_service_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			find_service_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -2121,9 +2127,11 @@ static void cmd_find(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 			break;
 		case 'h':
 			find_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			find_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -2195,6 +2203,7 @@ static void cmd_stop_find(struct mgmt *mgmt, uint16_t index, int argc,
 		case 'h':
 		default:
 			stop_find_usage();
+			optind = 0;
 			exit(EXIT_SUCCESS);
 		}
 	}
@@ -2311,9 +2320,11 @@ static void cmd_pair(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 			break;
 		case 'h':
 			pair_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			pair_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -2400,9 +2411,11 @@ static void cmd_cancel_pair(struct mgmt *mgmt, uint16_t index, int argc,
 			break;
 		case 'h':
 			cancel_pair_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			cancel_pair_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -2484,9 +2497,11 @@ static void cmd_unpair(struct mgmt *mgmt, uint16_t index, int argc,
 			break;
 		case 'h':
 			unpair_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			unpair_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -2615,6 +2630,7 @@ static void cmd_irks(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 		case 'l':
 			if (count >= MAX_IRKS) {
 				error("Number of IRKs exceeded");
+				optind = 0;
 				return noninteractive_quit(EXIT_FAILURE);
 			}
 			if (strlen(optarg) > 3 &&
@@ -2624,15 +2640,18 @@ static void cmd_irks(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 				local_index = atoi(optarg);
 			if (!load_identity(local_index, &cp->irks[count])) {
 				error("Unable to load identity");
+				optind = 0;
 				return noninteractive_quit(EXIT_FAILURE);
 			}
 			count++;
 			break;
 		case 'h':
 			irks_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			irks_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -2710,9 +2729,11 @@ static void cmd_block(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 			break;
 		case 'h':
 			block_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			block_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
@@ -2760,9 +2781,11 @@ static void cmd_unblock(struct mgmt *mgmt, uint16_t index, int argc,
 			break;
 		case 'h':
 			unblock_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_SUCCESS);
 		default:
 			unblock_usage();
+			optind = 0;
 			return noninteractive_quit(EXIT_FAILURE);
 		}
 	}
-- 
1.8.4

