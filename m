Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 1/2] time: fix byte position
Date: Thu,  5 Jul 2012 14:37:33 -0300
Message-Id: <1341509854-9875-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The position of the "Time Zone" and "Daylight Saving Time" fields on
the Local Time Information characteristic was inverted. This commit
fix their position.
---
 time/server.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/time/server.c b/time/server.c
index be6e196..ddf88ae 100644
--- a/time/server.c
+++ b/time/server.c
@@ -107,13 +107,13 @@ static uint8_t local_time_info_read(struct attribute *a,
 
 	tzset();
 
-	/* FIXME: POSIX "daylight" variable only indicates whether there is DST
-	 * for the local time or not. The offset is unknown. */
-	value[0] = daylight ? 0xff : 0x00;
-
 	/* Convert POSIX "timezone" (seconds West of GMT) to Time Profile
 	 * format (offset from UTC in number of 15 minutes increments). */
-	value[1] = (uint8_t) (-1 * timezone / (60 * 15));
+	value[0] = (uint8_t) (-1 * timezone / (60 * 15));
+
+	/* FIXME: POSIX "daylight" variable only indicates whether there is DST
+	 * for the local time or not. The offset is unknown. */
+	value[1] = daylight ? 0xff : 0x00;
 
 	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
 
-- 
1.7.10.4

