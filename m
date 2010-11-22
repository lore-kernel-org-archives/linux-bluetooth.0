Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH] hciattach: download configuration at maximum baud rate possible
Date: Mon, 22 Nov 2010 16:28:00 +0530
Message-ID: <1290423480-29840-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch support downloading configuration files for
Atheros AR300x HCI UART chip at user requested baud rate
instead of the initial baud rate.
---
 tools/hciattach.c       |    2 +-
 tools/hciattach.h       |    3 +-
 tools/hciattach_ath3k.c |   97 +++++++++++++++++++++++++++++++++-------------
 3 files changed, 72 insertions(+), 30 deletions(-)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index fd53710..a47fa55 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -304,7 +304,7 @@ static int texasalt(int fd, struct uart_t *u, struct termios *ti)
 
 static int ath3k_ps(int fd, struct uart_t *u, struct termios *ti)
 {
-	return ath3k_init(fd, u->bdaddr, u->speed);
+	return ath3k_init(fd, u->speed, u->init_speed, u->bdaddr, ti);
 }
 
 static int ath3k_pm(int fd, struct uart_t *u, struct termios *ti)
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 2d26b77..fed0d11 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -50,6 +50,7 @@ int texas_post(int fd, struct termios *ti);
 int texasalt_init(int fd, int speed, struct termios *ti);
 int stlc2500_init(int fd, bdaddr_t *bdaddr);
 int bgb2xx_init(int dd, bdaddr_t *bdaddr);
-int ath3k_init(int fd, char *bdaddr, int speed);
+int ath3k_init(int fd, int speed, int init_speed, char *bdaddr,
+						struct termios *ti);
 int ath3k_post(int fd, int pm);
 int qualcomm_init(int fd, int speed, struct termios *ti, const char *bdaddr);
diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index 70ade30..5df20d8 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -922,14 +922,49 @@ int ath3k_post(int fd, int pm)
 #define WRITE_BAUD_CMD_LEN   6
 #define MAX_CMD_LEN          WRITE_BDADDR_CMD_LEN
 
+static int set_cntrlr_baud(int fd, int speed)
+{
+	int baud;
+	struct timespec tm = { 0, 500000 };
+	unsigned char cmd[MAX_CMD_LEN], rsp[HCI_MAX_EVENT_SIZE];
+	unsigned char *ptr = cmd + 1;
+	hci_command_hdr *ch = (void *)ptr;
+
+	cmd[0] = HCI_COMMAND_PKT;
+
+	/* set controller baud rate to user specified value */
+	ptr = cmd + 1;
+	ch->opcode = htobs(cmd_opcode_pack(HCI_VENDOR_CMD_OGF,
+						HCI_CHG_BAUD_CMD_OCF));
+	ch->plen = 2;
+	ptr += HCI_COMMAND_HDR_SIZE;
+
+	baud = speed/100;
+	ptr[0] = (char)baud;
+	ptr[1] = (char)(baud >> 8);
+
+	if (write(fd, cmd, WRITE_BAUD_CMD_LEN) != WRITE_BAUD_CMD_LEN) {
+		perror("Failed to write change baud rate command");
+		return -ETIMEDOUT;
+	}
+
+	nanosleep(&tm, NULL);
+
+	if (read_hci_event(fd, rsp, sizeof(rsp)) < 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 /*
  * Atheros AR300x specific initialization and configuration file
  * download
  */
-int ath3k_init(int fd, char *bdaddr, int speed)
+int ath3k_init(int fd, int speed, int init_speed, char *bdaddr,
+						struct termios *ti)
 {
 	int r;
-	int baud;
+	int err = 0;
 	struct timespec tm = { 0, 500000 };
 	unsigned char cmd[MAX_CMD_LEN], rsp[HCI_MAX_EVENT_SIZE];
 	unsigned char *ptr = cmd + 1;
@@ -937,11 +972,22 @@ int ath3k_init(int fd, char *bdaddr, int speed)
 
 	cmd[0] = HCI_COMMAND_PKT;
 
+	/* set both controller and host baud rate to maximum possible value */
+	err = set_cntrlr_baud(fd, speed);
+	if (err < 0)
+		return err;
+
+	if (set_speed(fd, ti, speed) < 0) {
+		perror("Can't set required baud rate");
+		return -1;
+	}
+
 	/* Download PS and patch */
 	r = ath_ps_download(fd);
 	if (r < 0) {
 		perror("Failed to Download configuration");
-		return -ETIMEDOUT;
+		err = -ETIMEDOUT;
+		goto exit;
 	}
 
 	/* Write BDADDR */
@@ -960,12 +1006,14 @@ int ath3k_init(int fd, char *bdaddr, int speed)
 		if (write(fd, cmd, WRITE_BDADDR_CMD_LEN) !=
 					WRITE_BDADDR_CMD_LEN) {
 			perror("Failed to write BD_ADDR command\n");
-			return -ETIMEDOUT;
+			err = -ETIMEDOUT;
+			goto exit;
 		}
 
 		if (read_hci_event(fd, rsp, sizeof(rsp)) < 0) {
 			perror("Failed to set BD_ADDR\n");
-			return -ETIMEDOUT;
+			err = -ETIMEDOUT;
+			goto exit;
 		}
 	}
 
@@ -975,33 +1023,26 @@ int ath3k_init(int fd, char *bdaddr, int speed)
 	cmd[3] = 0x00;
 
 	r = write(fd, cmd, 4);
-	if (r != 4)
-		return -ETIMEDOUT;
+	if (r != 4) {
+		err = -ETIMEDOUT;
+		goto exit;
+	}
 
 	nanosleep(&tm, NULL);
-	if (read_hci_event(fd, rsp, sizeof(rsp)) < 0)
-		return -ETIMEDOUT;
-
-	/* set controller baud rate to user specified value */
-	ptr = cmd + 1;
-	ch->opcode = htobs(cmd_opcode_pack(HCI_VENDOR_CMD_OGF,
-						HCI_CHG_BAUD_CMD_OCF));
-	ch->plen = 2;
-	ptr += HCI_COMMAND_HDR_SIZE;
-
-	baud = speed/100;
-	ptr[0] = (char)baud;
-	ptr[1] = (char)(baud >> 8);
-
-	if (write(fd, cmd, WRITE_BAUD_CMD_LEN) != WRITE_BAUD_CMD_LEN) {
-		perror("Failed to write change baud rate command");
-		return -ETIMEDOUT;
+	if (read_hci_event(fd, rsp, sizeof(rsp)) < 0) {
+		err = -ETIMEDOUT;
+		goto exit;
 	}
 
-	nanosleep(&tm, NULL);
+	err = set_cntrlr_baud(fd, speed);
+	if (err < 0)
+		return err;
 
-	if (read_hci_event(fd, rsp, sizeof(rsp)) < 0)
-		return -ETIMEDOUT;
+exit:
+	if (err < 0) {
+		set_cntrlr_baud(fd, init_speed);
+		set_speed(fd, ti, init_speed);
+	}
 
-	return 0;
+	return err;
 }
-- 
1.7.0.4

