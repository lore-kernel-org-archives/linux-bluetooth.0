Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH] Bluetooth: Get a more accurate PDU len
Date: Fri, 25 May 2012 18:57:05 -0300
Message-Id: <1337983025-20656-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Both FCS and Extended header might be or might not be present in a ERTM
channel.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c07c134..c614532 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2143,7 +2143,13 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	pdu_len = min_t(size_t, pdu_len, L2CAP_BREDR_MAX_PAYLOAD);
 
 	/* Adjust for largest possible L2CAP overhead. */
-	pdu_len -= L2CAP_EXT_HDR_SIZE + L2CAP_FCS_SIZE;
+	if (chan->fcs)
+		pdu_len -= L2CAP_FCS_SIZE;
+
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		pdu_len -= L2CAP_EXT_HDR_SIZE;
+	else
+		pdu_len -= L2CAP_ENH_HDR_SIZE;
 
 	/* Remote device may have requested smaller PDUs */
 	pdu_len = min_t(size_t, pdu_len, chan->remote_mps);
-- 
1.7.10.1

