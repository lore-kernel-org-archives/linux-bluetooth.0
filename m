Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42EBC2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73ABB611CD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhEYKdz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhEYKcr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 06:32:47 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084FEC061377
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:31 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id z2-20020a3765020000b02903a5f51b1c74so18235174qkb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q1TI3JS8LiK7Q2wz43m+DheiZ9D7HZBK4O3jJENpSdg=;
        b=qk3q+CXBfWFKr/wy9MOiwyjXboL4xukemFTRhjFLXiylmW2bqoJRhEKEpH79YObVgk
         rPx6YvD26PHQY5XJKo2q3vdGu8aKkoC6JwFjuLbXfguzEYUiFvVw06pBcfza/hhMkWOe
         QCG2HphpiAUdCKTB17A7hocO0pp7xN8vdEkxvU8JLzGdCnsA9dqB4tq9T7vzjHtmCvkQ
         mFjKXvEIw9+5rhTE6B7E/LQCzI/BAKXstZzEwHrn/GVJzz5LVkcuT+GKIdVI20akxE9l
         nMNbDZHZe5vXkr/qr06zIjYbMMDvzTe94xyDdluQCtPLIzQeOO7RoZJDqMczG/QIpKtm
         ML0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q1TI3JS8LiK7Q2wz43m+DheiZ9D7HZBK4O3jJENpSdg=;
        b=H6yyK1wJZ/nKFpZ6eCo/z56ehecXwKKeUAF9TT9Rrb7vu8PSisSMZKlz4lSB2TIk91
         ZxZ6+y1lmGSD6C07YCFzapDCaSVc40jzIYuovNHRNaGe3tfASqPMu+HQ3JVsYRgkzod1
         z5Omg0JDnIoPcOTSSa85AQl3JDmbe2oP7X/Qsv8g8B4gfHWQYwzfXnOeg9hO9jd1Oofl
         xqp/0suCQ/fR6gZLDBrkvzMs//Zo6Q0iA775l70axh6vHxMN1ovq2SOpy95mvoC1D1PZ
         SOMa/uI0WAaVv4Vw+ECrbL1q1d5nNlVuVgJdW7BOMMWAAm2xyac63Z3d6VsFJS6VA2MD
         IKYA==
X-Gm-Message-State: AOAM532M/LD30oGzIQl9XkysrQ3bQbpApYIpktBceQpPEP3KqVE8slbZ
        zHlPhM+wIDL2rNeogUiCMxB1jOVLWXtG+odW1LBgZC9jvfqZqKnoBvBwTrSRoOWe4qv5Hl5n5QB
        7TjXxZWO+5mkryzZJalFENT+UTghwKzrF4KKzqztYYbslDsixUZzNYO0qjRdQ1Ql9Hge55zxbUn
        a8
X-Google-Smtp-Source: ABdhPJw24HDxRIA8SyHsbhM9r3oodY7md0cTkrehRUhXc3tS2AS5gaOyl8NBMQlhXJJrmnJq4o6E44agUz6K
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:8806:6b98:8ae6:8824])
 (user=apusaka job=sendgmr) by 2002:a05:6214:76b:: with SMTP id
 f11mr36537191qvz.8.1621938629944; Tue, 25 May 2021 03:30:29 -0700 (PDT)
Date:   Tue, 25 May 2021 18:29:39 +0800
In-Reply-To: <20210525102941.3958649-1-apusaka@google.com>
Message-Id: <20210525182900.10.I014436e29e9c804a3f7583db6264214cad746a7d@changeid>
Mime-Version: 1.0
References: <20210525102941.3958649-1-apusaka@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 10/12] Bluetooth: use inclusive language when filtering
 devices out
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Use "reject list".

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         |  4 ++--
 net/bluetooth/hci_debugfs.c      |  2 +-
 net/bluetooth/hci_event.c        |  6 +++---
 net/bluetooth/hci_sock.c         | 12 ++++++------
 net/bluetooth/l2cap_core.c       |  4 ++--
 net/bluetooth/mgmt.c             |  4 ++--
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cfe2ada49ca2..9c8cdc4fe3c5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -522,7 +522,7 @@ struct hci_dev {
 	struct hci_conn_hash	conn_hash;
 
 	struct list_head	mgmt_pending;
-	struct list_head	blacklist;
+	struct list_head	reject_list;
 	struct list_head	whitelist;
 	struct list_head	uuids;
 	struct list_head	link_keys;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b9ebad0f8fb9..932df458bc80 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3822,7 +3822,7 @@ struct hci_dev *hci_alloc_dev(void)
 	mutex_init(&hdev->req_lock);
 
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
-	INIT_LIST_HEAD(&hdev->blacklist);
+	INIT_LIST_HEAD(&hdev->reject_list);
 	INIT_LIST_HEAD(&hdev->whitelist);
 	INIT_LIST_HEAD(&hdev->uuids);
 	INIT_LIST_HEAD(&hdev->link_keys);
@@ -4042,7 +4042,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	destroy_workqueue(hdev->req_workqueue);
 
 	hci_dev_lock(hdev);
-	hci_bdaddr_list_clear(&hdev->blacklist);
+	hci_bdaddr_list_clear(&hdev->reject_list);
 	hci_bdaddr_list_clear(&hdev->whitelist);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 3352e831af3d..f5c423f44076 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -144,7 +144,7 @@ static int reject_list_show(struct seq_file *f, void *p)
 	struct bdaddr_list *b;
 
 	hci_dev_lock(hdev);
-	list_for_each_entry(b, &hdev->blacklist, list)
+	list_for_each_entry(b, &hdev->reject_list, list)
 		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c5871c2a16ba..c41fef24166f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2745,7 +2745,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	if (hci_bdaddr_list_lookup(&hdev->blacklist, &ev->bdaddr,
+	if (hci_bdaddr_list_lookup(&hdev->reject_list, &ev->bdaddr,
 				   BDADDR_BREDR)) {
 		hci_reject_conn(hdev, &ev->bdaddr);
 		return;
@@ -5224,7 +5224,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		addr_type = BDADDR_LE_RANDOM;
 
 	/* Drop the connection if the device is blocked */
-	if (hci_bdaddr_list_lookup(&hdev->blacklist, &conn->dst, addr_type)) {
+	if (hci_bdaddr_list_lookup(&hdev->reject_list, &conn->dst, addr_type)) {
 		hci_conn_drop(conn);
 		goto unlock;
 	}
@@ -5380,7 +5380,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 		return NULL;
 
 	/* Ignore if the device is blocked */
-	if (hci_bdaddr_list_lookup(&hdev->blacklist, addr, addr_type))
+	if (hci_bdaddr_list_lookup(&hdev->reject_list, addr, addr_type))
 		return NULL;
 
 	/* Most controller will fail if we try to create new connections
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 251b9128f530..26d794b164f1 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -892,7 +892,7 @@ static int hci_sock_release(struct socket *sock)
 	return 0;
 }
 
-static int hci_sock_blacklist_add(struct hci_dev *hdev, void __user *arg)
+static int hci_sock_reject_list_add(struct hci_dev *hdev, void __user *arg)
 {
 	bdaddr_t bdaddr;
 	int err;
@@ -902,14 +902,14 @@ static int hci_sock_blacklist_add(struct hci_dev *hdev, void __user *arg)
 
 	hci_dev_lock(hdev);
 
-	err = hci_bdaddr_list_add(&hdev->blacklist, &bdaddr, BDADDR_BREDR);
+	err = hci_bdaddr_list_add(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
 
 	hci_dev_unlock(hdev);
 
 	return err;
 }
 
-static int hci_sock_blacklist_del(struct hci_dev *hdev, void __user *arg)
+static int hci_sock_reject_list_del(struct hci_dev *hdev, void __user *arg)
 {
 	bdaddr_t bdaddr;
 	int err;
@@ -919,7 +919,7 @@ static int hci_sock_blacklist_del(struct hci_dev *hdev, void __user *arg)
 
 	hci_dev_lock(hdev);
 
-	err = hci_bdaddr_list_del(&hdev->blacklist, &bdaddr, BDADDR_BREDR);
+	err = hci_bdaddr_list_del(&hdev->reject_list, &bdaddr, BDADDR_BREDR);
 
 	hci_dev_unlock(hdev);
 
@@ -959,12 +959,12 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 	case HCIBLOCKADDR:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		return hci_sock_blacklist_add(hdev, (void __user *)arg);
+		return hci_sock_reject_list_add(hdev, (void __user *)arg);
 
 	case HCIUNBLOCKADDR:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		return hci_sock_blacklist_del(hdev, (void __user *)arg);
+		return hci_sock_reject_list_del(hdev, (void __user *)arg);
 	}
 
 	return -ENOIOCTLCMD;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c10a45368ec2..6b0f8f7867bc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7662,7 +7662,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 	 * at least ensure that we ignore incoming data from them.
 	 */
 	if (hcon->type == LE_LINK &&
-	    hci_bdaddr_list_lookup(&hcon->hdev->blacklist, &hcon->dst,
+	    hci_bdaddr_list_lookup(&hcon->hdev->reject_list, &hcon->dst,
 				   bdaddr_dst_type(hcon))) {
 		kfree_skb(skb);
 		return;
@@ -8119,7 +8119,7 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	dst_type = bdaddr_dst_type(hcon);
 
 	/* If device is blocked, do not create channels for it */
-	if (hci_bdaddr_list_lookup(&hdev->blacklist, &hcon->dst, dst_type))
+	if (hci_bdaddr_list_lookup(&hdev->reject_list, &hcon->dst, dst_type))
 		return;
 
 	/* Find fixed channels and notify them of the new connection. We
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0f550740e1f4..b15af55c00d6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5207,7 +5207,7 @@ static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	err = hci_bdaddr_list_add(&hdev->blacklist, &cp->addr.bdaddr,
+	err = hci_bdaddr_list_add(&hdev->reject_list, &cp->addr.bdaddr,
 				  cp->addr.type);
 	if (err < 0) {
 		status = MGMT_STATUS_FAILED;
@@ -5243,7 +5243,7 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	err = hci_bdaddr_list_del(&hdev->blacklist, &cp->addr.bdaddr,
+	err = hci_bdaddr_list_del(&hdev->reject_list, &cp->addr.bdaddr,
 				  cp->addr.type);
 	if (err < 0) {
 		status = MGMT_STATUS_INVALID_PARAMS;
-- 
2.31.1.818.g46aad6cb9e-goog

