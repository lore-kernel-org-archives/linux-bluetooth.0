Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ao2@ao2.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCHv2 BlueZ 2/5] plugins/sixaxis: Factor out a set_leds_hidraw() function
Date: Wed, 14 May 2014 23:40:02 +0200
Message-Id: <1400103605-25183-2-git-send-email-ao2@ao2.it>
In-Reply-To: <1400103605-25183-1-git-send-email-ao2@ao2.it>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it>
 <1400103605-25183-1-git-send-email-ao2@ao2.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is in preparation for a set_leds_sysfs() function.

Make set_leds_hidraw() return void, as its return value is never used
by the caller: the setup_leds() callback has to always return FALSE.
---

Changes since v1:
  - Use capital letter after colon in the short commit message.
  - Make set_leds_hidraw() return void, its return value is never used by the
    caller.

 plugins/sixaxis.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 8045448..3a2cadf 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -125,8 +125,7 @@ static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
 	return ret;
 }
 
-static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
-							gpointer user_data)
+static void set_leds_hidraw(int fd, int number)
 {
 	/*
 	 * the total time the led is active (0xff means forever)
@@ -147,18 +146,11 @@ static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_1 */
 		0x00, 0x00, 0x00, 0x00, 0x00,
 	};
-	int number = GPOINTER_TO_INT(user_data);
 	int ret;
-	int fd;
-
-	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
-		return FALSE;
-
-	DBG("number %d", number);
 
 	/* TODO we could support up to 10 (1 + 2 + 3 + 4) */
 	if (number > 7)
-		return FALSE;
+		return;
 
 	if (number > 4) {
 		leds_report[10] |= 0x10;
@@ -167,16 +159,29 @@ static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 
 	leds_report[10] |= 0x01 << number;
 
-	fd = g_io_channel_unix_get_fd(channel);
-
 	ret = write(fd, leds_report, sizeof(leds_report));
 	if (ret == sizeof(leds_report))
-		return FALSE;
+		return;
 
 	if (ret < 0)
 		error("sixaxis: failed to set LEDS (%s)", strerror(errno));
 	else
 		error("sixaxis: failed to set LEDS (%d bytes written)", ret);
+}
+
+static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	int number = GPOINTER_TO_INT(user_data);
+	int fd;
+
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
+		return FALSE;
+
+	DBG("number %d", number);
+
+	fd = g_io_channel_unix_get_fd(channel);
+	set_leds_hidraw(fd, number);
 
 	return FALSE;
 }
-- 
2.0.0.rc2

