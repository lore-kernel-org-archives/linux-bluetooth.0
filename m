Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25963C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 23:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiGAXhL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 19:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiGAXhK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 19:37:10 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E827538BEA
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 16:37:07 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r133so3682907iod.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iQYywyf7iBnsNVgDmdxLZWmYH4PU0zg4vQRXr7w8BhQ=;
        b=bq09jRV1NK5FtkRwg6/6ourTh9hrzwrB++tRi/65c9NE+srXdZBzZKslMzVk4vRx2o
         1aOns7uQr2OhH0OW6RfoV5L4PNsnyrXGPujaJyRmcLuUH4A2aq2qHwoPFn6rZsw9NCqg
         rC/yp0hEa2/6E526msPgQdsK1oaX1ewLVfHzqu1Uum/UVHxSAZVoF47wIHSnTiV9Fvq6
         AGRW2Zf55mEp6rNoM+5qw76hU7WTlkbffV4WhY6679Ea1CSI19GY0tLoSVTMWh5Y+JSm
         KL0A+bhTLEuo1P/dKrtSi4lfm7gPQ6D73h+PpTEa2jXf0rSDLFL0iK83zre44jtYL1oi
         Wj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQYywyf7iBnsNVgDmdxLZWmYH4PU0zg4vQRXr7w8BhQ=;
        b=fNSvsSAJ074i9vf0N/XOw18k7T2PiXsaFj+cgiJTi/MWlueXreq6kSAd/m96fDlYj0
         kobCFxMSiErW4jD/sr1qRJHE2NiDvuWo/FkyR0ejD88ttTHaz0wqj0dcFMZhIy3OtBA+
         RSMS6eT7zj22DPXZEnNnuaeMVRPeNMlzo0Lr7rPz0ZFh9lZ3gtm9ua8FCiFjRabwdOcx
         lBcxBpyN+16IHBvirvSfmir43yceIfvN3Rzv3lhD3q7GJOayYRh1dQd0/9gghyGNIkCk
         f1x3KepzYWQyACS38ui0MsAkw9gLS5mKIPikdOCwGk6JMbzupq/acdLeaFm25UALFN/T
         n6XQ==
X-Gm-Message-State: AJIora8AFauG67heToB/W3F+Y74S1L9nDzj+IJvss83HJFm0MQUhTduh
        y6O11pPR/NZeFWFeEg+Y8VI8tOwzQQA=
X-Google-Smtp-Source: AGRyM1t0qfih9Jc56QeiOsnJnOxijDgQh9BPIBD/6Dp2bPJYgCdzKIHZVlk38sCvN3cWd7IU+l06LA==
X-Received: by 2002:a05:6638:22cf:b0:33b:fd4a:122b with SMTP id j15-20020a05663822cf00b0033bfd4a122bmr10173001jat.244.1656718626878;
        Fri, 01 Jul 2022 16:37:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p70-20020a022949000000b00339d2cd8da1sm10312154jap.152.2022.07.01.16.37.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 16:37:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 6/7] Bluetooth: btusb: Add support for ISO packets
Date:   Fri,  1 Jul 2022 16:36:57 -0700
Message-Id: <20220701233658.966972-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701233658.966972-1-luiz.dentz@gmail.com>
References: <20220701233658.966972-1-luiz.dentz@gmail.com>
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
index fb1a67189412..28fbc5837f79 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1765,6 +1765,13 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -2258,6 +2265,13 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
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
2.35.3

