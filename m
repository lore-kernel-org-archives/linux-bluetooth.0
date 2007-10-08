Return-Path: <fchevalier@silicom.fr>
Message-ID: <470A194E.4000106@silicom.fr>
Date: Mon, 08 Oct 2007 13:49:34 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] STLC2500 updated patch
References: <470A11D3.10707@silicom.fr> <1191842227.7931.3.camel@aeonflux.holtmann.net>
In-Reply-To: <1191842227.7931.3.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed;
 boundary="------------000505000804080200080701"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000505000804080200080701
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit


> please break this down into four separate patches. I hate big patches
> that try to fix everything in one go.
> 
Third on the list: Retrieve version string before anything else, remove 
bogus resets, add OCF & OGF comments.

Cheers,

Fabien

--------------000505000804080200080701
Content-Type: text/x-patch;
 name="hciattach-stl2500-cleanup-and-fix-3.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="hciattach-stl2500-cleanup-and-fix-3.patch"

Index: tools/hciattach_st.c
===================================================================
--- tools/hciattach_st.c	(.../tags/20070928_1730)	(révision 107)
+++ tools/hciattach_st.c	(.../branches/20070928_1730)	(révision 107)
@@ -192,46 +197,42 @@
 {
 	unsigned char cmd[16];
 	unsigned char buf[254];
 	uint16_t version;
 	int len;
 
-	len = do_command(dd, 0x04, 0x0001, NULL, 0, buf, sizeof(buf));
+	/* Hci_Cmd_Ericsson_Read_Revision_Information */	
+	len = do_command(dd, 0xff, 0x000f, NULL, 0, buf, sizeof(buf));
 	if (len < 0)
 		return -1;
 
-	version = buf[2] << 8 | buf[1];
-
-	if (load_file(dd, version, ".ptc") < 0)
-		return -1;
+	printf("%s\n", buf);
 
-	len = do_command(dd, 0x03, 0x0003, NULL, 0, buf, sizeof(buf));
+	/* HCI_Read_Local_Version_Information */	
+	len = do_command(dd, 0x04, 0x0001, NULL, 0, buf, sizeof(buf));
 	if (len < 0)
 		return -1;
 
-	if (load_file(dd, buf[2] << 8 | buf[1], ".ssf") < 0)
-		return -1;
+	version = buf[2] << 8 | buf[1];
 
-	len = do_command(dd, 0x03, 0x0003, NULL, 0, buf, sizeof(buf));
-	if (len < 0)
+	if (load_file(dd, version, ".ptc") < 0)
 		return -1;
 
-	len = do_command(dd, 0xff, 0x000f, NULL, 0, buf, sizeof(buf));
-	if (len < 0)
+	if (load_file(dd, buf[2] << 8 | buf[1], ".ssf") < 0)
 		return -1;
 
-	printf("%s\n", buf);
-
 	cmd[0] = 0xfe;
 	cmd[1] = 0x06;
 	bacpy((bdaddr_t *) (cmd + 2), bdaddr);
 
+	/* Hci_Cmd_ST_Store_In_NVDS */	
 	len = do_command(dd, 0xff, 0x0022, cmd, 8, buf, sizeof(buf));
 	if (len < 0)
 		return -1;
 
+	/* HCI_Reset : applies parameters*/
 	len = do_command(dd, 0x03, 0x0003, NULL, 0, buf, sizeof(buf));
 	if (len < 0)
 		return -1;
 
 	return 0;
 }


--------------000505000804080200080701
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


--------------000505000804080200080701--
