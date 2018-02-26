Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/14] sharead/mainloop-glib: Fix mainloop_exit*
Date: Mon, 26 Feb 2018 17:53:30 +0200
Message-Id: <20180226155336.25875-9-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These function shall cause the mainloop to quit.
---
 src/shared/mainloop-glib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
index 14d43207a..1bbac5d11 100644
--- a/src/shared/mainloop-glib.c
+++ b/src/shared/mainloop-glib.c
@@ -53,11 +53,13 @@ void mainloop_quit(void)
 void mainloop_exit_success(void)
 {
 	exit_status = EXIT_SUCCESS;
+	mainloop_quit();
 }
 
 void mainloop_exit_failure(void)
 {
 	exit_status = EXIT_FAILURE;
+	mainloop_quit();
 }
 
 int mainloop_run(void)
-- 
2.14.3

