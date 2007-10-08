Return-Path: <fchevalier@silicom.fr>
Message-ID: <470A11D3.10707@silicom.fr>
Date: Mon, 08 Oct 2007 13:17:39 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [PATCH] STLC2500 updated patch
Content-Type: multipart/mixed;
 boundary="------------080102010909030701060708"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080102010909030701060708
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Marcel & all,

Here is an updated version of the STLC2500 patch. Compared to previous 
patch versions, it adds support to speeds up to 4000000 bps.

* Add support for speed up to 4000000 bps.
* Makes the firmware & parameters download optional : even though those 
are supposed to be mandatory, practive shows that the chip can run 
without them.
* Cleanup the speed setting step : call the Ericsson routines directly 
instead of duplicating the code.
* Reset the chip only once after all settings & downloads have been done.

Cheers,

Fabien

--------------080102010909030701060708
Content-Type: text/x-patch;
 name="hciattach-stl2500-cleanup-and-fix.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="hciattach-stl2500-cleanup-and-fix.patch"

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
Index: tools/hciattach_st.c
===================================================================
--- tools/hciattach_st.c	(.../tags/20070928_1730)	(révision 105)
+++ tools/hciattach_st.c	(.../branches/20070928_1730)	(révision 105)
@@ -119,13 +119,13 @@
 	DIR *dir;
 	struct dirent *d;
 	char pathname[PATH_MAX], filename[NAME_MAX], prefix[20];
 	unsigned char cmd[256];
 	unsigned char buf[256];
 	uint8_t seqnum = 0;
-	int fd, size, len;
+	int fd, size, len, found_fw_file;
 
 	memset(filename, 0, sizeof(filename));
 
 	snprintf(prefix, sizeof(prefix), "STLC2500_R%d_%02d_",
 						version >> 8, version & 0xff);
 
@@ -135,12 +135,13 @@
 		strcpy(pathname, ".");
 		dir = opendir(pathname);
 		if (!dir)
 			return -errno;
 	}
 
+	found_fw_file = 0;	
 	while (1) {
 		d = readdir(dir);
 		if (!d)
 			break;
 
 		if (strncmp(d->d_name + strlen(d->d_name) - strlen(suffix),
@@ -149,16 +150,20 @@
 
 		if (strncmp(d->d_name, prefix, strlen(prefix)))
 			continue;
 
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
 	if (fd < 0) {
 		perror("Can't open firmware file");
 		return -errno;
@@ -191,47 +196,54 @@
 int stlc2500_init(int dd, bdaddr_t *bdaddr)
 {
 	unsigned char cmd[16];
 	unsigned char buf[254];
 	uint16_t version;
 	int len;
+	int err;
 
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
-
-	len = do_command(dd, 0x03, 0x0003, NULL, 0, buf, sizeof(buf));
-	if (len < 0)
-		return -1;
+	version = buf[2] << 8 | buf[1];
 
-	len = do_command(dd, 0xff, 0x000f, NULL, 0, buf, sizeof(buf));
-	if (len < 0)
-		return -1;
+	err = load_file(dd, version, ".ptc");
+	if (err < 0) {
+		if (err == -ENOENT) 	
+			fprintf(stderr, "No ROM patch file loaded.\n");
+		else
+			return -1;
+	}
 
-	printf("%s\n", buf);
+	err = load_file(dd, buf[2] << 8 | buf[1], ".ssf");
+	if (err < 0) {
+		if (err == -ENOENT) 	
+			fprintf(stderr, "No static settings file loaded.\n");
+		else
+			return -1;
+	}
 
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

--------------080102010909030701060708
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
--------------080102010909030701060708--
