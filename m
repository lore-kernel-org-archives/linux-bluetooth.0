Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix X-IRMC-CALL-DATETIME format
Date: Wed, 13 Oct 2010 16:15:56 +0300
Message-Id: <1286975756-13134-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Use the format suggested in the spec:

"For instance, a call that was missed on March 20th, 2005 at 10 am would
be stamped: X-IRMC-CALL-DATETIME;MISSED:20050320T100000"
---
 plugins/phonebook-tracker.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index d0cea2e..39e4c81 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -705,7 +705,7 @@ static char *iso8601_utc_to_localtime(const char *datetime)
 
 	memset(&tm, 0, sizeof(tm));
 
-	nr = sscanf(datetime, "%04u-%02u-%02uT%02u:%02u:%02u%c",
+	nr = sscanf(datetime, "%04u%02u%02uT%02u%02u%02u%c",
 			&tm.tm_year, &tm.tm_mon, &tm.tm_mday,
 			&tm.tm_hour, &tm.tm_min, &tm.tm_sec,
 			&tz);
@@ -726,7 +726,7 @@ static char *iso8601_utc_to_localtime(const char *datetime)
 
 	local = localtime(&time);
 
-	strftime(localdate, sizeof(localdate), "%Y-%m-%dT%H:%M:%S", local);
+	strftime(localdate, sizeof(localdate), "%Y%m%dT%H%M%S", local);
 
 	return g_strdup(localdate);
 }
-- 
1.7.1

