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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCB5C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB3E207FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXSSsV8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgAOVCf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:02:35 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41083 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgAOVCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:02:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id f14so40004plr.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 13:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/0l7XUV8UWV7OGtRGpnQ/sdmhdQTT9hpq4idu/sT62U=;
        b=VXSSsV8fevgtxDrfW7N0ckHDEbzO47NisZPOi77RErO7FEjvS3MCbMkNJTOhkiTnCC
         jRR3w5akkSyLgXQ40whgt9cCnYZDCCimerkEdj+jLBFteEQggi7H2Imr3GQylyS+Gsd4
         A7aLsn+jVkN4+bIYmDt0pa99eJMFvBg/4AAjt39vxX00idZhXiNBgv4W6ifZjU3hgh87
         DAI5+4DbUS8OySWNGnXU6iXNe0eG43pnnfIKa6htGMXYTz6LsshW/LUI8Ai2b+eNnEGi
         YpMZgtjVQiuBNyJ0xzXnIdsDXJwBLCWQmLsivPuVI2vqhN8K6OGDwB8MHRPLuHzvnHGt
         6Zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0l7XUV8UWV7OGtRGpnQ/sdmhdQTT9hpq4idu/sT62U=;
        b=n20ukAamRRuAlO2N7GL3QTOAMwYBYjWYm/xh/Q8jGoOpxYFZU7JiJWmUYxhkWtx/Tk
         u3sc8BgBwHF2T/R6tuqPzDX1erWSx+0dDwP1mSBRqpx6c+h+DJqiMmuZYvyH2ja1/Jwx
         SzXs7+Z3NbYelMtnP0PkwYtDeZfS/yhVmKPmpTfRwEg7T6sVoPf8MgQ4cTnIW7tEeigg
         AAXie+CPQgmBuYDs9e8kS0P9IYoRHcqQLCtusFDONaT7dgTsT0VSA+rRrMmv7atlnm01
         9jzP9e5C6mtswIor/4W5W0KqDeuEDyeNYdevHGw74Dm/74gon6/zoRJK9I7xzSresXIT
         yulw==
X-Gm-Message-State: APjAAAV6UTBFIp3nuGdzW9K2EM6ZeOsLCvgwCizY/J+WGe4lqzPIDwQf
        FouiVAklZS7C1ruyhr1DFNhCrSA8suw=
X-Google-Smtp-Source: APXvYqwiHGRGeiEiwbmBMrrPkKcrpkCsN5aFLZ0YCQ/Agt22Z3yqXjEXS3A5V+KjUWRjyqmZ5J9Qqg==
X-Received: by 2002:a17:902:b407:: with SMTP id x7mr10455474plr.301.1579122154212;
        Wed, 15 Jan 2020 13:02:34 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.41])
        by smtp.gmail.com with ESMTPSA id s24sm23290976pfd.161.2020.01.15.13.02.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 13:02:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 09/11] Bluetooth: hci_h4: Add support for ISO packets
Date:   Wed, 15 Jan 2020 13:02:19 -0800
Message-Id: <20200115210221.13096-10-luiz.dentz@gmail.com>
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

This enables H4 driver to properly handle ISO packets.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_h4.c   | 1 +
 drivers/bluetooth/hci_uart.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 19ba52005009..6dc1fbeb564b 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -103,6 +103,7 @@ static const struct h4_recv_pkt h4_recv_pkts[] = {
 	{ H4_RECV_ACL,   .recv = hci_recv_frame },
 	{ H4_RECV_SCO,   .recv = hci_recv_frame },
 	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+	{ H4_RECV_ISO,   .recv = hci_recv_frame },
 };
 
 /* Recv data */
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 6ab631101019..4e039d7a16f8 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -143,6 +143,13 @@ struct h4_recv_pkt {
 	.lsize = 1, \
 	.maxlen = HCI_MAX_EVENT_SIZE
 
+#define H4_RECV_ISO \
+	.type = HCI_ISODATA_PKT, \
+	.hlen = HCI_ISO_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 2, \
+	.maxlen = HCI_MAX_FRAME_SIZE \
+
 struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			    const unsigned char *buffer, int count,
 			    const struct h4_recv_pkt *pkts, int pkts_count);
-- 
2.21.0

