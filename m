Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5 v2] AVRCP: Prefix folder name with /Filesystem
Date: Wed,  6 Feb 2013 11:14:56 +0200
Message-Id: <1360142100-5141-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This separate the scopes of the folder as documented in doc/media-api.txt
---
 profiles/audio/avrcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 00eeea1..5967180 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1935,9 +1935,10 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 
 	depth = operands[13];
 
-	folders = g_new0(char *, depth + 1);
+	folders = g_new0(char *, depth + 2);
+	folders[0] = g_strdup("/Filesystem");
 
-	for (i = 14, count = 0; count < depth; count++) {
+	for (i = 14, count = 1; count - 1 < depth; count++) {
 		char *part;
 		uint8_t len;
 
-- 
1.8.1

