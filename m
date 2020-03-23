Return-Path: <SRS0=apyX=5I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEB9C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 20:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A8B2070A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 20:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntOQnrfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCWUfF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:35:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44078 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgCWUfE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 16:35:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id 142so2558000pgf.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2020 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ax6LJvZifxs+Jz4PFhlO8B8liSrqW0rQiTisJ5Q7W3U=;
        b=ntOQnrfA6z+IscP9DIlQg25WWHsBJN7ozbit0trXiRszQSzQleAPvuMAXdbn/R30cn
         Nyh7C6cJIJ1of1hnPdNyhwu4SV5U5Uz3EvOuoIgSgCtjq6Dnxr+aEMtqzYsVPLJ5CF61
         kwnmGiP9qcUhTBEwDHnYT7p6gzgLpQtZqz2txi5qJUiRj5RB0VzyBgjRs+NFSEErAB1Q
         vJL07hgsFLRd35BmCvH2hybue8GyQdPUf7XI76GVH2z73g4P+1k5oH5g9IaxAd+7vACv
         Kcjg9hOEIVJORCy5aBwHnzMvdNZ7KERCrY0cknFL5+0c7aSQYP10Vn2PxNluBj6YcgPB
         qo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ax6LJvZifxs+Jz4PFhlO8B8liSrqW0rQiTisJ5Q7W3U=;
        b=p1kKcQ0nP/Us3Pei5XOXpHYRBwiRGzVBBQF8ezXK0tLk/DzQbxxhiq6Bzy6mqtm9Dh
         4eaJW+9hbHyZUzFhpM9CgCoJFR5pseiOBAIpWAqkMCCDx5kgPJ3FKtpKHoC26JTm2VVe
         WC013klCzXx+sy4WuJriCcYrnQztTmU7mdgEE/IUm51kq4a6zmud1WN3Q53jjuPsaYhv
         sbcdoxOIrgU73z6GAGihZ834RbfhBPCHmwEFrpLp+cIvqpODCh9QmV9mJfudo8K5ZK0j
         9rGmt6ZRR34BUTHJMi3Cj05YhAo2qslA89/YWtxb8r4BYlSQ2lXNZ/UsSSjipABPU2x0
         +x0g==
X-Gm-Message-State: ANhLgQ3T5uEROQQrYoA9REEmdb/woMwyw6Be/JJXzDsbsWRKTSSRO/WM
        zKLD6PXE9sS4RBZksPM4KmJ/MQKb
X-Google-Smtp-Source: ADFU+vvC4g6LF9vZUh48pzxjTS5uiEzbv5leQbSzFOTJw8DJE7rxm0SUwfFqxxD3czkZxR6a375FNA==
X-Received: by 2002:a62:8684:: with SMTP id x126mr25833793pfd.160.1584995702534;
        Mon, 23 Mar 2020 13:35:02 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q71sm440469pjb.5.2020.03.23.13.35.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:35:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/3] Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections
Date:   Mon, 23 Mar 2020 13:34:57 -0700
Message-Id: <20200323203458.24733-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323203458.24733-1-luiz.dentz@gmail.com>
References: <20200323203458.24733-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses the DEFER_SETUP flag to group channels with
L2CAP_CREDIT_BASED_CONNECTION_REQ.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |   4 +
 net/bluetooth/l2cap_core.c    | 136 +++++++++++++++++++++++++++++++---
 2 files changed, 130 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2d7d28474d34..dada14d0622c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -47,6 +47,7 @@
 #define L2CAP_DEFAULT_ACC_LAT		0xFFFFFFFF
 #define L2CAP_BREDR_MAX_PAYLOAD		1019    /* 3-DH5 packet */
 #define L2CAP_LE_MIN_MTU		23
+#define L2CAP_ECRED_CONN_SCID_MAX	5
 
 #define L2CAP_DISC_TIMEOUT		msecs_to_jiffies(100)
 #define L2CAP_DISC_REJ_TIMEOUT		msecs_to_jiffies(5000)
@@ -984,6 +985,9 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
+typedef void (*l2cap_chan_func_t)(struct l2cap_chan *chan, void *data);
+void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
+		     void *data);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
 void l2cap_move_start(struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5e6e35ab44dd..9f699d09d973 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -678,6 +678,29 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_del);
 
+static void __l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
+			      void *data)
+{
+	struct l2cap_chan *chan;
+
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		func(chan, data);
+	}
+}
+
+void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
+		     void *data)
+{
+	if (!conn)
+		return;
+
+	mutex_lock(&conn->chan_lock);
+	__l2cap_chan_list(conn, func, data);
+	mutex_unlock(&conn->chan_lock);
+}
+
+EXPORT_SYMBOL_GPL(l2cap_chan_list);
+
 static void l2cap_conn_update_id_addr(struct work_struct *work)
 {
 	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
@@ -1356,29 +1379,79 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 		       sizeof(req), &req);
 }
 
-static void l2cap_ecred_connect(struct l2cap_chan *chan)
-{
-	struct l2cap_conn *conn = chan->conn;
+struct l2cap_ecred_conn_data {
 	struct {
 		struct l2cap_ecred_conn_req req;
-		__le16 scid;
+		__le16 scid[5];
 	} __packed pdu;
+	struct l2cap_chan *chan;
+	struct pid *pid;
+	int count;
+};
+
+static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *data)
+{
+	struct l2cap_ecred_conn_data *conn = data;
+	struct pid *pid;
+
+	if (chan == conn->chan)
+		return;
+
+	if (!test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
+		return;
+
+	pid = chan->ops->get_peer_pid(chan);
+
+	/* Only add deferred channels with the same PID/PSM */
+	if (conn->pid != pid || chan->psm != conn->chan->psm || chan->ident ||
+	    chan->mode != L2CAP_MODE_EXT_FLOWCTL || chan->state != BT_CONNECT)
+		return;
+
+	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+		return;
+
+	l2cap_ecred_init(chan, 0);
+
+	/* Set the same ident so we can match on the rsp */
+	chan->ident = conn->chan->ident;
+
+	/* Include all channels deferred */
+	conn->pdu.scid[conn->count] = cpu_to_le16(chan->scid);
+
+	conn->count++;
+}
+
+static void l2cap_ecred_connect(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct l2cap_ecred_conn_data data;
+
+	if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
+		return;
 
 	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
 		return;
 
 	l2cap_ecred_init(chan, 0);
 
-	pdu.req.psm     = chan->psm;
-	pdu.req.mtu     = cpu_to_le16(chan->imtu);
-	pdu.req.mps     = cpu_to_le16(chan->mps);
-	pdu.req.credits = cpu_to_le16(chan->rx_credits);
-	pdu.scid        = cpu_to_le16(chan->scid);
+	data.pdu.req.psm     = chan->psm;
+	data.pdu.req.mtu     = cpu_to_le16(chan->imtu);
+	data.pdu.req.mps     = cpu_to_le16(chan->mps);
+	data.pdu.req.credits = cpu_to_le16(chan->rx_credits);
+	data.pdu.scid[0]     = cpu_to_le16(chan->scid);
 
 	chan->ident = l2cap_get_ident(conn);
+	data.pid = chan->ops->get_peer_pid(chan);
+
+	data.count = 1;
+	data.chan = chan;
+	data.pid = chan->ops->get_peer_pid(chan);
+
+	__l2cap_chan_list(conn, l2cap_ecred_defer_connect, &data);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_CONN_REQ,
-		       sizeof(pdu), &pdu);
+		       sizeof(data.pdu.req) + data.count * sizeof(__le16),
+		       &data.pdu);
 }
 
 static void l2cap_le_start(struct l2cap_chan *chan)
@@ -7694,6 +7767,33 @@ static bool is_valid_psm(u16 psm, u8 dst_type) {
 	return ((psm & 0x0101) == 0x0001);
 }
 
+struct l2cap_chan_data {
+	struct l2cap_chan *chan;
+	struct pid *pid;
+	int count;
+};
+
+static void l2cap_chan_by_pid(struct l2cap_chan *chan, void *data)
+{
+	struct l2cap_chan_data *d = data;
+	struct pid *pid;
+
+	if (chan == d->chan)
+		return;
+
+	if (!test_bit(FLAG_DEFER_SETUP, &chan->flags))
+		return;
+
+	pid = chan->ops->get_peer_pid(chan);
+
+	/* Only count deferred channels with the same PID/PSM */
+	if (d->pid != pid || chan->psm != d->chan->psm || chan->ident ||
+	    chan->mode != L2CAP_MODE_EXT_FLOWCTL || chan->state != BT_CONNECT)
+		return;
+
+	d->count++;
+}
+
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type)
 {
@@ -7813,6 +7913,22 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		goto done;
 	}
 
+	if (chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
+		struct l2cap_chan_data data;
+
+		data.chan = chan;
+		data.pid = chan->ops->get_peer_pid(chan);
+		data.count = 0;
+
+		l2cap_chan_list(conn, l2cap_chan_by_pid, &data);
+		/* Check if there isn't too many channels being connected */
+		if (!(data.count < L2CAP_ECRED_CONN_SCID_MAX - 1)) {
+			hci_conn_drop(hcon);
+			err = -EPROTO;
+			goto done;
+		}
+	}
+
 	mutex_lock(&conn->chan_lock);
 	l2cap_chan_lock(chan);
 
-- 
2.21.1

