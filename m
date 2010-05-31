Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: jprvita@profusion.mobi, gustavo@padovan.org, marcel@holtmann.org
Subject: [PATCH 07/11] Bluetooth: Only check SAR bits if frame is I-frame
Date: Mon, 31 May 2010 16:05:23 -0300
Message-Id: <1275332727-16263-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1275332727-16263-6-git-send-email-padovan@profusion.mobi>
References: <1275332727-16263-1-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-2-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-3-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-4-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-5-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-6-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Check the SAR bit only make sense for an I-frame. Also check SAR for
S-frame lead to errors.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 97584d8..7a8454a 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4122,7 +4122,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (l2cap_check_fcs(pi, skb))
 			goto drop;
 
-		if (__is_sar_start(control))
+		if (__is_sar_start(control) && __is_iframe(control))
 			len -= 2;
 
 		if (pi->fcs == L2CAP_FCS_CRC16)
-- 
1.6.4.4
