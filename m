Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 1/6] Bluetooth: Ignore Tx Window value with Streaming mode
Date: Fri, 26 Mar 2010 16:19:14 -0300
Message-Id: <1269631159-20750-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-20-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-20-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Tx Window value shall not be used with Streaming Mode and the receiver
of the config Request shall ignore its value.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 8c8b5d9..2cfad45 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2491,7 +2491,6 @@ done:
 			break;
 
 		case L2CAP_MODE_STREAMING:
-			pi->remote_tx_win = rfc.txwin_size;
 			pi->max_pdu_size = rfc.max_pdu_size;
 
 			pi->conf_state |= L2CAP_CONF_MODE_DONE;
-- 
1.6.4.4
