Return-Path: <fabchevalier@free.fr>
Message-ID: <4704E820.3090605@free.fr>
Date: Thu, 04 Oct 2007 15:18:24 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>, denis.kenzior@trolltech.com
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] makes STLC2500 start without files download
 &	other cleanup
References: <47049EBF.2000103@silicom.fr> <4704DFAC.2050709@silicom.fr>
In-Reply-To: <4704DFAC.2050709@silicom.fr>
Content-Type: multipart/mixed;
 boundary="------------070205080600000102020603"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070205080600000102020603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Rereading my own code,
same patch but with coding rules fixes :-)

Fabien

--------------070205080600000102020603
Content-Type: text/x-patch;
 name="hciattach-stl2500-cleanup-and-fix.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="hciattach-stl2500-cleanup-and-fix.patch"

Index: tools/hciattach.c
===================================================================
--- tools/hciattach.c	(.../trunk)	(révision 89)
+++ tools/hciattach.c	(.../branches/20070928_1730)	(révision 89)
@@ -829,62 +829,20 @@
 
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
+	if(rvalue != 0)
+		return rvalue;
 
 #ifdef STLC2500_DEBUG
 	fprintf(stderr, "Setting speed\n");
 #endif
 	if (set_speed(fd, ti, u->speed) < 0) {
 		perror("Can't set baud rate");
Index: tools/hciattach_st.c
===================================================================
--- tools/hciattach_st.c	(.../trunk)	(révision 89)
+++ tools/hciattach_st.c	(.../branches/20070928_1730)	(révision 89)
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
 
+	if(!found_fw_file)
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
+	if(err < 0) {
+		if(err == -ENOENT) 	
+			fprintf(stderr, "No ROM patch file loaded.\n");
+		else
+			return -1;
+	}
 
-	printf("%s\n", buf);
+	err = load_file(dd, buf[2] << 8 | buf[1], ".ssf");
+	if(err < 0) {
+		if(err == -ENOENT) 	
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


--------------070205080600000102020603--
