Return-Path: <SRS0=d6qz=3A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11DCC33CA2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40322072E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGzWpajt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgAKCWb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 21:22:31 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56211 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgAKCWa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 21:22:30 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so1711602pjz.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 18:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=021TzVmd1leXiV66J7GnIXC047OEsAiKPHYKND4BrLU=;
        b=OGzWpajtwliHTgIRZdM4qRxfW0/n5GDt+mXe7rCjyMjMgKwudBNaQPtoZh+7iFEXTo
         Pmt7wSRGxb7PslmhGJAPXEKkwZcmoMG39YnZii9O+SLVJpH8Y/vDjw6xNYdih4CH2fNN
         A+oLjkvENfu198xqr51wdYi/pw/5g0Ihm56nh26USeGqcS1UZ8KpGYDganLETQxDOX4P
         6896qOxwdRJjJb21HCqAbZJt7Fs/IP0uE4fszn+ECbICjso9ifuSlAZk3HCNUvM6etcA
         u5uqtyWR1VdKbKPA8/nmTs9+hUkoHX/q1bNyPCkeneVnsEKL0ubwSx+Rkl46cImf7pw+
         UoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=021TzVmd1leXiV66J7GnIXC047OEsAiKPHYKND4BrLU=;
        b=Q5qbr4YP/RhfI+Lhcs2UqSSsBHFV136TqQDwfulaAAtBkqTZOpau5rl5xbhRk+lzj4
         fc4DO6W6VhS6nJgCYaY76+fMs+V1nA3Diy2UpHpAkR+x0ExUxolN1Hmqh0r51uwHY+zX
         pFxJFrvlv01UpgmE0NYWgOKKGH924DGNHqWpyYMR6vdijOjZxsupw6JR7w6tFFiIOcek
         zQZSMW7TP4hmVKJiqFROo1cmv53eAQl2ZFybmtc7tYHh/8FeFRBBQwJ0106Ro11qvCGF
         3kpUcZPmrPVd7y7q7YVXfIqP6d+gEH830aOh3TQNPxz6fxZ08F1JtHAR7102BxCVFImM
         z/Cw==
X-Gm-Message-State: APjAAAXIN10wSbVbt2QrFDHIz1kOvNcBhaQw8fDeHltxMKb6Ee0Aturl
        jA1lmErU6yrfCZoWR696coYfUQV+iaU=
X-Google-Smtp-Source: APXvYqxTYWgJOQEChaNjZ6CZlsidafdZO1G0eVN5CMj4ou+GOTbfaxYA1IjRqpt2cH/KJp8lQlQK/g==
X-Received: by 2002:a17:90a:c691:: with SMTP id n17mr8920112pjt.41.1578709349768;
        Fri, 10 Jan 2020 18:22:29 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id g22sm4158906pgk.85.2020.01.10.18.22.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 18:22:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/10] Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet
Date:   Fri, 10 Jan 2020 18:22:16 -0800
Message-Id: <20200111022216.30842-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200111022216.30842-1-luiz.dentz@gmail.com>
References: <20200111022216.30842-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix up the packet type if ISO packets are sent over the bulk endpoint.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ded0ba83bcce..4b5172c785ce 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -663,11 +663,21 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
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
2.21.0

