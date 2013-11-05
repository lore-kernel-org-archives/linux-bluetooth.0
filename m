Return-Path: <cyrus@holtmann.org>
From: Seung-Woo Kim <sw0312.kim@samsung.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc: gustavo@padovan.org, johan.hedberg@gmail.com,
	sw0312.kim@samsung.com, s.syam@samsung.com
Subject: [PATCH] Bluetooth: Fix to set proper bdaddr_type for RFCOMM connect
Date: Tue, 05 Nov 2013 17:15:42 +0900
Message-id: <1383639342-9972-1-git-send-email-sw0312.kim@samsung.com>
In-reply-to: <FF845DCC-A87F-4B35-A9A4-0F031DC7CE0B@holtmann.org>
References: <FF845DCC-A87F-4B35-A9A4-0F031DC7CE0B@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

L2CAP socket validates proper bdaddr_type for connect, so this
patch fixes to set explictly bdaddr_type for RFCOMM connect.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 net/bluetooth/rfcomm/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ca55ea1..facd8a7 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -720,6 +720,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	addr.l2_family = AF_BLUETOOTH;
 	addr.l2_psm    = __constant_cpu_to_le16(RFCOMM_PSM);
 	addr.l2_cid    = 0;
+	addr.l2_bdaddr_type = BDADDR_BREDR;
 	*err = kernel_connect(sock, (struct sockaddr *) &addr, sizeof(addr), O_NONBLOCK);
 	if (*err == 0 || *err == -EINPROGRESS)
 		return s;
-- 
1.7.4.1

