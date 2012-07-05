Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 2/2] time: fix daylight variable description
Date: Thu,  5 Jul 2012 14:37:34 -0300
Message-Id: <1341509854-9875-2-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341509854-9875-1-git-send-email-jprvita@openbossa.org>
References: <1341509854-9875-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 time/server.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/time/server.c b/time/server.c
index ddf88ae..a5f151e 100644
--- a/time/server.c
+++ b/time/server.c
@@ -111,8 +111,9 @@ static uint8_t local_time_info_read(struct attribute *a,
 	 * format (offset from UTC in number of 15 minutes increments). */
 	value[0] = (uint8_t) (-1 * timezone / (60 * 15));
 
-	/* FIXME: POSIX "daylight" variable only indicates whether there is DST
-	 * for the local time or not. The offset is unknown. */
+	/* FIXME: POSIX "daylight" variable only indicates if DST is used for
+	 * the local time or not. Both the offset and wheter it's currently
+	 * active is unknown. */
 	value[1] = daylight ? 0xff : 0x00;
 
 	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
-- 
1.7.10.4

