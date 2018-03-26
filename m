Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 0/6] Make commands return exit status
Message-ID: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
Date: Mon, 26 Mar 2018 17:25:37 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commands always return 0 as exit status in non-interactive mode. This
patch set makes them return the exit_status variable as exit status.

Note:
  This patch set does not include the following fix for meshctl, due to
  conflict with Inga's patch ("mesh/meshctl: Exit cleanly if start up
  fails")[1]. I will send a rebased fix after merging Inga's patch to
  BlueZ master branch.

  [1]: https://www.spinics.net/lists/linux-bluetooth/msg75020.html


ERAMOTO Masaya (6):
  shared/shell: Return exit status to caller
  client: Return exit status for non-interactive
  tools/bluetooth-player: Return exit status for non-interactive
  tools/obexctl: Return exit status for non-interactive
  tools/btmgmt: Return exit status for non-interactive
  shared/mainloop: Fix overwriting exit status

 client/main.c            | 5 +++--
 src/shared/mainloop.c    | 4 +---
 src/shared/shell.c       | 7 +++++--
 src/shared/shell.h       | 2 +-
 tools/bluetooth-player.c | 5 +++--
 tools/btmgmt.c           | 2 +-
 tools/obexctl.c          | 5 +++--
 7 files changed, 17 insertions(+), 13 deletions(-)


---
 mesh/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index d991c9f8c..c79c44bd8 100644
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
 
@@ -2001,5 +2002,5 @@ int main(int argc, char *argv[])
 	g_list_free(service_list);
 	g_list_free_full(ctrl_list, proxy_leak);
 
-	return 0;
+	return status;
 }
--
2.14.1

