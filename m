Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C8CCA479
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 22:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347641AbiFQWRf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346993AbiFQWRY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 18:17:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F2458E5F
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:17:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d14so1858020pjs.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A5LrmgTgvCmMiw2D30mRJ2rF8pm0EvvvJb9ByHe153M=;
        b=Lsx+nlIHNtXQHRw/XZ255ULH+aCeA4doBL+eofgCYTS+lFryAADl0KHIG77S8B6NMZ
         3omgU6eD0I0U35peZ319o9lHpAXcHtwd+5FCeXcjNV+RygNHGR9Hl7774VAdeoDaOlCl
         UlBt6CtjCCFE6oAd9Y2EAULz8LpFfevD6fz/+89n0Nan2qxGURsu5il5235Pw3Fb5Zg0
         OcmWEdu/hqOBEcgNr0UDGIev20kbyxsbiBwtauri1gDyoz7/aNySsjmAk+/oo2KreqE/
         vtNAokTy2XGpHI8xzzXlX4EQnjDo6wt4fAKZWxkOtUYWvDhXOowMcMNCjaP0j8l0Gh+I
         APTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5LrmgTgvCmMiw2D30mRJ2rF8pm0EvvvJb9ByHe153M=;
        b=Mhu6KlWAPGIRU3QrxlerKEZ6VYRrLN7S6ywMqK4kXhdYhFjt/k8YizvS4JnBzDSmP8
         JkHwxeLtoH23sbWIuYaPAmHi/cvxvfZvry3jTtLrvnyDoTiy8APlEOtPjVmMQ4ZGrzcX
         3LUN8jJZjVDpI1aHhM+rG76all4qyQvbuqasO9Yv4yPMZdaa5814AEviZoFJFtDlWCxF
         o9vxLW4MjIYeXNUKBkkHtpOICCqyjihe3N9oaIibHUq3T2cgq4WaBqZjVwLrWV+RDkgv
         x6XXbfCSMx4N8NLa0/outizOP8F4dRjnDuyB5pzK0AnwwYyeleYmRihK9sUGirI2IMHW
         XESw==
X-Gm-Message-State: AJIora+ysb+m53amWJPaTEUdat9P6iH69/mhY7XeU9AUqi0vf0o9+dJ2
        UI+HWBcLMEOE0WqjMbcohy6yXNhEK9c=
X-Google-Smtp-Source: AGRyM1sP6UnTooJvV0BViYad2LASJBOzFLZCcsutaYOhP5qcwcHcf9sF73CZK8MJMlWfVxlm3Dl9Yg==
X-Received: by 2002:a17:902:c946:b0:167:6e53:6a51 with SMTP id i6-20020a170902c94600b001676e536a51mr11421491pla.70.1655504242050;
        Fri, 17 Jun 2022 15:17:22 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id jc21-20020a17090325d500b0016184e7b013sm4117261plb.36.2022.06.17.15.17.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:17:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 7/7] Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet
Date:   Fri, 17 Jun 2022 15:17:12 -0700
Message-Id: <20220617221712.1394014-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220617221712.1394014-1-luiz.dentz@gmail.com>
References: <20220617221712.1394014-1-luiz.dentz@gmail.com>
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

