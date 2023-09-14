Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8434EEAA77
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 21:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjINVEG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjINVEF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 17:04:05 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF352698
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:04:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fdcc37827so1875381b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694725440; x=1695330240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ttJo81OzOiXXRPa6WEjkW5TVXXbz7eCrRejkuktRL8=;
        b=d6NjCWadU8CIvo6T5Cu/guyaDk+RH+bAza6QvxZmTSzUtOTg0R2lQmcJilTRxQXbC7
         h03GcrV8DDOcCMI3K9McTLyDA1mFeHepwQWKCyMLeSwjsrBp3eGLDPhclAElFC6dpYCb
         vwnfWoe8NZYL3o/4wiM1dq+W8LXMIAcx6LPF+KZjkjjH5c6a4LyLOqN71kSbX6ubHeRW
         p6EIWa9TfEmmR6vWIgGRqqN4OPB5DoJf6urMNX0z6FrloKfj7VDu13SzWTyCqtXs6O4D
         ftbWtr7ifn96GzIIPcWGD6VCAFu9KwJbMerxQxVMAt23IpvHlrvG0CJmApYSAvjTIMSZ
         Fljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725440; x=1695330240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ttJo81OzOiXXRPa6WEjkW5TVXXbz7eCrRejkuktRL8=;
        b=TS7opNAqpmPRhmES9U+jgs1M/w0Mlj/INxSgcdsFs3g+oiIlNj4LPbyjSC0/IxhyxR
         WTw4jbz8U+EyOnywldzP4APM4YKdMoi7T0Ebz/Kq6eWT9ZNYvUVqzA+ycSkKt5qWSUjf
         cUkNgRVbcvRF/3hS34tEjk0EV12fp/s1F7iyL5tPqU7bHk+z/U+kwXKBnzLlOB/4JYSm
         R1PHxxFQ+JOxxZ2LVL0XRyIpHOLRc0knog1YR6XTL2eRzcZYv/uIa6UxPtTnA8uOI7Cs
         N6L5Vx5Lc5gaQ+10l+3VatB1gMmtBp8W3p4+8rD7WtIoHOPyRRbSd3GCo5MPr5EDEY1V
         mSnw==
X-Gm-Message-State: AOJu0YxTEfLFahI/jft7egx2AHp/a7xfdG/gtDQCyh0arEUd1kOVtaf1
        l12hCuqW7xH2HPHK2PTqUN02ZtZ8YfliCw==
X-Google-Smtp-Source: AGHT+IFeMpsKPuuPpvPCax+Qs17f0o7ZiCajoGBRpWemZ/d5faih0TMgByaVa4YmqurZswkoVWIBRw==
X-Received: by 2002:a05:6a20:160c:b0:134:70b7:2386 with SMTP id l12-20020a056a20160c00b0013470b72386mr4009721pzj.9.1694725439916;
        Thu, 14 Sep 2023 14:03:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id z13-20020a63b04d000000b0056c2de1f32esm1570331pgo.78.2023.09.14.14.03.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:03:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix leaking l2cap_conn objects
Date:   Thu, 14 Sep 2023 14:03:58 -0700
Message-ID: <20230914210358.3335206-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_conn.c         |  4 ++++
 net/bluetooth/l2cap_core.c       | 29 ++++++++++++++++++++++++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

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
index e62a5f368a51..757a5840c978 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2746,6 +2746,10 @@ void hci_chan_del(struct hci_chan *chan)
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

