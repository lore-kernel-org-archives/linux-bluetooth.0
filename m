Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] android/hal-socket: Match functions names with HAL name
Date: Tue, 18 Feb 2014 11:05:23 +0100
Message-Id: <1392717924-7712-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1392717924-7712-1-git-send-email-szymon.janc@tieto.com>
References: <1392717924-7712-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c |  2 +-
 android/hal-socket.c    | 16 ++++++++--------
 android/hal.h           |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 67c91e4..65432a8 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -751,7 +751,7 @@ static const void *get_profile_interface(const char *profile_id)
 		return NULL;
 
 	if (!strcmp(profile_id, BT_PROFILE_SOCKETS_ID))
-		return bt_get_sock_interface();
+		return bt_get_socket_interface();
 
 	if (!strcmp(profile_id, BT_PROFILE_HIDHOST_ID))
 		return bt_get_hidhost_interface();
diff --git a/android/hal-socket.c b/android/hal-socket.c
index f62b7ef..ea7d9d8 100644
--- a/android/hal-socket.c
+++ b/android/hal-socket.c
@@ -26,7 +26,7 @@
 #include "hal-utils.h"
 #include "hal.h"
 
-static bt_status_t sock_listen(btsock_type_t type, const char *service_name,
+static bt_status_t socket_listen(btsock_type_t type, const char *service_name,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
@@ -55,7 +55,7 @@ static bt_status_t sock_listen(btsock_type_t type, const char *service_name,
 				sizeof(cmd), &cmd, NULL, NULL, sock);
 }
 
-static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
+static bt_status_t socket_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
@@ -84,13 +84,13 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 					sizeof(cmd), &cmd, NULL, NULL, sock);
 }
 
-static btsock_interface_t sock_if = {
-	sizeof(sock_if),
-	sock_listen,
-	sock_connect
+static btsock_interface_t socket_if = {
+	sizeof(socket_if),
+	socket_listen,
+	socket_connect
 };
 
-btsock_interface_t *bt_get_sock_interface(void)
+btsock_interface_t *bt_get_socket_interface(void)
 {
-	return &sock_if;
+	return &socket_if;
 }
diff --git a/android/hal.h b/android/hal.h
index 5005b49..6fd2559 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -23,7 +23,7 @@
 #include <hardware/bt_rc.h>
 #include <hardware/bt_hf.h>
 
-btsock_interface_t *bt_get_sock_interface(void);
+btsock_interface_t *bt_get_socket_interface(void);
 bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
 btav_interface_t *bt_get_a2dp_interface(void);
-- 
1.8.3.2

