Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227DFCCA47F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jul 2022 00:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiGBASB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 20:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiGBASA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 20:18:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A049538D87
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 17:17:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w24so4066982pjg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 17:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A5LrmgTgvCmMiw2D30mRJ2rF8pm0EvvvJb9ByHe153M=;
        b=AbXouwiweSHpC8OUpyxHlE/mEiVWLWAUZRXehzhvqLQaq+0lWyegSpLPztukxaB0D1
         vnyT5EgURuVKRwG2L0DkpKYdac3kQxETEtmb7MDyLTbzdEBElCaa03qAHgUQGeVvMYz0
         xfkan0bt3s6dnqcDexkOMbv3rNqUGvnXjujpWeH6godb57yey65oxp74z3lgBulv3VSe
         5y4aLnE7iFWe1Sno8Yguxg8zGi14xkGEWzXCHukKlqXwZfGlgh7j8lfTzBYiIYCgatix
         GArK7yOpHX8QiT9Uego76AY6YFjh9BnnLQJFHFSUPJ+A/VXfEMeuWxbNulK238FthX5c
         Xz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5LrmgTgvCmMiw2D30mRJ2rF8pm0EvvvJb9ByHe153M=;
        b=h9PHhjyOsRlOgvxSqy+DDgEtC1Ejme2EV6zuEvet15HLr8/hZ2S2jHjRmU1hZe1ay/
         XT7MvwiPs9gZJFxA6ZeHx2SE7DRsSgvlbDrPK1SmKpk2Btejsu65QlOHBkS5rsanSfm4
         PsQuguCaX5or7zYS+k5d8S82laTDyyxB5Vaz9i8PzVGlAFTkX8ThOnRViqdW5SXxVZdv
         l6OXmoOSJywPf4OKyF0S0jaMcHPdtJ7AhMSevRrXT+oJBlY2vdhjurNpLKvsmpjPhfol
         Oo7S4kgSd6wn/pLMPbR+jC1vqvVSDL6AU8DWYwwliFARpP9x9B8yWlmfNe5ynY7hKwkc
         Yuug==
X-Gm-Message-State: AJIora9jDBxytH4AgOZUXOViJeLS4ohSMuA+3dFEkdP8GIo24Egpt5Gu
        DhB4aoq+lpr38itCL1fYy7BiMDw6LMU=
X-Google-Smtp-Source: AGRyM1uUOd8bXTUq0JmSv4iBsVB//HcG4gxweVXUZlZJlyo1A69wMJeu6/0YNPhBrL2lL1PVaToyXQ==
X-Received: by 2002:a17:902:cf06:b0:16b:cc33:5bce with SMTP id i6-20020a170902cf0600b0016bcc335bcemr984339plg.152.1656721078661;
        Fri, 01 Jul 2022 17:17:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0052089e1b88esm16219667pfe.192.2022.07.01.17.17.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 17:17:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 7/7] Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet
Date:   Fri,  1 Jul 2022 17:17:48 -0700
Message-Id: <20220702001748.1003783-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220702001748.1003783-1-luiz.dentz@gmail.com>
References: <20220702001748.1003783-1-luiz.dentz@gmail.com>
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

