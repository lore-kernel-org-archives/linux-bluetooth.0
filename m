Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hidp: Fix handling of strncpy for hid->name information
Date: Mon, 30 Jul 2018 13:57:41 +0200
Message-Id: <20180730115741.80946-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes two issues with setting hid->name information.

  CC      net/bluetooth/hidp/core.o
In function ‘hidp_setup_hid’,
    inlined from ‘hidp_session_dev_init’ at net/bluetooth/hidp/core.c:815:9,
    inlined from ‘hidp_session_new’ at net/bluetooth/hidp/core.c:953:8,
    inlined from ‘hidp_connection_add’ at net/bluetooth/hidp/core.c:1366:8:
net/bluetooth/hidp/core.c:778:2: warning: ‘strncpy’ output may be truncated copying 127 bytes from a string of length 127 [-Wstringop-truncation]
  strncpy(hid->name, req->name, sizeof(req->name) - 1);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  CC      net/bluetooth/hidp/core.o
net/bluetooth/hidp/core.c: In function ‘hidp_setup_hid’:
net/bluetooth/hidp/core.c:778:38: warning: argument to ‘sizeof’ in ‘strncpy’ call is the same expression as the source; did you mean to use the size of the destination? [-Wsizeof-pointer-memaccess]
  strncpy(hid->name, req->name, sizeof(req->name));
                                      ^

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 1036e4fa1ea2..6f3eaf2fb94f 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -775,7 +775,7 @@ static int hidp_setup_hid(struct hidp_session *session,
 	hid->version = req->version;
 	hid->country = req->country;
 
-	strncpy(hid->name, req->name, sizeof(req->name) - 1);
+	strncpy(hid->name, req->name, sizeof(hid->name));
 
 	snprintf(hid->phys, sizeof(hid->phys), "%pMR",
 		 &l2cap_pi(session->ctrl_sock->sk)->chan->src);
-- 
2.17.1

