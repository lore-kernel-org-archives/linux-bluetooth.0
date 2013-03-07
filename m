Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5 v2] AVRCP: Fix not checking for invalid folder length
Date: Thu,  7 Mar 2013 17:11:57 +0200
Message-Id: <1362669119-10890-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362669119-10890-1-git-send-email-luiz.dentz@gmail.com>
References: <1362669119-10890-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds checks for invalid folder length in SetBrowsedPlayer that
could cause crashes while reading invalid memory.
---
 profiles/audio/avrcp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index d5e6574..afb8c09 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1934,7 +1934,7 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 	uint32_t items;
 	char **folders, *path;
 	uint8_t depth, count;
-	int i;
+	size_t i;
 
 	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 13)
 		return FALSE;
@@ -1948,14 +1948,19 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 	folders = g_new0(char *, depth + 2);
 	folders[0] = g_strdup("/Filesystem");
 
-	for (i = 10, count = 1; count - 1 < depth; count++) {
-		char *part;
+	for (i = 10, count = 1; count - 1 < depth && i < operand_count;
+								count++) {
 		uint8_t len;
 
 		len = pdu->params[i++];
-		part = g_memdup(&pdu->params[i], len);
+
+		if (i + len > operand_count || len == 0) {
+			error("Invalid folder length");
+			break;
+		}
+
+		folders[count] = g_memdup(&pdu->params[i], len);
 		i += len;
-		folders[count] = part;
 	}
 
 	path = g_build_pathv("/", folders);
-- 
1.8.1.4

