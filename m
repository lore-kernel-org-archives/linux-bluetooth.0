Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A83C33CB3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F46207FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tce2ARz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgAOVCi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:02:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32962 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgAOVCh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:02:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so8781696pgk.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 13:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vydUZCINUwkxp1YMuRjgYB6LJk/sgCsjqA2SODaEyGw=;
        b=Tce2ARz+s6uUTcnaGL1jGHhrNER54U+JBJOFbJmzb/60faHFhX0Tm/hCSwi8G4yCUd
         +lSTU92lRUWOR6kUBzoYBIb4FRmvmd3BdTNLBG4kDbXMg1EDCrp81jQwoArQKbcvLF0K
         S1vDj/STRHxhknedq9Z4aSpsri9w4iac2lyWwjNNsOddS+9dNc+wq6sqczPhLzkCoYMO
         WiKT0KAUAxNHbyyz205bE5oCJGKKnsuEZHQ0TuEPE94xCOdhb06BM8kKa48Sv+lCvWAL
         x2h/cqpJ4yhJUXlEcg4QDEBSTm/Ru5oWIXvOIsG5VVsnCgp6IR6WZc9dxq7J792Yn9Qk
         Pr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vydUZCINUwkxp1YMuRjgYB6LJk/sgCsjqA2SODaEyGw=;
        b=VJagMjIJCEUiezG6AsUL9Yo9h8OvuAY+5KEwVssWuaQUHzSQ2pPZZgv1MR3y0mTATU
         g/HiVQIqsdrWASObY4zFntWYMbbw8bovlALbFO5V39QYSnfG17JNj4a/i9Ey+DrTUDgi
         UZ8NW8uoJDbP1h3fvp+6ZLaic8SzyigryxM24B/R6gE+y8junKnbu7jeDheTsrvgH5Rh
         zsDRwSixQR/8+9LPkeDLAWwvT3ygwbG8LP3ChjpepMNvqCsrO3ZkpB1pI5J6sSDg73Gt
         iqQ1paWcGuis5rur9UJ6Q4el5Uzjz8m7qqYSJv1d161N9TQ+rB4voot7FF9jY0ugyPIL
         EHFQ==
X-Gm-Message-State: APjAAAUVdE5CuJeuxABjaL7uQsO92XqKWndEacOF2zAncBlJpNJghmWB
        oczWUrNJxicvVXdtdmNZlNnHNxyTbTc=
X-Google-Smtp-Source: APXvYqz0BOCsbjMii9sen2zxzlbwXxkh0doML+3CJOFoyuRlqzJH0sAGbPHCxfEfY8ngET/U22yK9Q==
X-Received: by 2002:a63:ff52:: with SMTP id s18mr35762812pgk.253.1579122156928;
        Wed, 15 Jan 2020 13:02:36 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.41])
        by smtp.gmail.com with ESMTPSA id s24sm23290976pfd.161.2020.01.15.13.02.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 13:02:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 11/11] Bluetooth: btsdio: Check for valid packet type
Date:   Wed, 15 Jan 2020 13:02:21 -0800
Message-Id: <20200115210221.13096-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115210221.13096-1-luiz.dentz@gmail.com>
References: <20200115210221.13096-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Check for valid packet type before calling hci_recv_frame which is
inline with what other drivers are doing.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btsdio.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index fd9571d5fdac..199e8f7d426d 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -145,11 +145,20 @@ static int btsdio_rx_packet(struct btsdio_data *data)
 
 	data->hdev->stat.byte_rx += len;
 
-	hci_skb_pkt_type(skb) = hdr[3];
-
-	err = hci_recv_frame(data->hdev, skb);
-	if (err < 0)
-		return err;
+	switch (hdr[3]) {
+	case HCI_EVENT_PKT:
+	case HCI_ACLDATA_PKT:
+	case HCI_SCODATA_PKT:
+	case HCI_ISODATA_PKT:
+		hci_skb_pkt_type(skb) = hdr[3];
+		err = hci_recv_frame(data->hdev, skb);
+		if (err < 0)
+			return err;
+		break;
+	default:
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	sdio_writeb(data->func, 0x00, REG_PC_RRT, NULL);
 
-- 
2.21.0

