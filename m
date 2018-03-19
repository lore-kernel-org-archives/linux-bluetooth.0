Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 1/2] shared/shell: Return NULL if generator error occur
Message-ID: <645f8de1-77a5-71d9-ca31-637fcf30c6fa@jp.fujitsu.com>
Date: Mon, 19 Mar 2018 13:46:05 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Explicitly returns NULL if asprintf() fails, since the asprintf(3)
man-page says that the contents of the first argument are undefined if
any error occurs.
---
 src/shared/shell.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 0a05b5215..7417e7ab4 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -643,8 +643,13 @@ static char *cmd_generator(const char *text, int state)
 	}
 
 	cmd = find_cmd(text + strlen(menu->name) + 1, menu->entries, &index);
-	if (cmd)
-		asprintf(&cmd, "%s.%s", menu->name, cmd);
+	if (cmd) {
+		int err;
+
+		err = asprintf(&cmd, "%s.%s", menu->name, cmd);
+		if (err < 0)
+			return NULL;
+	}
 
 	return cmd;
 }
-- 
2.14.1

