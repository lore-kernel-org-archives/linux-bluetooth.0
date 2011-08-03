Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Fix memory allocation in Proximity Monitor
Date: Wed,  3 Aug 2011 11:25:33 -0300
Message-Id: <1312381533-20485-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

textfile get functions returns memory allocated using malloc. String
is now being re-allocated using glib functions to keep the code standard
in the Proximity Monitor code.
---
 proximity/monitor.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index d068142..a3cb8ef 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -91,13 +91,21 @@ static char *read_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
 							const char *alert)
 {
 	char filename[PATH_MAX + 1], addr[18], key[38];
+	char *str, *strnew;
 
 	create_filename(filename, PATH_MAX, sba, "proximity");
 
 	ba2str(dba, addr);
 	snprintf(key, sizeof(key), "%17s#%s", addr, alert);
 
-	return textfile_caseget(filename, key);
+	str = textfile_caseget(filename, key);
+	if (str == NULL)
+		return NULL;
+
+	strnew = g_strdup(str);
+	free(str);
+
+	return strnew;
 }
 
 static void char_discovered_cb(GSList *characteristics, guint8 status,
-- 
1.7.6

