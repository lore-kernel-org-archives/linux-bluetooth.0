Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <908666c60601201207x7a2adfa5g@mail.gmail.com>
From: Pierre Michon <pierre.michon@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_11150_24831054.1137787653847"
Subject: [Bluez-devel] hciattach for bcm2035
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 20 Jan 2006 21:07:33 +0100

------=_Part_11150_24831054.1137787653847
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have extracted from jungo modification of bluez [1], the vendor code
for changing the baudrate.
It could useful for embedded device that use broadcom chip.

Pierre


[1] http://openboxes.free.fr/download/ad6843/rg-bluetooth_4.0.29_2005121413=
41-src.tar.bz2

------=_Part_11150_24831054.1137787653847
Content-Type: application/octet-stream; name=hciattach_bcm2035.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="hciattach_bcm2035.patch"

--- hciattach.c.org	2006-01-20 21:04:48.000000000 +0100
+++ hciattach.c	2006-01-20 21:03:29.000000000 +0100
@@ -802,6 +802,117 @@
 	return 0;
 }
 
+
+/*
+ * Broadcom specific initialization
+ * Extracted from Jungo openrg
+ */
+static int bcm2035(int fd, struct uart_t *u, struct termios *ti)
+{
+	int n;
+	unsigned char cmd[30], resp[30];
+
+	/* Reset the BT Chip */
+	memset(cmd, 0, sizeof(cmd));
+	memset(resp, 0, sizeof(resp));
+	cmd[0] = HCI_COMMAND_PKT;
+	cmd[1] = 0x03;
+	cmd[2] = 0x0c;
+	cmd[3] = 0x00;
+	/* Send command */
+	if (write(fd, cmd, 4) != 4) {
+		fprintf(stderr, "Failed to write reset command\n");
+		return -1;
+	}
+	/* Read reply */
+	if ((n = read_hci_event(fd, resp, 4)) < 0) {
+	        fprintf(stderr, "Failed to reset chip\n");
+                return -1;
+	}
+
+	/* Read the local version info */
+	memset(cmd, 0, sizeof(cmd));
+	memset(resp, 0, sizeof(resp));
+	cmd[0] = HCI_COMMAND_PKT;
+	cmd[1] = 0x01;
+	cmd[2] = 0x10;
+	cmd[3] = 0x00;
+	/* Send command */
+	if (write(fd, cmd, 4) != 4) {
+		fprintf(stderr, "Failed to write \"read local version\" "
+			"command\n");
+		return -1;
+	}
+	/* Read reply */
+	if ((n = read_hci_event(fd, resp, 4)) < 0) {
+		fprintf(stderr, "Failed to read local version\n");
+                return -1;
+	}
+
+	/* Read the local supported commands info */
+	memset(cmd, 0, sizeof(cmd));
+	memset(resp, 0, sizeof(resp));
+	cmd[0] = HCI_COMMAND_PKT;
+	cmd[1] = 0x02;
+	cmd[2] = 0x10;
+	cmd[3] = 0x00;
+	/* Send command */
+	if (write(fd, cmd, 4) != 4) {
+		fprintf(stderr, "Failed to write \"read local supported "
+			"commands\" command\n");
+		return -1;
+	}
+	/* Read reply */
+	if ((n = read_hci_event(fd, resp, 4)) < 0) {
+		fprintf(stderr, "Failed to read local supported commands\n");
+                return -1;
+	}
+
+	/* Set the baud rate */
+	memset(cmd, 0, sizeof(cmd));
+	memset(resp, 0, sizeof(resp));
+	cmd[0] = HCI_COMMAND_PKT;
+	cmd[1] = 0x18;
+	cmd[2] = 0xfc;
+	cmd[3] = 0x02;
+	switch (u->speed) {
+	case 57600:
+	    cmd[4] = 0x00;
+	    cmd[5] = 0xe6;
+	    break;
+	case 230400:
+	    cmd[4] = 0x22;
+	    cmd[5] = 0xfa;
+	    break;
+	case 460800:
+	    cmd[4] = 0x11;
+	    cmd[5] = 0xfd;
+	    break;
+	case 921600:
+	    cmd[4] = 0x65;
+	    cmd[5] = 0xff;
+	    break;
+	default:
+	    /* Default is 115200 */
+	    cmd[4] = 0x00;
+	    cmd[5] = 0xf3;
+	    break;
+	}
+	fprintf(stderr, "Baud rate parameters: DHBR=0x%2x,DLBR=0x%2x\n",
+		cmd[4], cmd[5]);
+
+	/* Send command */
+	if (write(fd, cmd, 6) != 6) {
+		fprintf(stderr, "Failed to write \"set baud rate\" command\n");
+		return -1;
+	}
+	if ((n = read_hci_event(fd, resp, 6)) < 0) {
+	        fprintf(stderr, "Failed to set baud rate\n");
+                return -1;
+	}
+	return 0;
+}
+
 struct uart_t uart[] = {
 	{ "any",        0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL     },
 	{ "ericsson",   0x0000, 0x0000, HCI_UART_H4,   57600,  115200, FLOW_CTL, ericsson },
@@ -855,6 +966,9 @@
 	/* Billionton PCBTC1 PCMCIA Card */
 	{ "billionton", 0x0279, 0x950b, HCI_UART_BCSP, 115200, 115200, 0,        bcsp     },
 
+	/* Broadcom BCM2035 */
+	{ "bcm2035",  0x0A5C, 0x2035, HCI_UART_H4,   115200, 115200 , 0, bcm2035 },
+
 	{ NULL, 0 }
 };
 


------=_Part_11150_24831054.1137787653847--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
