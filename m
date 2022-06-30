Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2276CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 22:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiF3WOb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiF3WO2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 18:14:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97304D175
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so4577237pjr.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iQYywyf7iBnsNVgDmdxLZWmYH4PU0zg4vQRXr7w8BhQ=;
        b=Mion408MRlZl4NQryArSF9CBvY1NvfSbJIdPJ6XEoT0vmZxkH7xzdmjMMB9tkZmkyI
         prj0IOOxWUoPLsunPNLwyPPrGbYNzcZIvkpLui+eC7OlS6wgGS9rrU1Fmgu+N6kquusT
         xjhN4nBswPS+gCOPr8HUh8TAm31YBIXmX4gwUBuuHT1wp2C2CY4gQD5heHm1x+JLCZ3C
         rwxb6OsI3wwVl5iN/snDnoraTDYaco+Y38RidQNHz0mYU9HMTKOXedp9HXhLdZoJ9Tdr
         qdOxVhg+nmZF/K9DLLiwJ9lF7xAuRBxT0W1uhsRFIk0ojD9QqKc8kE++A5Mqtv2TyU34
         hgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQYywyf7iBnsNVgDmdxLZWmYH4PU0zg4vQRXr7w8BhQ=;
        b=kCTgvvRnWvOPMuLtBzz4gJyxJTmQZmI2/k6Bjditdj9nYIrbXQ3yLtaCQSR5huKS5C
         iYl/mpbI/zdSDoyIRW26f5H1tDbpNnV0N0/IAh/gEgL23KfboERy99SMHeZKql/DvlhT
         CUi/oe+l9y5WlEBg5G2a7i/tlWx94Ewt3vLdAh4JOUYAESioGk3oBcOEkj3SsO0wGVnp
         PYXm8yD0Nr+pKH7SwqgwzW/MV7Wn84x13L21GT0ExG+5oyCBVJU7MWpSL2t7UPuZObL7
         Q3ZWewDEFleiUQGv0xHFw+w+9GP1m0tkNxJZxkFctFCr1BdxkhUMpCE8brawxPwvTkZy
         39Aw==
X-Gm-Message-State: AJIora9cs8ZSzkAYPQ6GdGpjt7uhHnc/DR/wm6kdSn4voA5CLl+9jtiW
        PEAT2M+okp5Ivu8FEB4j11glVkYnROWT3g==
X-Google-Smtp-Source: AGRyM1sz/oQcIZIYZ4tQx4qCHM0KlLJCru9BigVkoDSRTfuQXp1ntVwT04t01I2Wut/jzOisCWohMg==
X-Received: by 2002:a17:90b:4c4e:b0:1ec:bc42:47c2 with SMTP id np14-20020a17090b4c4e00b001ecbc4247c2mr13885432pjb.180.1656627264767;
        Thu, 30 Jun 2022 15:14:24 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090a688f00b001eef3f30c74sm2490869pjd.48.2022.06.30.15.14.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:14:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 6/7] Bluetooth: btusb: Add support for ISO packets
Date:   Thu, 30 Jun 2022 15:14:14 -0700
Message-Id: <20220630221415.638408-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220630221415.638408-1-luiz.dentz@gmail.com>
References: <20220630221415.638408-1-luiz.dentz@gmail.com>
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

