Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ao2@ao2.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH BlueZ 3/5] plugins/sixaxis: factor out a calc_leds_bitmap() function
Date: Tue,  6 May 2014 12:06:14 +0200
Message-Id: <1399370776-5027-4-git-send-email-ao2@ao2.it>
In-Reply-To: <1399370776-5027-1-git-send-email-ao2@ao2.it>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is also in preparation of set_leds_sysfs().
---
 plugins/sixaxis.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 61fd0b5..b629c06 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -125,7 +125,25 @@ static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
 	return ret;
 }
 
-static gboolean set_leds_hidraw(int fd, int number)
+static gboolean calc_leds_bitmap(int number, uint8_t *bitmap)
+{
+	*bitmap = 0;
+
+	/* TODO we could support up to 10 (1 + 2 + 3 + 4) */
+	if (number > 7)
+		return FALSE;
+
+	if (number > 4) {
+		*bitmap |= 0x10;
+		number -= 4;
+	}
+
+	*bitmap |= 0x01 << number;
+
+	return TRUE;
+}
+
+static gboolean set_leds_hidraw(int fd, uint8_t leds_bitmap)
 {
 	/*
 	 * the total time the led is active (0xff means forever)
@@ -148,16 +166,7 @@ static gboolean set_leds_hidraw(int fd, int number)
 	};
 	int ret;
 
-	/* TODO we could support up to 10 (1 + 2 + 3 + 4) */
-	if (number > 7)
-		return FALSE;
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
@@ -175,6 +184,7 @@ static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
 	int number = GPOINTER_TO_INT(user_data);
+	uint8_t bitmap = 0;
 	int fd;
 
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
@@ -183,7 +193,9 @@ static gboolean setup_leds(GIOChannel *channel, GIOCondition cond,
 	DBG("number %d", number);
 
 	fd = g_io_channel_unix_get_fd(channel);
-	set_leds_hidraw(fd, number);
+
+	if (calc_leds_bitmap(number, &bitmap))
+		set_leds_hidraw(fd, bitmap);
 
 	return FALSE;
 }
-- 
2.0.0.rc0

