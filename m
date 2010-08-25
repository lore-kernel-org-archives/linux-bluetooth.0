Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:40:11 +0800
Message-ID: <AANLkTinEjo0WvHYaamqX_XY-HSY3nKA1voj-MkYDkyv6@mail.gmail.com>
Subject: [PATCH 20/22] Add EFS & EWS config parameters for ERTM & Streaming
 modes in l2cap_build_conf_req
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 74b6581d7fdb0d3e5c0cd9546b15d58357c3758c Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Tue, 24 Aug 2010 15:52:49 +0800
Subject: [PATCH 20/22] Add EFS & EWS config parameters for ERTM &
Streaming modes in l2cap_build_conf_req.

---
 net/bluetooth/l2cap.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index e7f7067..73142ae 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2500,6 +2500,7 @@ static int l2cap_build_conf_req(struct sock *sk,
void *data)
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
 	struct l2cap_conf_rfc rfc = { .mode = pi->mode };
+	struct l2cap_conf_efs efs = { .service_type = L2CAP_SERVTYPE_BESTEFFORT };
 	void *ptr = req->data;

 	BT_DBG("sk %p", sk);
@@ -2510,10 +2511,25 @@ static int l2cap_build_conf_req(struct sock
*sk, void *data)
 	switch (pi->mode) {
 	case L2CAP_MODE_STREAMING:
 	case L2CAP_MODE_ERTM:
-		if (pi->conf_state & L2CAP_CONF_STATE2_DEVICE)
-			break;
+		pi->conf_state |= L2CAP_CONF_STATE2_DEVICE;

-		/* fall through */
+		if (enable_highspeed && pi->hschan_req) {
+			pi->ext_flowspec_enable = 1;
+
+			pi->loc_efs.service_type = (!pi->guaranteed) ?
+				L2CAP_SERVTYPE_BESTEFFORT : L2CAP_SERVTYPE_GUARANTEED;
+			pi->loc_efs.max_sdu_size = L2CAP_DEFAULT_MAX_SDU_SIZE;
+			pi->loc_efs.sdu_inter_time = L2CAP_DEFAULT_SDU_ARRIVAL_TIME;
+			pi->loc_efs.access_latency = L2CAP_DEFAULT_ACCESS_LATENCY;
+			pi->loc_efs.flush_timeout = L2CAP_DEFAULT_FLUSH_TIMEOUT;
+		}
+		if (enable_highspeed && (pi->conn->feat_mask & L2CAP_FEAT_EXT_WINSIZE)) {
+			pi->extwin_enable = 1;
+			pi->extwin_size = L2CAP_DEFAULT_EXT_WINSIZE;
+		}
+		if (!l2cap_mode_supported(pi->mode, pi->conn->feat_mask))
+			l2cap_send_disconn_req(pi->conn, sk, ECONNRESET);
+		break;
 	default:
 		pi->mode = l2cap_select_mode(rfc.mode, pi->conn->feat_mask);
 		break;
@@ -2552,6 +2568,33 @@ done:
 			pi->fcs = L2CAP_FCS_NONE;
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, pi->fcs);
 		}
+
+		if (pi->ext_flowspec_enable) {
+			efs.service_type = pi->loc_efs.service_type;
+			efs.max_sdu_size = cpu_to_le16(pi->loc_efs.max_sdu_size);
+			efs.sdu_inter_time = cpu_to_le32(pi->loc_efs.sdu_inter_time);
+			if (pi->loc_efs.service_type == L2CAP_SERVTYPE_BESTEFFORT) {
+				pi->loc_efs.id = 1;
+				efs.id = pi->loc_efs.id;
+				efs.access_latency = cpu_to_le32(0xFFFFFFFF);
+				efs.flush_timeout = cpu_to_le32(0xFFFFFFFF);
+			} else {
+				/* As spec, the ident shall be unique within
+				   the scope of a physical link.
+				*/
+				pi->loc_efs.id = l2cap_flowspec_ident(l2cap_pi(sk)->conn);
+				efs.id = pi->loc_efs.id;
+				efs.access_latency = cpu_to_le32(pi->loc_efs.access_latency);
+				efs.flush_timeout = cpu_to_le32(pi->loc_efs.flush_timeout);
+			}
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
+						sizeof(efs), (unsigned long) &efs);
+		}
+
+		if (pi->extwin_enable) {
+			pi->extwin_size = max_t(__u16, pi->extwin_size, 0x01);
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 4, pi->extwin_size);
+		}
 		break;

 	case L2CAP_MODE_STREAMING:
@@ -2572,6 +2615,24 @@ done:
 			pi->fcs = L2CAP_FCS_NONE;
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, pi->fcs);
 		}
+
+		if (pi->ext_flowspec_enable) {
+			efs.id = 1;
+			efs.service_type = L2CAP_SERVTYPE_BESTEFFORT;
+			efs.max_sdu_size = cpu_to_le16(pi->loc_efs.max_sdu_size);
+			efs.sdu_inter_time = cpu_to_le32(pi->loc_efs.sdu_inter_time);
+			efs.access_latency = 0;
+			efs.flush_timeout = 0;
+
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
+						sizeof(efs), (unsigned long) &efs);
+		}
+
+		if (pi->extwin_enable) {
+			pi->extwin_enable = 1;
+			pi->extwin_size = 0;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 4, pi->extwin_size);
+		}
 		break;
 	}

-- 
1.6.3.3
