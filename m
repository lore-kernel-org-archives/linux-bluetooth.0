Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 5/7] Bluetooth: parse EFS in l2cap config response
Date: Thu,  1 Sep 2011 14:07:34 +0300
Message-Id: <1314875256-6904-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1314875256-6904-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1314875256-6904-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add parsing extended flowspec in l2cap config response
Based upon haijun.liu <haijun.liu@atheros.com> series of patches
(sent Sun, 22 Aug 2010)

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b7f36da..02908f0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2213,6 +2213,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 	int type, olen;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc;
+	struct l2cap_conf_efs efs;
 
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
@@ -2248,6 +2249,19 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
 			break;
+
+		case L2CAP_CONF_EFS:
+			if (olen == sizeof(efs))
+				memcpy(&efs, (void *)val, olen);
+
+			if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
+				efs.service_type != L2CAP_SERV_NOTRAFIC &&
+				efs.service_type != chan->local_stype)
+				return -ECONNREFUSED;
+
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
+					sizeof(efs), (unsigned long) &efs);
+			break;
 		}
 	}
 
@@ -2256,13 +2270,26 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 
 	chan->mode = rfc.mode;
 
-	if (*result == L2CAP_CONF_SUCCESS) {
+	if (*result == L2CAP_CONF_SUCCESS || *result == L2CAP_CONF_PENDING) {
 		switch (rfc.mode) {
 		case L2CAP_MODE_ERTM:
 			chan->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
 			chan->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
 			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
+
+			if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
+				/* id, service type should not be changed */
+				chan->local_msdu =
+					le16_to_cpu(efs.max_sdu_size);
+				chan->local_sdu_itime =
+					le32_to_cpu(efs.sdu_inter_time);
+				chan->local_acc_lat =
+					le32_to_cpu(efs.access_latency);
+				chan->local_flush_to =
+					le32_to_cpu(efs.flush_timeout);
+			}
 			break;
+
 		case L2CAP_MODE_STREAMING:
 			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
 		}
-- 
1.7.4.1

