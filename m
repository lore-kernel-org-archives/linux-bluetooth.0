Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 2/2] Bluetooth: Prevent uninitialized data access in L2CAP configuration
Date: Tue,  6 Dec 2011 16:23:27 -0800
Message-Id: <1323217407-2490-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1323217407-2490-1-git-send-email-mathewm@codeaurora.org>
References: <1323217407-2490-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When configuring an ERTM or streaming mode connection, remote devices
are expected to send an RFC option in a successful config response.  A
misbehaving remote device might not send an RFC option, and the L2CAP
code should not access uninitialized data in this case.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5ea94a1..49ae7df 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2152,7 +2152,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 	void *ptr = req->data;
 	int type, olen;
 	unsigned long val;
-	struct l2cap_conf_rfc rfc;
+	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
@@ -2205,6 +2205,9 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 			break;
 		case L2CAP_MODE_STREAMING:
 			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
+			break;
+		default:
+			break;
 		}
 	}
 
@@ -2271,6 +2274,14 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 		}
 	}
 
+	/* Use sane default values in case a misbehaving remote device
+	 * did not send an RFC option.
+	 */
+	rfc.mode = chan->mode;
+	rfc.retrans_timeout = cpu_to_le16(chan->retrans_timeout);
+	rfc.monitor_timeout = cpu_to_le16(chan->monitor_timeout);
+	rfc.max_pdu_size = cpu_to_le16(chan->mps);
+
 done:
 	switch (rfc.mode) {
 	case L2CAP_MODE_ERTM:
@@ -2280,6 +2291,9 @@ done:
 		break;
 	case L2CAP_MODE_STREAMING:
 		chan->mps    = le16_to_cpu(rfc.max_pdu_size);
+		break;
+	default:
+		break;
 	}
 }
 
-- 
1.7.8

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
