Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB2DC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 11:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26AC2087E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 11:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfARL4d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:56:33 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42311 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfARL4d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 06:56:33 -0500
Received: from localhost.localdomain (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id DF3B8CEE14;
        Fri, 18 Jan 2019 13:04:17 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt
Date:   Fri, 18 Jan 2019 12:56:20 +0100
Message-Id: <20190118115620.7562-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When doing option parsing for standard type values of 1, 2 or 4 octets,
the value is converted directly into a variable instead of a pointer. To
avoid being tricked into being a pointer, check that for these option
types that sizes actually match. In L2CAP every option is fixed size and
thus it is prudent anyway to ensure that the remote side sends us the
right option size along with option paramters.

If the option size is not matching the option type, then that option is
silently ignored. It is a protocol violation and instead of trying to
give the remote attacker any further hints just pretend that option is
not present and proceed with the default values. Implementation
following the specification and its qualification procedures will always
use the correct size and thus not being impacted here.

To keep the code readable and consistent accross all options, a few
cosmetic changes were also required.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 77 +++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2a7fb517d460..77799e7d5a34 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3343,10 +3343,14 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
+			if (olen != 2)
+				break;
 			mtu = val;
 			break;
 
 		case L2CAP_CONF_FLUSH_TO:
+			if (olen != 2)
+				break;
 			chan->flush_to = val;
 			break;
 
@@ -3354,26 +3358,30 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			break;
 
 		case L2CAP_CONF_RFC:
-			if (olen == sizeof(rfc))
-				memcpy(&rfc, (void *) val, olen);
+			if (olen != sizeof(rfc))
+				break;
+			memcpy(&rfc, (void *) val, olen);
 			break;
 
 		case L2CAP_CONF_FCS:
+			if (olen != 1)
+				break;
 			if (val == L2CAP_FCS_NONE)
 				set_bit(CONF_RECV_NO_FCS, &chan->conf_state);
 			break;
 
 		case L2CAP_CONF_EFS:
-			if (olen == sizeof(efs)) {
-				remote_efs = 1;
-				memcpy(&efs, (void *) val, olen);
-			}
+			if (olen != sizeof(efs))
+				break;
+			remote_efs = 1;
+			memcpy(&efs, (void *) val, olen);
 			break;
 
 		case L2CAP_CONF_EWS:
+			if (olen != 2)
+				break;
 			if (!(chan->conn->local_fixed_chan & L2CAP_FC_A2MP))
 				return -ECONNREFUSED;
-
 			set_bit(FLAG_EXT_CTRL, &chan->flags);
 			set_bit(CONF_EWS_RECV, &chan->conf_state);
 			chan->tx_win_max = L2CAP_DEFAULT_EXT_WINDOW;
@@ -3383,7 +3391,6 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		default:
 			if (hint)
 				break;
-
 			result = L2CAP_CONF_UNKNOWN;
 			*((u8 *) ptr++) = type;
 			break;
@@ -3551,55 +3558,60 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
+			if (olen != 2)
+				break;
 			if (val < L2CAP_DEFAULT_MIN_MTU) {
 				*result = L2CAP_CONF_UNACCEPT;
 				chan->imtu = L2CAP_DEFAULT_MIN_MTU;
 			} else
 				chan->imtu = val;
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, chan->imtu, endptr - ptr);
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, chan->imtu,
+					   endptr - ptr);
 			break;
 
 		case L2CAP_CONF_FLUSH_TO:
+			if (olen != 2)
+				break;
 			chan->flush_to = val;
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO,
-					   2, chan->flush_to, endptr - ptr);
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO, 2,
+					   chan->flush_to, endptr - ptr);
 			break;
 
 		case L2CAP_CONF_RFC:
-			if (olen == sizeof(rfc))
-				memcpy(&rfc, (void *)val, olen);
-
+			if (olen != sizeof(rfc))
+				break;
+			memcpy(&rfc, (void *)val, olen);
 			if (test_bit(CONF_STATE2_DEVICE, &chan->conf_state) &&
 			    rfc.mode != chan->mode)
 				return -ECONNREFUSED;
-
 			chan->fcs = 0;
-
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
-					   sizeof(rfc), (unsigned long) &rfc, endptr - ptr);
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+					   (unsigned long) &rfc, endptr - ptr);
 			break;
 
 		case L2CAP_CONF_EWS:
+			if (olen != 2)
+				break;
 			chan->ack_win = min_t(u16, val, chan->ack_win);
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2,
 					   chan->tx_win, endptr - ptr);
 			break;
 
 		case L2CAP_CONF_EFS:
-			if (olen == sizeof(efs)) {
-				memcpy(&efs, (void *)val, olen);
-
-				if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
-				    efs.stype != L2CAP_SERV_NOTRAFIC &&
-				    efs.stype != chan->local_stype)
-					return -ECONNREFUSED;
-
-				l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS, sizeof(efs),
-						   (unsigned long) &efs, endptr - ptr);
-			}
+			if (olen != sizeof(efs))
+				break;
+			memcpy(&efs, (void *)val, olen);
+			if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
+			    efs.stype != L2CAP_SERV_NOTRAFIC &&
+			    efs.stype != chan->local_stype)
+				return -ECONNREFUSED;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS, sizeof(efs),
+					   (unsigned long) &efs, endptr - ptr);
 			break;
 
 		case L2CAP_CONF_FCS:
+			if (olen != 1)
+				break;
 			if (*result == L2CAP_CONF_PENDING)
 				if (val == L2CAP_FCS_NONE)
 					set_bit(CONF_RECV_NO_FCS,
@@ -3731,10 +3743,13 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 
 		switch (type) {
 		case L2CAP_CONF_RFC:
-			if (olen == sizeof(rfc))
-				memcpy(&rfc, (void *)val, olen);
+			if (olen != sizeof(rfc))
+				break;
+			memcpy(&rfc, (void *)val, olen);
 			break;
 		case L2CAP_CONF_EWS:
+			if (olen != 2)
+				break;
 			txwin_ext = val;
 			break;
 		}
-- 
2.20.1

