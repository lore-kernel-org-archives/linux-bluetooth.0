Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD7DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 21:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444638AbiEFWBj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444629AbiEFWBh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:01:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCFF3A1A1
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 14:57:53 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id f4so9487622iov.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JBpgrjNMgWpTskmRnE/wkrvDdfqnLyxeNkic0pV8L7U=;
        b=Gg8V/ahnd4/+llBu90pfvk+erWzcNnLTSLXwkuAQEWuKL+K6XjHiyZmgYG9Lee41JV
         qxnRG3vmb5buKe1aGw9qQP9Q1ulUwPL6Ffmpk027lGkOcTOsTwD/z3sqhPUJeNINirrf
         xhMeCI/3BLp4zlauI5njpZXGXEA+gM8nrpPxj7YCaK+QAlpZ+0C0dj4ZcXuKVblp3zTW
         7y3XHZ7o5tA28q/1InfFUBEKsLZqCiNpu5Ag5w4F3TJ4JMYMGEL8DWJclJbuq4GSZVYL
         hKpkla7+KrV2doz8ioH28SVc5/CTuLlZ98brO98Qy475XCWieV62ub8a8uxmub6LT5Xr
         9HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBpgrjNMgWpTskmRnE/wkrvDdfqnLyxeNkic0pV8L7U=;
        b=EOD8Z068bUpDSwsl3NYRXsvKBqD+RA3EPpkBQyhPVXoMyHpydjC1pRzpT+kuidvB3y
         EwOM4zHPZYq7J7bGgZzly3gcN6nVFIV9xXcfwDxKCxMFLgSzdsCVHwjx6DuJRH3c8cMb
         spGMDSWVFaXnVJSJ6D86DeQzrzmgGU3t40t8cdLBicMgK0GowG0Jjky+IBupT0mgff+x
         FC0aRwU4pDyRkl2U1FcxP0l9B75oi2R2V/VwXPCBzj4O65nT4zUCh3iLyx1fcXQaUo/x
         ivo3b59nOLRX4dh0RD2DG/x3P45AIYEsNkMEmMC8fxpmejHgYk6zNxI7ntWAaE+/CeEk
         fI2A==
X-Gm-Message-State: AOAM531UOnx0j9W/iu+XSjsTn7dsRZjNkE4x8ClnrcWuaw84+ptNMBFY
        t4Bz0lbgu6D7e86Ii18KMz47HPmFn9w=
X-Google-Smtp-Source: ABdhPJxEzqKWQxiVjTi65C+Ncwa4JGFPBU3GPKkq/5aKejCrjDGrjDXnrPcxGunPskazIRMBSiJTAw==
X-Received: by 2002:a05:6638:168f:b0:323:e2d5:878b with SMTP id f15-20020a056638168f00b00323e2d5878bmr2390032jat.95.1651874272528;
        Fri, 06 May 2022 14:57:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s14-20020a5e980e000000b0065aab053448sm1572281ioj.21.2022.05.06.14.57.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 14:57:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/8] Bluetooth: btusb: Add support for ISO packets
Date:   Fri,  6 May 2022 14:57:42 -0700
Message-Id: <20220506215743.3870212-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506215743.3870212-1-luiz.dentz@gmail.com>
References: <20220506215743.3870212-1-luiz.dentz@gmail.com>
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
index e25fcd49db70..a1ee0b20bdf6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1762,6 +1762,13 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -2255,6 +2262,13 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
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
2.35.1

