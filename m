Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC49CCA47B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 22:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiF3WOc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiF3WO2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 18:14:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1EF57232
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so4508395pjl.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A5LrmgTgvCmMiw2D30mRJ2rF8pm0EvvvJb9ByHe153M=;
        b=Pr9ALzC1DIH2vl/ZSP4k6uHtY1/H+zjy8hxj6zEoodNYIIi+2RZkbmP2lcky0bLWt6
         HZB5c/IJyG2jp0hauciATnn9E5ZBdPE2Gz+7nH0+JCzGdvAuUeg20euIdqlWD/5SRUUd
         yoYp0AEIVO9P7Tt1YN+RwXlYWwHNUxqDfjyKgD32j2tvxR0R2Ut203GIF7eycxsJluof
         xWNKtRRwnI1nfb0KFNzlUsSM4fLTc8s7C5p4Q6iEAC2Nd2GzyycJ1M6tmI5mP8AXgkqA
         QjK1Kj+g4f0BToxDZUKZQFz+1/BEADZEulS/kaXJv3cGKOL5KcnQKk4yC3lwLYJZkxrp
         vUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5LrmgTgvCmMiw2D30mRJ2rF8pm0EvvvJb9ByHe153M=;
        b=ZDe2ZUSDmz3I1ZNcbgUkb4LMzjEVyGUpJLUDZxkExaJISFYlmr93D8iy6sBktEh8zr
         5b/NzSD99g7RBPNZSxBC6GQj1YWQhYNXkeT0AVK1PHqdRp9TdZqEXem478C9o9RB9zHG
         aAviwnrQqaDKDMXWRqkkUasj60v7hksLQKKsQK25tb5t/ZXEWfDf3dhnJhbI5S/NpOFX
         VgZ8OGjSNbCxozJuEMHKON6GFmkAYNfPDc4NZ7n6XjMpaFT67KrRTpbC3N64tToScRA8
         thDyiW/dXY+46ta/ZSAWGU0X3PNvPVB5zG1gYgIpNHp1Xop8JmnlgMFZP0BbWirbH0vN
         OWJg==
X-Gm-Message-State: AJIora9EPB7DgNWjaQq5o2nVGdYILgpemj4RHdX/x5ycmf13tpwqTIgy
        JXJN+z/KeSp9VCiPgZ6PHowSkayZ0oA0uQ==
X-Google-Smtp-Source: AGRyM1veaoaPGHHV0YrHI4BEbvKwHdRd+iMqpqh50sFWUxeR19f28gRSjLRuz/DQP0KuRJZzbR0TpA==
X-Received: by 2002:a17:90b:144:b0:1ea:f3a9:5f37 with SMTP id em4-20020a17090b014400b001eaf3a95f37mr14280123pjb.104.1656627266372;
        Thu, 30 Jun 2022 15:14:26 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090a688f00b001eef3f30c74sm2490869pjd.48.2022.06.30.15.14.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:14:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 7/7] Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet
Date:   Thu, 30 Jun 2022 15:14:15 -0700
Message-Id: <20220630221415.638408-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220630221415.638408-1-luiz.dentz@gmail.com>
References: <20220630221415.638408-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix up the packet type if ISO packets are sent over the bulk endpoint.

Note: This is a stopgap since the Bluetooth specification currently
doesn't define any endpoint to transport ISO packets.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 28fbc5837f79..812a046f1b5e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -896,11 +896,21 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 		hci_skb_expect(skb) -= len;
 
 		if (skb->len == HCI_ACL_HDR_SIZE) {
+			__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
 			__le16 dlen = hci_acl_hdr(skb)->dlen;
+			__u8 type;
 
 			/* Complete ACL header */
 			hci_skb_expect(skb) = __le16_to_cpu(dlen);
 
+			/* Detect if ISO packet has been sent over bulk */
+			if (hci_conn_num(data->hdev, ISO_LINK)) {
+				type = hci_conn_lookup_type(data->hdev,
+							    hci_handle(handle));
+				if (type == ISO_LINK)
+					hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
+			}
+
 			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
 				kfree_skb(skb);
 				skb = NULL;
-- 
2.35.3

