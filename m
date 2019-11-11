Return-Path: <SRS0=pK2I=ZD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DB9C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 19:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3691E2067B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 19:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKKTyJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:54:09 -0500
Received: from hall.aurel32.net ([195.154.113.88]:58222 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfKKTyJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Nov 2019 14:54:09 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1iUFlI-0002rm-Em; Mon, 11 Nov 2019 20:54:08 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1iUFlI-0000rw-2r; Mon, 11 Nov 2019 20:54:08 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH BlueZ] mesh: fix (re)transmit count & interval steps
Date:   Mon, 11 Nov 2019 20:54:06 +0100
Message-Id: <20191111195406.3291-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Foundation Model Layer uses little endian ordering. As a
consequence the (re)transmit count and interval steps in the Config
Relay, Config Model Publication and Config Network Transmit messages
use the lower 3 bits for the (re)transmission count and the higher 5
bits for the interval steps.

The figure 4.5 in section 4.3.2.16 of the Mesh Profile Bluetooth
Specification provides a good clarification.

This patch therefore fixes those messages for both the daemon and
configuration client parts.
---
 mesh/cfgmod-server.c | 16 ++++++++--------
 mesh/model.c         |  4 ++--
 tools/mesh/cfgcli.c  |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 55cc8e9eb..8acde95b9 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -211,8 +211,8 @@ static bool config_pub_set(struct mesh_node *node, uint16_t net_idx,
 			.ttl = ttl,
 			.credential = cred_flag,
 			.period = period,
-			.count = retransmit >> 5,
-			.interval = ((0x1f & retransmit) + 1) * 50
+			.count = retransmit & 0x7,
+			.interval = ((retransmit >> 3) + 1) * 50
 		};
 
 		if (b_virt)
@@ -870,8 +870,8 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 		if (size != 2 || pkt[0] > 0x01)
 			return true;
 
-		count = (pkt[1] >> 5) + 1;
-		interval = ((pkt[1] & 0x1f) + 1) * 10;
+		count = (pkt[1] & 0x7) + 1;
+		interval = ((pkt[1] >> 3) + 1) * 10;
 		node_relay_mode_set(node, !!pkt[0], count, interval);
 		/* Fall Through */
 
@@ -879,7 +879,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 		n = mesh_model_opcode_set(OP_CONFIG_RELAY_STATUS, msg);
 
 		msg[n++] = node_relay_mode_get(node, &count, &interval);
-		msg[n++] = ((count - 1) << 5) + ((interval/10 - 1) & 0x1f);
+		msg[n++] = (count - 1) + ((interval/10 - 1) << 3);
 
 		l_debug("Get/Set Relay Config (%d)", msg[n-1]);
 		break;
@@ -888,8 +888,8 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 		if (size != 1)
 			return true;
 
-		count = (pkt[0] >> 5) + 1;
-		interval = ((pkt[0] & 0x1f) + 1) * 10;
+		count = (pkt[0] & 0x7) + 1;
+		interval = ((pkt[0] >> 3) + 1) * 10;
 
 		if (mesh_config_write_net_transmit(node_config_get(node), count,
 								interval))
@@ -900,7 +900,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 		n = mesh_model_opcode_set(OP_CONFIG_NETWORK_TRANSMIT_STATUS,
 									msg);
 		mesh_net_transmit_params_get(net, &count, &interval);
-		msg[n++] = ((count - 1) << 5) + ((interval/10 - 1) & 0x1f);
+		msg[n++] = (count - 1) + ((interval/10 - 1) << 3);
 
 		l_debug("Get/Set Network Transmit Config");
 		break;
diff --git a/mesh/model.c b/mesh/model.c
index 84f1dc74c..45cdb93bb 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1537,8 +1537,8 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 	if (pub && (pub->virt || !(IS_UNASSIGNED(pub->addr)))) {
 		uint8_t mod_addr[2];
 		uint8_t *pub_addr;
-		uint8_t retransmit = (pub->count << 5) +
-						(pub->interval / 50 - 1);
+		uint8_t retransmit = pub->count +
+					((pub->interval / 50 - 1) << 3);
 
 		/* Add publication */
 		l_put_le16(pub->addr, &mod_addr);
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 04edc706c..d468fb28c 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -471,7 +471,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 			return true;
 
 		bt_shell_printf("Node %4.4x: Relay 0x%02x, cnt %d, steps %d\n",
-				src, data[0], data[1]>>5, data[1] & 0x1f);
+				src, data[0], data[1] & 0x7, data[1] >> 3);
 		break;
 
 	case OP_CONFIG_PROXY_STATUS:
@@ -527,8 +527,8 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 			break;
 		}
 
-		bt_shell_printf("Rexmit count\t%d\n", data[9] >> 5);
-		bt_shell_printf("Rexmit steps\t%d\n", data[9] & 0x1f);
+		bt_shell_printf("Rexmit count\t%d\n", data[9] & 0x7);
+		bt_shell_printf("Rexmit steps\t%d\n", data[9] >> 3);
 
 		break;
 
@@ -1056,7 +1056,7 @@ static void cmd_relay_set(int argc, char *argv[])
 	}
 
 	msg[n++] = parms[0];
-	msg[n++] = (parms[1] << 5) | parms[2];
+	msg[n++] = parms[1] | (parms[2] << 3);
 
 	if (!config_send(msg, n, OP_CONFIG_RELAY_SET))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-- 
2.24.0

