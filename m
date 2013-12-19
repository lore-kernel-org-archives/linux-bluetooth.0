Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/6] emulator: Remove not necessary bthost_set_server_psm
Date: Thu, 19 Dec 2013 15:29:05 +0100
Message-Id: <1387463345-26406-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1387463345-26406-1-git-send-email-marcin.kraglak@tieto.com>
References: <1387463345-26406-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove not necessary function and replace all uses with new one,
bthost_add_l2cap_server().
---
 android/android-tester.c | 2 +-
 emulator/bthost.c        | 5 -----
 emulator/bthost.h        | 2 --
 tools/l2cap-tester.c     | 3 ++-
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index c24f5a6..2d78646 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1279,7 +1279,7 @@ static void test_socket_real_connect(const void *test_data)
 
 	bdaddr2android((bdaddr_t *) client_bdaddr, &emu_bdaddr);
 
-	bthost_set_server_psm(bthost, 0x0003);
+	bthost_add_l2cap_server(bthost, 0x0003, NULL, NULL);
 
 	status = data->if_sock->connect(&emu_bdaddr, test->sock_type,
 					test->service_uuid, test->channel,
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 7ccef9c..28d0591 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1303,11 +1303,6 @@ void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
 	bthost->new_l2cap_conn_data = data;
 }
 
-void bthost_set_server_psm(struct bthost *bthost, uint16_t psm)
-{
-	bthost_add_l2cap_server(bthost, psm, NULL, NULL);
-}
-
 void bthost_start(struct bthost *bthost)
 {
 	if (!bthost)
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 2b8f212..97f011b 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -77,8 +77,6 @@ void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 typedef void (*bthost_l2cap_connect_cb) (uint16_t handle, uint16_t cid,
 							void *user_data);
 
-void bthost_set_server_psm(struct bthost *bthost, uint16_t psm);
-
 void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
 				bthost_l2cap_connect_cb func, void *user_data);
 
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 55e8ac9..2a7a394 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -720,7 +720,8 @@ static void test_connect(const void *test_data)
 		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 
 		if (!l2data->data_len)
-			bthost_set_server_psm(bthost, l2data->server_psm);
+			bthost_add_l2cap_server(bthost, l2data->server_psm,
+								NULL, NULL);
 		else
 			bthost_add_l2cap_server(bthost, l2data->server_psm,
 						client_l2cap_connect_cb, data);
-- 
1.8.3.1

