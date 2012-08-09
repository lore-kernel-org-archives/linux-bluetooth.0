Return-Path: <cyrus@holtmann.org>
From: Ludek Finstrle <luf@pzkagis.cz>
To: linux-bluetooth@vger.kernel.org
Cc: Ludek Finstrle <luf@pzkagis.cz>
Subject: [PATCH obexd] client: Fix pbap_select using absolute path with known locations
Date: Thu,  9 Aug 2012 18:07:33 +0200
Message-Id: <1344528453-27245-1-git-send-email-luf@pzkagis.cz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

pbap_select has to use absolute path with known location to support
repeatable pbap_select calls. In other way the second call fails.
---
 client/pbap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 48dbac1..d8c39e5 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -232,14 +232,14 @@ static gchar *build_phonebook_path(const char *location, const char *item)
 
 	if (!g_ascii_strcasecmp(location, "INT") ||
 			!g_ascii_strcasecmp(location, "INTERNAL"))
-		path = g_strdup("telecom");
+		path = g_strdup("/telecom");
 	else if (!g_ascii_strncasecmp(location, "SIM", 3)) {
 		if (strlen(location) == 3)
 			tmp = g_strdup("SIM1");
 		else
 			tmp = g_ascii_strup(location, 4);
 
-		path = g_build_filename(tmp, "telecom", NULL);
+		path = g_build_filename("/", tmp, "telecom", NULL);
 		g_free(tmp);
 	} else
 		return NULL;
-- 
1.7.1

