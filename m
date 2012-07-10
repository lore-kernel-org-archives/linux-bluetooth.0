Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] time: fix daylight variable description
Date: Tue, 10 Jul 2012 10:58:22 -0300
Message-Id: <1341928702-9024-1-git-send-email-jprvita@openbossa.org>
In-Reply-To: <CAJdJm_Po4UXnVWWEy0cBEtPWHOs3pS_6Rd1uJ6O2xxvO2WVXew@mail.gmail.com>
References: <CAJdJm_Po4UXnVWWEy0cBEtPWHOs3pS_6Rd1uJ6O2xxvO2WVXew@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 time/server.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/time/server.c b/time/server.c
index ddf88ae..d7bcf2d 100644
--- a/time/server.c
+++ b/time/server.c
@@ -111,8 +111,9 @@ static uint8_t local_time_info_read(struct attribute *a,
 	 * format (offset from UTC in number of 15 minutes increments). */
 	value[0] = (uint8_t) (-1 * timezone / (60 * 15));
 
-	/* FIXME: POSIX "daylight" variable only indicates whether there is DST
-	 * for the local time or not. The offset is unknown. */
+	/* FIXME: POSIX "daylight" variable only indicates if DST is used for
+	 * the local time or not. Both the offset and whether it's currently
+	 * active is unknown. */
 	value[1] = daylight ? 0xff : 0x00;
 
 	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
-- 
1.7.10.4

