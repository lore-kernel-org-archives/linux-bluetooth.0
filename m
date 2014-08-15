Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] Bluetooth: Fix incorrect LE CoC PDU length restriction based on HCI MTU
Date: Fri, 15 Aug 2014 21:06:51 +0300
Message-Id: <1408126019-29761-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408126019-29761-1-git-send-email-johan.hedberg@gmail.com>
References: <1408126019-29761-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The l2cap_create_le_flowctl_pdu() function that l2cap_segment_le_sdu()
calls is perfectly capable of doing packet fragmentation if given bigger
PDUs than the HCI buffers allow. Forcing the PDU length based on the HCI
MTU (conn->mtu) would therefore needlessly strict operation on hardware
with limited LE buffers (e.g. both Intel and Broadcom seem to have this
set to just 27 bytes).

This patch removes the restriction and makes it possible to send PDUs of
the full length that the remote MPS value allows.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4a90438d99df..52b56808d5d3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2358,12 +2358,8 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
 
 	BT_DBG("chan %p, msg %p, len %zu", chan, msg, len);
 
-	pdu_len = chan->conn->mtu - L2CAP_HDR_SIZE;
-
-	pdu_len = min_t(size_t, pdu_len, chan->remote_mps);
-
 	sdu_len = len;
-	pdu_len -= L2CAP_SDULEN_SIZE;
+	pdu_len = chan->remote_mps - L2CAP_SDULEN_SIZE;
 
 	while (len > 0) {
 		if (len <= pdu_len)
-- 
1.9.3

