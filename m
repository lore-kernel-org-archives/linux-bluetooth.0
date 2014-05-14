Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ao2@ao2.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCHv2 BlueZ 3/5] plugins/sixaxis: Factor out a calc_leds_bitmap() function
Date: Wed, 14 May 2014 23:40:03 +0200
Message-Id: <1400103605-25183-3-git-send-email-ao2@ao2.it>
In-Reply-To: <1400103605-25183-1-git-send-email-ao2@ao2.it>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it>
 <1400103605-25183-1-git-send-email-ao2@ao2.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is also in preparation of set_leds_sysfs().
---

Changes since v1:
  - Use capital letter after colon in the short commit message.
  - Make the calc_bitmap() helper simply return the bitmap value and then
    treat 0 as error.

 plugins/sixaxis.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 3a2cadf..1b7bb30 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -125,7 +125,25 @@ static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
 	return ret;
 }
 
-static void set_leds_hidraw(int fd, int number)
+static uint8_t calc_leds_bitmap(int number)
+{
+	uint8_t bitmap = 0;
+
+	/* TODO we could support up to 10 (1 + 2 + 3 + 4) */
+	if (number > 7)
+		return bitmap;
+
+	if (number > 4) {
+		bitmap |= 0x10;
+		number -= 4;
+	}
+
+	bitmap |= 0x01 << number;
+
+	return bitmap;
+}
+
+static void set_leds_hidraw(int fd, uint8_t leds_bitmap)
 {
 	/*
 	 * the total time the led is active (0xff means forever)
@@ -148,16 +166,7 @@ static void set_leds_hidraw(int fd, int number)
 	};
 	int ret;
 
-	/* TODO we could support up to 10 (1 + 2 + 3 + 4) */
-	if (number > 7)
-		return;
-
-	if (number > 4) {
-		leds_report[10] |= 0x10;
-		number -= 4;
-	}
-
-	leds_report[10] |= 0x01 << number;
+	leds_report[10] = leds_bitmap;
 
 	ret = write(fd, leds_report, sizeof(leds_report));
 	if (ret == sizeof(leds_report))
@@ -173,6 +182,7 @@ static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
 	int number = GPOINTER_TO_INT(user_data);
+	uint8_t bitmap;
 	int fd;
 
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
@@ -181,7 +191,10 @@ static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 	DBG("number %d", number);
 
 	fd = g_io_channel_unix_get_fd(channel);
-	set_leds_hidraw(fd, number);
+
+	bitmap = calc_leds_bitmap(number);
+	if (bitmap != 0)
+		set_leds_hidraw(fd, bitmap);
 
 	return FALSE;
 }
-- 
2.0.0.rc2

