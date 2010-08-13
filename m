Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH v2 1/2] Bluetooth: Option to enable power management from host
Date: Fri, 13 Aug 2010 12:06:47 +0530
Message-ID: <1281681408-27376-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This provides a new option for hciattach to enable hardware specific
power management from host.
This option by default will be disabled for existing devices
---
 tools/hciattach.8 |   13 ++++++++
 tools/hciattach.c |   88 ++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/tools/hciattach.8 b/tools/hciattach.8
index 9bd1538..f443dff 100644
--- a/tools/hciattach.8
+++ b/tools/hciattach.8
@@ -122,7 +122,20 @@ the serial link (
 set by default. To force no flow control use
 .B noflow
 instead.
+.TP
+.I sleep
+Enables hardware specific power management feature. If
+.I sleep
+is appended to the list of options then this feature is enabled. To disable
+this feature use
+.B nosleep
+instead.
+All above mentioned device types have
+.B nosleep
+set by default.
 
+Note: This option will only be valid for hardware which support
+hardware specific power management enable option from host.
 .TP
 .I bdaddr
 The
diff --git a/tools/hciattach.c b/tools/hciattach.c
index 81aea7b..8616899 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -63,12 +63,15 @@ struct uart_t {
 	int  init_speed;
 	int  speed;
 	int  flags;
+	int  pm;
 	char *bdaddr;
 	int  (*init) (int fd, struct uart_t *u, struct termios *ti);
 	int  (*post) (int fd, struct uart_t *u, struct termios *ti);
 };
 
 #define FLOW_CTL	0x0001
+#define ENABLE_PM	1
+#define DISABLE_PM	0
 
 static volatile sig_atomic_t __io_canceled = 0;
 
@@ -1006,72 +1009,100 @@ static int bcm2035(int fd, struct uart_t *u, struct termios *ti)
 }
 
 struct uart_t uart[] = {
-	{ "any",        0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
-	{ "ericsson",   0x0000, 0x0000, HCI_UART_H4,   57600,  115200, FLOW_CTL, NULL, ericsson },
-	{ "digi",       0x0000, 0x0000, HCI_UART_H4,   9600,   115200, FLOW_CTL, NULL, digi     },
+	{ "any",        0x0000, 0x0000, HCI_UART_H4,   115200, 115200,
+				FLOW_CTL, DISABLE_PM, NULL, NULL     },
 
-	{ "bcsp",       0x0000, 0x0000, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	{ "ericsson",   0x0000, 0x0000, HCI_UART_H4,   57600,  115200,
+				FLOW_CTL, DISABLE_PM, NULL, ericsson },
+
+	{ "digi",       0x0000, 0x0000, HCI_UART_H4,   9600,   115200,
+				FLOW_CTL, DISABLE_PM, NULL, digi     },
+
+	{ "bcsp",       0x0000, 0x0000, HCI_UART_BCSP, 115200, 115200,
+				0, DISABLE_PM, NULL, bcsp     },
 
 	/* Xircom PCMCIA cards: Credit Card Adapter and Real Port Adapter */
-	{ "xircom",     0x0105, 0x080a, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
+	{ "xircom",     0x0105, 0x080a, HCI_UART_H4,   115200, 115200,
+				FLOW_CTL, DISABLE_PM,  NULL, NULL     },
 
 	/* CSR Casira serial adapter or BrainBoxes serial dongle (BL642) */
-	{ "csr",        0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, csr      },
+	{ "csr",        0x0000, 0x0000, HCI_UART_H4,   115200, 115200,
+				FLOW_CTL, DISABLE_PM, NULL, csr      },
 
 	/* BrainBoxes PCMCIA card (BL620) */
-	{ "bboxes",     0x0160, 0x0002, HCI_UART_H4,   115200, 460800, FLOW_CTL, NULL, csr      },
+	{ "bboxes",     0x0160, 0x0002, HCI_UART_H4,   115200, 460800,
+				FLOW_CTL, DISABLE_PM, NULL, csr      },
 
 	/* Silicon Wave kits */
-	{ "swave",      0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, swave    },
+	{ "swave",      0x0000, 0x0000, HCI_UART_H4,   115200, 115200,
+				FLOW_CTL, DISABLE_PM, NULL, swave    },
 
 	/* Texas Instruments Bluelink (BRF) modules */
-	{ "texas",      0x0000, 0x0000, HCI_UART_LL,   115200, 115200, FLOW_CTL, NULL, texas,    texas2 },
-	{ "texasalt",   0x0000, 0x0000, HCI_UART_LL,   115200, 115200, FLOW_CTL, NULL, texasalt, NULL   },
+	{ "texas",      0x0000, 0x0000, HCI_UART_LL,   115200, 115200,
+				FLOW_CTL, DISABLE_PM, NULL, texas,    texas2 },
+
+	{ "texasalt",   0x0000, 0x0000, HCI_UART_LL,   115200, 115200,
+				FLOW_CTL, DISABLE_PM, NULL, texasalt, NULL   },
 
 	/* ST Microelectronics minikits based on STLC2410/STLC2415 */
-	{ "st",         0x0000, 0x0000, HCI_UART_H4,    57600, 115200, FLOW_CTL, NULL, st       },
+	{ "st",         0x0000, 0x0000, HCI_UART_H4,    57600, 115200,
+				FLOW_CTL, DISABLE_PM,  NULL, st       },
 
 	/* ST Microelectronics minikits based on STLC2500 */
-	{ "stlc2500",   0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, "00:80:E1:00:AB:BA", stlc2500 },
+	{ "stlc2500",   0x0000, 0x0000, HCI_UART_H4, 115200, 115200,
+			FLOW_CTL, DISABLE_PM, "00:80:E1:00:AB:BA", stlc2500 },
 
 	/* Philips generic Ericsson IP core based */
-	{ "philips",    0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
+	{ "philips",    0x0000, 0x0000, HCI_UART_H4,   115200, 115200,
+				FLOW_CTL, DISABLE_PM, NULL, NULL     },
 
 	/* Philips BGB2xx Module */
-	{ "bgb2xx",    0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, "BD:B2:10:00:AB:BA", bgb2xx },
+	{ "bgb2xx",    0x0000, 0x0000, HCI_UART_H4,   115200, 115200,
+			FLOW_CTL, DISABLE_PM, "BD:B2:10:00:AB:BA", bgb2xx },
 
 	/* Sphinx Electronics PICO Card */
-	{ "picocard",   0x025e, 0x1000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
+	{ "picocard",   0x025e, 0x1000, HCI_UART_H4, 115200, 115200,
+				FLOW_CTL, DISABLE_PM, NULL, NULL     },
 
 	/* Inventel BlueBird Module */
-	{ "inventel",   0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, NULL     },
+	{ "inventel",   0x0000, 0x0000, HCI_UART_H4, 115200, 115200,
+				FLOW_CTL, DISABLE_PM, NULL, NULL     },
 
 	/* COM One Platinium Bluetooth PC Card */
-	{ "comone",     0xffff, 0x0101, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	{ "comone",     0xffff, 0x0101, HCI_UART_BCSP, 115200, 115200,
+				0, DISABLE_PM,  NULL, bcsp     },
 
 	/* TDK Bluetooth PC Card and IBM Bluetooth PC Card II */
-	{ "tdk",        0x0105, 0x4254, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	{ "tdk",        0x0105, 0x4254, HCI_UART_BCSP, 115200, 115200,
+				0, DISABLE_PM, NULL, bcsp     },
 
 	/* Socket Bluetooth CF Card (Rev G) */
-	{ "socket",     0x0104, 0x0096, HCI_UART_BCSP, 230400, 230400, 0,        NULL, bcsp     },
+	{ "socket",     0x0104, 0x0096, HCI_UART_BCSP, 230400, 230400,
+				0, DISABLE_PM, NULL, bcsp     },
 
 	/* 3Com Bluetooth Card (Version 3.0) */
-	{ "3com",       0x0101, 0x0041, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, csr      },
+	{ "3com",       0x0101, 0x0041, HCI_UART_H4,   115200, 115200,
+				FLOW_CTL, DISABLE_PM, NULL, csr      },
 
 	/* AmbiCom BT2000C Bluetooth PC/CF Card */
-	{ "bt2000c",    0x022d, 0x2000, HCI_UART_H4,    57600, 460800, FLOW_CTL, NULL, csr      },
+	{ "bt2000c",    0x022d, 0x2000, HCI_UART_H4,    57600, 460800,
+				FLOW_CTL, DISABLE_PM, NULL, csr      },
 
 	/* Zoom Bluetooth PCMCIA Card */
-	{ "zoom",       0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	{ "zoom",       0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200,
+				0, DISABLE_PM, NULL, bcsp     },
 
 	/* Sitecom CN-504 PCMCIA Card */
-	{ "sitecom",    0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	{ "sitecom",    0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200,
+				0, DISABLE_PM, NULL, bcsp     },
 
 	/* Billionton PCBTC1 PCMCIA Card */
-	{ "billionton", 0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        NULL, bcsp     },
+	{ "billionton", 0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200,
+				0, DISABLE_PM, NULL, bcsp     },
 
 	/* Broadcom BCM2035 */
-	{ "bcm2035",    0x0A5C, 0x2035, HCI_UART_H4,   115200, 460800, FLOW_CTL, NULL, bcm2035  },
+	{ "bcm2035",    0x0A5C, 0x2035, HCI_UART_H4,   115200, 460800,
+				FLOW_CTL, DISABLE_PM, NULL, bcm2035  },
 
 	{ NULL, 0 }
 };
@@ -1290,6 +1321,13 @@ int main(int argc, char *argv[])
 			break;
 
 		case 4:
+			if (!strcmp("sleep", argv[optind]))
+				u->pm = ENABLE_PM;
+			else
+				u->pm = DISABLE_PM;
+			break;
+
+		case 5:
 			u->bdaddr = argv[optind];
 			break;
 		}
-- 
1.7.0.4

