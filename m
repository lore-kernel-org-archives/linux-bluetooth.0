Return-Path: <fchevalier@silicom.fr>
Message-ID: <470A24D6.70901@silicom.fr>
Date: Mon, 08 Oct 2007 14:38:46 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] STLC2500 updated patch
References: <470A11D3.10707@silicom.fr> <1191842227.7931.3.camel@aeonflux.holtmann.net>
In-Reply-To: <1191842227.7931.3.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed;
 boundary="------------010707070507010901080605"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010707070507010901080605
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit


And finally the last of the list:

* Makes the firmware & parameters download optional : even though those
are supposed to be mandatory, practive shows that the chip can run
without them.

Cheers,

Fabien

--------------010707070507010901080605
Content-Type: text/x-patch;
 name="hciattach-stl2500-cleanup-and-fix-4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hciattach-stl2500-cleanup-and-fix-4.patch"

--- tools/hciattach_st.c	2007-10-08 13:47:07.000000000 +0200
+++ ../tools/hciattach_st.c	2007-10-08 14:35:41.000000000 +0200
@@ -122,7 +122,7 @@
 	unsigned char cmd[256];
 	unsigned char buf[256];
 	uint8_t seqnum = 0;
-	int fd, size, len;
+	int fd, size, len, found_fw_file;
 
 	memset(filename, 0, sizeof(filename));
 
@@ -138,6 +138,7 @@
 			return -errno;
 	}
 
+	found_fw_file = 0;	
 	while (1) {
 		d = readdir(dir);
 		if (!d)
@@ -152,10 +153,14 @@
 
 		snprintf(filename, sizeof(filename), "%s/%s",
 							pathname, d->d_name);
+		found_fw_file = 1;
 	}
 
 	closedir(dir);
 
+	if (!found_fw_file)
+		return -ENOENT;
+
 	printf("Loading file %s\n", filename);
 
 	fd = open(filename, O_RDONLY);
@@ -194,6 +199,7 @@
 	unsigned char buf[254];
 	uint16_t version;
 	int len;
+	int err;
 
 	/* Hci_Cmd_Ericsson_Read_Revision_Information */	
 	len = do_command(dd, 0xff, 0x000f, NULL, 0, buf, sizeof(buf));
@@ -209,11 +215,21 @@
 
 	version = buf[2] << 8 | buf[1];
 
-	if (load_file(dd, version, ".ptc") < 0)
-		return -1;
+	err = load_file(dd, version, ".ptc");
+	if (err < 0) {
+		if (err == -ENOENT) 	
+			fprintf(stderr, "No ROM patch file loaded.\n");
+		else
+			return -1;
+	}
 
-	if (load_file(dd, buf[2] << 8 | buf[1], ".ssf") < 0)
-		return -1;
+	err = load_file(dd, buf[2] << 8 | buf[1], ".ssf");
+	if (err < 0) {
+		if (err == -ENOENT) 	
+			fprintf(stderr, "No static settings file loaded.\n");
+		else
+			return -1;
+	}
 
 	cmd[0] = 0xfe;
 	cmd[1] = 0x06;

--------------010707070507010901080605
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


--------------010707070507010901080605--
