Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDB3EEAA71
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 21:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjINVLl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjINVLk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 17:11:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3746826B2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:11:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fdd6011f2so1135567b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694725895; x=1695330695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/308pntA+ZYZm9I5MvpRH8IQRP7l/fbGGryUi/IgXU=;
        b=gWH94xxAMEeKxsL/WDlSdPAp5ruUqk+Z0bf39yVkRZGpXBMP9LsC/FMBdyHW8jnCIT
         c0Br8VBjCxU6RZa+DmF9jiGk/Ev2wgxF4k9XGLsyvhbvbzmj6xhWTrDyCFewvCRMa818
         lMezIw3sdsykDcLgIwwioXdX3lhiEqoFxDv7Sna110EM9uPQCOacl0HMMS7CMnnFRdKS
         3uKlf8NVH0CPKdhS3vCT2PTo89PvzyXOVBeyf+gCD9RnoSwCPW6e7jm3uYrhg/2pLsHw
         Zah1LlxJv10dLF4z634VNNrEJbpIRs/Bi3TtSjonJr9qFmOjWJCZdR6CM0360gAqjfwz
         OApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725895; x=1695330695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/308pntA+ZYZm9I5MvpRH8IQRP7l/fbGGryUi/IgXU=;
        b=hWxkaNZB8C1Iqg5U3qhSM1TEDyFdE+b6Im2zCSL1dipQHwK/WxHuWgFR4gIEHK7BWV
         JTobb70FnzzwyxkyKFMrSrfqvMYjSSkiYYZu5iwiLsOVqPMIHrt8ElXRoUjuznS9y9Y7
         F6hsL0YnRCRTTZZUDnTVxx5biyxI4GX6dRyXAlcx8euhknhrngtzmVbZrmbfw/Se+WUV
         1MVY6CtsAb26uYupnYuvkhdX4uXf7xO+4D/6876y1GdMB30erC+Z/aWYKuXCto8QSmTb
         Mltzgr/63q2AdzjNAyx2Lj017ze9vFvPWmW2FGbpxNyhxZUJ1OJULYQScCOA54cWe7xs
         ulkA==
X-Gm-Message-State: AOJu0YyPnq+KnnmoMi8LXqtdvT4DWsF/EQkt4jOxHekpHNI5I7iyzQjZ
        g/eZUv2YrI5n87VlgMsRJG164bKd2JGOrw==
X-Google-Smtp-Source: AGHT+IGmwkeNMz6Z31IGcj9uVXkOGi+GFbuM2+vyon6H5s7rN1IwCfL99sG5o3lPfoOxBfw9p25Z3w==
X-Received: by 2002:aa7:8881:0:b0:68f:d4fe:6344 with SMTP id z1-20020aa78881000000b0068fd4fe6344mr8100374pfe.0.1694725894769;
        Thu, 14 Sep 2023 14:11:34 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b0069029a2206bsm1731424pfu.47.2023.09.14.14.11.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:11:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix leaking l2cap_conn objects
Date:   Thu, 14 Sep 2023 14:11:33 -0700
Message-ID: <20230914211133.3339473-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_conn.c         | 10 ++++++++--
 net/bluetooth/l2cap_core.c       | 29 ++++++++++++++++++++++++++---
 3 files changed, 36 insertions(+), 5 deletions(-)

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
index e62a5f368a51..c4e16e92446c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2735,9 +2735,11 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 void hci_chan_del(struct hci_chan *chan)
 {
 	struct hci_conn *conn = chan->conn;
-	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("%s hcon %p chan %p", hdev->name, conn, chan);
+	if (!conn)
+		return;
+
+	bt_dev_dbg(conn->hdev, "hcon %p chan %p", conn, chan);
 
 	list_del_rcu(&chan->list);
 
@@ -2746,6 +2748,10 @@ void hci_chan_del(struct hci_chan *chan)
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

