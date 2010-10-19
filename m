Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix regression when formatting timestamps from tracker
Date: Tue, 19 Oct 2010 14:53:56 +0300
Message-Id: <1287489236-4558-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Tracker format user delimiters like '-' and ':' which need to be keep in
order to sscanf to work.
---
 plugins/phonebook-tracker.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 2da825b..f0e00b8 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -705,18 +705,21 @@ static char *iso8601_utc_to_localtime(const char *datetime)
 
 	memset(&tm, 0, sizeof(tm));
 
-	nr = sscanf(datetime, "%04u%02u%02uT%02u%02u%02u%c",
+	nr = sscanf(datetime, "%04u-%02u-%02uT%02u:%02u:%02u%c",
 			&tm.tm_year, &tm.tm_mon, &tm.tm_mday,
 			&tm.tm_hour, &tm.tm_min, &tm.tm_sec,
 			&tz);
 	if (nr < 6) {
 		/* Invalid time format */
+		error("sscanf(): %s (%d)", strerror(errno), errno);
 		return g_strdup("");
 	}
 
 	/* Time already in localtime */
-	if (nr == 6)
-		return g_strdup(datetime);
+	if (nr == 6) {
+		strftime(localdate, sizeof(localdate), "%Y%m%dT%H%M%S", &tm);
+		return g_strdup(localdate);
+	}
 
 	tm.tm_year -= 1900;	/* Year since 1900 */
 	tm.tm_mon--;		/* Months since January, values 0-11 */
-- 
1.7.1

