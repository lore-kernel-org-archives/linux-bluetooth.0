Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B69C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Dec 2021 00:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383639AbhLDATK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 19:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359660AbhLDATJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 19:19:09 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04727C061751
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 16:15:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so6124820pjj.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Dec 2021 16:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O8rQs8lkXZ7g7WxJLfX1FduNXZk5lXU85QoseCRnv0g=;
        b=pxM1Bf2rKBR39+mHs1DMbTz3xYFebZpGSUCsIowN2I6TZJimE7uEMTlnTnqBZ3Of/L
         AMsp1kE3eVpP6MH5XvGBiyZXZLaYtNvRqthiPLYy3pjhYRuIP3pRm85clZhUjTnyQirI
         JJZjnbV/NImpYzINFFeXqfijPqEkWXhTq66aNbRK60JC/4lW7sYZQDYr50Lm4RlksD+M
         qIG18doCYpaLn3qrhHLbFsDVPq6hawiUTuxizf3es/cArkAc8haKYljnktaQoL2EY5pt
         oATbQeAfU1kNpnnOOt6rFpeULi9yEwEojpMbCx042WHaJSmQKiJZJNeub/6LxzRWRYVK
         SQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O8rQs8lkXZ7g7WxJLfX1FduNXZk5lXU85QoseCRnv0g=;
        b=WY1D5z/ZenV7bmPZPBGhB7Mesolfv53g0+p05c3Suzajm9suA1v1JTPG4eLr9st6e1
         wSN3vTZAaR6vrzN04o8uPKCahcbGou5ojnNAyJyc3lQrqGzrnG1IHnAeU8F8wSTeD9pk
         FtM5WRQZ82WE4AZRxvIFj7rtzKGOmfykUNMY90jd0bEv73uCTnB5sHRJ70OjsFSW6Eau
         0hm0BbyAkapx+ywLhgxecd8v1tDGtAlvJ+sMhCRLc0dBDTZ70SgfSK/GHhhXIdRXkZIX
         HW8veIOgd4NHrc3Duj1rdqD52KZhE5oEvCh0USYnLqohGjyoFWxvUuh2X01tkE3LgvhY
         u7OA==
X-Gm-Message-State: AOAM532OCYPCJRF8zeURpByTrp0gSxDjhFy56FQq4pMFePHGSfePXfgC
        HmZdBdHgBrbCpKAPZ2AvzmNH03MvDY8=
X-Google-Smtp-Source: ABdhPJxV3lCI6OfeBn3U6NQPIpmIcEtm1xOIrgE5QCpycSRDkBcWiDiNbSw2gEJ1FM2V/FM9Gppj8w==
X-Received: by 2002:a17:90a:a083:: with SMTP id r3mr17704121pjp.55.1638576944177;
        Fri, 03 Dec 2021 16:15:44 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g21sm4381221pfc.95.2021.12.03.16.15.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 16:15:43 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: mgmt: Introduce mgmt_alloc_skb and mgmt_send_event_skb
Date:   Fri,  3 Dec 2021 16:15:40 -0800
Message-Id: <20211204001542.2404778-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/bluetooth.h |  6 +++
 net/bluetooth/mgmt_util.c         | 66 +++++++++++++++++++++++--------
 net/bluetooth/mgmt_util.h         |  4 ++
 3 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 2f31e571f34c..77906832353f 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -390,6 +390,11 @@ struct hci_ctrl {
 	};
 };
 
+struct mgmt_ctrl {
+	struct hci_dev *hdev;
+	u16 opcode;
+};
+
 struct bt_skb_cb {
 	u8 pkt_type;
 	u8 force_active;
@@ -399,6 +404,7 @@ struct bt_skb_cb {
 		struct l2cap_ctrl l2cap;
 		struct sco_ctrl sco;
 		struct hci_ctrl hci;
+		struct mgmt_ctrl mgmt;
 	};
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 83875f2a0604..edee60bbc7b4 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -56,40 +56,72 @@ static struct sk_buff *create_monitor_ctrl_event(__le16 index, u32 cookie,
 	return skb;
 }
 
-int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
-		    void *data, u16 data_len, int flag, struct sock *skip_sk)
+struct sk_buff *mgmt_alloc_skb(struct hci_dev *hdev, u16 opcode,
+			       unsigned int size)
 {
 	struct sk_buff *skb;
-	struct mgmt_hdr *hdr;
 
-	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_KERNEL);
+	skb = alloc_skb(sizeof(struct mgmt_hdr) + size, GFP_KERNEL);
 	if (!skb)
-		return -ENOMEM;
+		return skb;
 
-	hdr = skb_put(skb, sizeof(*hdr));
-	hdr->opcode = cpu_to_le16(event);
-	if (hdev)
-		hdr->index = cpu_to_le16(hdev->id);
-	else
-		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
-	hdr->len = cpu_to_le16(data_len);
+	skb_reserve(skb, sizeof(struct mgmt_hdr));
+	bt_cb(skb)->mgmt.hdev = hdev;
+	bt_cb(skb)->mgmt.opcode = opcode;
 
-	if (data)
-		skb_put_data(skb, data, data_len);
+	return skb;
+}
+
+int mgmt_send_event_skb(unsigned short channel, struct sk_buff *skb, int flag,
+			struct sock *skip_sk)
+{
+	struct hci_dev *hdev;
+	struct mgmt_hdr *hdr;
+	int len = skb->len;
+
+	if (!skb)
+		return -EINVAL;
+
+	hdev = bt_cb(skb)->mgmt.hdev;
 
 	/* Time stamp */
 	__net_timestamp(skb);
 
-	hci_send_to_channel(channel, skb, flag, skip_sk);
-
+	/* Send just the data, without headers, to the monitor */
 	if (channel == HCI_CHANNEL_CONTROL)
-		hci_send_monitor_ctrl_event(hdev, event, data, data_len,
+		hci_send_monitor_ctrl_event(hdev, bt_cb(skb)->mgmt.opcode,
+					    skb->data, skb->len,
 					    skb_get_ktime(skb), flag, skip_sk);
 
+	hdr = skb_push(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(bt_cb(skb)->mgmt.opcode);
+	if (hdev)
+		hdr->index = cpu_to_le16(hdev->id);
+	else
+		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
+	hdr->len = cpu_to_le16(len);
+
+	hci_send_to_channel(channel, skb, flag, skip_sk);
+
 	kfree_skb(skb);
 	return 0;
 }
 
+int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
+		    void *data, u16 data_len, int flag, struct sock *skip_sk)
+{
+	struct sk_buff *skb;
+
+	skb = mgmt_alloc_skb(hdev, event, data_len);
+	if (!skb)
+		return -ENOMEM;
+
+	if (data)
+		skb_put_data(skb, data, data_len);
+
+	return mgmt_send_event_skb(channel, skb, flag, skip_sk);
+}
+
 int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb, *mskb;
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index 63b965eaaaac..98e40395a383 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -32,6 +32,10 @@ struct mgmt_pending_cmd {
 	int (*cmd_complete)(struct mgmt_pending_cmd *cmd, u8 status);
 };
 
+struct sk_buff *mgmt_alloc_skb(struct hci_dev *hdev, u16 opcode,
+			       unsigned int size);
+int mgmt_send_event_skb(unsigned short channel, struct sk_buff *skb, int flag,
+			struct sock *skip_sk);
 int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
 		    void *data, u16 data_len, int flag, struct sock *skip_sk);
 int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status);
-- 
2.33.1

