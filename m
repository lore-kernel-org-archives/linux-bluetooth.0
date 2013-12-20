Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 3/3] emulator/bthost: Remove not used bthost_set_server_psm
Date: Fri, 20 Dec 2013 11:53:47 +0100
Message-Id: <1387536827-1590-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1387536827-1590-1-git-send-email-marcin.kraglak@tieto.com>
References: <1387536827-1590-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is not needed and has been replaced with bthost_add_l2cap_server.
---
 emulator/bthost.c | 5 -----
 emulator/bthost.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 8e62d26..c627f8a 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1304,11 +1304,6 @@ void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
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
 
-- 
1.8.3.1

