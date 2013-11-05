Return-Path: <cyrus@holtmann.org>
From: Seung-Woo Kim <sw0312.kim@samsung.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, gustavo@padovan.org,
 johan.hedberg@gmail.com
Cc: sw0312.kim@samsung.com, s.syam@samsung.com
Subject: [PATCH] Bluetooth: Fix RFCOMM bind fail for L2CAP sock
Date: Tue, 05 Nov 2013 16:02:24 +0900
Message-id: <1383634944-4141-1-git-send-email-sw0312.kim@samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

L2CAP socket bind checks its bdaddr type but RFCOMM kernel thread
does not assign proper bdaddr type for L2CAP sock. This can cause
that RFCOMM failure.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
The issue is came from following commit, but it is only in bluetooth-next tree,
so this patch is not needed for stable tree.

commit 80c1a2e76dbb36588facb265ab364b1302f7ef8c
Author: Johan Hedberg <johan.hedberg@intel.com>
Date:   Mon Oct 14 21:17:52 2013 +0300

    Bluetooth: Reject invalid bdaddr types for sockets

This patch is based on commit cca34b785a21d220176038c45071ffe842e99fd3 of
bluetooth-next tree.
---
 net/bluetooth/rfcomm/core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 94d06cb..ca55ea1 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -694,6 +694,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	addr.l2_family = AF_BLUETOOTH;
 	addr.l2_psm    = 0;
 	addr.l2_cid    = 0;
+	addr.l2_bdaddr_type = BDADDR_BREDR;
 	*err = kernel_bind(sock, (struct sockaddr *) &addr, sizeof(addr));
 	if (*err < 0)
 		goto failed;
@@ -1983,6 +1984,7 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 	addr.l2_family = AF_BLUETOOTH;
 	addr.l2_psm    = __constant_cpu_to_le16(RFCOMM_PSM);
 	addr.l2_cid    = 0;
+	addr.l2_bdaddr_type = BDADDR_BREDR;
 	err = kernel_bind(sock, (struct sockaddr *) &addr, sizeof(addr));
 	if (err < 0) {
 		BT_ERR("Bind failed %d", err);
-- 
1.7.4.1
