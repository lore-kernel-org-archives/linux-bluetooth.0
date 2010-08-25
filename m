Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:41:02 +0800
Message-ID: <AANLkTimQsNmOc-Mv30xA0x_NEpxvs4kXjGfuOfqHxEDP@mail.gmail.com>
Subject: [PATCH 22/22] Parse EFS & EWS parameters for in l2cap_parse_conf_rsp
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 72afc40895eb272269156b98ab3024ac4f130b0d Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Wed, 25 Aug 2010 22:08:47 +0800
Subject: [PATCH 22/22] Parse EFS & EWS parameters for in l2cap_parse_conf_rsp.

---
 net/bluetooth/l2cap.c |   35 ++++++++++++++++++++++++++++++-----
 1 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index d66d923..e21aed0 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2896,6 +2896,7 @@ static int l2cap_parse_conf_rsp(struct sock *sk,
void *rsp, int len, void *data,
 	int type, olen;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc;
+	struct l2cap_conf_efs efs;

 	BT_DBG("sk %p, rsp %p, len %d, req %p", sk, rsp, len, data);

@@ -2926,18 +2927,34 @@ static int l2cap_parse_conf_rsp(struct sock
*sk, void *rsp, int len, void *data,
 							rfc.mode != pi->mode)
 				return -ECONNREFUSED;

+			pi->mode = rfc.mode;
 			pi->fcs = 0;

 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
 			break;
-		}
-	}

-	if (pi->mode == L2CAP_MODE_BASIC && pi->mode != rfc.mode)
-		return -ECONNREFUSED;
+		case L2CAP_CONF_EFS:
+			if (olen == sizeof(efs))
+				memcpy(&efs, (void *)val, olen);

-	pi->mode = rfc.mode;
+			if (pi->loc_efs.service_type != L2CAP_SERVTYPE_NOTRAFIC &&
+				efs.service_type != L2CAP_SERVTYPE_NOTRAFIC &&
+				efs.service_type != pi->loc_efs.service_type)
+				return -ECONNREFUSED;
+
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
+					sizeof(efs), (unsigned long) &efs);
+			break;
+
+		case L2CAP_CONF_EWS:
+			pi->extwin_size = val;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS,
+							2, pi->extwin_size);
+			break;
+
+		}
+	}

 	if (*result == L2CAP_CONF_SUCCESS) {
 		switch (rfc.mode) {
@@ -2946,6 +2963,14 @@ static int l2cap_parse_conf_rsp(struct sock
*sk, void *rsp, int len, void *data,
 			pi->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
 			pi->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
 			pi->mps    = le16_to_cpu(rfc.max_pdu_size);
+			if (pi->ext_flowspec_enable) {
+				/* id, service type should not be changed */
+				pi->loc_efs.max_sdu_size = le16_to_cpu(efs.max_sdu_size);
+				pi->loc_efs.sdu_inter_time = le16_to_cpu(efs.sdu_inter_time);
+				pi->loc_efs.access_latency = le16_to_cpu(efs.access_latency);
+				pi->loc_efs.flush_timeout = le16_to_cpu(efs.flush_timeout);
+			}
+
 			break;
 		case L2CAP_MODE_STREAMING:
 			pi->mps    = le16_to_cpu(rfc.max_pdu_size);
-- 
1.6.3.3
