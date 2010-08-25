Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:40:37 +0800
Message-ID: <AANLkTimFzgWZ-HdOUK22xbV6pVTG4spm4FJhYMH5rj1N@mail.gmail.com>
Subject: [PATCH 21/22] Parse EFS & EWS parameters for in l2cap_parse_conf_req
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From c3c9a97f3dfda527da2f9c4893302cde56e24198 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Wed, 25 Aug 2010 21:59:19 +0800
Subject: [PATCH 21/22] Parse EFS & EWS parameters for in l2cap_parse_conf_req.

---
 net/bluetooth/l2cap.c |  100 +++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 73142ae..d66d923 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2660,6 +2660,9 @@ static int l2cap_parse_conf_req(struct sock *sk,
void *data)
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	u16 mtu = L2CAP_DEFAULT_MTU;
+	struct l2cap_conf_efs efs = { .service_type = L2CAP_SERVTYPE_BESTEFFORT };
+	u8 ext_flowspec_enable = 0;
+	u16 extwin_size = 0;
 	u16 result = L2CAP_CONF_SUCCESS;

 	BT_DBG("sk %p", sk);
@@ -2693,6 +2696,17 @@ static int l2cap_parse_conf_req(struct sock
*sk, void *data)

 			break;

+		case L2CAP_CONF_EFS:
+			/* handle the extended flow spec mode */
+			ext_flowspec_enable = 1;
+			if (olen == sizeof(efs))
+				memcpy(&efs, (void *) val, olen);
+			break;
+
+		case L2CAP_CONF_EWS:
+			extwin_size = val;
+			break;
+
 		default:
 			if (hint)
 				break;
@@ -2709,16 +2723,29 @@ static int l2cap_parse_conf_req(struct sock
*sk, void *data)
 	switch (pi->mode) {
 	case L2CAP_MODE_STREAMING:
 	case L2CAP_MODE_ERTM:
-		if (!(pi->conf_state & L2CAP_CONF_STATE2_DEVICE)) {
-			pi->mode = l2cap_select_mode(rfc.mode,
-					pi->conn->feat_mask);
-			break;
+		pi->conf_state |= L2CAP_CONF_STATE2_DEVICE;
+		if (enable_highspeed && ext_flowspec_enable && pi->hschan_req) {
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
 		}

-		if (pi->mode != rfc.mode)
+		if (!l2cap_mode_supported(pi->mode, pi->conn->feat_mask))
 			return -ECONNREFUSED;

 		break;
+	default:
+		pi->mode = l2cap_select_mode(sk, rfc.mode, pi->conn->feat_mask);
+		break;
 	}

 done:
@@ -2733,8 +2760,36 @@ done:
 					sizeof(rfc), (unsigned long) &rfc);
 	}

+	/*
+		Add the ext flow spec and ext win size option parameters check here.
+	*/
+
+	if (result == L2CAP_CONF_SUCCESS && ext_flowspec_enable) {
+		if (!pi->ext_flowspec_enable) {
+			/* remote support , local not support, refused */
+
+			result = L2CAP_CONF_REJECT;
+			return -ECONNREFUSED;
+		} else if (pi->loc_efs.service_type != L2CAP_SERVTYPE_NOTRAFIC &&
+			efs.service_type != L2CAP_SERVTYPE_NOTRAFIC &&
+			efs.service_type != pi->loc_efs.service_type) {
+
+			result = L2CAP_CONF_UNACCEPT;
+
+			if (pi->num_conf_req >= 1)
+				return -ECONNREFUSED;
+
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
+				sizeof(efs), (unsigned long) &efs);
+
+		} else {
+			result = L2CAP_CONF_PENDING;
+			pi->conf_state |= L2CAP_CONF_LOCAL_PEND;
+		}
+	}

-	if (result == L2CAP_CONF_SUCCESS) {
+
+	if (result == L2CAP_CONF_SUCCESS || result == L2CAP_CONF_PENDING) {
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */

@@ -2770,6 +2825,22 @@ done:
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);

+			if (pi->ext_flowspec_enable) {
+				/* record the extend flow spec parameters */
+				pi->rem_efs.id = efs.id;
+				pi->rem_efs.service_type = efs.service_type;
+				pi->rem_efs.max_sdu_size = le16_to_cpu(efs.max_sdu_size);
+				pi->rem_efs.flush_timeout = le16_to_cpu(efs.flush_timeout);
+				pi->rem_efs.access_latency = le16_to_cpu(efs.access_latency);
+				pi->rem_efs.sdu_inter_time = le16_to_cpu(efs.sdu_inter_time);
+				l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
+						sizeof(efs), (unsigned long) &efs);
+			}
+			if (extwin_size > 0) {
+				pi->rem_extwin_enable = 1;
+				pi->rem_extwin_size = extwin_size;
+				pi->conf_state |= L2CAP_CONF_EXTWINSIZE_DONE;
+			}
 			break;

 		case L2CAP_MODE_STREAMING:
@@ -2782,7 +2853,22 @@ done:

 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
-
+			if (pi->ext_flowspec_enable) {
+				/* record the extend flow spec parameters */
+				pi->rem_efs.id = efs.id;
+				pi->rem_efs.service_type = efs.service_type;
+				pi->rem_efs.max_sdu_size = le16_to_cpu(efs.max_sdu_size);
+				pi->rem_efs.flush_timeout = le16_to_cpu(efs.flush_timeout);
+				pi->rem_efs.access_latency = le16_to_cpu(efs.access_latency);
+				pi->rem_efs.sdu_inter_time = le16_to_cpu(efs.sdu_inter_time);
+				l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
+						sizeof(efs), (unsigned long) &efs);
+			}
+			if (extwin_size == 0) {
+				pi->rem_extwin_enable = 1;
+				pi->rem_extwin_size = extwin_size;
+				pi->conf_state |= L2CAP_CONF_EXTWINSIZE_DONE;
+			}
 			break;

 		default:
-- 
1.6.3.3
