Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 5/6] Remove extra spaces from tools dir
Date: Fri,  7 May 2010 00:27:11 +0200
Message-Id: <1273184832-8265-5-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1273184832-8265-1-git-send-email-santoscadenas@gmail.com>
References: <1273184832-8265-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/bccmd.c           |    2 +-
 tools/dfutool.c         |    4 +-
 tools/hciattach.c       |   48 +++++++++++++++++++++++-----------------------
 tools/hciattach_st.c    |   12 +++++-----
 tools/hciattach_ti.c    |    2 +-
 tools/hciattach_tialt.c |   22 ++++++++++----------
 tools/hciconfig.c       |    6 ++--
 tools/kword.h           |    2 +-
 tools/main.c            |    6 ++--
 tools/ppporc.c          |    4 +-
 tools/sdptool.c         |   36 +++++++++++++++++-----------------
 11 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/tools/bccmd.c b/tools/bccmd.c
index 921bd20..686e858 100644
--- a/tools/bccmd.c
+++ b/tools/bccmd.c
@@ -984,7 +984,7 @@ static int cmd_psread(int transport, int argc, char *argv[])
 			str = NULL;
 		}
 
-		printf("// %s%s\n&%04x =", str ? "PSKEY_" : "", 
+		printf("// %s%s\n&%04x =", str ? "PSKEY_" : "",
 						str ? str : val, pskey);
 		for (i = 0; i < length; i++)
 			printf(" %02x%02x", array[(i * 2) + 7], array[(i * 2) + 6]);
diff --git a/tools/dfutool.c b/tools/dfutool.c
index 551af6b..16dd62e 100644
--- a/tools/dfutool.c
+++ b/tools/dfutool.c
@@ -341,7 +341,7 @@ static void cmd_verify(char *device, int argc, char **argv)
 	size = st.st_size;
 
 	if (!(buf = malloc(size))) {
-		perror("Unable to allocate file buffer"); 
+		perror("Unable to allocate file buffer");
 		exit(1);
 	}
 
@@ -442,7 +442,7 @@ static void cmd_upgrade(char *device, int argc, char **argv)
 	filesize = st.st_size;
 
 	if (!(buf = malloc(filesize))) {
-		perror("Unable to allocate file buffer"); 
+		perror("Unable to allocate file buffer");
 		exit(1);
 	}
 
diff --git a/tools/hciattach.c b/tools/hciattach.c
index 364c5ff..b13db1b 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -146,10 +146,10 @@ int set_speed(int fd, struct termios *ti, int speed)
 	return tcsetattr(fd, TCSANOW, ti);
 }
 
-/* 
+/*
  * Read an HCI event from the given file descriptor.
  */
-int read_hci_event(int fd, unsigned char* buf, int size) 
+int read_hci_event(int fd, unsigned char* buf, int size)
 {
 	int remain, r;
 	int count = 0;
@@ -177,9 +177,9 @@ int read_hci_event(int fd, unsigned char* buf, int size)
 	}
 
 	/* Now we read the parameters. */
-	if (buf[2] < (size - 3)) 
+	if (buf[2] < (size - 3))
 		remain = buf[2];
-	else 
+	else
 		remain = size - 3;
 
 	while ((count - 3) < remain) {
@@ -192,8 +192,8 @@ int read_hci_event(int fd, unsigned char* buf, int size)
 	return count;
 }
 
-/* 
- * Ericsson specific initialization 
+/*
+ * Ericsson specific initialization
  */
 static int ericsson(int fd, struct uart_t *u, struct termios *ti)
 {
@@ -247,8 +247,8 @@ static int ericsson(int fd, struct uart_t *u, struct termios *ti)
 	return 0;
 }
 
-/* 
- * Digianswer specific initialization 
+/*
+ * Digianswer specific initialization
  */
 static int digi(int fd, struct uart_t *u, struct termios *ti)
 {
@@ -306,7 +306,7 @@ static int read_check(int fd, void *buf, int count)
 	do {
 		res = read(fd, buf, count);
 		if (res != -1) {
-			buf += res; 
+			buf += res;
 			count -= res;
 		}
 	} while (count && (errno == 0 || errno == EINTR));
@@ -480,8 +480,8 @@ static int bcsp(int fd, struct uart_t *u, struct termios *ti)
 	return 0;
 }
 
-/* 
- * CSR specific initialization 
+/*
+ * CSR specific initialization
  * Inspired strongly by code in OpenBT and experimentations with Brainboxes
  * Pcmcia card.
  * Jean Tourrilhes <jt@hpl.hp.com> - 14.11.01
@@ -544,7 +544,7 @@ static int csr(int fd, struct uart_t *u, struct termios *ti)
 			return -1;
 		}
 
-	/* Event code 0xFF is for vendor-specific events, which is 
+	/* Event code 0xFF is for vendor-specific events, which is
 	 * what we're looking for. */
 	} while (resp[1] != 0xFF);
 
@@ -560,7 +560,7 @@ static int csr(int fd, struct uart_t *u, struct termios *ti)
 	}
 #endif
 	/* Display that to user */
-	fprintf(stderr, "CSR build ID 0x%02X-0x%02X\n", 
+	fprintf(stderr, "CSR build ID 0x%02X-0x%02X\n",
 		resp[15] & 0xFF, resp[14] & 0xFF);
 
 	/* Try to read the current speed of the CSR chip */
@@ -588,7 +588,7 @@ static int csr(int fd, struct uart_t *u, struct termios *ti)
 			return -1;
 		}
 
-	/* Event code 0xFF is for vendor-specific events, which is 
+	/* Event code 0xFF is for vendor-specific events, which is
 	 * what we're looking for. */
 	} while (resp[1] != 0xFF);
 
@@ -602,7 +602,7 @@ static int csr(int fd, struct uart_t *u, struct termios *ti)
 #endif
 
 	if (u->speed > 1500000) {
-		fprintf(stderr, "Speed %d too high. Remaining at %d baud\n", 
+		fprintf(stderr, "Speed %d too high. Remaining at %d baud\n",
 			u->speed, u->init_speed);
 		u->speed = u->init_speed;
 	} else if (u->speed != 57600 && uart_speed(u->speed) == B57600) {
@@ -652,8 +652,8 @@ static int csr(int fd, struct uart_t *u, struct termios *ti)
 	return 0;
 }
 
-/* 
- * Silicon Wave specific initialization 
+/*
+ * Silicon Wave specific initialization
  * Thomas Moser <thomas.moser@tmoser.ch>
  */
 static int swave(int fd, struct uart_t *u, struct termios *ti)
@@ -669,7 +669,7 @@ static int swave(int fd, struct uart_t *u, struct termios *ti)
 	// Subcommand", e.g. "soft reset" to make the changes effective.
 
 	cmd[0] = HCI_COMMAND_PKT;	// it's a command packet
-	cmd[1] = 0x0B;			// OCF 0x0B	= param access set	
+	cmd[1] = 0x0B;			// OCF 0x0B	= param access set
 	cmd[2] = 0xfc;			// OGF bx111111 = vendor specific
 	cmd[3] = 0x06;			// 6 bytes of data following
 	cmd[4] = 0x01;			// param sub command
@@ -703,9 +703,9 @@ static int swave(int fd, struct uart_t *u, struct termios *ti)
 		return -1;
 	}
 
-	// We should wait for a "GET Event" to confirm the success of 
-	// the baud rate setting. Wait some time before reading. Better:  
-	// read with timeout, parse data 
+	// We should wait for a "GET Event" to confirm the success of
+	// the baud rate setting. Wait some time before reading. Better:
+	// read with timeout, parse data
 	// until correct answer, else error handling ... todo ...
 
 	nanosleep(&tm, NULL);
@@ -749,7 +749,7 @@ static int swave(int fd, struct uart_t *u, struct termios *ti)
 	// now the uart baud rate on the silicon wave module is set and effective.
 	// change our own baud rate as well. Then there is a reset event comming in
  	// on the *new* baud rate. This is *undocumented*! The packet looks like this:
-	// 04 FF 01 0B (which would make that a confirmation of 0x0B = "Param 
+	// 04 FF 01 0B (which would make that a confirmation of 0x0B = "Param
 	// subcommand class". So: change to new baud rate, read with timeout, parse
 	// data, error handling. BTW: all param access in Silicon Wave is done this way.
 	// Maybe this code would belong in a seperate file, or at least code reuse...
@@ -1259,7 +1259,7 @@ int main(int argc, char *argv[])
 				fprintf(stderr, "Unknown device type or id\n");
 				exit(1);
 			}
-			
+
 			break;
 
 		case 2:
@@ -1300,7 +1300,7 @@ int main(int argc, char *argv[])
 
 	n = init_uart(dev, u, send_break);
 	if (n < 0) {
-		perror("Can't initialize device"); 
+		perror("Can't initialize device");
 		exit(1);
 	}
 
diff --git a/tools/hciattach_st.c b/tools/hciattach_st.c
index f10bcf6..dbb7c47 100644
--- a/tools/hciattach_st.c
+++ b/tools/hciattach_st.c
@@ -140,7 +140,7 @@ static int load_file(int dd, uint16_t version, const char *suffix)
 			return -errno;
 	}
 
-	found_fw_file = 0;	
+	found_fw_file = 0;
 	while (1) {
 		d = readdir(dir);
 		if (!d)
@@ -203,14 +203,14 @@ int stlc2500_init(int dd, bdaddr_t *bdaddr)
 	int len;
 	int err;
 
-	/* Hci_Cmd_Ericsson_Read_Revision_Information */	
+	/* Hci_Cmd_Ericsson_Read_Revision_Information */
 	len = do_command(dd, 0xff, 0x000f, NULL, 0, buf, sizeof(buf));
 	if (len < 0)
 		return -1;
 
 	printf("%s\n", buf);
 
-	/* HCI_Read_Local_Version_Information */	
+	/* HCI_Read_Local_Version_Information */
 	len = do_command(dd, 0x04, 0x0001, NULL, 0, buf, sizeof(buf));
 	if (len < 0)
 		return -1;
@@ -219,7 +219,7 @@ int stlc2500_init(int dd, bdaddr_t *bdaddr)
 
 	err = load_file(dd, version, ".ptc");
 	if (err < 0) {
-		if (err == -ENOENT) 	
+		if (err == -ENOENT)
 			fprintf(stderr, "No ROM patch file loaded.\n");
 		else
 			return -1;
@@ -227,7 +227,7 @@ int stlc2500_init(int dd, bdaddr_t *bdaddr)
 
 	err = load_file(dd, buf[2] << 8 | buf[1], ".ssf");
 	if (err < 0) {
-		if (err == -ENOENT) 	
+		if (err == -ENOENT)
 			fprintf(stderr, "No static settings file loaded.\n");
 		else
 			return -1;
@@ -237,7 +237,7 @@ int stlc2500_init(int dd, bdaddr_t *bdaddr)
 	cmd[1] = 0x06;
 	bacpy((bdaddr_t *) (cmd + 2), bdaddr);
 
-	/* Hci_Cmd_ST_Store_In_NVDS */	
+	/* Hci_Cmd_ST_Store_In_NVDS */
 	len = do_command(dd, 0xff, 0x0022, cmd, 8, buf, sizeof(buf));
 	if (len < 0)
 		return -1;
diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
index bf91e40..7627bc1 100644
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -446,7 +446,7 @@ int texas_init(int fd, struct termios *ti)
 
 	memset(resp,'\0', 100);
 
-	/* It is possible to get software version with manufacturer specific 
+	/* It is possible to get software version with manufacturer specific
 	   HCI command HCI_VS_TI_Version_Number. But the only thing you get more
 	   is if this is point-to-point or point-to-multipoint module */
 
diff --git a/tools/hciattach_tialt.c b/tools/hciattach_tialt.c
index 11a7ebd..1ba009c 100644
--- a/tools/hciattach_tialt.c
+++ b/tools/hciattach_tialt.c
@@ -68,10 +68,10 @@ static int read_command_complete(int fd, unsigned short opcode, unsigned char le
 	/* Read reply. */
 	FAILIF(read_hci_event(fd, (unsigned char *)&resp, sizeof(resp)) < 0,
 		   "Failed to read response");
-	
+
 	/* Parse speed-change reply */
 	FAILIF(resp.uart_prefix != HCI_EVENT_PKT,
-		   "Error in response: not an event packet, but 0x%02x!\n", 
+		   "Error in response: not an event packet, but 0x%02x!\n",
 		   resp.uart_prefix);
 
 	FAILIF(resp.hci_hdr.evt != EVT_CMD_COMPLETE, /* event must be event-complete */
@@ -107,7 +107,7 @@ static int texas_load_firmware(int fd, const char *firmware) {
 
 	fprintf(stdout, "Opening firmware file: %s\n", firmware);
 
-	FAILIF(fw < 0, 
+	FAILIF(fw < 0,
 		   "Could not open firmware file %s: %s (%d).\n",
 		   firmware, strerror(errno), errno);
 
@@ -123,17 +123,17 @@ static int texas_load_firmware(int fd, const char *firmware) {
 			break;
 		FAILIF(nr != sizeof(cmdp), "Could not read H4 + HCI header!\n");
 		FAILIF(*cmdp != HCI_COMMAND_PKT, "Command is not an H4 command packet!\n");
-		
+
 		FAILIF(read(fw, data, cmd->plen) != cmd->plen,
 			   "Could not read %d bytes of data for command with opcode %04x!\n",
 			   cmd->plen,
 			   cmd->opcode);
-				
+
 		{
 			int nw;
 #if 0
-			fprintf(stdout, "\topcode 0x%04x (%d bytes of data).\n", 
-					cmd->opcode, 
+			fprintf(stdout, "\topcode 0x%04x (%d bytes of data).\n",
+					cmd->opcode,
 					cmd->plen);
 #endif
 			struct iovec iov_cmd[2];
@@ -142,18 +142,18 @@ static int texas_load_firmware(int fd, const char *firmware) {
 			iov_cmd[1].iov_base = data;
 			iov_cmd[1].iov_len	= cmd->plen;
 			nw = writev(fd, iov_cmd, 2);
-			FAILIF(nw != (int) sizeof(cmd) +	cmd->plen, 
+			FAILIF(nw != (int) sizeof(cmd) +	cmd->plen,
 				   "Could not send entire command (sent only %d bytes)!\n",
 				   nw);
 		}
 
 		/* Wait for response */
-		if (read_command_complete(fd, 
+		if (read_command_complete(fd,
 								  cmd->opcode,
 								  cmd->plen) < 0) {
 			return -1;
 		}
-			
+
 	} while(1);
 	fprintf(stdout, "Firmware upload successful.\n");
 
@@ -170,7 +170,7 @@ int texasalt_init(int fd, int speed, struct termios *ti)
 
 	memset(resp,'\0', 100);
 
-	/* It is possible to get software version with manufacturer specific 
+	/* It is possible to get software version with manufacturer specific
 	   HCI command HCI_VS_TI_Version_Number. But the only thing you get more
 	   is if this is point-to-point or point-to-multipoint module */
 
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 3f687e0..06c9459 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -453,7 +453,7 @@ static void cmd_name(int ctl, int hdev, char *opt)
 	hci_close_dev(dd);
 }
 
-/* 
+/*
  * see http://www.bluetooth.org/assigned-numbers/baseband.htm --- all
  * strings are reproduced verbatim
  */
@@ -562,7 +562,7 @@ static char *get_minor_device_name(int major, int minor)
 		break;
 	case 5:	/* peripheral */ {
 		static char cls_str[48];
-		
+
 		cls_str[0] = '\0';
 
 		switch(minor & 48) {
@@ -1380,7 +1380,7 @@ static void cmd_page_to(int ctl, int hdev, char *opt)
 			exit(1);
 		}
 		print_dev_hdr(&di);
-		
+
 		timeout = btohs(rp.timeout);
 		printf("\tPage timeout: %u slots (%.2f ms)\n",
 				timeout, (float)timeout * 0.625);
diff --git a/tools/kword.h b/tools/kword.h
index e1cffcc..81a2a88 100644
--- a/tools/kword.h
+++ b/tools/kword.h
@@ -28,7 +28,7 @@ struct keyword_t {
 	int type;
 };
 
-extern struct keyword_t rfcomm_keyword[]; 
+extern struct keyword_t rfcomm_keyword[];
 
 int rfcomm_find_keyword(struct keyword_t *keyword, char *string);
 
diff --git a/tools/main.c b/tools/main.c
index 3baa61d..6800445 100644
--- a/tools/main.c
+++ b/tools/main.c
@@ -118,7 +118,7 @@ static void print_dev_info(struct rfcomm_dev_info *di)
 
 	printf("rfcomm%d: %s channel %d %s %s\n",
 		di->id, addr, di->channel,
-		rfcomm_state[di->state], 
+		rfcomm_state[di->state],
 		di->flags ? rfcomm_flagstostr(di->flags) : "");
 }
 
@@ -717,7 +717,7 @@ static void usage(void)
 		"\t-E, --encrypt         Enable encryption\n"
 		"\t-S, --secure          Secure connection\n"
 		"\t-M, --master          Become the master of a piconet\n"
-		"\t-f, --config [file]   Specify alternate config file\n" 
+		"\t-f, --config [file]   Specify alternate config file\n"
 		"\t-a                    Show all devices (default)\n"
 		"\n");
 
@@ -743,7 +743,7 @@ static struct option main_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-int main(int argc, char *argv[]) 
+int main(int argc, char *argv[])
 {
 	bdaddr_t bdaddr;
 	int i, opt, ctl, dev_id, show_all = 0;
diff --git a/tools/ppporc.c b/tools/ppporc.c
index eab1818..ca44b40 100644
--- a/tools/ppporc.c
+++ b/tools/ppporc.c
@@ -147,7 +147,7 @@ static int process_data(int fd)
 
 	p[0].fd = 0;
 	p[0].events = POLLIN | POLLERR | POLLHUP | POLLNVAL;
-	
+
 	p[1].fd = fd;
 	p[1].events = POLLIN | POLLERR | POLLHUP | POLLNVAL;
 
@@ -156,7 +156,7 @@ static int process_data(int fd)
 	while (!__io_canceled) {
 		p[0].revents = 0;
 		p[1].revents = 0;
-		
+
 		err = poll(p, 2, -1);
 		if (err < 0)
 			break;
diff --git a/tools/sdptool.c b/tools/sdptool.c
index 89166ae..7cca3ca 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -753,7 +753,7 @@ static void print_raw_attr(sdp_record_t *rec)
  * Set attributes with single values in SDP record
  * Jean II
  */
-static int set_attrib(sdp_session_t *sess, uint32_t handle, uint16_t attrib, char *value) 
+static int set_attrib(sdp_session_t *sess, uint32_t handle, uint16_t attrib, char *value)
 {
 	sdp_list_t *attrid_list;
 	uint32_t range = 0x0000ffff;
@@ -783,7 +783,7 @@ static int set_attrib(sdp_session_t *sess, uint32_t handle, uint16_t attrib, cha
 		sdp_attr_add_new(rec, attrib, SDP_UUID16, &value_uuid.value.uuid16);
 	} else if (!strncasecmp(value, "0x", 2)) {
 		/* Int */
-		uint32_t value_int;  
+		uint32_t value_int;
 		value_int = strtoul(value + 2, NULL, 16);
 		printf("Adding attrib 0x%X int 0x%X to record 0x%X\n",
 			attrib, value_int, handle);
@@ -811,7 +811,7 @@ static struct option set_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static const char *set_help = 
+static const char *set_help =
 	"Usage:\n"
 	"\tget record_handle attrib_id attrib_value\n";
 
@@ -949,7 +949,7 @@ static struct option seq_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static const char *seq_help = 
+static const char *seq_help =
 	"Usage:\n"
 	"\tget record_handle attrib_id attrib_values\n";
 
@@ -1685,7 +1685,7 @@ static int add_simaccess(sdp_session_t *session, svc_info_t *si)
 	sdp_record_t record;
 	uint8_t u8 = si->channel? si->channel : 8;
 	uint16_t u16 = 0x31;
-	sdp_data_t *channel, *features;	
+	sdp_data_t *channel, *features;
 	int ret = 0;
 
 	memset((void *)&record, 0, sizeof(sdp_record_t));
@@ -2250,7 +2250,7 @@ static int add_hid_keyb(sdp_session_t *session, svc_info_t *si)
 	static const uint16_t intr = 0x13;
 	static const uint16_t hid_attr[] = { 0x100, 0x111, 0x40, 0x0d, 0x01, 0x01 };
 	static const uint16_t hid_attr2[] = { 0x0, 0x01, 0x100, 0x1f40, 0x01, 0x01 };
-	const uint8_t hid_spec[] = { 
+	const uint8_t hid_spec[] = {
 		0x05, 0x01, // usage page
 		0x09, 0x06, // keyboard
 		0xa1, 0x01, // key codes
@@ -2263,14 +2263,14 @@ static int add_hid_keyb(sdp_session_t *session, svc_info_t *si)
 		0x75, 0x01, // input data variable absolute
 		0x95, 0x08, // report count
 		0x81, 0x02, // report size
-		0x75, 0x08, 
-		0x95, 0x01, 
-		0x81, 0x01, 
-		0x75, 0x01, 
+		0x75, 0x08,
+		0x95, 0x01,
+		0x81, 0x01,
+		0x75, 0x01,
 		0x95, 0x05,
 		0x05, 0x08,
 		0x19, 0x01,
-		0x29, 0x05, 
+		0x29, 0x05,
 		0x91, 0x02,
 		0x75, 0x03,
 		0x95, 0x01,
@@ -3526,7 +3526,7 @@ static struct option add_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static const char *add_help = 
+static const char *add_help =
 	"Usage:\n"
 	"\tadd [--handle=RECORD_HANDLE --channel=CHANNEL] service\n";
 
@@ -3591,7 +3591,7 @@ static int del_service(bdaddr_t *bdaddr, void *arg)
 	sdp_session_t *sess;
 	sdp_record_t *rec;
 
-	if (!arg) { 
+	if (!arg) {
 		printf("Record handle was not specified.\n");
 		return -1;
 	}
@@ -3630,7 +3630,7 @@ static struct option del_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static const char *del_help = 
+static const char *del_help =
 	"Usage:\n"
 	"\tdel record_handle\n";
 
@@ -3771,7 +3771,7 @@ static struct option browse_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static const char *browse_help = 
+static const char *browse_help =
 	"Usage:\n"
 	"\tbrowse [--tree] [--raw] [--xml] [--uuid uuid] [--l2cap] [bdaddr]\n";
 
@@ -3837,7 +3837,7 @@ static struct option search_options[] = {
 	{ 0, 0, 0, 0}
 };
 
-static const char *search_help = 
+static const char *search_help =
 	"Usage:\n"
 	"\tsearch [--bdaddr bdaddr] [--tree] [--raw] [--xml] SERVICE\n"
 	"SERVICE is a name (string) or UUID (0x1002)\n";
@@ -3996,7 +3996,7 @@ static struct option records_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static const char *records_help = 
+static const char *records_help =
 	"Usage:\n"
 	"\trecords [--tree] [--raw] [--xml] bdaddr\n";
 
@@ -4066,7 +4066,7 @@ static struct option get_options[] = {
 	{ 0, 0, 0, 0 }
 };
 
-static const char *get_help = 
+static const char *get_help =
 	"Usage:\n"
 	"\tget [--tree] [--raw] [--xml] [--bdaddr bdaddr] record_handle\n";
 
-- 
1.7.0.4

