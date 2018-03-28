Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ] mesh: Return exit status for non-interactive
Message-ID: <9f2f8362-c561-a87e-dc61-71dbd15500e1@jp.fujitsu.com>
Date: Wed, 28 Mar 2018 15:22:02 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
This patch is related to the previous patch set[1].

[1]: https://www.spinics.net/lists/linux-bluetooth/msg75031.html

 mesh/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index d0f71c2d9..3e1484f61 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1904,6 +1904,7 @@ static void client_ready(GDBusClient *client, void *user_data)
 int main(int argc, char *argv[])
 {
 	GDBusClient *client;
+	int status;
 	int len;
 	int extra;
 
@@ -1989,7 +1990,7 @@ int main(int argc, char *argv[])
 	if (!onoff_client_init(PRIMARY_ELEMENT_IDX))
 		g_printerr("Failed to initialize mesh generic On/Off client\n");
 
-	bt_shell_run();
+	status = bt_shell_run();
 
 	g_dbus_client_unref(client);
 
@@ -2001,7 +2002,7 @@ int main(int argc, char *argv[])
 	g_list_free(service_list);
 	g_list_free_full(ctrl_list, proxy_leak);
 
-	return EXIT_SUCCESS;
+	return status;
 
 fail:
 	bt_shell_cleanup();
-- 
2.14.1

