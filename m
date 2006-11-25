Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 25 Nov 2006 22:35:25 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dcLaFAKYApMTg/W"
Message-Id: <200611252235.25637.dgollub@suse.de>
Subject: [Bluez-devel] [PATCH] Replaced isprint() with a more multibyte
	friendly check
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

--Boundary-00=_dcLaFAKYApMTg/W
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

there is a problem with multibyte chars when scanning with hcitool scan.
This problem appears only when the device name was not stored in the adapters 
name list. I replace some isprint() with a more multibyte friendly check. 
This should avoid this problem and print also full names with multibyte chars 
included.

best regards,
Daniel

--Boundary-00=_dcLaFAKYApMTg/W
Content-Type: text/x-diff; charset="us-ascii"; name="bluez-hcitool-mb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-hcitool-mb.diff"

Index: tools/hciconfig.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hciconfig.c,v
retrieving revision 1.83
diff -u -r1.83 hciconfig.c
--- tools/hciconfig.c	21 Nov 2006 15:44:56 -0000	1.83
+++ tools/hciconfig.c	25 Nov 2006 21:24:16 -0000
@@ -473,9 +473,11 @@
 			exit(1);
 		}
 
-		for (i = 0; i < 248 && name[i]; i++)
-			if (!isprint(name[i]))
+		for (i = 0; i < 248 && name[i]; i++) {
+			if ((unsigned char) name[i] < 32 || name[i] == 127)
 				name[i] = '.';
+		}
+
 		name[248] = '\0';
 
 		print_dev_hdr(&di);
@@ -1002,9 +1004,11 @@
 				str = malloc(len);
 				if (str) {
 					snprintf(str, len, "%s", ptr);
-					for (i = 0; i < len - 1; i++)
-						if (!isprint(str[i]))
+					for (i = 0; i < len - 1; i++) {
+						if ((unsigned char) str[i] < 32 || str[i] == 127)
 							str[i] = '.';
+					}
+
 					printf("\t%s local name: \'%s\'\n",
 						type == 0x08 ? "Shortened" : "Complete", str);
 					free(str);
Index: tools/hcitool.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hcitool.c,v
retrieving revision 1.91
diff -u -r1.91 hcitool.c
--- tools/hcitool.c	29 Sep 2006 11:42:14 -0000	1.91
+++ tools/hcitool.c	25 Nov 2006 21:24:16 -0000
@@ -546,9 +546,11 @@
 					sizeof(name), name, 100000) < 0)
 				strcpy(name, "n/a");
 
-			for (n = 0; n < 248 && name[n]; n++)
-				if (!isprint(name[n]))
-					name[n] = '.';
+			for (n = 0; n < 248 && name[n]; n++) {
+				if ((unsigned char) name[i] < 32 || name[i] == 127)
+					name[i] = '.';
+			}
+
 			name[248] = '\0';
 
 			printf("\t%s\t%s\n", addr, name);
@@ -605,9 +607,11 @@
 				if (!nc)
 					strcpy(name, "n/a");
 			} else {
-				for (n = 0; n < 248 && name[n]; n++)
-					if (!isprint(name[n]))
-						name[n] = '.';
+				for (n = 0; n < 248 && name[n]; n++) {
+					if ((unsigned char) name[i] < 32 || name[i] == 127)
+						name[i] = '.';
+				}
+
 				name[248] = '\0';
 				nc = 0;
 			}

--Boundary-00=_dcLaFAKYApMTg/W
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_dcLaFAKYApMTg/W
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_dcLaFAKYApMTg/W--
