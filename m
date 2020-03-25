Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC09C2D0E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 19:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980522074D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 19:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7E30qdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCYTh6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:37:58 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54833 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgCYTh6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 15:37:58 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so1464788pjb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2020 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Hck71EOBb0dUUmvDFaIbtvHUwex/uJgI90sN3cQvuY=;
        b=G7E30qdvhep1+NRR8Yd24MtU78nqWepQc3KM16BjRDXXcZdKRWXMz528c1mnWIaqvJ
         FAe+4WEebgwcko5Z7jP4ydx/hZ5hKR9BAwBmlHKaLDdTYPGFTTAhXHG/3LDmVJ/P9iW0
         FoT62bEkbcgSr0Dv4F3Z1JsM+SJ6wCjfo867HzQxPG0h3QD1XwfiVE4j01UmFxwoUwfo
         I0ljUaK87m+WQCjeVRZ++Yst60SJTXUFZSfSbVeruT+G4mR50iGZfqtbXVM1AMWEbwza
         VxBiizsTGK+0WAa9wIF9xenSjgJZOAlF4hOF00+pfiJ4GH78Nc2KHeB+OdHqO/2adHr6
         5NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Hck71EOBb0dUUmvDFaIbtvHUwex/uJgI90sN3cQvuY=;
        b=V79MApignqo7wicV3qDESDHC6GN+KEQECvR/unM4KX5o2yjdVFeONshf6Sghd1dLa3
         7d5/Azy76V9Sro9/cK2E7Mt3lwBI+SfOT/v8R/C6Lr/y+Vjv/NJu/ej1KZUo+zJuKpBD
         9TMdqWpRKTFHa9QfbS0bFXJqYV/C06KZGCbz5QwqRqQBYnGMvoX4X9BWl9+ywx3ESgnL
         5ax4FdzH1sLH7EtoXnMurPQQl8j/WOa2RLlKaN4NqhH9dMMcQWE+zOMdkDoGrft61Eg5
         eIMbRTiWTSQ2XeUV6ElibIczGgQIvMnnYoBO9U6TowOciNbBxK9Tfnoc/DwV2YRY4CIJ
         YMcA==
X-Gm-Message-State: ANhLgQ0ss/viHtlmTbFxIXsnzX0sq1dEpJ7gwfS189uoAxDhne5iv/JJ
        Z9nru7NbLyQE93gThCp0bDhrZ4Og
X-Google-Smtp-Source: ADFU+vvhUF7BylewTbvFwd7+Fwtcql+++ktaTMAaO9m+zhtkrSS/St7rwTROg2SSjd11eN9mto7bkQ==
X-Received: by 2002:a17:902:aa4c:: with SMTP id c12mr4870265plr.168.1585165075991;
        Wed, 25 Mar 2020 12:37:55 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g69sm49706pje.34.2020.03.25.12.37.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:37:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/2] Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections
Date:   Wed, 25 Mar 2020 12:37:53 -0700
Message-Id: <20200325193754.13950-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
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
 net/bluetooth/l2cap_core.c    | 137 +++++++++++++++++++++++++++++++---
 2 files changed, 131 insertions(+), 10 deletions(-)

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
index 8b0fca39989d..fd9d0d08f9c9 100644
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
 
 	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
 		return;
 
 	l2cap_ecred_init(chan, 0);
 
-	pdu.req.psm     = chan->psm;
-	pdu.req.mtu     = cpu_to_le16(chan->imtu);
-	pdu.req.mps     = cpu_to_le16(chan->mps);
-	pdu.req.credits = cpu_to_le16(chan->rx_credits);
-	pdu.scid        = cpu_to_le16(chan->scid);
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
+
+	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+		return;
+
+	l2cap_ecred_init(chan, 0);
+
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
@@ -7693,6 +7766,33 @@ static bool is_valid_psm(u16 psm, u8 dst_type) {
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
@@ -7812,6 +7912,23 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		goto done;
 	}
 
+	if (chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
+		struct l2cap_chan_data data;
+
+		data.chan = chan;
+		data.pid = chan->ops->get_peer_pid(chan);
+		data.count = 1;
+
+		l2cap_chan_list(conn, l2cap_chan_by_pid, &data);
+
+		/* Check if there isn't too many channels being connected */
+		if (data.count > L2CAP_ECRED_CONN_SCID_MAX) {
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

