Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A6BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 21:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE09A22A85
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 21:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgLUVnE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLUVnD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 16:43:03 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B8C061282
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 13:42:23 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t22so7222392pfl.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 13:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xPW0IWCDTvcXrc/0a2IJ4gxxXoSbfdlXelh09ep8QY8=;
        b=QLFy4sG6kdxcfoNMPaZQk7Xr5tSvLMP6nSYFx98UXWaeUU3/lhGblKbcSjEvyprUeg
         5fK6iurOldoH7jL/XJVARV6ggvmxj/Sld4dwSH360SQDQvvFBBodQXLQAEKe9UCaNdkk
         eT1bC4sFwtpOxqAvcwCVUlVFkaY7Tfi3wJJjqFyOF6b5oLj6BcqhMaFYofaC6Wlp5rdF
         n4EjqRwLEFKsoB5BQX6TXkaaggfCJ+Ro7BCzhkpaBUaAhyqyrRh2P1grpEqWHhAsFLxR
         9QvytRU3zpNhh6HITj8CMELN+wSjcSYn7Xwz/jdQZ8S5hRsrMoYzMmLlMFqqd0sl2/wB
         96OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPW0IWCDTvcXrc/0a2IJ4gxxXoSbfdlXelh09ep8QY8=;
        b=LdKrnPrAA2AMsKW+QFPF8vfwTJOVp64Y2blzmRICu9k3DWwH29a+Wybf2XZ0ut8m8u
         Z7KzKdtofudd/ozPV0I7dsl8LseHUqPjTrHwsRF4xF1SjPT7/Bmju/QfO+PCaiB7azGk
         /hvYZVHTyI5gEUqYJ3dA46NI8H2ig4dVTrr3Jcr8eNeUl0xOaV1mPG+7aOQ/8UKgoplR
         TNUsb4Of+fYGtZLEt0akSt0kOM0IyxWbuNHp7f2e5aoiCNHpCXJMOObZzySpG9Xft+YG
         e87GHZeVb5g8jIwLbRItWVE7hAZidPzfjyRrmqIONR+WOUC3K0APXFi5wCPyJ3bzWDI2
         ffNA==
X-Gm-Message-State: AOAM5328kCfrSUbTxbPNDkmh3Vgz39GjuyZ6QTGhtgsFZn6JkJVPOMR2
        6nuTSlvhRuqJcZX8xmfWzludrAL+lm0=
X-Google-Smtp-Source: ABdhPJz2oKCuXJYICdvnY0LJGTZFw0h+q+U2G8/mjygXmepVb6a/llKvMGjkebywVLah+SV8QQGwrg==
X-Received: by 2002:a05:6a00:795:b029:19e:28de:e92a with SMTP id g21-20020a056a000795b029019e28dee92amr16761969pfu.36.1608586942521;
        Mon, 21 Dec 2020 13:42:22 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 14sm17074840pjm.21.2020.12.21.13.42.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 13:42:21 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: btusb: Add support for ISO packets
Date:   Mon, 21 Dec 2020 13:42:17 -0800
Message-Id: <20201221214217.2093485-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201221214217.2093485-1-luiz.dentz@gmail.com>
References: <20201221214217.2093485-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enabled btusb driver to properly transmit ISO packets.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b630a1d54c02..ffd262a2add1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1587,6 +1587,13 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 		hdev->stat.sco_tx++;
 		return submit_tx_urb(hdev, urb);
+
+	case HCI_ISODATA_PKT:
+		urb = alloc_bulk_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(urb);
+
+		return submit_or_queue_tx_urb(hdev, urb);
 	}
 
 	return -EILSEQ;
@@ -2393,6 +2400,13 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
 		hdev->stat.sco_tx++;
 		return submit_tx_urb(hdev, urb);
+
+	case HCI_ISODATA_PKT:
+		urb = alloc_bulk_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(urb);
+
+		return submit_or_queue_tx_urb(hdev, urb);
 	}
 
 	return -EILSEQ;
-- 
2.26.2

