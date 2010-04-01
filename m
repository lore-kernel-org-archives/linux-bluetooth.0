Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 23/34] Bluetooth: Add le16 macro to Retransmission and Monitor Timeouts values
Date: Thu,  1 Apr 2010 17:23:41 -0300
Message-Id: <1270153432-6477-24-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-23-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-11-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-13-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-14-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-15-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-16-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-17-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-18-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-20-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-21-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-22-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-23-git-send-email-padovan@profusion.mobi>
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
