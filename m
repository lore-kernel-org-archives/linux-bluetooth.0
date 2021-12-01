Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB95C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352034AbhLAS6p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352096AbhLAS6i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:38 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E54C06175D
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:17 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s37so14889240pga.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K0Q/AjPg4LwkcVHvTd078tsJRcQ1xeg7l6PZYQuqunw=;
        b=GulY9miN5zHaBuPhapbniYVH/rgRq4G6ZUHRB70Z+M/tlMcX1cj9VH6NPRZQFjrIB2
         lxMkMtmjUiwMRQYaz+9yeep5ZFZcF15W9p7o0mbUeGtdiTH/oRHDZiVN9OexchIUu6Cp
         Qu0wSvpJhVBS2nc6+5NMbzO6XVj/WsSAtm7BLxWn1IrZJ39uPSMQZg5hu7n9sR8cMh0r
         d09k7KXuB+ZwcS4Oi2IKJqwAeHkXz6z8pYYmYS2TPL6RYKAzBKvwe8gh74uuwtokpgLB
         CSjH9szwt1HTgMxsAaK/lsFPvCT9LlKgHvFoobC7MNDoWzb7So3DTcKSvXfAdwmrcHqW
         Paag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0Q/AjPg4LwkcVHvTd078tsJRcQ1xeg7l6PZYQuqunw=;
        b=JjRvgL+iyxtKcsASSfSXo3HkGtIT5aHff34sUW82KreeX8+zS03XFyflNQPMsCTlGG
         b1tjtr0bhvl6Q5pA0UXdmrMmB4z1mhPORQKGRSWu09kZR/7PfBo4iWv2dSOaCjYI9hG0
         Fyw2p/LPHYFjrMcrpK5r6gN+qV0bCeZ/nB3NJV/uVtjAoQxIwFIsdBP5U94L989fJR6d
         k5HcAdvrt0CR+5rbjijUWyfMVdancbjap04ir/H/UTuH7Byk115Pu9omLbAY+5zygPb+
         mOnTsB2AJiHTULhJGtjfK3nd7iZEZcNAEv+4mDs8LLAp/+I7VKGYKpLpA6DwXJ2pS3B4
         5/Qg==
X-Gm-Message-State: AOAM532L2L9wzq5KWUISJvxP39TpaCy+67ULC++5b5EQm/1Y1AaPbUbk
        NQuSbbVdwWWyW0bcGUB8cDiPISGw9zI=
X-Google-Smtp-Source: ABdhPJwro6PPZ9aE51ZE/cf3RSU66p18Pxzi3RyinpQtlYVz2Hul65JS/oQLBbiuWDoiqo32oPy9ZA==
X-Received: by 2002:a63:b703:: with SMTP id t3mr5988428pgf.393.1638384916196;
        Wed, 01 Dec 2021 10:55:16 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:15 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 11/15] Bluetooth: HCI: Use skb_pull_data to parse LE Direct Advertising Report event
Date:   Wed,  1 Dec 2021 10:55:02 -0800
Message-Id: <20211201185506.1421186-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull_data to check the LE Direct Advertising Report
events received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  7 ++++++-
 net/bluetooth/hci_event.c   | 26 +++++++++++++++++++-------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d3f2da9b2ac2..4343f79bd02c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2500,7 +2500,7 @@ struct hci_ev_le_data_len_change {
 
 #define HCI_EV_LE_DIRECT_ADV_REPORT	0x0B
 struct hci_ev_le_direct_adv_info {
-	__u8	 evt_type;
+	__u8	 type;
 	__u8	 bdaddr_type;
 	bdaddr_t bdaddr;
 	__u8	 direct_addr_type;
@@ -2508,6 +2508,11 @@ struct hci_ev_le_direct_adv_info {
 	__s8	 rssi;
 } __packed;
 
+struct hci_ev_le_direct_adv_report {
+	__u8	 num;
+	struct hci_ev_le_direct_adv_info info[];
+} __packed;
+
 #define HCI_EV_LE_PHY_UPDATE_COMPLETE	0x0c
 struct hci_ev_le_phy_update_complete {
 	__u8  status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 23cfcb1c0ca3..8f21405997d1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6881,19 +6881,31 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	struct hci_ev_le_direct_adv_info *ev = (void *)&skb->data[1];
+	struct hci_ev_le_direct_adv_report *ev;
+	int i;
+
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_DIRECT_ADV_REPORT,
+				sizeof(*ev));
+	if (!ev)
+		return;
 
-	if (!num_reports || skb->len < num_reports * sizeof(*ev) + 1)
+	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_DIRECT_ADV_REPORT,
+				flex_array_size(ev, info, ev->num)))
+		return;
+
+	if (!ev->num)
 		return;
 
 	hci_dev_lock(hdev);
 
-	for (; num_reports; num_reports--, ev++)
-		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
-				   ev->bdaddr_type, &ev->direct_addr,
-				   ev->direct_addr_type, ev->rssi, NULL, 0,
+	for (i = 0; i < ev->num; i++) {
+		struct hci_ev_le_direct_adv_info *info = &ev->info[i];
+
+		process_adv_report(hdev, info->type, &info->bdaddr,
+				   info->bdaddr_type, &info->direct_addr,
+				   info->direct_addr_type, info->rssi, NULL, 0,
 				   false);
+	}
 
 	hci_dev_unlock(hdev);
 }
-- 
2.33.1

