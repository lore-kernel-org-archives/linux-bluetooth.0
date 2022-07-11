Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BFCCCA47B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jul 2022 23:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiGKXfx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 19:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiGKXfr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 19:35:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD87B2B626
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 16:35:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d10so6036244pfd.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A5LrmgTgvCmMiw2D30mRJ2rF8pm0EvvvJb9ByHe153M=;
        b=ClixVJyoGzzxwLRfWfVxGbAGPbyes9Ec8tdYdV8F+p0L9bwzxJi8O8b4/0izO8wpqV
         AWhD2lxeEYCv1iP++ZwvQr8QSVYtwci3UvJvkUORmMG1UuSeB/0Yo93Kq45XR9F1OHov
         MqpyWs19QMyWdijfTUpDt8FNvaDBHu3eA6skkMewW/guCqiIxjLwM+ZyLvURVfQBNxj0
         Vy98hYnF/YhUvjHbN/eST+/s82hSaqh+ruKWpI3UHJ0m1bQHkoMlq6O/HF3W8pukQDgA
         SqhfQZ3vPvEXSkfShrM0P61onGJLYfyma63dLElDuz/aIZIEPYTUuap/BK1p6dVL0Smd
         qp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5LrmgTgvCmMiw2D30mRJ2rF8pm0EvvvJb9ByHe153M=;
        b=wBx/WtY0wDdDg1J28ZrY9PC0q98aYPuEkOdzBPnJW3ji9Z9k8XZZIci32yRnA02ANW
         YlpQ46D5ipHeq8Zgo7/Ak4u1nmlvQjZZLSpeNPaozWPv2W4kxEfMst6ampLP34vP0JrV
         qovPwrc630JQ+XW8zmEdwN1/9zH/F9qdawA6IjZ1hL1aeC14mZFe8MWt+IrDrc4oaAY6
         mDZ8zIrrBjSzAhnb5l6CH8HX9UQvOpdLz5/5cQn7P5gbxNUTXVoxXbnAWTDFJfeptiYY
         cNmsp7jNkJbx9kubhdGIKL4Ovcq9AoCLNsA1JIWDygQCzGtiylG6uy28xjp/1ZxVhJQu
         6KyQ==
X-Gm-Message-State: AJIora8z91o5DMmq/JecpyWMQh05XDVyRessbsVU1oHN6MFvdIeOTIw4
        uZztXNfUfE4Eqv2nI8xi2TGl5bgV4v8=
X-Google-Smtp-Source: AGRyM1v3nGs1BcB8ohwoR1AUm2Hqr278FaBElr7S+CoSGTPYQrZvyHk08XOwF6rUyBi3he51hYKkoA==
X-Received: by 2002:a63:b144:0:b0:40c:e240:5e05 with SMTP id g4-20020a63b144000000b0040ce2405e05mr18410753pgp.276.1657582545857;
        Mon, 11 Jul 2022 16:35:45 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a17e600b001e33e264fd6sm5446281pja.40.2022.07.11.16.35.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:35:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 7/7] Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet
Date:   Mon, 11 Jul 2022 16:35:35 -0700
Message-Id: <20220711233535.3134546-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220711233535.3134546-1-luiz.dentz@gmail.com>
References: <20220711233535.3134546-1-luiz.dentz@gmail.com>
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

