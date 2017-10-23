Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 8/8] tools/btmgmt: Use cmd_usage() for select command
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Message-ID: <24c4eec7-14af-9502-1649-4a28bc334327@jp.fujitsu.com>
Date: Mon, 23 Oct 2017 17:28:49 +0900
MIME-Version: 1.0
In-Reply-To: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btmgmt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 8eee2b1..552f744 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4528,7 +4528,7 @@ static void cmd_select(struct mgmt *mgmt, uint16_t index,
 						int argc, char **argv)
 {
 	if (argc != 2) {
-		error("Usage: select <index>");
+		cmd_usage(argv[0]);
 		return;
 	}
 
@@ -4641,6 +4641,14 @@ static void cmd_usage(char *cmd)
 		return;
 
 	c = find_cmd(cmd, all_cmd, NELEM(all_cmd));
+	if (!c && interactive) {
+		c = find_cmd(cmd, interactive_cmd, NELEM(interactive_cmd));
+		if (!c)
+			return;
+		error("Usage: %s %s", cmd, c->arg ? : "");
+		return;
+	}
+
 	if (!c)
 		return;
 
-- 
2.7.4

