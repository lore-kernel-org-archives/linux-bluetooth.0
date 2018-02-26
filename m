Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/14] shared/mainloop-glib: Fix calling g_main_loop_quit with NULL
Date: Mon, 26 Feb 2018 17:53:31 +0200
Message-Id: <20180226155336.25875-10-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This produces warnings such as:

(process:5122): GLib-CRITICAL **: g_main_loop_quit: assertion 'loop != NULL' failed
---
 src/shared/mainloop-glib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
index 1bbac5d11..8436969bb 100644
--- a/src/shared/mainloop-glib.c
+++ b/src/shared/mainloop-glib.c
@@ -47,6 +47,9 @@ void mainloop_init(void)
 
 void mainloop_quit(void)
 {
+	if (!main_loop)
+		return;
+
 	g_main_loop_quit(main_loop);
 }
 
-- 
2.14.3

