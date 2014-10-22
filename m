Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: johan.hedberg@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] hciattach: bcm43xx: Use final baudrate to download the firmware
Date: Wed, 22 Oct 2014 17:08:49 +0200
Message-Id: <1413990529-1628-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Speed up bcm43xx init by setting the final baudrate before firmware
download.
---
 tools/hciattach.c         |  2 +-
 tools/hciattach.h         |  3 ++-
 tools/hciattach_bcm43xx.c | 63 +++++++++++++++++++++++++++++------------------
 3 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index bf927fc..14d3511 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -329,7 +329,7 @@ static int intel(int fd, struct uart_t *u, struct termios *ti)
 
 static int bcm43xx(int fd, struct uart_t *u, struct termios *ti)
 {
-	return bcm43xx_init(fd, u->speed, ti, u->bdaddr);
+	return bcm43xx_init(fd, u->init_speed, u->speed, ti, u->bdaddr);
 }
 
 static int read_check(int fd, void *buf, int count)
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 4810a09..2aaf075 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -58,4 +58,5 @@ int ath3k_init(int fd, int speed, int init_speed, char *bdaddr,
 int ath3k_post(int fd, int pm);
 int qualcomm_init(int fd, int speed, struct termios *ti, const char *bdaddr);
 int intel_init(int fd, int init_speed, int *speed, struct termios *ti);
-int bcm43xx_init(int fd, int speed, struct termios *ti, const char *bdaddr);
+int bcm43xx_init(int fd, int def_speed, int speed, struct termios *ti,
+		const char *bdaddr);
diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
index cb4bfb9..3d36c20 100644
--- a/tools/hciattach_bcm43xx.c
+++ b/tools/hciattach_bcm43xx.c
@@ -154,63 +154,71 @@ static int bcm43xx_set_bdaddr(int fd, const char *bdaddr)
 	return 0;
 }
 
-static int bcm43xx_set_speed(int fd, uint32_t speed)
+static int bcm43xx_set_clock(int fd, unsigned char clock)
 {
-	unsigned char cmd[] =
-		{ HCI_COMMAND_PKT, 0x18, 0xfc, 0x06, 0x00, 0x00,
-				0x00, 0x00, 0x00, 0x00 };
+	unsigned char cmd[] = { HCI_COMMAND_PKT, 0x45, 0xfc, 0x01, 0x00 };
 	unsigned char resp[CC_MIN_SIZE];
 
-	printf("Set Controller UART speed to %d bit/s\n", speed);
+	printf("Set Controller clock (%d)\n", clock);
 
-	cmd[6] = (uint8_t) (speed);
-	cmd[7] = (uint8_t) (speed >> 8);
-	cmd[8] = (uint8_t) (speed >> 16);
-	cmd[9] = (uint8_t) (speed >> 24);
+	cmd[4] = clock;
 
 	tcflush(fd, TCIOFLUSH);
 
 	if (write(fd, cmd, sizeof(cmd)) != sizeof(cmd)) {
-		fprintf(stderr, "Failed to write update baudrate command\n");
+		fprintf(stderr, "Failed to write update clock command\n");
 		return -1;
 	}
 
 	if (read_hci_event(fd, resp, sizeof(resp)) < CC_MIN_SIZE) {
-		fprintf(stderr, "Failed to update baudrate, invalid HCI event\n");
+		fprintf(stderr, "Failed to update clock, invalid HCI event\n");
 		return -1;
 	}
 
 	if (resp[4] != cmd[1] || resp[5] != cmd[2] || resp[6] != CMD_SUCCESS) {
-		fprintf(stderr, "Failed to update baudrate, command failure\n");
+		fprintf(stderr, "Failed to update clock, command failure\n");
 		return -1;
 	}
 
 	return 0;
 }
 
-static int bcm43xx_set_clock(int fd, unsigned char clock)
+static int bcm43xx_set_speed(int fd, struct termios *ti, uint32_t speed)
 {
-	unsigned char cmd[] = { HCI_COMMAND_PKT, 0x45, 0xfc, 0x01, 0x00 };
+	unsigned char cmd[] =
+		{ HCI_COMMAND_PKT, 0x18, 0xfc, 0x06, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x00 };
 	unsigned char resp[CC_MIN_SIZE];
 
-	printf("Set Controller clock (%d)\n", clock);
+	if (speed > 3000000 && bcm43xx_set_clock(fd, BCM43XX_CLOCK_48))
+		return -1;
 
-	cmd[4] = clock;
+	printf("Set Controller UART speed to %d bit/s\n", speed);
+
+	cmd[6] = (uint8_t) (speed);
+	cmd[7] = (uint8_t) (speed >> 8);
+	cmd[8] = (uint8_t) (speed >> 16);
+	cmd[9] = (uint8_t) (speed >> 24);
 
 	tcflush(fd, TCIOFLUSH);
 
 	if (write(fd, cmd, sizeof(cmd)) != sizeof(cmd)) {
-		fprintf(stderr, "Failed to write update clock command\n");
+		fprintf(stderr, "Failed to write update baudrate command\n");
 		return -1;
 	}
 
 	if (read_hci_event(fd, resp, sizeof(resp)) < CC_MIN_SIZE) {
-		fprintf(stderr, "Failed to update clock, invalid HCI event\n");
+		fprintf(stderr, "Failed to update baudrate, invalid HCI event\n");
 		return -1;
 	}
 
 	if (resp[4] != cmd[1] || resp[5] != cmd[2] || resp[6] != CMD_SUCCESS) {
-		fprintf(stderr, "Failed to update clock, command failure\n");
+		fprintf(stderr, "Failed to update baudrate, command failure\n");
+		return -1;
+	}
+
+	if (set_speed(fd, ti, speed) < 0) {
+		perror("Can't set host baud rate");
 		return -1;
 	}
 
@@ -343,7 +351,8 @@ static int bcm43xx_locate_patch(const char *dir_name,
 	return ret;
 }
 
-int bcm43xx_init(int fd, int speed, struct termios *ti, const char *bdaddr)
+int bcm43xx_init(int fd, int def_speed, int speed, struct termios *ti,
+		const char *bdaddr)
 {
 	char chip_name[20];
 	char fw_path[PATH_MAX];
@@ -359,9 +368,18 @@ int bcm43xx_init(int fd, int speed, struct termios *ti, const char *bdaddr)
 	if (bcm43xx_locate_patch(FIRMWARE_DIR, chip_name, fw_path)) {
 		fprintf(stderr, "Patch not found, continue anyway\n");
 	} else {
+		if (bcm43xx_set_speed(fd, ti, speed))
+			return -1;
+
 		if (bcm43xx_load_firmware(fd, fw_path))
 			return -1;
 
+		/* Controller speed has been reset to def speed */
+		if (set_speed(fd, ti, def_speed) < 0) {
+			perror("Can't set host baud rate");
+			return -1;
+		}
+
 		if (bcm43xx_reset(fd))
 			return -1;
 	}
@@ -369,10 +387,7 @@ int bcm43xx_init(int fd, int speed, struct termios *ti, const char *bdaddr)
 	if (bdaddr)
 		bcm43xx_set_bdaddr(fd, bdaddr);
 
-	if (speed > 3000000 && bcm43xx_set_clock(fd, BCM43XX_CLOCK_48))
-		return -1;
-
-	if (bcm43xx_set_speed(fd, speed))
+	if (bcm43xx_set_speed(fd, ti, speed))
 		return -1;
 
 	return 0;
-- 
1.8.3.2
