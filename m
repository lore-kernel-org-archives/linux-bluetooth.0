Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29504C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351455AbhLAS6o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244895AbhLAS6d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8507DC061757
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:11 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b11so18406393pld.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=j5ekZ4KztehWagyD6KmPICwo6+51UABy5q3ntCm5U44=;
        b=WXtvRgS+r8eXu9DPhGsVhIyG0lO8Pgj8Gwt1GtqciLTbzLpnx3uWHXI0zKfyNZo7/z
         UmUdKOPdqg0EwjK0Sg/i9TG2dj3Ib5z34fKfHeYHOj1NZ/b2hYhhMGdxm2xfBkpKWIwN
         57oeb25nqCtLa3woPHikBIl9EpfaizYVrwoxuULQAkClNPW1s7Av8frpOB1CL+uroyqz
         RuwDTl7DUZMSSsg1xXGRX/GXuwVQdSI4QoLb1QhkquYjDnIgiwzZi39tK3zs4XF4L+LL
         vG+nG3q0bZcT/OMUwsw0C4hyLvnE8rV/JXZKQXamkfzF0/RzH3qmUV1wamOtKK0gkazy
         vAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5ekZ4KztehWagyD6KmPICwo6+51UABy5q3ntCm5U44=;
        b=CVUd8P+sTAaxwtbOT0coHdM0DAHGjw5lKISHI29Khd7hbJDutirztphotvrFU8hoBR
         +T8OjrqpFSk/Olq6UA8vZP5WefzLOjvtzqdJqdNJTYod5gD3BrRu651I5YsSmi4Y9WFD
         4cJNPLoZO4J7WJfoCdeVCIAHfA7UGULl+N3RJIc88lI5Si+lPYgOX6OmEE0g5FqdzoUd
         Tu8ahHeIsvxBsf6LNCknWe/iZxmPFmNnwIDcj98zIJnEOA9gioeqqaS2m4LjYYgHiEoW
         w81LAdHwXA7xZxrdoHuZcSxkRzArM582X5PP5gQmkytfe2s3syzen10yoIUVxhZokg90
         G2bQ==
X-Gm-Message-State: AOAM532Jj9V5GkQNNkZtk1HYyonaY9VvS/MZPAfgfRoa0na8x7dLe8IJ
        d6GfyGvxazxvziub8nnKcajyvVZXlMc=
X-Google-Smtp-Source: ABdhPJzAEdBcWJC4hBbYeLVrgTiSQMELRGEMvMPs5jLAXJ+b1dkzbXdyMVepGV9bINGNEdU0GP/xNQ==
X-Received: by 2002:a17:90a:4414:: with SMTP id s20mr66184pjg.132.1638384910786;
        Wed, 01 Dec 2021 10:55:10 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:10 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/15] Bluetooth: HCI: Use skb_pull_data to parse Number of Complete Packets event
Date:   Wed,  1 Dec 2021 10:54:55 -0800
Message-Id: <20211201185506.1421186-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull_data to check the Number of Complete Packets events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_event.c   | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ba89b078ceb5..3f57fd677b67 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2139,7 +2139,7 @@ struct hci_comp_pkts_info {
 } __packed;
 
 struct hci_ev_num_comp_pkts {
-	__u8     num_hndl;
+	__u8     num;
 	struct hci_comp_pkts_info handles[];
 } __packed;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 09d7d997c4b1..b27a4ad647ca 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4465,23 +4465,25 @@ static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
+	struct hci_ev_num_comp_pkts *ev;
 	int i;
 
-	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
-		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
+	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_PKTS, sizeof(*ev));
+	if (!ev)
 		return;
-	}
 
-	if (skb->len < sizeof(*ev) ||
-	    skb->len < struct_size(ev, handles, ev->num_hndl)) {
-		BT_DBG("%s bad parameters", hdev->name);
+	if (!hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_PKTS,
+			     flex_array_size(ev, handles, ev->num)))
+		return;
+
+	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
+		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
 		return;
 	}
 
-	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
+	BT_DBG("%s num %d", hdev->name, ev->num);
 
-	for (i = 0; i < ev->num_hndl; i++) {
+	for (i = 0; i < ev->num; i++) {
 		struct hci_comp_pkts_info *info = &ev->handles[i];
 		struct hci_conn *conn;
 		__u16  handle, count;
-- 
2.33.1

