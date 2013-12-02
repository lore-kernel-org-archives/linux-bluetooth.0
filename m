Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/socket Use 4K buffer for socket handling
Date: Mon,  2 Dec 2013 18:06:02 +0200
Message-Id: <1386000362-3298-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make SOCKET_BUFFER define and use 4K instead of 1K.
---
 android/socket.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 4502e90..98ec3ec 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -52,6 +52,8 @@
 
 #define SVC_HINT_OBEX 0x10
 
+#define SOCKET_BUFFER 4096
+
 static bdaddr_t adapter_addr;
 
 /* Simple list of RFCOMM server sockets */
@@ -487,7 +489,7 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
-	unsigned char buf[1024];
+	unsigned char buf[SOCKET_BUFFER];
 	int len, sent;
 
 	if (cond & G_IO_HUP) {
@@ -526,7 +528,7 @@ static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
-	unsigned char buf[1024];
+	unsigned char buf[SOCKET_BUFFER];
 	int len, sent;
 
 	if (cond & G_IO_HUP) {
-- 
1.8.3.2

