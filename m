Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6F8C43217
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444627AbiEFWBk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444634AbiEFWBi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:01:38 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8510124F09
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 14:57:54 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z26so9483840iot.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aaPK0e3xWbCk/gr+fK3J7GSQyesYbC8VHkpcykGAlxI=;
        b=SQFKmup1GeA7LLqhPgjXFFT0fwfmV34Du0E2D2hf0G6ik0V3qPCCeithOc/ETUrFVy
         sWihSc8wT4G19b5evlDUvqhW9epznMXe+o9yzVZlm6IYGQglnXAhDr+7G51XTjl5CS8w
         OmGKGsGHAnEE8LXQbNClBn5UepMZlT5BANijceC8eyJ5X57o/upisD5RXkUQ5z7Q/tZV
         uQI6/xNNqIqxsyGJ9qD3jXavrQCP8NK5sUkFGENEhUpa0pP3XdXoNCymF0aHCOjjumjr
         UdfsoY3NUhoPPiJcP3Q5K4oyKe7k2DR4ZbvSlGWjMq8acwwsl8bRkWk33PInTWmoTrPT
         Njew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaPK0e3xWbCk/gr+fK3J7GSQyesYbC8VHkpcykGAlxI=;
        b=srnJjfLHCsnvQK7Kc5fK9mB8xH5k1b4tpwPQ4/Ep5FVEubrdu31L7PFue11jRlnS+s
         l7ltqDzEHa9Qoi+sC4ukHoQFqGzp86nl3xBcYh2Vo02G+lISw5KKvkS3HgsrN72v1OHk
         7u8Vo3IJZi5ys1av49Mm8QQAxP8EXwU/HHcIZjnB+6s9ZgVLgPLu9lrCLf073biMISg0
         AvakTjHuz5eaonsW289JjLsG3GidmaZDya9t2sB1qu1ddbWnWarv1m2pjBXRPnMOWeZq
         rx8iIDd7Z+XVcWGm1vkJ88Dy1g9iH2KtdV7pysWhZoOpcj/nx8IbiwYnUCYoxTAs+RHj
         NSRA==
X-Gm-Message-State: AOAM532YzYNxIXtZWf5bEK2w3Hv4HBdVtWYc8UpaEXPAPcjxRSV5tXUa
        JXD9hePJJU/qbD5cFHm3b+4UG8odNUE=
X-Google-Smtp-Source: ABdhPJzSeMB9SDVIkom8rlE76uEhIczDPFgb11W4X/eLcfWYf/MFj/j+wQzaojZ1cK1YAj7nvmqF1Q==
X-Received: by 2002:a02:950c:0:b0:323:918d:a98f with SMTP id y12-20020a02950c000000b00323918da98fmr2247686jah.190.1651874273690;
        Fri, 06 May 2022 14:57:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s14-20020a5e980e000000b0065aab053448sm1572281ioj.21.2022.05.06.14.57.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 14:57:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 8/8] Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet
Date:   Fri,  6 May 2022 14:57:43 -0700
Message-Id: <20220506215743.3870212-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506215743.3870212-1-luiz.dentz@gmail.com>
References: <20220506215743.3870212-1-luiz.dentz@gmail.com>
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

