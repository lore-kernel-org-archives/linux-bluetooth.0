Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96A4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 23:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386601AbiEEXJs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 19:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386594AbiEEXJo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 19:09:44 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBE55EDC4
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 16:06:04 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id n6so1910444ili.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 May 2022 16:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aaPK0e3xWbCk/gr+fK3J7GSQyesYbC8VHkpcykGAlxI=;
        b=Sxx11aUk8rnnaEYi40RUgePh317fWRrTKDgatwaBG4tZgaMIit0mBN/JdYbM57+tAo
         dh9n/SnGOqcIaX0gO5W/L7joCZH0Fh37hK73f4GLP6Zm4XbR92GfqlOjEBhv3nfUxFt1
         q5h3JTOyS6MLeyBEt7PJhUKhhx70+mXCuVIzqvX6XHP7heicN5o8qonMfMzGWqjuuvRx
         P85F8BImTIOklaIy7BMSNC7JVqpaB/O9FcQJ61y6hm0W9d8TPrxLYvUzAdIIXf0YXg3m
         5WQwxWIPDgy1kjtwwWLMWtHbaeNXrhlsuY6RSm73VHSizE+SAHGa6KWzWlzFf5/rFb99
         Z5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaPK0e3xWbCk/gr+fK3J7GSQyesYbC8VHkpcykGAlxI=;
        b=WCXuTFIlfeX1HZFypPsZEAxlfZOdzxhsQ+UGXcoH5kJWAmx9thJRvbbXS7S2c+gwO5
         LtN18UJ2Xivz9oCld1bThCeeRXn0GPPS/NY34hJCXvxhj2suEcUlxaKpZCpnqXoMY4Ze
         vvX4Q/cAQ6dN/mq7E7SYkkvRVqFsvnHUhFrbELIcuYmfeSrohnVVWenc1HyNb3SN2Hv2
         UWJY21P4ZvQVtRbZjlVjLxseNuQdsep3/brcfpAcbJtf+/sMlWb0rdf+xQOkbAHn7poT
         ns+w9AINM6wAGR6GzS2dJ8+9NaOpjm2+UY8ChRgwXqn7MpDx69ye2q9Cb8wOIP1Fei1U
         q/ng==
X-Gm-Message-State: AOAM5339x6w4iPgc4OiDLbacGt1OU/0U1EIxzMoTVWUeLdTHD1LrUcVM
        1eqFvupjBd3KJTVphdMPbSvO6O1Q5jY=
X-Google-Smtp-Source: ABdhPJzrHgUIPB3o+fX6dY7UON7m/3pznZxFVfCatL7Ue63+jGhqjW4MoL9g2TcZwiwMKPjlxxKmZA==
X-Received: by 2002:a05:6e02:145:b0:2cd:f8ad:dde2 with SMTP id j5-20020a056e02014500b002cdf8addde2mr186764ilr.290.1651791963037;
        Thu, 05 May 2022 16:06:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l10-20020a92d8ca000000b002cde6e352bfsm780757ilo.9.2022.05.05.16.06.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 16:06:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet
Date:   Thu,  5 May 2022 16:05:50 -0700
Message-Id: <20220505230550.3450617-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505230550.3450617-1-luiz.dentz@gmail.com>
References: <20220505230550.3450617-1-luiz.dentz@gmail.com>
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
index a1ee0b20bdf6..0120cd7cc197 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -893,11 +893,21 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
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
2.35.1

