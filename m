Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723CCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 21:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359689AbiEFWBe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444627AbiEFWBc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:01:32 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D520D3F883
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 14:57:47 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h85so9473427iof.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UGs3eWnzMlMcYy7o1gP5HPjZRQpD9Txg0Es5X9kruBM=;
        b=V+ZG56G+9u/gtOoarUYFWBv3Azhwda/1dv2LdSRTnrGTM4FvJl0NrMensEukJlF7nb
         ULg95i0eF05H6Xme/+mLoGCSZ4xxmJEPO7gbbJ7nuRoB8MrTl4ZWO1lXnvbd38jkAf7x
         9sPVF10Sor6v8jjo3gCfHaOrlZ0FGDgqa0T/ShqydCm5sB0ZUojiENFvqTe/1WclwQf1
         g1xYfPi7UnJPCym3KTHiUC02e6EiKayHqImLtkFCo6y5F7dcsOU28pkEM2U7jGOd+Bsj
         MNgxYhhn421XhPLEgYBRKD+EGYUeAGQd0N9emJjull6WhOP6Z9xnOH4aBJyBJQAwNWVG
         Vm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGs3eWnzMlMcYy7o1gP5HPjZRQpD9Txg0Es5X9kruBM=;
        b=H0FmPrMLu+iKzk5sBxi05XKrRQdCdtFqVramXkEYsNKFUKQhv2q8HgLeVW7hLHVQuN
         0BDvtnUWIFVul8LTh5xvyDyu1/2RP/Q+aUQiq21989Oa3yrpoC+3m4+aqSCHMOLdTAsB
         SneMhmohNuLhXMjBJ/1akgU+bnM8mJNJYupIRdOpjWYfiKMhKl/uJdsZjDmo+pnvapcR
         z/TMmJO/phLmjyaRF1nVEvto2IpsF84tFMVA5VXfliVC5o2x6J3sYKV2gReixmhKCcXT
         +1k2WMPq2qEXA8FoP6Zh9ZGeq2g69kAms4n2VaEP8UcupymoaIm+npoFsiD4cOfuw8d1
         uMzA==
X-Gm-Message-State: AOAM532298aX+QQI5xHFC+QQCtmRCsgVfwPNbZayA6U2eWJhyMraWQ5o
        sTJo40VOXGQRh7mEEelzr/fwZD5ukLo=
X-Google-Smtp-Source: ABdhPJzZXDhWxwClWueeWOxz2d/YW4yPndOHBRbvRyliKKXpGv0AZiIigIVKLqakAghkAYPytrZNUw==
X-Received: by 2002:a05:6638:2723:b0:32b:d0c6:23a9 with SMTP id m35-20020a056638272300b0032bd0c623a9mr1007296jav.319.1651874266918;
        Fri, 06 May 2022 14:57:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s14-20020a5e980e000000b0065aab053448sm1572281ioj.21.2022.05.06.14.57.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 14:57:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/8] Bluetooth: hci_core: Introduce hci_recv_event_data
Date:   Fri,  6 May 2022 14:57:37 -0700
Message-Id: <20220506215743.3870212-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506215743.3870212-1-luiz.dentz@gmail.com>
References: <20220506215743.3870212-1-luiz.dentz@gmail.com>
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
index ad4f4ab0afca..377c0712bf3b 100644
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

