Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] phonebook-tracker.c: Fix iso8601_utc_to_localtime
Date: Thu,  8 Dec 2011 10:41:21 +0100
Message-Id: <1323337281-5094-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Timestamp returned from Tracker can optionally contain fractional
seconds. Original code treated any character after seconds as flag for
UTC timestamp. This patch changes it so now only the beginning of string
is scanned and the end of string is checked for UTC flag ('Z') presence.
---
 plugins/phonebook-tracker.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 61c7af9..da82ff5 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -728,15 +728,13 @@ static char *iso8601_utc_to_localtime(const char *datetime)
 	time_t time;
 	struct tm tm, *local;
 	char localdate[32];
-	char tz;
 	int nr;
 
 	memset(&tm, 0, sizeof(tm));
 
-	nr = sscanf(datetime, "%04u-%02u-%02uT%02u:%02u:%02u%c",
+	nr = sscanf(datetime, "%04u-%02u-%02uT%02u:%02u:%02u",
 			&tm.tm_year, &tm.tm_mon, &tm.tm_mday,
-			&tm.tm_hour, &tm.tm_min, &tm.tm_sec,
-			&tz);
+			&tm.tm_hour, &tm.tm_min, &tm.tm_sec);
 	if (nr < 6) {
 		/* Invalid time format */
 		error("sscanf(): %s (%d)", strerror(errno), errno);
@@ -744,7 +742,7 @@ static char *iso8601_utc_to_localtime(const char *datetime)
 	}
 
 	/* Time already in localtime */
-	if (nr == 6) {
+	if (!g_str_has_suffix(datetime, "Z")) {
 		strftime(localdate, sizeof(localdate), "%Y%m%dT%H%M%S", &tm);
 		return g_strdup(localdate);
 	}
-- 
1.7.4.1

