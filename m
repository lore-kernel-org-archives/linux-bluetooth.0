Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Fix error when proximity config file is missing
Date: Wed,  3 Aug 2011 11:45:27 -0300
Message-Id: <1312382727-32709-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds checking to avoid the following GLib critical error:
Parsing /etc/bluetooth/proximity.conf failed: No such file or directory
GLib-CRITICAL **: g_key_file_get_string_list: assertion `key_file !=
NULL' failed
---
 proximity/manager.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/proximity/manager.c b/proximity/manager.c
index a9526a1..30384d1 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -83,6 +83,9 @@ static void load_config_file(GKeyFile *config)
 	char **list;
 	int i;
 
+	if (config == NULL)
+		return;
+
 	list = g_key_file_get_string_list(config, "General", "Disable",
 								NULL, NULL);
 	for (i = 0; list && list[i] != NULL; i++) {
-- 
1.7.6

