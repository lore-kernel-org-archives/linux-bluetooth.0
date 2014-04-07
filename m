Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] obexd/client: Fix calling g_obex_cancel_req for completed requests
Date: Mon,  7 Apr 2014 14:03:07 +0300
Message-Id: <1396868588-20875-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This leads to incorrect responses such as the following:

> ACL data: handle 12 flags 0x02 dlen 26
    L2CAP(d): cid 0x0041 len 22 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 38 pf 0 ilen 18 fcs 0xfd
        OBEX: Get rsp(f): status 200 len 18
        Status 200 = Success
        Connection ID (0xcb) = 1
        App. Parameters (0x4c) = Sequence length 4
        End of Body (0x49) = Sequence length 0
< ACL data: handle 12 flags 0x00 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 38 pf 0 ilen 3 fcs 0x27
        OBEX: Get rsp(f): status 715 len 3
---
 obexd/client/transfer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 3564a34..bd2b1ab 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -698,6 +698,7 @@ static void get_xfer_progress_first(GObex *obex, GError *err, GObexPacket *rsp,
 	}
 
 	if (rspcode == G_OBEX_RSP_SUCCESS) {
+		transfer->req = 0;
 		xfer_complete(obex, err, transfer);
 		return;
 	}
-- 
1.9.0

