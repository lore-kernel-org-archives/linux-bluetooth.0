Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 04/10] Bluetooth: Add le16 macro to Retransmission and Monitor Timeouts values
Date: Tue, 30 Mar 2010 15:52:34 -0300
Message-Id: <1269975160-9994-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269975160-9994-3-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-20-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-1-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-2-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-3-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Fix a possible problem with Big Endian machines.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 4c98e3c..e6e2351 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2483,8 +2483,10 @@ done:
 
 			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
-			rfc.retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
-			rfc.monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
+			rfc.retrans_timeout =
+				le16_to_cpu(L2CAP_DEFAULT_RETRANS_TO);
+			rfc.monitor_timeout =
+				le16_to_cpu(L2CAP_DEFAULT_MONITOR_TO);
 
 			pi->conf_state |= L2CAP_CONF_MODE_DONE;
 
@@ -2574,8 +2576,8 @@ static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data,
 		switch (rfc.mode) {
 		case L2CAP_MODE_ERTM:
 			pi->remote_tx_win   = rfc.txwin_size;
-			pi->retrans_timeout = rfc.retrans_timeout;
-			pi->monitor_timeout = rfc.monitor_timeout;
+			pi->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
+			pi->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
 			pi->mps    = le16_to_cpu(rfc.max_pdu_size);
 			break;
 		case L2CAP_MODE_STREAMING:
@@ -2630,8 +2632,8 @@ done:
 	switch (rfc.mode) {
 	case L2CAP_MODE_ERTM:
 		pi->remote_tx_win   = rfc.txwin_size;
-		pi->retrans_timeout = rfc.retrans_timeout;
-		pi->monitor_timeout = rfc.monitor_timeout;
+		pi->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
+		pi->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
 		pi->mps    = le16_to_cpu(rfc.max_pdu_size);
 		break;
 	case L2CAP_MODE_STREAMING:
-- 
1.6.4.4
