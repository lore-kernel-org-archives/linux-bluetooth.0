Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 11/12] android/client: Fix uninitialized "sock_fd" variable
Date: Fri,  3 Jan 2014 21:55:27 -0400
Message-Id: <1388800528-10699-12-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If EXEC() macro is called with the first pointer argument NULL, sock_fd
will not be initialized. Given that the NULL check is not fatal, it is a
good idea to initialize the variable to -1 so the code has defined
behavior on this situation.

Detected by clang:

android/client/if-sock.c:251:7: error: variable 'sock_fd' is used
uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
---
 android/client/if-sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/client/if-sock.c b/android/client/if-sock.c
index 050bc96..4c1af82 100644
--- a/android/client/if-sock.c
+++ b/android/client/if-sock.c
@@ -207,7 +207,7 @@ static void listen_p(int argc, const char **argv)
 	const char *service_name;
 	bt_uuid_t service_uuid;
 	int channel;
-	int sock_fd;
+	int sock_fd = -1;
 	int flags;
 
 	RETURN_IF_NULL(if_sock);
@@ -281,7 +281,7 @@ static void connect_p(int argc, const char **argv)
 	btsock_type_t type;
 	bt_uuid_t uuid;
 	int channel;
-	int sock_fd;
+	int sock_fd = -1;
 	int flags;
 
 	/* Address */
-- 
1.8.3.2

