Return-Path: <cyrus@holtmann.org>
Message-ID: <4E64D1B4.9020300@visionsystems.de>
Date: Mon, 05 Sep 2011 15:42:12 +0200
From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] hciattach: fix serial speed setting for wl1271
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-bluetooth.vger.kernel.org>

override speed setting if firmware script issues serial settings command,
otherwise the value given in the firmware script will be overridden.

Example:

hciattach /dev/ttyO1 texas 115200

will fail, because /dev/ttyO1 will be opened with 115200 b/s, then
the firmware script will set the buadrate to 3000000 b/s, after UART init
hciattach.c will set the baudrate to 115200, so communication is broken.

The only correct way is to set both speeds:

hciattach -s 115200 /dev/ttyO1 texas 3000000

With this patch only initial speed must be specified. The former semantic
will be preserved in case the firmware script doesn't provide serial
settings action.

Tested with wl1271 and firmware TIInit_7.2.31.bts

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 tools/hciattach.c    |    2 +-
 tools/hciattach.h    |    2 +-
 tools/hciattach_ti.c |   19 +++++++++++--------
 3 files changed, 13 insertions(+), 10 deletions(-)

Index: b/tools/hciattach.c
===================================================================
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -296,7 +296,7 @@
 
 static int texas(int fd, struct uart_t *u, struct termios *ti)
 {
-	return texas_init(fd, ti);
+	return texas_init(fd, &u->speed, ti);
 }
 
 static int texas2(int fd, struct uart_t *u, struct termios *ti)
Index: b/tools/hciattach.h
===================================================================
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -45,7 +45,7 @@
 int read_hci_event(int fd, unsigned char* buf, int size);
 int set_speed(int fd, struct termios *ti, int speed);
 
-int texas_init(int fd, struct termios *ti);
+int texas_init(int fd, int *speed, struct termios *ti);
 int texas_post(int fd, struct termios *ti);
 int texasalt_init(int fd, int speed, struct termios *ti);
 int stlc2500_init(int fd, bdaddr_t *bdaddr);
Index: b/tools/hciattach_ti.c
===================================================================
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -210,7 +210,7 @@
 }
 
 static int brf_set_serial_params(struct bts_action_serial *serial_action,
-						int fd, struct termios *ti)
+						int fd, int *speed, struct termios *ti)
 {
 	fprintf(stderr, "texas: changing baud rate to %u, flow control to %u\n",
 				serial_action->baud, serial_action->flow_control );
@@ -233,6 +233,9 @@
 		return -1;
 	}
 
+	if (speed)
+		*speed = serial_action->baud;
+
 	return 0;
 }
 
@@ -312,7 +315,7 @@
 }
 
 static int brf_do_action(uint16_t brf_type, uint8_t *brf_action, long brf_size,
-				int fd, struct termios *ti, int hcill_installed)
+				int fd, int *speed, struct termios *ti, int hcill_installed)
 {
 	int ret = 0;
 
@@ -326,7 +329,7 @@
 		break;
 	case ACTION_SERIAL:
 		DPRINTF("S");
-		ret = brf_set_serial_params((struct bts_action_serial *) brf_action, fd, ti);
+		ret = brf_set_serial_params((struct bts_action_serial *) brf_action, fd, speed, ti);
 		break;
 	case ACTION_DELAY:
 		DPRINTF("D");
@@ -377,7 +380,7 @@
  * The second time it is called, it assumes HCILL protocol is set up,
  * and sends rest of brf script via the supplied socket.
  */
-static int brf_do_script(int fd, struct termios *ti, const char *bts_file)
+static int brf_do_script(int fd, int *speed, struct termios *ti, const char *bts_file)
 {
 	int ret = 0,  hcill_installed = bts_file ? 0 : 1;
 	uint32_t vers;
@@ -412,7 +415,7 @@
 	/* execute current action and continue to parse brf script file */
 	while (brf_size != 0) {
 		ret = brf_do_action(brf_type, brf_action, brf_size,
-						fd, ti, hcill_installed);
+						fd, speed, ti, hcill_installed);
 		if (ret == -1)
 			break;
 
@@ -435,7 +438,7 @@
 	return ret;
 }
 
-int texas_init(int fd, struct termios *ti)
+int texas_init(int fd, int *speed, struct termios *ti)
 {
 	struct timespec tm = {0, 50000};
 	char cmd[4];
@@ -486,7 +489,7 @@
 	bts_file = get_firmware_name(resp);
 	fprintf(stderr, "Firmware file : %s\n", bts_file);
 
-	n = brf_do_script(fd, ti, bts_file);
+	n = brf_do_script(fd, speed, ti, bts_file);
 
 	nanosleep(&tm, NULL);
 
@@ -520,7 +523,7 @@
 		return -1;
 	}
 
-	ret = brf_do_script(dd, ti, NULL);
+	ret = brf_do_script(dd, NULL, ti, NULL);
 
 	hci_close_dev(dd);
 
