Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91687C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 19:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353658AbhLCT24 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244366AbhLCT2z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 14:28:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B70CC061751
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 11:25:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x7so3096383pjn.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Dec 2021 11:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qws4wvCB4UWJD9VpnFUtUzuwOKFsR7MZMEGQWCDqwZ4=;
        b=PBTSLV5qI+eMDbuQ5+3gYaJULSTh2Q5RcQrIdvcfIry18kYrVXmvw4jy508tDpIbJR
         CDZIjFJ+SPK+rZpytKVIfU7t4YozOpfes494Ol1CvibZ7pWmHdelIKRgyzjTkzk7c2eL
         87aF4LuVgOa/UYfqsvX5XzevdO3Phv8Q3lEc+XxT41H5hMWTMpnrqWlggyntRnPZ/VFt
         uQtCP/YtVKhZ9ce4IE/oid/0L8A0yLJJHqY0nMK1B6X2qAFOHziH5bxgvWIY+6nAyEyS
         f5RYLY08k7FVYtGMpzZBUTtCGgJZvB8RJVRmu2w6GU+ovUoMAqNPZbkJ1hrl9K4TiLAJ
         955Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qws4wvCB4UWJD9VpnFUtUzuwOKFsR7MZMEGQWCDqwZ4=;
        b=249mJk65zTZA8/KGV2lXc40pBHOPHCbnV7WWEvF0/aWFCs8JZB4iONZ1T2uScSmyne
         a6vrc+WKj3bbWMWvoZAA3Xp2mt+ayZv9n8mmRfeI/Q/olmvpfaEABb4IoycRQL7AL39X
         fmE/36xiIvMGiZWplFRrLt7BQcboKBAIhG3BUTgcHVZMMsIgWZD7k92vl70xnkXmkWHR
         U4uM2aGMJbc4PXg8Xej2WcsaJj/Cg0loY8WJ5noxS/WrdkpDFOgQqFKCy32pN4UhbDRY
         RWbylChpvE5GN5L9YKNF8SN+QnrbsFlF9NUBp/Hzld3R2IJB/hNb9t/uX3lEZY3t5XxA
         2SMw==
X-Gm-Message-State: AOAM530RC+gvMCS2zDikvd28hYupM4bSnqVdxCSc6wdtGByuqFZZODpa
        DCTiXDTRra9I3Mn1GVrWmR3gk5CY+yI=
X-Google-Smtp-Source: ABdhPJzr0qPxVmzQN1CPhaJkSVpzwj57QBYHZoflp2wA3AN/7HHKjz3G+HJxA9J9hBf8GhymTyX1bg==
X-Received: by 2002:a17:902:e5d0:b0:141:cdfe:97d7 with SMTP id u16-20020a170902e5d000b00141cdfe97d7mr24475281plf.65.1638559530427;
        Fri, 03 Dec 2021 11:25:30 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k18sm4341601pfc.155.2021.12.03.11.25.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:25:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: mgmt: Introduce mgmt_alloc_skb and mgmt_send_event_skb
Date:   Fri,  3 Dec 2021 11:25:29 -0800
Message-Id: <20211203192529.2199867-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces mgmt_alloc_skb and mgmt_send_event_skb which are
convenient when building MGMT events that have variable length as the
likes of skb_put_data can be used to insert portion directly on the skb
instead of having to first build an intermediate buffer just to be
copied over the skb.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt_util.c | 54 +++++++++++++++++++++++++++------------
 net/bluetooth/mgmt_util.h |  3 +++
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 83875f2a0604..4774e993d774 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -56,40 +56,60 @@ static struct sk_buff *create_monitor_ctrl_event(__le16 index, u32 cookie,
 	return skb;
 }
 
-int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
-		    void *data, u16 data_len, int flag, struct sock *skip_sk)
+struct sk_buff *mgmt_alloc_skb(unsigned int size)
 {
 	struct sk_buff *skb;
+
+	skb = alloc_skb(sizeof(struct mgmt_hdr) + size, GFP_KERNEL);
+	if (skb)
+		skb_reserve(skb, sizeof(struct mgmt_hdr));
+
+	return skb;
+}
+
+int mgmt_send_event_skb(u16 event, struct hci_dev *hdev, unsigned short channel,
+			struct sk_buff *skb, int flag, struct sock *skip_sk)
+{
 	struct mgmt_hdr *hdr;
+	int len = skb->len;
 
-	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
+	/* Time stamp */
+	__net_timestamp(skb);
 
-	hdr = skb_put(skb, sizeof(*hdr));
+	/* Send just the data, without headers, to the monitor */
+	if (channel == HCI_CHANNEL_CONTROL)
+		hci_send_monitor_ctrl_event(hdev, event, skb->data, skb->len,
+					    skb_get_ktime(skb), flag, skip_sk);
+
+	hdr = skb_push(skb, sizeof(*hdr));
 	hdr->opcode = cpu_to_le16(event);
 	if (hdev)
 		hdr->index = cpu_to_le16(hdev->id);
 	else
 		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
-	hdr->len = cpu_to_le16(data_len);
-
-	if (data)
-		skb_put_data(skb, data, data_len);
-
-	/* Time stamp */
-	__net_timestamp(skb);
+	hdr->len = cpu_to_le16(len);
 
 	hci_send_to_channel(channel, skb, flag, skip_sk);
 
-	if (channel == HCI_CHANNEL_CONTROL)
-		hci_send_monitor_ctrl_event(hdev, event, data, data_len,
-					    skb_get_ktime(skb), flag, skip_sk);
-
 	kfree_skb(skb);
 	return 0;
 }
 
+int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
+		    void *data, u16 data_len, int flag, struct sock *skip_sk)
+{
+	struct sk_buff *skb;
+
+	skb = mgmt_alloc_skb(data_len);
+	if (!skb)
+		return -ENOMEM;
+
+	if (data)
+		skb_put_data(skb, data, data_len);
+
+	return mgmt_send_event_skb(event, hdev, channel, skb, flag, skip_sk);
+}
+
 int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb, *mskb;
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index 63b965eaaaac..9f8692d4ce90 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -32,6 +32,9 @@ struct mgmt_pending_cmd {
 	int (*cmd_complete)(struct mgmt_pending_cmd *cmd, u8 status);
 };
 
+struct sk_buff *mgmt_alloc_skb(unsigned int size);
+int mgmt_send_event_skb(u16 event, struct hci_dev *hdev, unsigned short channel,
+			struct sk_buff *skb, int flag, struct sock *skip_sk);
 int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
 		    void *data, u16 data_len, int flag, struct sock *skip_sk);
 int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status);
-- 
2.33.1

