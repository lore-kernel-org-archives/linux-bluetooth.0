Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/2] android/hal: Add UUID debug print in socket HAL
Date: Wed,  6 Nov 2013 17:10:43 +0200
Message-Id: <1383750643-1139-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383750643-1139-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <903E7C5D-33E0-4EDB-BD6D-02B183278514@holtmann.org>
 <1383750643-1139-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sock.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/android/hal-sock.c b/android/hal-sock.c
index 32c7939..1d198ac 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -25,6 +25,8 @@
 #include "hal-msg.h"
 #include "hal.h"
 
+#include "hal-utils.h"
+
 static bt_status_t sock_listen_rfcomm(const char *service_name,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
@@ -49,13 +51,14 @@ static bt_status_t sock_listen(btsock_type_t type, const char *service_name,
 					int *sock, int flags)
 {
 	if ((!uuid && chan <= 0) || !sock) {
-		error("%s: invalid params: uuid %p, chan %d, sock %p",
-						__func__, uuid, chan, sock);
+		error("Invalid params: uuid %s, chan %d, sock %p",
+				btuuid2str((bt_uuid_t *) uuid), chan, sock);
 		return BT_STATUS_PARM_INVALID;
 	}
 
-	DBG("uuid %p chan %d sock %p type %d service_name %s",
-					uuid, chan, sock, type, service_name);
+	DBG("uuid %s chan %d sock %p type %d service_name %s",
+				btuuid2str((bt_uuid_t *) uuid), chan,
+				sock, type, service_name);
 
 	switch (type) {
 	case BTSOCK_RFCOMM:
@@ -76,12 +79,13 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 	struct hal_cmd_sock_connect cmd;
 
 	if ((!uuid && chan <= 0) || !bdaddr || !sock) {
-		error("invalid params: bd_addr %p, uuid %p, chan %d, sock %p",
-					bdaddr, uuid, chan, sock);
+		error("Invalid params: bd_addr %p, uuid %s, chan %d, sock %p",
+			bdaddr, btuuid2str((bt_uuid_t *) uuid), chan, sock);
 		return BT_STATUS_PARM_INVALID;
 	}
 
-	DBG("uuid %p chan %d sock %p type %d", uuid, chan, sock, type);
+	DBG("uuid %s chan %d sock %p type %d", btuuid2str((bt_uuid_t *) uuid),
+							chan, sock, type);
 
 	if (type != BTSOCK_RFCOMM) {
 		error("Socket type %u not supported", type);
-- 
1.7.10.4

