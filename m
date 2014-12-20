Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove duplicate constant for RFCOMM PSM
Date: Sat, 20 Dec 2014 17:59:31 +0100
Message-Id: <1419094771-41539-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The RFCOMM_PSM constant is actually a duplicate. So remove it and
use the L2CAP_PSM_RFCOMM contant instead.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/rfcomm.h | 2 --
 net/bluetooth/rfcomm/core.c    | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 578b83127af1..4190af53a46a 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -24,8 +24,6 @@
 #ifndef __RFCOMM_H
 #define __RFCOMM_H
 
-#define RFCOMM_PSM 3
-
 #define RFCOMM_CONN_TIMEOUT (HZ * 30)
 #define RFCOMM_DISC_TIMEOUT (HZ * 20)
 #define RFCOMM_AUTH_TIMEOUT (HZ * 25)
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 73f8c75abe6e..4fea24275b17 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -771,7 +771,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 
 	bacpy(&addr.l2_bdaddr, dst);
 	addr.l2_family = AF_BLUETOOTH;
-	addr.l2_psm    = cpu_to_le16(RFCOMM_PSM);
+	addr.l2_psm    = cpu_to_le16(L2CAP_PSM_RFCOMM);
 	addr.l2_cid    = 0;
 	addr.l2_bdaddr_type = BDADDR_BREDR;
 	*err = kernel_connect(sock, (struct sockaddr *) &addr, sizeof(addr), O_NONBLOCK);
@@ -2038,7 +2038,7 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 	/* Bind socket */
 	bacpy(&addr.l2_bdaddr, ba);
 	addr.l2_family = AF_BLUETOOTH;
-	addr.l2_psm    = cpu_to_le16(RFCOMM_PSM);
+	addr.l2_psm    = cpu_to_le16(L2CAP_PSM_RFCOMM);
 	addr.l2_cid    = 0;
 	addr.l2_bdaddr_type = BDADDR_BREDR;
 	err = kernel_bind(sock, (struct sockaddr *) &addr, sizeof(addr));
-- 
2.1.0

