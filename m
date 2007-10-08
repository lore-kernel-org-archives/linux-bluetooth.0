Return-Path: <fchevalier@silicom.fr>
Message-ID: <470A1639.7020302@silicom.fr>
Date: Mon, 08 Oct 2007 13:36:25 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] STLC2500 updated patch
References: <470A11D3.10707@silicom.fr> <1191842227.7931.3.camel@aeonflux.holtmann.net>
In-Reply-To: <1191842227.7931.3.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed;
 boundary="------------060508050000040701000808"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060508050000040701000808
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:

> please break this down into four separate patches. I hate big patches
> that try to fix everything in one go.
> 

Second on the list : remove duplicated code between ericsson and st 
initialization methods.

Fabien

--------------060508050000040701000808
Content-Type: text/x-patch;
 name="hciattach-stl2500-cleanup-and-fix-2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="hciattach-stl2500-cleanup-and-fix-2.patch"

Index: tools/hciattach.c
===================================================================
--- tools/hciattach.c	(.../tags/20070928_1730)	(révision 105)
+++ tools/hciattach.c	(.../branches/20070928_1730)	(révision 105)
@@ -829,62 +849,20 @@
 
 extern int stlc2500_init(int fd, bdaddr_t *bdaddr);
 
 static int stlc2500(int fd, struct uart_t *u, struct termios *ti)
 {
 	bdaddr_t bdaddr;
-	char cmd[5];
 	unsigned char resp[10];
 	int n;
+	int rvalue;
 
-	/* STLC2500 Set Baud Rate stuff */
-	/* We should set the baud rate first, so the firmware download */
-	/* goes much faster */
-
-	/* STLC2500 Seems to support the Ericsson set baud rate stuff */
-	/* It should also support the ST Set Baud Rate command */
-	/* (as in st() function above, but those commands never succeed */
-	cmd[0] = HCI_COMMAND_PKT;
-	cmd[1] = 0x09;
-	cmd[2] = 0xfc;
-	cmd[3] = 0x01;
-
-	switch (u->speed) {
-	case 57600:
-		cmd[4] = 0x03;
-		break;
-	case 115200:
-		cmd[4] = 0x02;
-		break;
-	case 230400:
-		cmd[4] = 0x01;
-		break;
-	case 460800:
-		cmd[4] = 0x00;
-		break;
-	case 921600:
-		cmd[4] = 0x20;
-		break;
-	default:
-		cmd[4] = 0x02;
-		u->speed = 115200;
-		break;
-	}
-
-#ifdef STLC2500_DEBUG
-	fprintf(stderr, "Sending Baud Rate %02x\n", cmd[4]);
-#endif
-	/* Send initialization command */
-	if (write(fd, cmd, 5) != 5) {
-		perror("Failed to write init command");
-		return -1;
-	}
-
-	/* Need to wait here to give a chance for the device to set baud */
-	/* But no more than 0.5 seconds */
-	usleep(200000);
+	/* STLC2500 has an ericsson core */
+	rvalue = ericsson(fd, u, ti);
+	if (rvalue != 0)
+		return rvalue;
 
 #ifdef STLC2500_DEBUG
 	fprintf(stderr, "Setting speed\n");
 #endif
 	if (set_speed(fd, ti, u->speed) < 0) {
 		perror("Can't set baud rate");


--------------060508050000040701000808
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fchevalier.vcf"

YmVnaW46dmNhcmQNCmZuOkZhYmllbiBDSEVWQUxJRVINCm46Q0hFVkFMSUVSO0ZhYmllbg0K
b3JnOlNJTElDT00NCmFkcjo7OzQgcnVlIGRlIEpvdWFuZXQ7IFJFTk5FUyBBVEFMQU5URTs7
MzU3MDA7RlJBTkNFDQplbWFpbDtpbnRlcm5ldDpmY2hldmFsaWVyQHNpbGljb20uZnINCnRp
dGxlOlNvZnR3YXJlICYgU3R1ZGllcyBFbmdpbmVlcg0KdGVsO3dvcms6KzMzICgwKSAyIDk5
IDg0IDE3IDE3DQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------060508050000040701000808--
