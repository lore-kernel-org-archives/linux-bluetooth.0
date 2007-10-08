Return-Path: <fchevalier@silicom.fr>
Message-ID: <470A146C.3060806@silicom.fr>
Date: Mon, 08 Oct 2007 13:28:44 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] STLC2500 updated patch
References: <470A11D3.10707@silicom.fr> <1191842227.7931.3.camel@aeonflux.holtmann.net>
In-Reply-To: <1191842227.7931.3.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed;
 boundary="------------090508020803010307030804"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090508020803010307030804
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit


> please break this down into four separate patches. I hate big patches
> that try to fix everything in one go.
> 

First of the list : provide support for higher baud rates for ericcson 
based chipsets.

Fabien



--------------090508020803010307030804
Content-Type: text/x-patch;
 name="hciattach-stl2500-cleanup-and-fix-1.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="hciattach-stl2500-cleanup-and-fix-1.patch"

Index: tools/hciattach.c
===================================================================
--- tools/hciattach.c	(.../tags/20070928_1730)	(révision 105)
+++ tools/hciattach.c	(.../branches/20070928_1730)	(révision 105)
@@ -117,12 +117,22 @@
 	case 1000000:
 		return B1000000;
 	case 1152000:
 		return B1152000;
 	case 1500000:
 		return B1500000;
+	case 2000000:
+		return B2000000;
+	case 2500000:
+		return B2500000;
+	case 3000000:
+		return B3000000;
+	case 3500000:
+		return B3500000;
+	case 4000000:
+		return B4000000;
 	default:
 		return B57600;
 	}
 }
 
 static int set_speed(int fd, struct termios *ti, int speed)
@@ -203,15 +213,25 @@
 	case 460800:
 		cmd[4] = 0x00;
 		break;
 	case 921600:
 		cmd[4] = 0x20;
 		break;
+	case 2000000:
+		cmd[4] = 0x25;
+		break;
+	case 3000000:
+		cmd[4] = 0x27;
+		break;
+	case 4000000:
+		cmd[4] = 0x2B;
+		break;
 	default:
 		cmd[4] = 0x03;
 		u->speed = 57600;
+		fprintf(stderr, "Invalid speed requested, using %d bps instead\n", u->speed);
 		break;
 	}
 
 	/* Send initialization command */
 	if (write(fd, cmd, 5) != 5) {
 		perror("Failed to write init command");


--------------090508020803010307030804
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fchevalier.vcf"

begin:vcard
fn:Fabien CHEVALIER
n:CHEVALIER;Fabien
org:SILICOM
adr:;;4 rue de Jouanet; RENNES ATALANTE;;35700;FRANCE
email;internet:fchevalier@silicom.fr
title:Software & Studies Engineer
tel;work:+33 (0) 2 99 84 17 17
version:2.1
end:vcard


--------------090508020803010307030804--
