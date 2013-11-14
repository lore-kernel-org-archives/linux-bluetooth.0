Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 04/16] android/hal-sock: Define structures for socket HAL
Date: Thu, 14 Nov 2013 17:11:43 +0200
Message-Id: <1384441915-23966-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This defines structures for socket HAL. We need to emulate Android
sockets by sending connect/accept signals over file descriptor.
---
 android/socket.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index e580036..4699dce 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -37,6 +37,18 @@
 
 static bdaddr_t adapter_addr;
 
+/* Simple list of RFCOMM server sockets */
+GList *rfcomm_srv_list = NULL;
+
+/* Simple list of RFCOMM connected sockets */
+GList *rfcomm_connected_list = NULL;
+
+struct rfcomm_slot {
+	int fd;		/* descriptor for communication with Java framework */
+	int real_sock;	/* real RFCOMM socket */
+	int channel;	/* RFCOMM channel */
+};
+
 static int handle_listen(void *buf)
 {
 	DBG("Not implemented");
-- 
1.7.10.4

