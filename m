Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ 4/4] Time Server: use time zone and DST from system
Date: Mon, 26 Sep 2011 17:01:37 -0400
Message-Id: <1317070897-17508-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317070897-17508-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317070897-17508-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 time/server.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/time/server.c b/time/server.c
index 5079f35..1f624a6 100644
--- a/time/server.c
+++ b/time/server.c
@@ -88,8 +88,16 @@ static uint8_t local_time_info_read(struct attribute *a, gpointer user_data)
 
 	DBG("a=%p", a);
 
-	value[0] = 0xff; /* DST Offset (255: unknown) */
-	value[1] = 0x80; /* Time Zone (-128: unknown) */
+	tzset();
+
+	/* FIXME: POSIX "daylight" variable only indicates whether there is DST
+	 * for the local time or not. The offset is unknown. */
+	value[0] = daylight ? 0xff : 0x00;
+
+	/* Convert POSIX "timezone" (seconds West of GMT) to Time Profile
+	 * format (offset from UTC in number of 15 minutes increments). */
+	value[1] = (uint8_t) (-1 * timezone / (60 * 15));
+
 	attrib_db_update(a->handle, NULL, value, sizeof(value), NULL);
 
 	return 0;
-- 
1.7.0.4

