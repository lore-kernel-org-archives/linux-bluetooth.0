Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] android/hal-sock: Check uuid before dereference
Date: Tue, 26 Nov 2013 16:05:49 +0200
Message-Id: <1385474750-18331-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

uuid might be NULL and channel might be specified which makes it
valid case for Android. This adds check for uuid and service name.
---
 android/hal-sock.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/android/hal-sock.c b/android/hal-sock.c
index e02a49a..f45be30 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -34,12 +34,17 @@ static bt_status_t sock_listen_rfcomm(const char *service_name,
 
 	DBG("");
 
+	memset(&cmd, 0, sizeof(cmd));
+
 	cmd.flags = flags;
 	cmd.type = BTSOCK_RFCOMM;
 	cmd.channel = chan;
-	memcpy(cmd.uuid, uuid, sizeof(cmd.uuid));
-	memset(cmd.name, 0, sizeof(cmd.name));
-	memcpy(cmd.name, service_name, strlen(service_name));
+
+	if (uuid)
+		memcpy(cmd.uuid, uuid, sizeof(cmd.uuid));
+
+	if (service_name)
+		memcpy(cmd.name, service_name, strlen(service_name));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN,
 				sizeof(cmd), &cmd, NULL, NULL, sock);
@@ -90,10 +95,15 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 		return BT_STATUS_UNSUPPORTED;
 	}
 
+	memset(&cmd, 0, sizeof(cmd));
+
 	cmd.flags = flags;
 	cmd.type = type;
 	cmd.channel = chan;
-	memcpy(cmd.uuid, uuid, sizeof(cmd.uuid));
+
+	if (uuid)
+		memcpy(cmd.uuid, uuid, sizeof(cmd.uuid));
+
 	memcpy(cmd.bdaddr, bdaddr, sizeof(cmd.bdaddr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT,
-- 
1.8.3.2

