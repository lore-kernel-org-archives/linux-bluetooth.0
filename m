Return-Path: <ohad@bencohen.org>
From: Ohad Ben-Cohen <ohad@bencohen.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH bluez-utils] add support for Texas Instruments' BRF63xx chips
MIME-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Date: Mon, 30 Apr 2007 11:39:44 -0400
Message-Id: <200704301139.44842.ohad@bencohen.org>
Content-Type: text/plain;
  charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

Introduces initializing procedures for Texas Instruments' BRF63xx chips.
These procedures take care of:
1. Loading TI's init script
2. Setting up HCILL, TI's runtime power-management UART protocol

An additional, tiny feature, which proved useful for
stress checkings, is added to l2test: random delays.

The patch is against the current CVS tree of bluez-utils.
---
 test/l2test.c        |   22 +++-
 tools/Makefile.am    |    2 +-
 tools/hciattach.8    |    3 +
 tools/hciattach.c    |  154 ++++++++++++---------
 tools/hciattach.h    |   73 ++++++++++
 tools/hciattach_ti.c |  382 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/hciattach_ti.h |  107 ++++++++++++++
 7 files changed, 673 insertions(+), 70 deletions(-)
 create mode 100644 tools/hciattach.h
 create mode 100644 tools/hciattach_ti.c
 create mode 100644 tools/hciattach_ti.h

diff --git a/test/l2test.c b/test/l2test.c
index 733c052..08745f1 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -84,6 +84,9 @@ static int count = 1;
 /* Default delay after sending count number of frames */
 static unsigned long delay = 0;
 
+/* Default delay random switch  (0 is off, else is on) */
+static int random_delay = 0;
+
 static char *filename = NULL;
 
 static int flowctl = 0;
@@ -580,10 +583,16 @@ static void recv_mode(int sk)
 	}
 }
 
+static double double_random(void)
+{
+	return ((double)rand())/((double)RAND_MAX);
+}
+
 static void do_send(int sk)
 {
 	uint32_t seq;
 	int i, fd, len;
+	unsigned long tmp_delay;
 
 	syslog(LOG_INFO, "Sending ...");
 
@@ -615,8 +624,10 @@ static void do_send(int sk)
 			exit(1);
 		}
 
-		if (num_frames && delay && count && !(seq % count))
-			usleep(delay);
+		if (num_frames && delay && count && !(seq % count)) {
+			tmp_delay = random_delay?delay*double_random():delay;
+			usleep(tmp_delay);
+		}
 	}
 }
 
@@ -814,6 +825,7 @@ static void usage(void)
 		"\t[-N num] send num frames (default = infinite)\n"
 		"\t[-C num] send num frames before delay (default = 1)\n"
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
+		"\t[-Z] random delay between 0 to the value that is set using -D\n"
 		"\t[-R] reliable mode\n"
 		"\t[-G] use connectionless channel (datagram)\n"
 		"\t[-F] enable flow control\n"
@@ -830,7 +842,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmnxyzb:i:P:I:O:B:N:L:C:D:RGFAESM")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmnxyzb:i:P:I:O:B:N:L:C:D:ZRGFAESM")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -953,6 +965,10 @@ int main(int argc, char *argv[])
 			socktype = SOCK_DGRAM;
 			break;
 
+		case 'Z':
+			random_delay = 1;
+			break;
+
 		default:
 			usage();
 			exit(1);
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 0ebb351..75142da 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -37,7 +37,7 @@ bin_PROGRAMS = hcitool l2ping sdptool ciptool $(dfutool_programs)
 
 noinst_PROGRAMS = hcisecfilter ppporc
 
-hciattach_SOURCES = hciattach.c hciattach_st.c
+hciattach_SOURCES = hciattach.c hciattach_st.c hciattach_ti.c
 hciattach_LDADD = @BLUEZ_LIBS@
 
 hciconfig_SOURCES = hciconfig.c csr.h csr.c
diff --git a/tools/hciattach.8 b/tools/hciattach.8
index f9d295e..62f773f 100644
--- a/tools/hciattach.8
+++ b/tools/hciattach.8
@@ -69,6 +69,9 @@ Silicon Wave kits
 .TP
 .B bcsp
 Serial adapters using CSR chips with BCSP serial protocol
+.TP
+.B texas
+Texas Instruments' BRF 63xx chips with HCILL serial protocol
 .RE
 
 Supported IDs are (manufacturer id, product id)
diff --git a/tools/hciattach.c b/tools/hciattach.c
index 776035e..9f59717 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -47,31 +47,8 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 
-#ifndef N_HCI
-#define N_HCI	15
-#endif
-
-#define HCIUARTSETPROTO _IOW('U', 200, int)
-#define HCIUARTGETPROTO _IOR('U', 201, int)
-
-#define HCI_UART_H4	0
-#define HCI_UART_BCSP	1
-#define HCI_UART_3WIRE	2
-#define HCI_UART_H4DS	3
-
-struct uart_t {
-	char *type;
-	int  m_id;
-	int  p_id;
-	int  proto;
-	int  init_speed;
-	int  speed;
-	int  flags;
-	char *bdaddr;
-	int  (*init) (int fd, struct uart_t *u, struct termios *ti);
-};
-
-#define FLOW_CTL	0x0001
+#include "hciattach.h"
+#include "hciattach_ti.h"
 
 static volatile sig_atomic_t __io_canceled = 0;
 
@@ -124,7 +101,7 @@ static int uart_speed(int s)
 	}
 }
 
-static int set_speed(int fd, struct termios *ti, int speed)
+int set_speed(int fd, struct termios *ti, int speed)
 {
 	cfsetospeed(ti, uart_speed(speed));
 	return tcsetattr(fd, TCSANOW, ti);
@@ -133,7 +110,7 @@ static int set_speed(int fd, struct termios *ti, int speed)
 /* 
  * Read an HCI event from the given file descriptor.
  */
-static int read_hci_event(int fd, unsigned char* buf, int size) 
+int read_hci_event(int fd, unsigned char* buf, int size)
 {
 	int remain, r;
 	int count = 0;
@@ -258,15 +235,41 @@ static int digi(int fd, struct uart_t *u, struct termios *ti)
 	return 0;
 }
 
+static int texas_continue_script(int fd, struct uart_t *u, struct termios *ti)
+{
+	int dev_id, dd, ret = 0;
+
+	sleep(1);
+
+	dev_id = ioctl(fd, HCIUARTGETDEVICE, 0);
+	if (dev_id < 0) {
+		perror("cannot get device id");
+		return -1;
+	}
+
+	DPRINTF("\nAdded device hci%d\n", dev_id);
+
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		perror("HCI device open failed");
+		return -1;
+	}
+
+	ret = brf_do_script(dd, u, ti, NULL);
+
+	hci_close_dev(dd);
+
+	return ret;
+}
+
 static int texas(int fd, struct uart_t *u, struct termios *ti)
 {
 	struct timespec tm = {0, 50000};
 	char cmd[4];
-	unsigned char resp[100];		/* Response */
+	unsigned char resp[100] = {0};
+	const char *bts_file;
 	int n;
 
-	memset(resp,'\0', 100);
-
 	/* It is possible to get software version with manufacturer specific 
 	   HCI command HCI_VS_TI_Version_Number. But the only thing you get more
 	   is if this is point-to-point or point-to-multipoint module */
@@ -284,7 +287,7 @@ static int texas(int fd, struct uart_t *u, struct termios *ti)
 			return -1;
 		}
 		if (n < 4) {
-			fprintf(stderr, "Wanted to write 4 bytes, could only write %d. Stop\n", n);
+			fprintf(stderr, "Failed to send command (sent %d/4 bytes\n", n);
 			return -1;
 		}
 
@@ -298,17 +301,21 @@ static int texas(int fd, struct uart_t *u, struct termios *ti)
 	} while (resp[4] != cmd[1] && resp[5] != cmd[2]);
 
 	/* Verify manufacturer */
-	if ((resp[11] & 0xFF) != 0x0d)
-		fprintf(stderr,"WARNING : module's manufacturer is not Texas Instrument\n");
+	if (! is_it_texas(resp)) {
+		fprintf(stderr,"ERROR: module's manufacturer is not Texas Instruments\n");
+		return -1;
+	}
 
-	/* Print LMP version */
-	fprintf(stderr, "Texas module LMP version : 0x%02x\n", resp[10] & 0xFF);
+	fprintf(stderr, "Found Texas Instruments chip, Welcome !\n");
 
-	/* Print LMP subversion */
-	fprintf(stderr, "Texas module LMP sub-version : 0x%02x%02x\n", resp[14] & 0xFF, resp[13] & 0xFF);
+	bts_file = get_firmware_name(resp);
+	fprintf(stderr, "Firmware file : %s\n", bts_file);
+
+	n = brf_do_script( fd, u, ti, bts_file);
 
 	nanosleep(&tm, NULL);
-	return 0;
+
+	return n;
 }
 
 static int read_check(int fd, void *buf, int count)
@@ -1040,69 +1047,71 @@ static int bcm2035(int fd, struct uart_t *u, struct termios *ti)
 }
 
 struct uart_t uart[] = {
-	{ "any",        0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
-	{ "ericsson",   0x0000, 0x0000, HCI_UART_H4,   57600,  115200, FLOW_CTL, NULL, ericsson },
-	{ "digi",       0x0000, 0x0000, HCI_UART_H4,   9600,   115200, FLOW_CTL, NULL, digi     },
-	{ "texas",      0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, texas    },
+	{ "any",        0x0000, 0x0000, HCI_UART_H4, 0, 115200, 115200, FLOW_CTL, NULL, NULL, NULL     },
+	{ "ericsson",   0x0000, 0x0000, HCI_UART_H4, 0, 57600,  115200, FLOW_CTL, NULL, ericsson, NULL },
+	{ "digi",       0x0000, 0x0000, HCI_UART_H4, 0, 9600,   115200, FLOW_CTL, NULL, digi, NULL     },
 
-	{ "bcsp",       0x0000, 0x0000, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	/* Texas Instruments BRF63xx modules */
+	{ "texas",      0x0000, 0x0000, HCI_UART_LL, BRF_DEEP_SLEEP_OPCODE, 115200, 115200, FLOW_CTL, NULL, texas, texas_continue_script    },
+
+	{ "bcsp",       0x0000, 0x0000, HCI_UART_BCSP, 0, 115200, 115200, 0,        NULL, bcsp, NULL     },
 
 	/* Xircom PCMCIA cards: Credit Card Adapter and Real Port Adapter */
-	{ "xircom",     0x0105, 0x080a, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
+	{ "xircom",     0x0105, 0x080a, HCI_UART_H4, 0, 115200, 115200, FLOW_CTL, NULL, NULL, NULL     },
 
 	/* CSR Casira serial adapter or BrainBoxes serial dongle (BL642) */
-	{ "csr",        0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, csr      },
+	{ "csr",        0x0000, 0x0000, HCI_UART_H4, 0, 115200, 115200, FLOW_CTL, NULL, csr, NULL      },
 
 	/* BrainBoxes PCMCIA card (BL620) */
-	{ "bboxes",     0x0160, 0x0002, HCI_UART_H4,   115200, 460800, FLOW_CTL, NULL, csr      },
+	{ "bboxes",     0x0160, 0x0002, HCI_UART_H4, 0, 115200, 460800, FLOW_CTL, NULL, csr, NULL      },
 
 	/* Silicon Wave kits */
-	{ "swave",      0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, swave    },
+	{ "swave",      0x0000, 0x0000, HCI_UART_H4, 0, 115200, 115200, FLOW_CTL, NULL, swave, NULL    },
 
 	/* ST Microelectronics minikits based on STLC2410/STLC2415 */
-	{ "st",         0x0000, 0x0000, HCI_UART_H4,    57600, 115200, FLOW_CTL, NULL, st       },
+	{ "st",         0x0000, 0x0000, HCI_UART_H4, 0, 57600, 115200, FLOW_CTL, NULL, st, NULL       },
 
 	/* ST Microelectronics minikits based on STLC2500 */
-	{ "stlc2500",   0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, "00:80:E1:00:AB:BA", stlc2500  },
+	{ "stlc2500",   0x0000, 0x0000, HCI_UART_H4, 0, 115200, 115200, FLOW_CTL, "00:80:E1:00:AB:BA", stlc2500, NULL  },
 
 	/* Philips generic Ericsson IP core based */
-	{ "philips",    0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
+	{ "philips",    0x0000, 0x0000, HCI_UART_H4, 0, 115200, 115200, FLOW_CTL, NULL, NULL, NULL     },
 
 	/* Philips BGB2xx Module */
-	{ "bgb2xx",    0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, "BD:B2:10:00:AB:BA", bgb2xx   },
+	{ "bgb2xx",    0x0000, 0x0000, HCI_UART_H4, 0, 115200, 115200, FLOW_CTL, "BD:B2:10:00:AB:BA", bgb2xx, NULL   },
 
 	/* Sphinx Electronics PICO Card */
-	{ "picocard",   0x025e, 0x1000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
+	{ "picocard",   0x025e, 0x1000, HCI_UART_H4, 0, 115200, 115200, FLOW_CTL, NULL, NULL, NULL     },
 
 	/* Inventel BlueBird Module */
-	{ "inventel",   0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
+	{ "inventel",   0x0000, 0x0000, HCI_UART_H4, 0, 115200, 115200, FLOW_CTL, NULL, NULL, NULL     },
 
 	/* COM One Platinium Bluetooth PC Card */
-	{ "comone",     0xffff, 0x0101, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	{ "comone",     0xffff, 0x0101, HCI_UART_BCSP, 0, 115200, 115200, 0,        NULL, bcsp, NULL     },
 
 	/* TDK Bluetooth PC Card and IBM Bluetooth PC Card II */
-	{ "tdk",        0x0105, 0x4254, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	{ "tdk",        0x0105, 0x4254, HCI_UART_BCSP, 0, 115200, 115200, 0,        NULL, bcsp, NULL     },
 
 	/* Socket Bluetooth CF Card (Rev G) */
-	{ "socket",     0x0104, 0x0096, HCI_UART_BCSP, 230400, 230400, 0,        NULL, bcsp     },
+	{ "socket",     0x0104, 0x0096, HCI_UART_BCSP, 0, 230400, 230400, 0,        NULL, bcsp, NULL     },
 
 	/* 3Com Bluetooth Card (Version 3.0) */
-	{ "3com",       0x0101, 0x0041, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, csr      },
+	{ "3com",       0x0101, 0x0041, HCI_UART_H4, 0, 115200, 115200, FLOW_CTL, NULL, csr, NULL      },
 
 	/* AmbiCom BT2000C Bluetooth PC/CF Card */
-	{ "bt2000c",    0x022d, 0x2000, HCI_UART_H4,    57600, 460800, FLOW_CTL, NULL, csr      },
+	{ "bt2000c",    0x022d, 0x2000, HCI_UART_H4, 0, 57600, 460800, FLOW_CTL, NULL, csr, NULL      },
 
 	/* Zoom Bluetooth PCMCIA Card */
-	{ "zoom",       0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	{ "zoom",       0x0279, 0x950b, HCI_UART_BCSP, 0, 115200, 115200, 0,        NULL, bcsp, NULL     },
 
 	/* Sitecom CN-504 PCMCIA Card */
-	{ "sitecom",    0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	{ "sitecom",    0x0279, 0x950b, HCI_UART_BCSP, 0, 115200, 115200, 0,        NULL, bcsp, NULL     },
 
 	/* Billionton PCBTC1 PCMCIA Card */
-	{ "billionton", 0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	{ "billionton", 0x0279, 0x950b, HCI_UART_BCSP, 0, 115200, 115200, 0,        NULL, bcsp, NULL     },
 
 	/* Broadcom BCM2035 */
-	{ "bcm2035",    0x0A5C, 0x2035, HCI_UART_H4,   115200, 115200, 0,        NULL, bcm2035  },
+	{ "bcm2035",    0x0A5C, 0x2035, HCI_UART_H4, 0, 115200, 115200, 0,        NULL, bcm2035, NULL  },
 
 	{ NULL, 0 }
 };
@@ -1195,6 +1204,9 @@ int init_uart(char *dev, struct uart_t *u, int send_break)
 		return -1;
 	}
 
+	if (u->init_post && u->init_post(fd, u, &ti) < 0)
+		return -1;
+
 	return fd;
 }
 
@@ -1202,7 +1214,7 @@ static void usage(void)
 {
 	printf("hciattach - HCI UART driver initialization utility\n");
 	printf("Usage:\n");
-	printf("\thciattach [-n] [-p] [-b] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
+	printf("\thciattach [-n] [-p] [-b] [-g device_param] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
 	printf("\thciattach -l\n");
 }
 
@@ -1210,8 +1222,9 @@ int main(int argc, char *argv[])
 {
 	struct uart_t *u = NULL;
 	int detach, printpid, opt, i, n, ld, err;
-	int to = 5; 
+	int to = 10;
 	int init_speed = 0;
+	__u16 device_param = 0;
 	int send_break = 0;
 	pid_t pid;
 	struct sigaction sa;
@@ -1221,7 +1234,7 @@ int main(int argc, char *argv[])
 	detach = 1;
 	printpid = 0;
 
-	while ((opt=getopt(argc, argv, "bnpt:s:l")) != EOF) {
+	while ((opt=getopt(argc, argv, "bnpt:g:s:l")) != EOF) {
 		switch(opt) {
 		case 'b':
 			send_break = 1;
@@ -1239,6 +1252,10 @@ int main(int argc, char *argv[])
 			to = atoi(optarg);
 			break;
 
+		case 'g':
+			device_param = (__u16)strtol(optarg, NULL, 16);
+			break;
+
 		case 's':
 			init_speed = atoi(optarg);
 			break;
@@ -1318,12 +1335,17 @@ int main(int argc, char *argv[])
 	if (init_speed)
 		u->init_speed = init_speed;
 
+	/* If user specified a device parameter, use that instead of
+	   the hardware's default */
+	if (device_param)
+		u->device_param = device_param;
+
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags   = SA_NOCLDSTOP;
 	sa.sa_handler = sig_alarm;
 	sigaction(SIGALRM, &sa, NULL);
 
-	/* 5 seconds should be enough for initialization */
+	/* 10 seconds should be enough for initialization */
 	alarm(to);
 
 	n = init_uart(dev, u, send_break);
diff --git a/tools/hciattach.h b/tools/hciattach.h
new file mode 100644
index 0000000..c90045a
--- /dev/null
+++ b/tools/hciattach.h
@@ -0,0 +1,73 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2000-2001  Qualcomm Incorporated
+ *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
+ *  Copyright (C) 2002-2007  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __HCIATTACH_H
+#define __HCIATTACH_H
+
+#include <termios.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+
+#ifdef HCIATTACH_DEBUG
+#define DPRINTF(x...)	printf(x)
+#else
+#define DPRINTF(x...)
+#endif
+
+#ifndef N_HCI
+#define N_HCI	15
+#endif
+
+#define HCIUARTSETPROTO _IOW('U', 200, int)
+#define HCIUARTGETPROTO _IOR('U', 201, int)
+#define HCIUARTGETDEVICE _IOR('U', 202, int)
+
+#define HCI_UART_H4	0
+#define HCI_UART_BCSP	1
+#define HCI_UART_3WIRE	2
+#define HCI_UART_H4DS	3
+#define HCI_UART_LL	4
+
+struct uart_t {
+	char *type;
+	int  m_id;
+	int  p_id;
+	int  proto;
+	__u16 device_param;
+	int  init_speed;
+	int  speed;
+	int  flags;
+	char *bdaddr;
+	int  (*init) (int fd, struct uart_t *u, struct termios *ti);
+	int  (*init_post) (int fd, struct uart_t *u, struct termios *ti);
+};
+
+#define FLOW_CTL	0x0001
+
+int set_speed(int fd, struct termios *ti, int speed);
+int read_hci_event(int fd, unsigned char* buf, int size);
+
+#endif /* __HCIATTACH_H */
diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
new file mode 100644
index 0000000..d460599
--- /dev/null
+++ b/tools/hciattach_ti.c
@@ -0,0 +1,382 @@
+/*
+ *  Init procedures for Texas Instruments's chips
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2007 Texas Instruments, Inc.
+ *
+ *  Written by Ohad Ben-Cohen <ohad@bencohen.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published by
+ *  the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <syslog.h>
+#include <limits.h>
+#include <termios.h>
+#include <time.h>
+#include <sys/time.h>
+#include <sys/poll.h>
+#include <sys/param.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+
+#include "hciattach.h"
+#include "hciattach_ti.h"
+
+FILE *bts_load_script(const char* file_name, __u32* version)
+{
+	struct bts_header header;
+	FILE* fp;
+
+	fp = fopen(file_name, "rb");
+	if (!fp) {
+		perror("can't open firmware file");
+		goto out;
+	}
+
+	if (1 != fread(&header, sizeof(struct bts_header), 1, fp)) {
+		perror("can't read firmware file");
+		goto errclose;
+	}
+
+	if (header.magic != FILE_HEADER_MAGIC) {
+		fprintf(stderr, "%s not a legal TI firmware file\n", file_name);
+		goto errclose;
+	}
+
+	if (NULL != version)
+		*version = header.version;
+
+	goto out;
+
+errclose:
+	fclose(fp);
+	fp = NULL;
+out:
+	return fp;
+}
+
+unsigned long bts_fetch_action(FILE* fp,
+				unsigned char* action_buf,
+				unsigned long buf_size,
+				__u16* action_type)
+{
+	struct bts_action action_hdr;
+	unsigned long nread;
+
+	if (!fp)
+		return 0;
+
+	if (1 != fread(&action_hdr, sizeof(struct bts_action), 1, fp))
+		return 0;
+
+	if (action_hdr.size > buf_size) {
+		fprintf(stderr, "bts_next_action: not enough space to read next action\n");
+		return 0;
+	}
+
+	nread = fread(action_buf, sizeof(__u8), action_hdr.size, fp);
+	if (nread != (action_hdr.size)) {
+		fprintf(stderr, "bts_next_action: fread failed to read next action\n");
+		return 0;
+	}
+
+	*action_type = action_hdr.type;
+
+	return nread * sizeof(__u8);
+}
+
+void bts_unload_script(FILE* fp)
+{
+	if (fp)
+		fclose(fp);
+}
+
+int is_it_texas(const __u8 *respond)
+{
+	__u16 manufacturer_id;
+
+	manufacturer_id = MAKEWORD(respond[11], respond[12]);
+
+	return TI_MANUFACTURER_ID == manufacturer_id ? 1 : 0;
+}
+
+const char *get_firmware_name(const __u8 *respond)
+{
+	static char firmware_file_name[PATH_MAX] = {0};
+	__u16 version = 0, chip = 0, min_ver = 0, maj_ver = 0;
+
+	version = MAKEWORD(respond[13], respond[14]);
+	chip =  (version & 0x7C00) >> 10;
+	min_ver = (version & 0x007F);
+	maj_ver = (version & 0x0380) >> 7;
+
+	if (version & 0x8000)
+		maj_ver |= 0x0008;
+
+	sprintf(firmware_file_name, FIRMWARE_DIRECTORY "TIInit_%d.%d.%d.bts", chip, maj_ver, min_ver);
+
+	return firmware_file_name;
+}
+
+static void brf_delay(struct bts_action_delay *delay)
+{
+	usleep(1000*delay->msec);
+}
+
+static int brf_set_serial_params(struct bts_action_serial *serial_action,
+				int fd,
+				struct uart_t *u,
+				struct termios *ti)
+{
+	fprintf(stderr, "texas: changing baud rate to %u, flow control to %u\n",
+				serial_action->baud, serial_action->flow_control );
+	tcflush(fd, TCIOFLUSH);
+
+	if (serial_action->flow_control)
+		ti->c_cflag |= CRTSCTS;
+	else
+		ti->c_cflag &= ~CRTSCTS;
+
+	if (tcsetattr(fd, TCSANOW, ti) < 0) {
+		perror("Can't set port settings");
+		return -1;
+	}
+
+	u->speed = serial_action->baud;
+
+	tcflush(fd, TCIOFLUSH);
+
+	if (set_speed(fd, ti, serial_action->baud) < 0) {
+		perror("Can't set baud rate");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int brf_send_command_socket(int fd, struct bts_action_send* send_action)
+{
+	char response[1024] = {0};
+	hci_command_hdr *cmd = (hci_command_hdr *) send_action->data;
+	uint16_t opcode = cmd->opcode;
+
+	struct hci_request rq;
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = cmd_opcode_ogf(opcode);
+	rq.ocf    = cmd_opcode_ocf(opcode);
+	rq.event  = EVT_CMD_COMPLETE;
+	rq.cparam = &send_action->data[3];
+	rq.clen   = send_action->data[2];
+	rq.rparam = response;
+	rq.rlen   = sizeof(response);
+
+	if (hci_send_req(fd, &rq, 15) < 0) {
+		perror("Cannot send hci command to socket");
+		return -1;
+	}
+
+	/* verify success */
+	if (response[0]) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int brf_send_command_file(int fd, struct bts_action_send* send_action, long size)
+{
+	unsigned char response[1024] = {0};
+	long ret = 0;
+
+	/* send command */
+	if (size != write(fd, send_action, size)) {
+		perror("Texas: Failed to write action command");
+		return -1;
+	}
+
+	/* read response */
+	ret = read_hci_event(fd, response, sizeof(response));
+	if (ret < 0) {
+		perror("texas: failed to read command response");
+		return -1;
+	}
+
+	/* verify success */
+	if (ret < 7 || 0 != response[6]) {
+		fprintf( stderr, "TI init command failed.\n" );
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
+
+static int brf_send_command(int fd, struct bts_action_send* send_action, long size, int hcill_installed)
+{
+	int ret = 0;
+	char *fixed_action;
+
+	/* remove packet type when giving to socket API */
+	if (hcill_installed) {
+		fixed_action = ((char *) send_action) + 1;
+		ret = brf_send_command_socket(fd, (struct bts_action_send *) fixed_action);
+	} else {
+		ret = brf_send_command_file(fd, send_action, size);
+	}
+
+	return ret;
+}
+
+static int brf_do_action(	__u16 brf_type, __u8 *brf_action,
+				long brf_size, int fd,
+				struct uart_t *u, struct termios *ti,
+				int hcill_installed)
+{
+	int ret = 0;
+
+	switch (brf_type) {
+	case ACTION_SEND_COMMAND:
+		DPRINTF("W");
+		ret = brf_send_command(fd, (struct bts_action_send*) brf_action, brf_size, hcill_installed);
+		break;
+	case ACTION_WAIT_EVENT:
+		DPRINTF("R");
+		break;
+	case ACTION_SERIAL:
+		DPRINTF("S");
+		ret = brf_set_serial_params((struct bts_action_serial *) brf_action, fd, u, ti);
+		break;
+	case ACTION_DELAY:
+		DPRINTF("D");
+		brf_delay((struct bts_action_delay *) brf_action);
+		break;
+	case ACTION_REMARKS:
+		DPRINTF("C");
+		break;
+	default:
+		fprintf(stderr, "brf_init: unknown firmware action type (%d)\n", brf_type);
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * tests whether a given brf action is a HCI_VS_Sleep_Mode_Configurations cmd
+ */
+static int brf_action_is_deep_sleep(struct uart_t *u, __u8 *brf_action, long brf_size, __u16 brf_type)
+{
+	__u16 opcode;
+
+	if (brf_type != ACTION_SEND_COMMAND)
+		return 0;
+
+	if (brf_size < 3)
+		return 0;
+
+	if (brf_action[0] != HCI_COMMAND_PKT)
+		return 0;
+
+	/* HCI data is little endian */
+	opcode = brf_action[1] | (brf_action[2] << 8);
+
+	if (opcode != u->device_param)
+		return 0;
+
+	/* action is deep sleep configuration command ! */
+	return 1;
+}
+
+/*
+ * This function is called twice.
+ * The first time it is called, it loads the brf script, and executes its
+ * commands until it reaches a deep sleep command (or its end).
+ * The second time it is called, it assumes HCILL protocol is set up,
+ * and sends rest of brf script via the supplied socket.
+ */
+int brf_do_script(int fd, struct uart_t *u, struct termios *ti, const char *bts_file)
+{
+	int ret = 0,  hcill_installed = bts_file ? 0 : 1;
+	__u32 vers;
+	static FILE *brf_script_file = NULL;
+	static __u8 brf_action[256];
+	static long brf_size;
+	static __u16 brf_type;
+
+	/* is it the first time we are called ? */
+	if (0 == hcill_installed) {
+		DPRINTF("Sending script to serial device\n");
+		brf_script_file = bts_load_script(bts_file, &vers );
+		if (!brf_script_file) {
+			fprintf(stderr, "Warning: cannot find BTS file: %s\n",
+					bts_file);
+			return 0;
+		}
+
+		fprintf( stderr, "Loaded BTS script version %u\n", vers );
+
+		brf_size = bts_fetch_action(	brf_script_file,
+						brf_action,
+						sizeof(brf_action),
+						&brf_type );
+		if (brf_size == 0) {
+			fprintf(stderr, "Warning: BTS file is empty !");
+			return 0;
+		}
+	}
+	else {
+		DPRINTF("Sending script to bluetooth socket\n");
+	}
+
+	/* execute current action and continue to parse brf script file */
+	while (brf_size != 0) {
+		ret = brf_do_action(	brf_type, brf_action, brf_size,
+					fd, u, ti, hcill_installed);
+		if (ret == -1)
+			break;
+
+		brf_size = bts_fetch_action(	brf_script_file,
+						brf_action,
+						sizeof(brf_action),
+						&brf_type );
+
+		/* if this is the first time we run (no HCILL yet) */
+		/* and a deep sleep command is encountered */
+		/* we exit */
+		if (	0 == hcill_installed &&
+			brf_action_is_deep_sleep(u, brf_action,
+						brf_size, brf_type))
+			return 0;
+	}
+
+	bts_unload_script(brf_script_file);
+	brf_script_file = NULL;
+	DPRINTF("\n");
+
+	return ret;
+}
diff --git a/tools/hciattach_ti.h b/tools/hciattach_ti.h
new file mode 100644
index 0000000..8836bbc
--- /dev/null
+++ b/tools/hciattach_ti.h
@@ -0,0 +1,107 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  required procedures for initializing TI's BRF chips.
+ *
+ *  Copyright (C) 2007 Texas Instruments, Inc.
+ *
+ *  Written by Ohad Ben-Cohen <ohad@bencohen.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published by
+ *  the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __HCIATTACH_TI_H
+#define __HCIATTACH_TI_H
+
+#include <linux/types.h>
+#include <unistd.h>
+#include <termios.h>
+
+#include "hciattach.h"
+
+#ifndef MAKEWORD
+#define MAKEWORD(a, b)      ((__u16)(((__u8)(a)) | ((__u16)((__u8)(b))) << 8))
+#endif
+
+#define TI_MANUFACTURER_ID		13
+
+#define FIRMWARE_DIRECTORY 		"/lib/firmware/"
+
+#define ACTION_SEND_COMMAND		1
+#define ACTION_WAIT_EVENT		2
+#define ACTION_SERIAL			3
+#define ACTION_DELAY			4
+#define ACTION_RUN_SCRIPT		5
+#define ACTION_REMARKS			6
+
+#define BRF_DEEP_SLEEP_OPCODE_BYTE_1 	0x0c
+#define BRF_DEEP_SLEEP_OPCODE_BYTE_2 	0xfd
+#define BRF_DEEP_SLEEP_OPCODE		\
+	(BRF_DEEP_SLEEP_OPCODE_BYTE_1 |(BRF_DEEP_SLEEP_OPCODE_BYTE_2 << 8))
+
+#define FILE_HEADER_MAGIC   		0x42535442
+
+/*
+ * BRF Firmware header
+ */
+struct bts_header {
+	__u32	magic;
+	__u32	version;
+	__u8	future[24];
+	__u8	actions[0];
+}__attribute__ ((packed));
+
+/*
+ * BRF Actions structure
+ */
+struct bts_action {
+	__u16	type;
+	__u16	size;
+	__u8	data[0];
+} __attribute__ ((packed));
+
+struct bts_action_send
+{
+	__u8 data[0];
+} __attribute__ ((packed));
+
+struct bts_action_wait
+{
+	__u32 msec;
+	__u32 size;
+	__u8 data[0];
+}__attribute__ ((packed));
+
+struct bts_action_delay
+{
+	__u32 msec;
+}__attribute__ ((packed));
+
+struct bts_action_serial
+{
+	__u32 baud;
+	__u32 flow_control;
+}__attribute__ ((packed));
+
+FILE *bts_load_script(const char* file_name, __u32* version);
+unsigned long bts_fetch_action( FILE* fp, unsigned char* action_buf,
+				unsigned long buf_size, __u16* action_type);
+void bts_unload_script(FILE* fp);
+const char * get_firmware_name(const __u8* respond);
+int brf_do_script(	int fd, struct uart_t *u, struct termios *ti,
+			const char *bts_file);
+int is_it_texas(const __u8* respond);
+
+#endif /* __HCIATTACH_TI_H */
-- 
1.5.0.6
