Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38212EE0207
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Sep 2023 19:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjIMTir (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjIMTiq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Sep 2023 15:38:46 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D946191
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Sep 2023 12:38:42 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34f27cf1786so621465ab.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Sep 2023 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694633921; x=1695238721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8eeca0hO0P95yMfRCzUieziGcJehEd+4vAsn+h19zJw=;
        b=AbqtkzAmQJyYjYWBqzz1Thb+/mQ2NNKx1vlx0OzLXWnrvTS3KAKtVuHta5HhTQMxHk
         CY0LxyoeTdmzgX4KmkOtaUQCBBDaFHAPtfWPb2NBV+ww+1uUcsGqr3xQUlRlxA72jO6H
         NELlBxk+HwqRqbm8qVlAulcipnHbgJIkarQl/mY6umGRc4EbKey3+UZXLZgJiewO1an7
         sKM7zj9tXnCCvnEqHdzw0mDwRxA8pigP1OB+BdSP4f4JlCAcjj1qC+JuTLLsZec8eVNM
         HkTPS8Rfmv8HDb714wd7ECtiY5/upSBMQK6z790+o0+nyYxXcJiV3ddDjRAboxq2ZRYB
         rm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633921; x=1695238721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eeca0hO0P95yMfRCzUieziGcJehEd+4vAsn+h19zJw=;
        b=WBCqbfvV8FyWkvjJQpnLsnXBVJ+3FCqIwFdQopbBoccmNNNi/Q5YxcMIjhY1B6D3vL
         w1NMjg45nkPo/liUfqF04RDL136eHE2p1+wt8tA5oK+Uu+IKOhTBr5jMZtWgFonoiDT8
         Y1cAsgmcO0Z0/aZ5JXQ2mEBUs2OhgbofmPVFcrj6aTf8Oc21D+v47TZHSyov6vp/WZMH
         oLlyEIgbp1ghOHAHQmzb7yj/DMtNOLU/6FvExcFMoj3C7AO5UuXeLz71dXWH+9+FlpyH
         HfiHBFnl+vJz1xYw7phIpVKkPTE8b0GXS7muJdTOrGycld/Q/s1F9mQ3XsfkUjrDe/l4
         sm9A==
X-Gm-Message-State: AOJu0YwiK0u8WMKLJC+n0TgmkTOOEZCqXEMvzscU6KrWlBlhBvNml9ke
        VyYP2SEd3lcl68VOrRz4O1eBE9cUYDs=
X-Google-Smtp-Source: AGHT+IGibpv46kBh3RNnyQEXDLES8l+BH08rDHtit0TJXNenfc3Mp72EJ24qPvpY8P++c7vf832Eaw==
X-Received: by 2002:a05:6e02:12b2:b0:348:797d:a94e with SMTP id f18-20020a056e0212b200b00348797da94emr3368498ilr.2.1694633921485;
        Wed, 13 Sep 2023 12:38:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id h20-20020a056e020d5400b00345d10ea524sm2174301ilj.65.2023.09.13.12.38.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:38:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix leaking l2cap_conn objects
Date:   Wed, 13 Sep 2023 12:38:39 -0700
Message-ID: <20230913193839.3029428-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

l2cap_conn objects must be cleanup whenever its hci_chan is deleted by
hci_chan_list_flush since it means the connection attempt is being
aborted prematurely thus no calls to connect_cfm/disconnect_cfm would
be generated causing the l2cap_conn object to leak.

Fixes: 73d80deb7bdf ("Bluetooth: prioritizing data over HCI")
Reported-by: Olivier L'Heureux <olivier.lheureux@fortrobotics.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         |  7 +++++++
 net/bluetooth/l2cap_core.c       | 29 ++++++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bbad301f5781..21459c38a074 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -795,6 +795,8 @@ struct hci_chan {
 	unsigned int	sent;
 	__u8		state;
 	bool		amp;
+
+	void (*cleanup)(struct hci_chan *chan);
 };
 
 struct hci_conn_params {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e62a5f368a51..814d8f3b029e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2737,6 +2737,9 @@ void hci_chan_del(struct hci_chan *chan)
 	struct hci_conn *conn = chan->conn;
 	struct hci_dev *hdev = conn->hdev;
 
+	if (!conn)
+		return;
+
 	BT_DBG("%s hcon %p chan %p", hdev->name, conn, chan);
 
 	list_del_rcu(&chan->list);
@@ -2746,6 +2749,10 @@ void hci_chan_del(struct hci_chan *chan)
 	/* Prevent new hci_chan's to be created for this hci_conn */
 	set_bit(HCI_CONN_DROP, &conn->flags);
 
+	if (chan->cleanup)
+		chan->cleanup(chan);
+
+	chan->conn = NULL;
 	hci_conn_put(conn);
 
 	skb_queue_purge(&chan->data_q);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 17ca13e8c044..a791f28ccd6a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1896,6 +1896,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	hcon->l2cap_data = NULL;
+
 	kfree_skb(conn->rx_skb);
 
 	skb_queue_purge(&conn->pending_rx);
@@ -1931,13 +1933,15 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	mutex_unlock(&conn->chan_lock);
 
-	hci_chan_del(conn->hchan);
+	if (conn->hchan) {
+		conn->hchan->cleanup = NULL;
+		hci_chan_del(conn->hchan);
+		conn->hchan = NULL;
+	}
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		cancel_delayed_work_sync(&conn->info_timer);
 
-	hcon->l2cap_data = NULL;
-	conn->hchan = NULL;
 	l2cap_conn_put(conn);
 }
 
@@ -7830,6 +7834,24 @@ static void process_pending_rx(struct work_struct *work)
 		l2cap_recv_frame(conn, skb);
 }
 
+static void l2cap_conn_hchan_cleanup(struct hci_chan *hchan)
+{
+	struct hci_conn *hcon = hchan->conn;
+	struct l2cap_conn *conn;
+
+	if (!hcon)
+		return;
+
+	conn = hcon->l2cap_data;
+	if (!conn)
+		return;
+
+	/* hci_chan_del has been called so we shouldn't call it gain. */
+	conn->hchan = NULL;
+
+	l2cap_conn_del(hcon, bt_to_errno(HCI_ERROR_LOCAL_HOST_TERM));
+}
+
 static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
@@ -7852,6 +7874,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	hcon->l2cap_data = conn;
 	conn->hcon = hci_conn_get(hcon);
 	conn->hchan = hchan;
+	hchan->cleanup = l2cap_conn_hchan_cleanup;
 
 	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
 
-- 
2.41.0

