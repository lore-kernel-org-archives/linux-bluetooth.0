Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 4/4] shared/shell: Fix auto-completion of invalid
 commands
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <8b962f05-12c2-8bd9-31ca-1700a45bbdae@jp.fujitsu.com>
Message-ID: <36e33345-4ff0-766d-cf97-90deaf4b56b0@jp.fujitsu.com>
Date: Mon, 11 Dec 2017 16:18:10 +0900
MIME-Version: 1.0
In-Reply-To: <8b962f05-12c2-8bd9-31ca-1700a45bbdae@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bt_shell always complements the invalid commands, which are the menu/back
command.
---
 src/shared/shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 26194f758..f20c74901 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -498,7 +498,7 @@ static char *find_cmd(const char *text,
 	while ((cmd = entry[*index].cmd)) {
 		(*index)++;
 
-		if (!strncmp(cmd, text, len))
+		if (!strncmp(cmd, text, len) && !command_isskipped(cmd))
 			return strdup(cmd);
 	}
 
-- 
2.14.1

