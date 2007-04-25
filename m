Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 26 Apr 2007 08:38:54 +1000
References: <200704260742.40197.denis.kenzior@trolltech.com>
In-Reply-To: <200704260742.40197.denis.kenzior@trolltech.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+h9LGIf9vCVlEV4"
Message-Id: <200704260838.54803.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] [PATCH] STLC2500 Baud Rate & Address Setting
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_+h9LGIf9vCVlEV4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

Disregard previous, can't keep my patches straight.

Here is the good one.

-Denis

On Thursday 26 April 2007 07:42, Denis KENZIOR wrote:
> Marcel,
>
> Don't know if you missed a previous submission, but here's the fixed
> STCL2500 baud rate patch again.
>
> -Denis

--Boundary-00=_+h9LGIf9vCVlEV4
Content-Type: text/x-diff; charset="utf-8"; name="hciattach_stlc2500.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hciattach_stlc2500.patch"

Index: hciattach.8
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hciattach.8,v
retrieving revision 1.4
diff -u -5 -r1.4 hciattach.8
--- hciattach.8	1 Jun 2006 18:36:20 -0000	1.4
+++ hciattach.8	25 Apr 2007 22:38:00 -0000
@@ -9,10 +9,11 @@
 .IR timeout \|]
 .I tty
 .IR type \||\| id
 .I speed
 .I flow
+.I bdaddr
 .SH DESCRIPTION
 .LP
 Hciattach is used to attach a serial UART to the Bluetooth stack as HCI
 transport interface.
 .SH OPTIONS
@@ -103,9 +104,19 @@
 .B flow
 set by default. To force no flow control use
 .B noflow
 instead.
 
+.TP
+.I bdaddr
+The 
+.I bdaddr
+specifies the Bluetooth Address to use.  Some devices (like the STLC2500) 
+do not store the Bluetooth address in hardware memory.  Instead it must 
+be uploaded during the initialization process.  If this argument
+is specified, then the address will be used to initialize the device.
+Otherwise, a default address will be used.
+
 .SH AUTHORS
 Written by Maxim Krasnyansky <maxk@qualcomm.com>
 .PP
 Manual page by Nils Faerber <nils@kernelconcepts.de>
Index: hciattach.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hciattach.c,v
retrieving revision 1.43
diff -u -5 -r1.43 hciattach.c
--- hciattach.c	17 Jan 2007 12:31:42 -0000	1.43
+++ hciattach.c	25 Apr 2007 22:38:00 -0000
@@ -65,10 +65,11 @@
 	int  p_id;
 	int  proto;
 	int  init_speed;
 	int  speed;
 	int  flags;
+	char *bdaddr;
 	int  (*init) (int fd, struct uart_t *u, struct termios *ti);
 };
 
 #define FLOW_CTL	0x0001
 
@@ -828,23 +829,96 @@
 extern int stlc2500_init(int fd, bdaddr_t *bdaddr);
 
 static int stlc2500(int fd, struct uart_t *u, struct termios *ti)
 {
 	bdaddr_t bdaddr;
+	char cmd[5];
+	unsigned char resp[10];
+	int n;
 
-	str2ba("00:80:E1:00:AB:BA", &bdaddr);
+	/* STLC2500 Set Baud Rate stuff */
+	/* We should set the baud rate first, so the firmware download */
+	/* goes much faster */
+
+	/* STLC2500 Seems to support the Ericsson set baud rate stuff */
+	/* It should also support the ST Set Baud Rate command */
+	/* (as in st() function above, but those commands never succeed */
+	cmd[0] = HCI_COMMAND_PKT;
+	cmd[1] = 0x09;
+	cmd[2] = 0xfc;
+	cmd[3] = 0x01;
 
+	switch (u->speed) {
+	case 57600:
+		cmd[4] = 0x03;
+		break;
+	case 115200:
+		cmd[4] = 0x02;
+		break;
+	case 230400:
+		cmd[4] = 0x01;
+		break;
+	case 460800:
+		cmd[4] = 0x00;
+		break;
+	case 921600:
+		cmd[4] = 0x20;
+		break;
+	default:
+		cmd[4] = 0x02;
+		u->speed = 115200;
+		break;
+	}
+
+#ifdef STLC2500_DEBUG
+	fprintf(stderr, "Sending Baud Rate %02x\n", cmd[4]);
+#endif
+	/* Send initialization command */
+	if (write(fd, cmd, 5) != 5) {
+		perror("Failed to write init command");
+		return -1;
+	}
+
+	/* Need to wait here to give a chance for the device to set baud */
+	/* But no more than 0.5 seconds */
+	usleep(200000);
+
+#ifdef STLC2500_DEBUG
+	fprintf(stderr, "Setting speed\n");
+#endif
+	if (set_speed(fd, ti, u->speed) < 0) {
+		perror("Can't set baud rate");
+		return -1;
+	}
+
+#ifdef STLC2500_DEBUG
+	fprintf(stderr, "Speed set...\n");
+#endif
+
+	/* Read reply */
+	if ((n = read_hci_event(fd, resp, 10)) < 0) {
+		fprintf(stderr, "Failed to set baud rate on chip\n");
+		return -1;
+	}
+
+#ifdef STLC2500_DEBUG
+	for (i = 0; i < n; i++) {
+		fprintf(stderr, "resp[%d] = %02x\n", i, resp[i]);
+	}
+#endif
+
+	str2ba(u->bdaddr, &bdaddr);
 	return stlc2500_init(fd, &bdaddr);
 }
 
 extern int bgb2xx_init(int fd, bdaddr_t *bdaddr);
 
 static int bgb2xx(int fd, struct uart_t *u, struct termios *ti)
 {
 	bdaddr_t bdaddr;
 
-	str2ba("BD:B2:10:00:AB:BA", &bdaddr);
+	str2ba(u->bdaddr, &bdaddr);
 
 	return bgb2xx_init(fd, &bdaddr);
 }
 
 /*
@@ -964,73 +1038,73 @@
 
 	return 0;
 }
 
 struct uart_t uart[] = {
-	{ "any",        0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL     },
-	{ "ericsson",   0x0000, 0x0000, HCI_UART_H4,   57600,  115200, FLOW_CTL, ericsson },
-	{ "digi",       0x0000, 0x0000, HCI_UART_H4,   9600,   115200, FLOW_CTL, digi     },
-	{ "texas",      0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, texas    },
+	{ "any",        0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
+	{ "ericsson",   0x0000, 0x0000, HCI_UART_H4,   57600,  115200, FLOW_CTL, NULL, ericsson },
+	{ "digi",       0x0000, 0x0000, HCI_UART_H4,   9600,   115200, FLOW_CTL, NULL, digi     },
+	{ "texas",      0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, texas    },
 
-	{ "bcsp",       0x0000, 0x0000, HCI_UART_BCSP, 115200, 115200, 0,        bcsp     },
+	{ "bcsp",       0x0000, 0x0000, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
 
 	/* Xircom PCMCIA cards: Credit Card Adapter and Real Port Adapter */
-	{ "xircom",     0x0105, 0x080a, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL     },
+	{ "xircom",     0x0105, 0x080a, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
 
 	/* CSR Casira serial adapter or BrainBoxes serial dongle (BL642) */
-	{ "csr",        0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, csr      },
+	{ "csr",        0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, csr      },
 
 	/* BrainBoxes PCMCIA card (BL620) */
-	{ "bboxes",     0x0160, 0x0002, HCI_UART_H4,   115200, 460800, FLOW_CTL, csr      },
+	{ "bboxes",     0x0160, 0x0002, HCI_UART_H4,   115200, 460800, FLOW_CTL, NULL, csr      },
 
 	/* Silicon Wave kits */
-	{ "swave",      0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, swave    },
+	{ "swave",      0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, swave    },
 
 	/* ST Microelectronics minikits based on STLC2410/STLC2415 */
-	{ "st",         0x0000, 0x0000, HCI_UART_H4,    57600, 115200, FLOW_CTL, st       },
+	{ "st",         0x0000, 0x0000, HCI_UART_H4,    57600, 115200, FLOW_CTL, NULL, st       },
 
 	/* ST Microelectronics minikits based on STLC2500 */
-	{ "stlc2500",   0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, stlc2500 },
+	{ "stlc2500",   0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, "00:80:E1:00:AB:BA", stlc2500  },
 
 	/* Philips generic Ericsson IP core based */
-	{ "philips",    0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL     },
+	{ "philips",    0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
 
 	/* Philips BGB2xx Module */
-	{ "bgb2xx",    0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, bgb2xx   },
+	{ "bgb2xx",    0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, "BD:B2:10:00:AB:BA", bgb2xx   },
 
 	/* Sphinx Electronics PICO Card */
-	{ "picocard",   0x025e, 0x1000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL     },
+	{ "picocard",   0x025e, 0x1000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
 
 	/* Inventel BlueBird Module */
-	{ "inventel",   0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL     },
+	{ "inventel",   0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
 
 	/* COM One Platinium Bluetooth PC Card */
-	{ "comone",     0xffff, 0x0101, HCI_UART_BCSP, 115200, 115200, 0,        bcsp     },
+	{ "comone",     0xffff, 0x0101, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
 
 	/* TDK Bluetooth PC Card and IBM Bluetooth PC Card II */
-	{ "tdk",        0x0105, 0x4254, HCI_UART_BCSP, 115200, 115200, 0,        bcsp     },
+	{ "tdk",        0x0105, 0x4254, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
 
 	/* Socket Bluetooth CF Card (Rev G) */
-	{ "socket",     0x0104, 0x0096, HCI_UART_BCSP, 230400, 230400, 0,        bcsp     },
+	{ "socket",     0x0104, 0x0096, HCI_UART_BCSP, 230400, 230400, 0,        NULL, bcsp     },
 
 	/* 3Com Bluetooth Card (Version 3.0) */
-	{ "3com",       0x0101, 0x0041, HCI_UART_H4,   115200, 115200, FLOW_CTL, csr      },
+	{ "3com",       0x0101, 0x0041, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, csr      },
 
 	/* AmbiCom BT2000C Bluetooth PC/CF Card */
-	{ "bt2000c",    0x022d, 0x2000, HCI_UART_H4,    57600, 460800, FLOW_CTL, csr      },
+	{ "bt2000c",    0x022d, 0x2000, HCI_UART_H4,    57600, 460800, FLOW_CTL, NULL, csr      },
 
 	/* Zoom Bluetooth PCMCIA Card */
-	{ "zoom",       0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        bcsp     },
+	{ "zoom",       0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
 
 	/* Sitecom CN-504 PCMCIA Card */
-	{ "sitecom",    0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        bcsp     },
+	{ "sitecom",    0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
 
 	/* Billionton PCBTC1 PCMCIA Card */
-	{ "billionton", 0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        bcsp     },
+	{ "billionton", 0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
 
 	/* Broadcom BCM2035 */
-	{ "bcm2035",    0x0A5C, 0x2035, HCI_UART_H4,   115200, 115200, 0,        bcm2035  },
+	{ "bcm2035",    0x0A5C, 0x2035, HCI_UART_H4,   115200, 115200, 0,        NULL, bcm2035  },
 
 	{ NULL, 0 }
 };
 
 struct uart_t * get_by_id(int m_id, int p_id)
@@ -1126,11 +1200,11 @@
 
 static void usage(void)
 {
 	printf("hciattach - HCI UART driver initialization utility\n");
 	printf("Usage:\n");
-	printf("\thciattach [-n] [-p] [-b] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow]\n");
+	printf("\thciattach [-n] [-p] [-b] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
 	printf("\thciattach -l\n");
 }
 
 int main(int argc, char *argv[])
 {
@@ -1225,10 +1299,14 @@
 			if (!strcmp("flow", argv[optind]))
 				u->flags |=  FLOW_CTL;
 			else
 				u->flags &= ~FLOW_CTL;
 			break;
+
+		case 4:
+			u->bdaddr = argv[optind];
+			break;
 		}
 	}
 
 	if (!u) {
 		fprintf(stderr, "Unknown device type or id\n");

--Boundary-00=_+h9LGIf9vCVlEV4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_+h9LGIf9vCVlEV4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_+h9LGIf9vCVlEV4--
