Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/14] shared/shell: Do not quit immediatelly on noninteractive mode
Date: Mon, 26 Feb 2018 17:53:26 +0200
Message-Id: <20180226155336.25875-5-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The command handler shall be able to tell when it is done by calling
bt_shell_noninteractive_quit.
---
 src/shared/shell.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index e82307d6f..eae4ffbdd 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -951,10 +951,7 @@ bool bt_shell_attach(int fd)
 	if (data.mode) {
 		shell_exec(data.argc, data.argv);
 
-		if (!data.timeout) {
-			bt_shell_detach();
-			mainloop_quit();
-		} else
+		if (data.timeout)
 			timeout_add(data.timeout * 1000, shell_quit, NULL,
 								NULL);
 	}
-- 
2.14.3

