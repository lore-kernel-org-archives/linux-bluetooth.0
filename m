Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/7] Bluetooth: EFS: parse l2cap config request
Date: Fri, 16 Sep 2011 16:26:33 +0300
Message-Id: <1316179596-30906-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1316179596-30906-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1316179596-30906-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add parsing extended flowspec option in L2cap config request
Based upon haijun.liu <haijun.liu@atheros.com> series of patches
(sent Sun, 22 Aug 2010)

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   67 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4b05248..f2aa2fe 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -338,6 +338,12 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		chan->omtu = L2CAP_DEFAULT_MTU;
 	}
 
+	chan->local_stype = L2CAP_SERV_BESTEFFORT;
+	chan->local_msdu = L2CAP_DEFAULT_MAX_SDU_SIZE;
+	chan->local_sdu_itime = L2CAP_DEFAULT_SDU_ARRIVAL_TIME;
+	chan->local_acc_lat = L2CAP_DEFAULT_ACCESS_LATENCY;
+	chan->local_flush_to = L2CAP_DEFAULT_FLUSH_TO;
+
 	chan_hold(chan);
 
 	list_add(&chan->list, &conn->chan_l);
@@ -1895,6 +1901,11 @@ static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
 	}
 }
 
+static inline bool __l2cap_efs_supported(struct l2cap_chan *chan)
+{
+	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_FLOW;
+}
+
 static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 {
 	struct l2cap_conf_req *req = data;
@@ -2001,6 +2012,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 	int type, hint, olen;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
+	struct l2cap_conf_efs efs = { .service_type = L2CAP_SERV_BESTEFFORT };
+	u8 remote_efs = 0;
 	u16 mtu = L2CAP_DEFAULT_MTU;
 	u16 result = L2CAP_CONF_SUCCESS;
 
@@ -2032,7 +2045,12 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 		case L2CAP_CONF_FCS:
 			if (val == L2CAP_FCS_NONE)
 				set_bit(CONF_NO_FCS_RECV, &chan->conf_state);
+			break;
 
+		case L2CAP_CONF_EFS:
+			remote_efs = 1;
+			if (olen == sizeof(efs))
+				memcpy(&efs, (void *) val, olen);
 			break;
 
 		default:
@@ -2057,7 +2075,10 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 			break;
 		}
 
-		if (chan->mode != rfc.mode)
+		if (remote_efs && __l2cap_efs_supported(chan))
+			set_bit(FLAG_EFS_ENABLE, &chan->flags);
+
+		if (!l2cap_mode_supported(chan->mode, chan->conn->feat_mask))
 			return -ECONNREFUSED;
 
 		break;
@@ -2075,8 +2096,35 @@ done:
 					sizeof(rfc), (unsigned long) &rfc);
 	}
 
+	/*
+	   Add extended flow specification option check here.
+	 */
+	if (result == L2CAP_CONF_SUCCESS && remote_efs) {
+		if (!test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
+			/* remote efs support , local efs not supported */
+
+			result = L2CAP_CONF_REJECT;
+			return -ECONNREFUSED;
+		}
+
+		if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
+				efs.service_type != L2CAP_SERV_NOTRAFIC &&
+				efs.service_type != chan->local_stype) {
+
+			result = L2CAP_CONF_UNACCEPT;
+
+			if (chan->num_conf_req >= 1)
+				return -ECONNREFUSED;
 
-	if (result == L2CAP_CONF_SUCCESS) {
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
+					sizeof(efs), (unsigned long) &efs);
+		} else {
+			result = L2CAP_CONF_PENDING;
+			set_bit(CONF_LOCAL_PEND, &chan->conf_state);
+		}
+	}
+
+	if (result == L2CAP_CONF_SUCCESS || result == L2CAP_CONF_PENDING) {
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */
 
@@ -2113,6 +2161,21 @@ done:
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
 
+			if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
+				chan->remote_id = efs.id;
+				chan->remote_stype = efs.service_type;
+				chan->remote_msdu =
+					le16_to_cpu(efs.max_sdu_size);
+				chan->remote_flush_to =
+					le32_to_cpu(efs.flush_timeout);
+				chan->remote_acc_lat =
+					le32_to_cpu(efs.access_latency);
+				chan->remote_sdu_itime =
+					le32_to_cpu(efs.sdu_inter_time);
+				l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
+					sizeof(efs), (unsigned long) &efs);
+			}
+
 			break;
 
 		case L2CAP_MODE_STREAMING:
-- 
1.7.4.1

