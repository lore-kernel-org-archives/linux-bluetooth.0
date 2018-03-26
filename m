Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 1/6] shared/shell: Return exit status to caller
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
Message-ID: <55db0097-8ca9-40b8-285b-569c2a53a8f5@jp.fujitsu.com>
Date: Mon, 26 Mar 2018 17:31:00 +0900
MIME-Version: 1.0
In-Reply-To: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/shell.c | 7 +++++--
 src/shared/shell.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 33bc0d980..b503c6628 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -993,17 +993,20 @@ static void env_destroy(void *data)
 	free(env);
 }
 
-void bt_shell_run(void)
+int bt_shell_run(void)
 {
 	struct io *signal;
+	int status;
 
 	signal = setup_signalfd();
 
-	mainloop_run();
+	status = mainloop_run();
 
 	io_destroy(signal);
 
 	bt_shell_cleanup();
+
+	return status;
 }
 
 void bt_shell_cleanup(void)
diff --git a/src/shared/shell.h b/src/shared/shell.h
index 33c31f35b..8b7cb7f30 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -66,7 +66,7 @@ struct bt_shell_opt {
 
 void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt);
 
-void bt_shell_run(void);
+int bt_shell_run(void);
 
 void bt_shell_quit(int status);
 void bt_shell_noninteractive_quit(int status);
-- 
2.14.1

