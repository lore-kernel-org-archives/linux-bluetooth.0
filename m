Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: sbrown@cortland.com
Subject: [PATCH] mesh: meshctl: Correct display security
Date: Fri, 22 Dec 2017 05:29:54 -0500
Message-Id: <20171222102954.14960-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

The case of a security command without an argument is not handled
and throws a segv.
---
 mesh/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 9360481f8..7e9763a00 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1670,14 +1670,19 @@ static void cmd_security(int argc, char *argv[])
 	uint8_t level;
 	char *end;
 
+	if (argc == 1)
+		goto done;
+
 	level = strtol(argv[1], &end, 10);
 	if (end == argv[1] || !prov_set_sec_level(level)) {
 		bt_shell_printf("Invalid security level %s\n", argv[1]);
 		return;
 	}
 
-	bt_shell_printf("Provision Security Level set to %u (%s)\n", level,
-						security2str(level));
+done:
+	bt_shell_printf("Provision Security Level set to %u (%s)\n",
+			prov_get_sec_level(),
+			security2str(prov_get_sec_level()));
 }
 
 static void cmd_connect(int argc, char *argv[])
-- 
2.14.1

