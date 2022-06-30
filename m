Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2926C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 22:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiF3WOV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiF3WOU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 18:14:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFD157206
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s27so609786pga.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smUQIYhmjvAArr1WU5GcWxgQxds+sae0hnLg29pXiRw=;
        b=Uy+6gfZSckDx5TsC8SDt3v3Pco5yJzjm9Q4Ch74lX3w5vutzUyFVa7SmhvZzOuFD+2
         cT30iz7SidRMuRQF0688tj8uVCaL7tnV6DPuwGofKUnBFyj47RM4kZKY+4iiqWVy/aLI
         gxBUxHb9wn3aXzZ4oZZc7AOzNmUtPm3WJZCnwQe7F7XpswBzrcMss1AG1Om3kw8pR6W+
         FAvUqG0KXyw5A/B/+jAW5fx6D/+RIeglphSA10kJEW+T5tnVHIqe+gVE3lj0eTXgG5u4
         CnuxSPKFwyAUyz3+1VXLMk10oGZ6vw4f7N/BrLA3ftN7wSbQb2Q6A71QzrgV5lh+mSXu
         UmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smUQIYhmjvAArr1WU5GcWxgQxds+sae0hnLg29pXiRw=;
        b=tAeVjuENxYhzSDHY4jN2DMA0Dg9/E+m2JvuuS1GQOKwLrfBNGugoFiIm04R90wEDgm
         o3NTZ1Jr7WOx+APcC70x+sjFXw00z/Mu5o4UuK27KhntjfS0euHDTeVqpMsP17GwkPQv
         Wt6L3HisqUSr6ahpTwLZMlLYAQXS+NF+hVZ1NaIvuNwRZS0uEbCfBEq9b2PzOwPu5Zym
         nIxZPnsFaqvVE0n+FxiKCQkIl6sY3gSubFUuiRr8PHeghkXvdY0n57AIwFapnwEIULmD
         c2YED+fx2ZcwGQqIOYF6s7Eh/IK3DjfHbW/GTh1cMOrSf23hiVoScZbLwn5cJUZmSbW0
         NLQw==
X-Gm-Message-State: AJIora+shGpssAKc/NXfFCz+dUZL8fWucXFVSRxKdVjkQmzU/2CY8CXo
        3LNywPErxqajOacrrRQ09SvSstDg0kJ9Bw==
X-Google-Smtp-Source: AGRyM1s4rb3JrkyE194Drv0BHNSMNaOHA2b5lOZlTTXfb/VKsWoIBlULqx582cuAiXZnjK2u4vuiuA==
X-Received: by 2002:a05:6a00:2402:b0:4e1:46ca:68bd with SMTP id z2-20020a056a00240200b004e146ca68bdmr17677477pfh.70.1656627257499;
        Thu, 30 Jun 2022 15:14:17 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090a688f00b001eef3f30c74sm2490869pjd.48.2022.06.30.15.14.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:14:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
Date:   Thu, 30 Jun 2022 15:14:09 -0700
Message-Id: <20220630221415.638408-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
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
v2: Fixes CI/kernel test robot findings
v3: Fix crash when disabling ISO Socket experimental UUID.
v4: Fix crashes when running iso-tester Defer and Defer Send tests which just
binds the CIS using DEFER_SETUP without attempting to connect it at first.

 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 32 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 15237ee5f761..0ce57e1856e5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -530,6 +530,7 @@ struct hci_dev {
 	struct sk_buff_head	cmd_q;
 
 	struct sk_buff		*sent_cmd;
+	struct sk_buff		*recv_event;
 
 	struct mutex		req_lock;
 	wait_queue_head_t	req_wait_q;
@@ -1755,6 +1756,7 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
+void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
 
 u32 hci_conn_get_phy(struct hci_conn *conn);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 05c13f639b94..1ff2c284e867 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2739,6 +2739,7 @@ void hci_release_dev(struct hci_dev *hdev)
 
 	ida_simple_remove(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
+	kfree_skb(hdev->recv_event);
 	kfree(hdev);
 }
 EXPORT_SYMBOL(hci_release_dev);
@@ -3045,6 +3046,37 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
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
+	hdr = (void *)hdev->recv_event->data;
+	offset = sizeof(*hdr);
+
+	if (hdr->evt != event) {
+		/* In case of LE metaevent check the subevent match */
+		if (hdr->evt == HCI_EV_LE_META) {
+			struct hci_ev_le_meta *ev;
+
+			ev = (void *)hdev->recv_event->data + offset;
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
index 34bec7446d00..2440275a143c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6936,6 +6936,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	kfree_skb(hdev->recv_event);
+	hdev->recv_event = skb_clone(skb, GFP_KERNEL);
+
 	event = hdr->evt;
 	if (!event) {
 		bt_dev_warn(hdev, "Received unexpected HCI Event 0x%2.2x",
-- 
2.35.3

