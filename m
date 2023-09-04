Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C39FC83F3E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Sep 2023 22:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbjIDWMK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Sep 2023 18:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbjIDWMI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 18:12:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427BDCCB
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 15:12:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9338e4695so28114111fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Sep 2023 15:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1693865521; x=1694470321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozfJRQtpgwFC9ZhqHlBlU2b3MtVkpPgDvpRNwWgjyLY=;
        b=KjwtFLj6cgNExLJWiGhEKSEZiUmC9b/QwK3MV9uP+9GiNk2nn4OyjUPGtvti824SWP
         sOC3B/0Kzgb9jOw/iYJsYwnGzv3vs/xmifRy2Djw5pxPGZNVBewFDIxVTlg6b0yhf3UD
         K8GIx1ceEv2d8T0qvBqKprETgMdk/myDBhVOeqz0a/5POfjHV71HwwKGlNurEvLYgunm
         efAzf4zJbzqikK/v0ganM72dqjOF5TS4+CJp1XUxXBYaQSjqMsmg8UnfriqpmLoPWmEX
         TwPMjaxhrEXiAt4SiB8MUphDhoUs861LRKEVibRxu2iW1eRrKXfddBF5e2qCbDuR26QM
         lVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693865521; x=1694470321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozfJRQtpgwFC9ZhqHlBlU2b3MtVkpPgDvpRNwWgjyLY=;
        b=B5jjj8iykSxgrr2eD3T91uRsTz2ERhSREFO/jQjId9hpeNNj265QAvEakhmuUZAX8s
         BIVXneUNJ6hgvXBACPySD2XikkNsBTNik2iBu4lRwnEO4MtteVzPmMJau/ffBBoRN/04
         QsDvmjhadkUUhaDvYgN/x4M7rs/rGuAxB2z7SrLJ53TYPnem2TOBV1+wiSLfHL4XNBUe
         Ny2k3PmB5dlWnVxHM5KJGhX3F9VpdYQ9ecuuODrxEp6XJbq9ja1NvF0IowmZGK/A8iWU
         B2NK6/sgxtsmabUh0gzAsSBJiVeIQiViI3iyoOlnAy8Jm9KpS+Sw0yRao/MuWaMWxoEe
         Ozkg==
X-Gm-Message-State: AOJu0YwVVbfALqnbzZCcjhfhWtOsJZJjqSMCAeyF4xGkCKo50d4s6MBH
        W8wKEBMr++ZFBegEKWPdd4qT5Q==
X-Google-Smtp-Source: AGHT+IE/vvRh/sSr63twRD+V6ZY16R6C3ID54jH2VOvEZ+HwDyYucHCTDn7JCaPBvJAJ8vwK5JTOTA==
X-Received: by 2002:a2e:9c1a:0:b0:2b6:e2c1:6cda with SMTP id s26-20020a2e9c1a000000b002b6e2c16cdamr8029681lji.46.1693865521537;
        Mon, 04 Sep 2023 15:12:01 -0700 (PDT)
Received: from olheureu-ThinkPad-E560.local.ess-mail.com ([2a02:578:85b9:1300:6c89:e61f:b837:7d81])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906715000b00993cc1242d4sm6692673ejj.151.2023.09.04.15.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 15:12:01 -0700 (PDT)
From:   Olivier L'Heureux <olivier.lheureux@mind.be>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Olivier L'Heureux <olivier.lheureux@mind.be>
Subject: [PATCH 2/7] Bluetooth: add many traces for allocation/free/refcounting
Date:   Tue,  5 Sep 2023 00:11:53 +0200
Message-Id: <20230904221158.35425-3-olivier.lheureux@mind.be>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904221158.35425-1-olivier.lheureux@mind.be>
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When debugging a kernel memory leak occuring when a bluetooth device
scans for a specific bluetooth device but can't find it [1], we
suspect the following structures are never freed, causing memory
leaks:
 1. the "struct hci_conn" allocated with "kzalloc()" in
    "hci_conn_add()"
 2. the "struct l2cap_conn" allocated with "kzalloc()" in
    "l2cap_conn_add()"

The "struct hci_conn" are reference-counted with 2 reference counters:
 1. "conn->dev" is a usual "struct device*" and it is used for the
    struct lifetime, with "hci_conn_get()" and "hci_conn_put()".
 2. "conn->refcnt" is a "atomic_t" that is used to control the
    underlying connections, with "hci_conn_hold()" and
    "hci_conn_drop()".

The "struct l2cap_conn" are reference-counted with a "struct kref ref"
member.

To debug [2], we add here some debug traces in the following
functions:
 1. "hci_conn_get()" and "hci_conn_put()", to trace the refcounts,
 2. "hci_conn_hold()" and "hci_conn_drop()", to trace the other
    refcounts,
 3. "hci_conn_add()", "bt_link_release()", to trace "struct hci_conn"
    allocation/free,
 4. "hci_conn_del_sysfs()" and "hci_conn_cleanup()", to better follow,
 4. "l2cap_conn_get()" and "l2cap_conn_put()", to trace the refcounts,
 5. "l2cap_conn_add()" and "l2cap_conn_free()", to trace "struct
    l2cap_conn" allocation/free.
 6. "l2cap_conn_add()", in case it does nothing and reuse the existing
    "conn".

We explicitly mention the "kzalloc()" and "kfree()" in the debugging
messages, to ease the allocation and free matching.

References:
- [1] "ble-memleak-repro"
      <https://gitlab.com/essensium-mind/ble-memleak-repro.git>
- [2] "Dynamic debug"
      <https://www.kernel.org/doc/html/v6.5/admin-guide/dynamic-debug-howto.html>

Signed-off-by: Olivier L'Heureux <olivier.lheureux@fortrobotics.com>
Signed-off-by: Olivier L'Heureux <olivier.lheureux@mind.be>
---
 include/net/bluetooth/hci_core.h |  6 ++++--
 net/bluetooth/hci_conn.c         |  4 ++++
 net/bluetooth/hci_sysfs.c        |  6 ++++++
 net/bluetooth/l2cap_core.c       | 12 ++++++++++--
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e01d52cb668c..d8badb2a28cd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1393,18 +1393,20 @@ void hci_conn_failed(struct hci_conn *conn, u8 status);
 
 static inline struct hci_conn *hci_conn_get(struct hci_conn *conn)
 {
+	BT_DBG("hcon %p orig kobj.refcount %d", conn, kref_read(&conn->dev.kobj.kref));
 	get_device(&conn->dev);
 	return conn;
 }
 
 static inline void hci_conn_put(struct hci_conn *conn)
 {
+	BT_DBG("hcon %p orig kobj.refcount %d", conn, kref_read(&conn->dev.kobj.kref));
 	put_device(&conn->dev);
 }
 
 static inline struct hci_conn *hci_conn_hold(struct hci_conn *conn)
 {
-	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
+	BT_DBG("hcon %p orig conn->refcnt %d", conn, atomic_read(&conn->refcnt));
 
 	atomic_inc(&conn->refcnt);
 	cancel_delayed_work(&conn->disc_work);
@@ -1414,7 +1416,7 @@ static inline struct hci_conn *hci_conn_hold(struct hci_conn *conn)
 
 static inline void hci_conn_drop(struct hci_conn *conn)
 {
-	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
+	BT_DBG("hcon %p orig conn->refcnt %d", conn, atomic_read(&conn->refcnt));
 
 	if (atomic_dec_and_test(&conn->refcnt)) {
 		unsigned long timeo;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 76222565e2df..23e635600717 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -143,6 +143,8 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
+	BT_DBG("%s hcon %p", hdev->name, conn);
+
 	if (test_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
 		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
 
@@ -994,6 +996,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	if (!conn)
 		return NULL;
 
+	BT_DBG("hcon %p=kzalloc()", conn);
+
 	bacpy(&conn->dst, dst);
 	bacpy(&conn->src, &hdev->bdaddr);
 	conn->handle = HCI_CONN_HANDLE_UNSET;
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 15b33579007c..fc297b651881 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -13,6 +13,9 @@ static const struct class bt_class = {
 static void bt_link_release(struct device *dev)
 {
 	struct hci_conn *conn = to_hci_conn(dev);
+
+	BT_DBG("kfree(conn %p)", conn);
+
 	kfree(conn);
 }
 
@@ -67,6 +70,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
+	BT_DBG("conn %p", conn);
+
 	if (!device_is_registered(&conn->dev))
 		return;
 
@@ -80,6 +85,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 		put_device(dev);
 	}
 
+	BT_DBG("calling device_del %p", conn);
 	device_del(&conn->dev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 17ca13e8c044..c749b434df97 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1945,12 +1945,16 @@ static void l2cap_conn_free(struct kref *ref)
 {
 	struct l2cap_conn *conn = container_of(ref, struct l2cap_conn, ref);
 
+	BT_DBG("kfree(conn) %p", conn);
+
 	hci_conn_put(conn->hcon);
 	kfree(conn);
 }
 
 struct l2cap_conn *l2cap_conn_get(struct l2cap_conn *conn)
 {
+	BT_DBG("conn %p, refcount %d", conn, kref_read(&conn->ref));
+
 	kref_get(&conn->ref);
 	return conn;
 }
@@ -1958,6 +1962,8 @@ EXPORT_SYMBOL(l2cap_conn_get);
 
 void l2cap_conn_put(struct l2cap_conn *conn)
 {
+	BT_DBG("conn %p, refcount %d", conn, kref_read(&conn->ref));
+
 	kref_put(&conn->ref, l2cap_conn_free);
 }
 EXPORT_SYMBOL(l2cap_conn_put);
@@ -7835,8 +7841,10 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct hci_chan *hchan;
 
-	if (conn)
+	if (conn) {
+		BT_DBG("hcon %p reuse conn %p", hcon, conn);
 		return conn;
+	}
 
 	hchan = hci_chan_create(hcon);
 	if (!hchan)
@@ -7853,7 +7861,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	conn->hcon = hci_conn_get(hcon);
 	conn->hchan = hchan;
 
-	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
+	BT_DBG("hcon %p conn %p=kzalloc() hchan %p", hcon, conn, hchan);
 
 	switch (hcon->type) {
 	case LE_LINK:
-- 
2.39.2

