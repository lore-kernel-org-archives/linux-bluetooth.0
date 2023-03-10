Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9394DC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 00:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCJABE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 19:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCJABB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 19:01:01 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA6E6DAF
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 16:00:59 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id e11so1403893ioe.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 16:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678406458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZl7/ZlLmpAbMyMPJw/a7JKmvg6sWP/WeZ4BXhjLbg4=;
        b=R1REWlphjkiVGgJq9GF4eosk9messm98dOs1AtvXxNe8SxDx0XljvgKQJnoZJxA+EX
         qrl/umJfDGWtlf/ZcRbhTtyKIL/+PI37JRU2jrV9A3cK9kmUqauuPzT9cp8yc5FgFvBQ
         lY8lEj51gBrDyFBdMvlADV3Q5N7z7PgNP/LJWMr2AXUUmh+UDgaamo+ndn0RHTDwEy3N
         scgwfiQboVjvlVWjWDSxcdAoEDLllCi9dOcKiWSdq3QN/zUsMBQAmYfNnOY9s5HQY5QE
         69n93j7GXB3g1k/Z2MiUL7SL/NfZvqal1NhhVPhIMod7gQBUDUuQA/C2U23SOl5oP45E
         gFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678406458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZl7/ZlLmpAbMyMPJw/a7JKmvg6sWP/WeZ4BXhjLbg4=;
        b=1J2N8AstKQuX3UzASqTpsFwYQTL/DvSHmbZGNGJIpuR2in29G+Qtgb6Vpt4V2nY3Gq
         vSRCg6lsoIMoXMdJm9MhVr3NhD8M/HnMrtgHWNNe3oijgzsrJ2QXeGOKSAElhW4naWzg
         bxZrgAsSqnlgwh2EgfOVhon62YObeP4axxwBLTh1YDHmHZfdsF+gn9FIGz9goVfJIEmE
         4GbkpSX8jMFIEaIrITngb91ISjGbZ5sh1pwrFV6d3304u/cQY7nugjPAHIZwxjPv+azd
         hTpuMdRItxG+kTUwR6pMZ+/mvDJWGIJbNzUsfEag52kSrgILF0YYGLMrsgQR4K7Agqbh
         7DvQ==
X-Gm-Message-State: AO0yUKUfwxV1e1pxH3GahdwCmLkcu0tri4Sn7tAJoXjECV/Yid58mXRZ
        HWOfcna6cg66FDYZ+uXVJIpeHk3gFkc=
X-Google-Smtp-Source: AK7set8QcxQ5WtIdjiJdCThAMS8V83fSO6KkTNG3Gy7K0qh1q630R62mHSojy8rqwBZ6crqltDXj+Q==
X-Received: by 2002:a5d:8554:0:b0:744:b4c2:30fa with SMTP id b20-20020a5d8554000000b00744b4c230famr14428319ios.18.1678406458605;
        Thu, 09 Mar 2023 16:00:58 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id z9-20020a056602204900b00745a82f892bsm153030iod.15.2023.03.09.16.00.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 16:00:58 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: L2CAP: Delay identity address updates
Date:   Thu,  9 Mar 2023 16:00:55 -0800
Message-Id: <20230310000055.3396026-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310000055.3396026-1-luiz.dentz@gmail.com>
References: <20230310000055.3396026-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This delays the identity address updates to give time for userspace to
process the new address otherwise there is a risk that userspace
creates a duplicated device if the MGMT event is delayed for some
reason.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h | 2 +-
 net/bluetooth/l2cap_core.c    | 7 +++----
 net/bluetooth/smp.c           | 9 ++++++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2f766e3437ce..cf393e72d6ed 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -694,7 +694,7 @@ struct l2cap_conn {
 	struct sk_buff_head	pending_rx;
 	struct work_struct	pending_rx_work;
 
-	struct work_struct	id_addr_update_work;
+	struct delayed_work	id_addr_timer;
 
 	__u8			disc_reason;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 49926f59cc12..8153293b9a45 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -745,7 +745,7 @@ EXPORT_SYMBOL_GPL(l2cap_chan_list);
 static void l2cap_conn_update_id_addr(struct work_struct *work)
 {
 	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
-					       id_addr_update_work);
+					       id_addr_timer.work);
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan;
 
@@ -1907,8 +1907,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (work_pending(&conn->pending_rx_work))
 		cancel_work_sync(&conn->pending_rx_work);
 
-	if (work_pending(&conn->id_addr_update_work))
-		cancel_work_sync(&conn->id_addr_update_work);
+	cancel_delayed_work_sync(&conn->id_addr_timer);
 
 	l2cap_unregister_all_users(conn);
 
@@ -7886,7 +7885,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 
 	skb_queue_head_init(&conn->pending_rx);
 	INIT_WORK(&conn->pending_rx_work, process_pending_rx);
-	INIT_WORK(&conn->id_addr_update_work, l2cap_conn_update_id_addr);
+	INIT_DELAYED_WORK(&conn->id_addr_timer, l2cap_conn_update_id_addr);
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 70663229b3cc..f1a9fc0012f0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -58,6 +58,8 @@
 
 #define SMP_TIMEOUT	msecs_to_jiffies(30000)
 
+#define ID_ADDR_TIMEOUT	msecs_to_jiffies(200)
+
 #define AUTH_REQ_MASK(dev)	(hci_dev_test_flag(dev, HCI_SC_ENABLED) ? \
 				 0x3f : 0x07)
 #define KEY_DIST_MASK		0x07
@@ -1067,7 +1069,12 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		if (hcon->type == LE_LINK) {
 			bacpy(&hcon->dst, &smp->remote_irk->bdaddr);
 			hcon->dst_type = smp->remote_irk->addr_type;
-			queue_work(hdev->workqueue, &conn->id_addr_update_work);
+			/* Use a short delay to make sure the new address is
+			 * propagated _before_ the channels.
+			 */
+			queue_delayed_work(hdev->workqueue,
+					   &conn->id_addr_timer,
+					   ID_ADDR_TIMEOUT);
 		}
 	}
 
-- 
2.39.2

