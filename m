Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 02/16] android/socket: Use static local adapter address
Date: Mon, 18 Nov 2013 10:26:05 +0200
Message-Id: <1384763179-2218-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index c283c5f..e580036 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -35,6 +35,7 @@
 #include "ipc.h"
 #include "socket.h"
 
+static bdaddr_t adapter_addr;
 
 static int handle_listen(void *buf)
 {
@@ -81,6 +82,8 @@ bool bt_socket_register(int sk, const bdaddr_t *addr)
 {
 	DBG("");
 
+	bacpy(&adapter_addr, addr);
+
 	return true;
 }
 
-- 
1.7.10.4

