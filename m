Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F61C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 23:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386585AbiEEXJi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 19:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386583AbiEEXJf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 19:09:35 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA9B5C65A
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 16:05:54 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e3so6364235ios.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 May 2022 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T+2lGbl7MnYr8zUoz+2zqreSAY2Nj3Q2V4W2qGGwZQs=;
        b=Fqz5OrjJnohQNu7vpa5WQmjfUU/RvKRx46reqfwRVb95YDfUIAJYGOUVS19ujduU3o
         wc+TIWHpbjSn42n09WEeLNVsa30+HK7EvSD2YuS4+enM6/8yXWdg5dE0gCgWU2wbtkZk
         ed4W1N9Z0xK1kHpvlSSrBFf84d1QhD9c8CVzltaLjpSUWoceEg6/e1zCQlGS7wBBUIjr
         DZux4emvaZDuS6xXD2rUDbMrSXouGtFoOQ7Na5U6RD9HvstdR14WE+tK5YqYw8udRgRG
         bN9FTS14XSk7vKFmshCn38T+mELIOu6S9/nGkI9wzvVe49c1vqa5Nn0DRjDzaP/KgRYV
         mTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T+2lGbl7MnYr8zUoz+2zqreSAY2Nj3Q2V4W2qGGwZQs=;
        b=TJ+TTIjqoYE9abgyJ2gCFTvp9h7vf5BLGxZ4CMwTg9+9/SvcGtXNKszd5PsAzBA/PZ
         Z8cHujKQV95qEgfPLAWaNCU4rWk9mvixJpq0I+0h5yIhdyPbS0b3MyWTh1yoQPfvH8z3
         oCQi3HHoCxuCRm+Z8RCr0jsNz9QP68oLXEu+iSRZeuwbHwD3V7kgP+8DH5fu+08wg/LU
         UP/6qB+yYFVGR0199HgZLxflF22D8buvg+/9XD2nZnZdiIqF2k3SPuDBXSVbpVpXtfSL
         tEPz6Pkb674CWksmUZdP/BY0ffZL5VMsyvi3Wnse6/naD6Ed6tblz8KTLdOKtqnN5fSu
         YOeQ==
X-Gm-Message-State: AOAM530XglTLoCvRs+ViptFmVNyFPuriftN0ivl2lpv8QAys96Xa6Ksp
        1lpHAsUYRVu0LZPToWgf8mpxd6kSr50=
X-Google-Smtp-Source: ABdhPJzN4LW+rWA7lBys+rc3P3pp1NXCx+v3hW589ssJI4IZ7iEHQs3KxFrvR5o7+Mt1I1TVRKTz9A==
X-Received: by 2002:a05:6602:3c5:b0:64c:727d:6e95 with SMTP id g5-20020a05660203c500b0064c727d6e95mr195873iov.118.1651791953632;
        Thu, 05 May 2022 16:05:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l10-20020a92d8ca000000b002cde6e352bfsm780757ilo.9.2022.05.05.16.05.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 16:05:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: hci_core: Introduce hci_recv_event_data
Date:   Thu,  5 May 2022 16:05:44 -0700
Message-Id: <20220505230550.3450617-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505230550.3450617-1-luiz.dentz@gmail.com>
References: <20220505230550.3450617-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces hci_recv_event_data to make it simpler to access the
contents of last received event rather than having to pass its contents
to the likes of *_ind/*_cfm callbacks.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 32 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 64d3a63759a8..8838aa2cd594 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -516,6 +516,7 @@ struct hci_dev {
 	struct sk_buff_head	cmd_q;
 
 	struct sk_buff		*sent_cmd;
+	struct sk_buff		*recv_event;
 
 	struct mutex		req_lock;
 	wait_queue_head_t	req_wait_q;
@@ -1739,6 +1740,7 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
+void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
 
 u32 hci_conn_get_phy(struct hci_conn *conn);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ad4f4ab0afca..12266f95a3c1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2738,6 +2738,7 @@ void hci_release_dev(struct hci_dev *hdev)
 
 	ida_simple_remove(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
+	kfree_skb(hdev->recv_event);
 	kfree(hdev);
 }
 EXPORT_SYMBOL(hci_release_dev);
@@ -3022,6 +3023,37 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 	return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
 }
 
+/* Get data from last received event */
+void *hci_recv_event_data(struct hci_dev *hdev, __u8 event)
+{
+	struct hci_event_hdr *hdr;
+	int offset;
+
+	if (!hdev->recv_event)
+		return NULL;
+
+	hdr = (void *) hdev->recv_event->data;
+	offset = sizeof(*hdr);
+
+	if (hdr->evt != event) {
+		/* In case of LE metaevent check the subevent match */
+		if (hdr->evt == HCI_EV_LE_META) {
+			struct hci_ev_le_meta *ev;
+
+			ev = (void *) hdev->recv_event->data + offset;
+			offset += sizeof(*ev);
+			if (ev->subevent == event)
+				goto found;
+		}
+		return NULL;
+	}
+
+found:
+	bt_dev_dbg(hdev, "event 0x%2.2x", event);
+
+	return hdev->recv_event->data + offset;
+}
+
 /* Send ACL data */
 static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0270e597c285..8b39b9d31879 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6933,6 +6933,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	kfree_skb(hdev->recv_event);
+	hdev->recv_event = skb_clone(skb, GFP_KERNEL);
+
 	event = hdr->evt;
 	if (!event) {
 		bt_dev_warn(hdev, "Received unexpected HCI Event 0x%2.2x",
-- 
2.35.1

