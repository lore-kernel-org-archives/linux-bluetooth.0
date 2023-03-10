Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08874C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 00:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjCJABD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 19:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjCJABA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 19:01:00 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A61E6FE7
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 16:00:58 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id k17so1409484iob.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 16:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678406457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+fiiEKNZl5NXZ0bM/JIwxHokC61cP2RaWFtAs1AWx8=;
        b=okiEUCHXFIUPltHu/WXbt9ueuLU1lhAHo5VfD9fS6f/+lkOXgRm3finarpUZIzJt7t
         suzB6RZjaVblkeV0QZsHq3c3xzSSoelzDStN7Fi6qjcnddXrqYKRiR7Y4TaaipKUC9wj
         cdkqC4eCS/q2n+fkaRN2bQqjSBq1ONxhx8npX1d5Zu0N6sMgKUPkkJ6YkBSR6qWnvD8O
         rcFS51nx+WgdJMMb9op/OjLZkYA1+zv/gEkYCL1G9NE/cM7rxyX998QQqHNry42BQMz4
         EG8/fzpEjA+FoYs+Hs8kJOS//gXFjq054IWRcgKXnlMPvWPsmlBS1ezXwkIlXC8b6Mb5
         nJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678406457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+fiiEKNZl5NXZ0bM/JIwxHokC61cP2RaWFtAs1AWx8=;
        b=x7g7qYtycfEP/0ymTmG7nzGTKUuOrVnDHfkD1KHHO+fJu0+Qr56OW62j5GioLgLc8H
         iOUuRi9X6CmQf9eslWljp6XGcsYFw/2R26FOnMmmTcDnl2T/ppw35TGerpiJP4Ye6RiP
         UeA4th3/VhH20eJ0URZZmWXTWHEeE85k0hcsAAXIsDWYS8b9wjmQugB2gkSw1C9KQ0qI
         Nm7o9RYD3RhncAikc2oUo9E2w0SrEN7qlUmhDDrfjNwHqIB4+vhc1pH6TAZgtf3+5ZdP
         uoLxkN/S2WWoJD5CDDcmfx5QgMK73j58n4m5fVtT9bd3oMYwQ6Po2/TIK+vW6k/NFYId
         TgTw==
X-Gm-Message-State: AO0yUKVe47IA8O/rC12jDuMz6Fv7Awzm/l+4U+FFLk/oStqerBBQcnr6
        qshzb6PqTLKJW02FpRtWUEOEstouV2w=
X-Google-Smtp-Source: AK7set/tNEpCV5FsRGfzy7rb6zDmcjdzC1yXjjaVeb9VGEFdyWJ6wdvMb02iBZYy2aD3rhmmNIMmjw==
X-Received: by 2002:a5d:904e:0:b0:74c:87b5:a083 with SMTP id v14-20020a5d904e000000b0074c87b5a083mr2008035ioq.17.1678406457471;
        Thu, 09 Mar 2023 16:00:57 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id z9-20020a056602204900b00745a82f892bsm153030iod.15.2023.03.09.16.00.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 16:00:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: L2CAP: Fix responding with wrong PDU type
Date:   Thu,  9 Mar 2023 16:00:54 -0800
Message-Id: <20230310000055.3396026-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

L2CAP_ECRED_CONN_REQ shall be responded with L2CAP_ECRED_CONN_RSP not
L2CAP_LE_CONN_RSP:

L2CAP LE EATT Server - Reject - run
  Listening for connections
  New client connection with handle 0x002a
  Sending L2CAP Request from client
  Client received response code 0x15
  Unexpected L2CAP response code (expected 0x18)
L2CAP LE EATT Server - Reject - test failed

> ACL Data RX: Handle 42 flags 0x02 dlen 26
      LE L2CAP: Enhanced Credit Connection Request (0x17) ident 1 len 18
        PSM: 39 (0x0027)
        MTU: 64
        MPS: 64
        Credits: 5
        Source CID: 65
        Source CID: 66
        Source CID: 67
        Source CID: 68
        Source CID: 69
< ACL Data TX: Handle 42 flags 0x00 dlen 16
      LE L2CAP: LE Connection Response (0x15) ident 1 len 8
        invalid size
        00 00 00 00 00 00 06 00

L2CAP LE EATT Server - Reject - run
  Listening for connections
  New client connection with handle 0x002a
  Sending L2CAP Request from client
  Client received response code 0x18
L2CAP LE EATT Server - Reject - test passed

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 133 ++++++++++++++++++++++++-------------
 1 file changed, 87 insertions(+), 46 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index adfc3ea06d08..49926f59cc12 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -708,6 +708,17 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_del);
 
+static void __l2cap_chan_list_id(struct l2cap_conn *conn, u16 id,
+				 l2cap_chan_func_t func, void *data)
+{
+	struct l2cap_chan *chan, *l;
+
+	list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
+		if (chan->ident == id)
+			func(chan, data);
+	}
+}
+
 static void __l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
 			      void *data)
 {
@@ -775,23 +786,9 @@ static void l2cap_chan_le_connect_reject(struct l2cap_chan *chan)
 
 static void l2cap_chan_ecred_connect_reject(struct l2cap_chan *chan)
 {
-	struct l2cap_conn *conn = chan->conn;
-	struct l2cap_ecred_conn_rsp rsp;
-	u16 result;
-
-	if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
-		result = L2CAP_CR_LE_AUTHORIZATION;
-	else
-		result = L2CAP_CR_LE_BAD_PSM;
-
 	l2cap_state_change(chan, BT_DISCONN);
 
-	memset(&rsp, 0, sizeof(rsp));
-
-	rsp.result  = cpu_to_le16(result);
-
-	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CONN_RSP, sizeof(rsp),
-		       &rsp);
+	__l2cap_ecred_conn_rsp_defer(chan);
 }
 
 static void l2cap_chan_connect_reject(struct l2cap_chan *chan)
@@ -846,7 +843,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 					break;
 				case L2CAP_MODE_EXT_FLOWCTL:
 					l2cap_chan_ecred_connect_reject(chan);
-					break;
+					return;
 				}
 			}
 		}
@@ -3938,43 +3935,86 @@ void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan)
 		       &rsp);
 }
 
-void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
+static void l2cap_ecred_list_defer(struct l2cap_chan *chan, void *data)
 {
-	struct {
-		struct l2cap_ecred_conn_rsp rsp;
-		__le16 dcid[5];
-	} __packed pdu;
-	struct l2cap_conn *conn = chan->conn;
-	u16 ident = chan->ident;
-	int i = 0;
+	int *result = data;
 
-	if (!ident)
+	if (*result || test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
 		return;
 
-	BT_DBG("chan %p ident %d", chan, ident);
-
-	pdu.rsp.mtu     = cpu_to_le16(chan->imtu);
-	pdu.rsp.mps     = cpu_to_le16(chan->mps);
-	pdu.rsp.credits = cpu_to_le16(chan->rx_credits);
-	pdu.rsp.result  = cpu_to_le16(L2CAP_CR_LE_SUCCESS);
-
-	mutex_lock(&conn->chan_lock);
-
-	list_for_each_entry(chan, &conn->chan_l, list) {
-		if (chan->ident != ident)
-			continue;
-
-		/* Reset ident so only one response is sent */
-		chan->ident = 0;
-
-		/* Include all channels pending with the same ident */
-		pdu.dcid[i++] = cpu_to_le16(chan->scid);
+	switch (chan->state) {
+	case BT_CONNECT2:
+		/* If channel still pending accept add to result */
+		(*result)++;
+		return;
+	case BT_CONNECTED:
+		return;
+	default:
+		/* If not connected or pending accept it has been refused */
+		*result = -ECONNREFUSED;
+		return;
 	}
+}
 
-	mutex_unlock(&conn->chan_lock);
+struct l2cap_ecred_rsp_data {
+	struct {
+		struct l2cap_ecred_conn_rsp rsp;
+		__le16 scid[L2CAP_ECRED_MAX_CID];
+	} __packed pdu;
+	int count;
+};
 
-	l2cap_send_cmd(conn, ident, L2CAP_ECRED_CONN_RSP,
-			sizeof(pdu.rsp) + i * sizeof(__le16), &pdu);
+static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
+{
+	struct l2cap_ecred_rsp_data *rsp = data;
+
+	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+		return;
+
+	/* Reset ident so only one response is sent */
+	chan->ident = 0;
+
+	/* Include all channels pending with the same ident */
+	if (!rsp->pdu.rsp.result)
+		rsp->pdu.rsp.dcid[rsp->count++] = cpu_to_le16(chan->scid);
+	else
+		l2cap_chan_del(chan, ECONNRESET);
+}
+
+void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct l2cap_ecred_rsp_data data;
+	u16 id = chan->ident;
+	int result = 0;
+
+	if (!id)
+		return;
+
+	BT_DBG("chan %p id %d", chan, id);
+
+	memset(&data, 0, sizeof(data));
+
+	data.pdu.rsp.mtu     = cpu_to_le16(chan->imtu);
+	data.pdu.rsp.mps     = cpu_to_le16(chan->mps);
+	data.pdu.rsp.credits = cpu_to_le16(chan->rx_credits);
+	data.pdu.rsp.result  = cpu_to_le16(L2CAP_CR_LE_SUCCESS);
+
+	/* Verify that all channels are ready */
+	__l2cap_chan_list_id(conn, id, l2cap_ecred_list_defer, &result);
+
+	if (result > 0)
+		return;
+
+	if (result < 0)
+		data.pdu.rsp.result = cpu_to_le16(L2CAP_CR_LE_AUTHORIZATION);
+
+	/* Build response */
+	__l2cap_chan_list_id(conn, id, l2cap_ecred_rsp_defer, &data);
+
+	l2cap_send_cmd(conn, id, L2CAP_ECRED_CONN_RSP,
+		       sizeof(data.pdu.rsp) + (data.count * sizeof(__le16)),
+		       &data.pdu);
 }
 
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
@@ -6078,6 +6118,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
 		chan->ident = cmd->ident;
+		chan->mode = L2CAP_MODE_EXT_FLOWCTL;
 
 		if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 			l2cap_state_change(chan, BT_CONNECT2);
-- 
2.39.2

