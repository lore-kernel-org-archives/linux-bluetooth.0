Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 5/6] Bluetooth: EFS: parse L2CAP config response
Date: Thu, 13 Oct 2011 16:18:57 +0300
Message-Id: <1318511938-24311-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318511938-24311-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318511938-24311-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add parsing Extended Flow Specification in L2CAP Config Response.
Based upon haijun.liu <haijun.liu@atheros.com> series of patches
(sent Sun, 22 Aug 2010)

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 255dada..7eab3a2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2330,6 +2330,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 	int type, olen;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc;
+	struct l2cap_conf_efs efs;
 
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
@@ -2372,6 +2373,19 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS,
 							2, chan->tx_win);
 			break;
+
+		case L2CAP_CONF_EFS:
+			if (olen == sizeof(efs))
+				memcpy(&efs, (void *)val, olen);
+
+			if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
+					efs.stype != L2CAP_SERV_NOTRAFIC &&
+					efs.stype != chan->local_stype)
+				return -ECONNREFUSED;
+
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
+					sizeof(efs), (unsigned long) &efs);
+			break;
 		}
 	}
 
@@ -2386,7 +2400,17 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 			chan->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
 			chan->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
 			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
+
+			if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
+				chan->local_msdu = le16_to_cpu(efs.msdu);
+				chan->local_sdu_itime =
+						le32_to_cpu(efs.sdu_itime);
+				chan->local_acc_lat = le32_to_cpu(efs.acc_lat);
+				chan->local_flush_to =
+						le32_to_cpu(efs.flush_to);
+			}
 			break;
+
 		case L2CAP_MODE_STREAMING:
 			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
 		}
-- 
1.7.4.1

