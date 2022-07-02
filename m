Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E448CCA480
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jul 2022 00:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiGBASC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 20:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiGBASA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 20:18:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9543981A
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 17:17:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w1-20020a17090a6b8100b001ef26ab992bso4244447pjj.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 17:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iQYywyf7iBnsNVgDmdxLZWmYH4PU0zg4vQRXr7w8BhQ=;
        b=StOfqnXpMBCeX9MLd62RrA5zp8EMsK+tonCTtsSe00z8CLWo01DowR+uWWjJer3OYZ
         sOG1U+RCNmVGiX7q4QcuZIf8Aj6qy0Hco1M5ed+E9K3Fgt+BOAOU/STEuk66NB5wwLQB
         qxlHGxN88XyMCM9+31XwbEC2FBRHHQJFPvqpdiA97QYlj8JUqjZpm/+/uLZs2nwt+fWn
         rdzEorIx2zd6E/cuNiHdA1d3+D5dBOdjteKsNyk+slUpAVy8iHvwBjgPMfrYaNScrdOr
         ocQZKaeJbeRNtxMRERaemRuuQmmLx+X4Gtb9kFMiue+zGUlWpT8gdqOv0Ab5AuGZM4eh
         emyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQYywyf7iBnsNVgDmdxLZWmYH4PU0zg4vQRXr7w8BhQ=;
        b=Zo++4LyJnmryWV/7IIhuSiCrfIP+/Dp2ZPgdEk1HyoZnuQihkw5Fma7ITwn7tSF9h3
         JuP9fO+A8rbwevGvT91Xo0iK9WAikNmhTxU74fYavu+LWT23Hdvz0EFIXCrY6VXJdHOJ
         LiMIQ+ydLClf7oO2RUoWf51xRpDy5tgoyAitMdGO0g4w4amHhkQWFQemdcMCykgHMmG1
         wBmEIprOQeh4ChXsfqpU4txbMykinp7vQ4SeeEwIYQi8294giKNHMXSK4rEXC1JJ/IpU
         n69JV6TE7XedoEr8A+USHjbmzW0wG2lZKygpHzZGVhdPPyZ2/RDCIm95Pq7/LrNHBxt1
         YCjg==
X-Gm-Message-State: AJIora+XjWpT25lMhGa0A5eGGYkv6Mzry3y2HR6VjqE7WeUV/gd2ioPU
        cJ4NjNQ0DklT42cVQfT+z2QORMvHQUs=
X-Google-Smtp-Source: AGRyM1tj0M4jSlP9tgKV0aIbBWx+vhMmXfLjMuM/vBbjqWN5Qb5xJboO5Z1VK1mAdPeTMB7Za3gVTw==
X-Received: by 2002:a17:903:22cd:b0:16a:7492:1fa with SMTP id y13-20020a17090322cd00b0016a749201famr24384569plg.59.1656721077535;
        Fri, 01 Jul 2022 17:17:57 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0052089e1b88esm16219667pfe.192.2022.07.01.17.17.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 17:17:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 6/7] Bluetooth: btusb: Add support for ISO packets
Date:   Fri,  1 Jul 2022 17:17:47 -0700
Message-Id: <20220702001748.1003783-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220702001748.1003783-1-luiz.dentz@gmail.com>
References: <20220702001748.1003783-1-luiz.dentz@gmail.com>
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

