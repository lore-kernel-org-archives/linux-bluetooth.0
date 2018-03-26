Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/6] client: Return exit status for non-interactive
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
Message-ID: <4b898795-52f9-5c4c-1739-ada17c4b111c@jp.fujitsu.com>
Date: Mon, 26 Mar 2018 17:31:02 +0900
MIME-Version: 1.0
In-Reply-To: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index 584217a82..7a100b552 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2532,6 +2532,7 @@ static void client_ready(GDBusClient *client, void *user_data)
 int main(int argc, char *argv[])
 {
 	GDBusClient *client;
+	int status;
 
 	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
@@ -2559,7 +2560,7 @@ int main(int argc, char *argv[])
 
 	g_dbus_client_set_ready_watch(client, client_ready, NULL);
 
-	bt_shell_run();
+	status = bt_shell_run();
 
 	g_dbus_client_unref(client);
 
@@ -2569,5 +2570,5 @@ int main(int argc, char *argv[])
 
 	g_free(auto_register_agent);
 
-	return 0;
+	return status;
 }
-- 
2.14.1

