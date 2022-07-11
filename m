Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85F0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jul 2022 23:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiGKXfu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 19:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiGKXfq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 19:35:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24AD2B61D
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 16:35:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so9785231pjr.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 16:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iQYywyf7iBnsNVgDmdxLZWmYH4PU0zg4vQRXr7w8BhQ=;
        b=Sq3LLvZPdAfgEq5B8RH+UPVDZEJ0Dnp7BSPZ4smopctSJV2PUWwdZfiFiToAOfNyBz
         rVAEKPoLOuvmD0pz2Z1bnNkKzWJ8hS1gkH76ASuJdR5pCaFGi69++ww501EARkoUZ5QO
         WDvIk4E3ElC8n/tSKu6Hfv0ysGayyZL67hTM35+zoGFfJnQVDWEstTy7jodEJAWEu6I5
         YKXSgP9nCct8O7RtKbTPrqoksY+jy73TGfam7OJeTHoj5dyeGN2Hejg5dOu7hFGMaAS8
         qOGcqEexaKHhByrrSV6cKiMTWt32DqcL4KrHAhjonYHCBmVkFspoBwEozSeKopCf/uuK
         zfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQYywyf7iBnsNVgDmdxLZWmYH4PU0zg4vQRXr7w8BhQ=;
        b=cD+r3DRjR2hCwPOJ2nvQWqITafVaZGxIls118Z4D6slV0sJwkM/bOd2ww8znc3DC5d
         d7mk+iE1qI3ak21Me9XnJYVQg04Xmbph+72Je5WfCALgrVUPJD8fZsuDsNRLO/B/jl1R
         y7ogMJtvlTrrPla48PpIfwnNjPk55GwXMoi7jOTk+ROZ2tPQQcaSBjKGfAlD/XZutitU
         2UOVOihMGwJLchgfKfq3Xrug5k02rPT9KlY+LmUdOFMP5g+KNdFlkmKLiLGDeSZHgYO8
         RbmTRuuhxr78EfwMHmKe5mSE5Pa1lIh4K44rqNF8himgooHlFlYcGlCZTnNy8HrvRFBB
         s7Xg==
X-Gm-Message-State: AJIora+V6RZPI6nSIqiIJv+TyoXB2ZvD5Qg8Tt0dzRTUY5RO9M0+pq8r
        nIkzq1Js/FpXRI4fL02by9BUfQVVwGI=
X-Google-Smtp-Source: AGRyM1uRpCpbFY6ygHjmwza1E9r5RSoJcjXWpyvPa+/wOKmqwQjZQ/b3O/OnnM4UMTjw/6f4IdszaQ==
X-Received: by 2002:a17:90b:396:b0:1ef:99a4:3737 with SMTP id ga22-20020a17090b039600b001ef99a43737mr931150pjb.106.1657582544572;
        Mon, 11 Jul 2022 16:35:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a17e600b001e33e264fd6sm5446281pja.40.2022.07.11.16.35.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:35:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 6/7] Bluetooth: btusb: Add support for ISO packets
Date:   Mon, 11 Jul 2022 16:35:34 -0700
Message-Id: <20220711233535.3134546-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220711233535.3134546-1-luiz.dentz@gmail.com>
References: <20220711233535.3134546-1-luiz.dentz@gmail.com>
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

