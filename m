Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8F6C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 22:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244720AbiFQWRQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiFQWRP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 18:17:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA70B58E5F
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:17:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l4so5100844pgh.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTftxStarsjR0xlLjp/6tAXsuwdE5XFAR3Ab3jaCwY4=;
        b=ajWORCYJDPlLfCXVxZ2ge2dtC472HcJ6TsGRwRgi47/YIeS/R8LADcfSrWp/k7TcbS
         i92r7oLDofD90TNCX4gD3oo4+XwKxesIam+60jpwp1VfZbTwdLf3Zpe0mY80+XrtwnXd
         dsnK5djr68lTr3KtxJ22u/Rce5jHJ927N5Iv4q7fQlshZzyrJCRe294YG/03CbGRxICu
         OyZTezMbfM6tO4mXBsZdjn6VjeIJr2Lgntpe4KWvbeWJTAOzPJm8c3vr8Qdo+blybfAH
         EbOwDy2ignx/Yv2V1Isfj6C98ryzTyVPm/1t9u+lXPFgyKc8+6nit7PSu0j0b5btGlIY
         iMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTftxStarsjR0xlLjp/6tAXsuwdE5XFAR3Ab3jaCwY4=;
        b=5lAZfWI8D3u8sMZzv15cf8UQH45mVFQArIA+Qit8guVx2eWg2LTEfmeyeT78wiCVhf
         AB4TG4Ebc0ZwE7YnvlaTQTSBUcVjq2OQ4o5OIMRSUhltB6vg1Dkclq7mjcjwW6PW8eOC
         iFZQobOcJWTM6KTFO7pIhjP2iTw0E8N5MxBlekrdRje0LjtWaCgyFr+itEMHmusM+KA9
         zPT5NLkljOW+JQ5nQfFSRKRohwAEHjLf4RbYs8MRBVihNnUba9wPd5s078a+4IkJOAfQ
         ljbY9nAxuXnYCxHqqkJ2bHMcus1x1Ud9xIZxjStgblrlVGoPUK6XTEIZaaaiFfC567zK
         wcYg==
X-Gm-Message-State: AJIora+ypTOw4nSNi8wmXA+MKhgFzS6+EVR98XVDH0HyqWnKLT2e2DQV
        r7PJLtu+psuuDLfqeXmPoYh43aDVHuI=
X-Google-Smtp-Source: AGRyM1sPPzUHRJJZdFE6AAUyrvogYc6eZXvJooE08FwToOaoX6cCxA6TiY/I/OO5/UekcIIdxEyWgg==
X-Received: by 2002:a63:130f:0:b0:401:ce98:24eb with SMTP id i15-20020a63130f000000b00401ce9824ebmr11160617pgl.217.1655504233883;
        Fri, 17 Jun 2022 15:17:13 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id jc21-20020a17090325d500b0016184e7b013sm4117261plb.36.2022.06.17.15.17.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:17:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
Date:   Fri, 17 Jun 2022 15:17:06 -0700
Message-Id: <20220617221712.1394014-1-luiz.dentz@gmail.com>
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

