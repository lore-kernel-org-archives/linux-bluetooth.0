Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH 04/10] Append RFC option when configuring an L2CAP socket.
Date: Thu, 30 Apr 2009 17:16:41 -0400
Message-Id: <1241126207-19996-5-git-send-email-ngh@isomerica.net>
In-Reply-To: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
References: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

When negotiating Enhanced Retransmission or Streaming modes, append our RFC
option to the configuration list.

Signed-off-by: Nathan Holstein <nathan@lampreynetworks.com>
---
 net/bluetooth/l2cap.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 7df307f..660a433 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1863,6 +1863,7 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
+	struct l2cap_conf_rfc rfc = { 0, };
 	void *ptr = req->data;
 
 	BT_DBG("sk %p", sk);
@@ -1870,6 +1871,29 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
 	if (pi->imtu != L2CAP_DEFAULT_MTU)
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
 
+	switch (pi->mode) {
+	case L2CAP_MODE_ERTM:
+		rfc.mode = L2CAP_MODE_ERTM;
+		rfc.txwin_size = L2CAP_DEFAULT_RX_WINDOW;
+		rfc.max_transmit = L2CAP_DEFAULT_MAX_RECEIVE;
+		rfc.retrans_timeout = cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
+		rfc.monitor_timeout = cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
+		rfc.max_pdu_size = cpu_to_le16(L2CAP_DEFAULT_MAX_RX_APDU);
+		break;
+
+	case L2CAP_MODE_STREAM:
+		rfc.mode = L2CAP_MODE_STREAM;
+		rfc.txwin_size = 0;
+		rfc.max_transmit = 0;
+		rfc.retrans_timeout = 0;
+		rfc.monitor_timeout = 0;
+		rfc.max_pdu_size = cpu_to_le16(L2CAP_DEFAULT_MAX_RX_APDU);
+		break;
+	}
+	if (rfc.mode)
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+				(unsigned long) &rfc);
+
 	/* FIXME: Need actual value of the flush timeout */
 	//if (flush_to != L2CAP_DEFAULT_FLUSH_TO)
 	//   l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO, 2, pi->flush_to);
-- 
1.6.0.6

