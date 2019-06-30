Return-Path: <SRS0=/Akc=U5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1CCC5B576
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Jun 2019 22:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A99208C3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Jun 2019 22:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfGmHY7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfF3WOW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Jun 2019 18:14:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38421 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfF3WOV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Jun 2019 18:14:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so13806338wmj.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jun 2019 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zt6k+megrNsbdnpdb+H0HjlcGwQEvMQjnXiBoWbLH+I=;
        b=pfGmHY7mFc4K4NX3kGi/A4QJOeT9WQK9O3+57QgLc8LmpSQg4ulSEFA9TIjZcK3f3q
         VTqARfmMRoe11jkwNkKyAfSuXvo3Mm/egGHibk/OKWBR3XlS1gg7UcE+/8QjHTyqoLMh
         AYu/WbvfO/645eOts0+AOlmIuNbPWOGXPVFhqF3a64FJGopMZKcTri8dHGLK3nHNK0GT
         z5pAjRrPpg8C9/ieTQCqTkXJJiRWNQdfXH++eO6LiKtcBG8+A0wlG0A/xXttITGX4cpP
         /J5q4nxSPQC3pJmqpzkRYiAuA+LhGSjdzQ5ADheGYPbo5MtDbMtaalfIAnKBd3R1aSy0
         KS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zt6k+megrNsbdnpdb+H0HjlcGwQEvMQjnXiBoWbLH+I=;
        b=mSCj3y3ZkLM9H0M4bsL3SNGcLubXewIuKPrZPiH1e/O2s3r8oxp9G1kNHnlzKyaYsB
         K3f/bPp584LplhLp8WA18WeQQuI31cnGmV1u7vqUcr1A4L1CJTlBriSb76lsTSXrZwLB
         gHe5CQlYH0121MANll+rUew4MHDmftmSB0iBtab1IYLM/fsH6L/7jM70bWxuJtHM81us
         44caklZZoKmE5jOLuVKLXnOB7K/tsSH5jg0JCzIBRoad/X81zR1TRhMlk1r1J9U0GTKh
         O7lazLTwbghnSC6FcoyODsgJVuwOUYzUEdt1e4tc447FN1VPfQJJzphVVwEuVXOqkwtp
         BS5g==
X-Gm-Message-State: APjAAAXFQAbTrbfUmUYWdbyIvukDKS65IxGIUTOAGIIiKbQwO7wGnoZb
        Ptm11FRfLGAErIFIlQ6PjHY=
X-Google-Smtp-Source: APXvYqwPmJWPh6TnsKk6OBAOk8LAuzdHJFVotesSEUN4u90uoWHqm0m2+cYejEfSNmzjS2b+PmI68A==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr13992644wmc.33.1561932859657;
        Sun, 30 Jun 2019 15:14:19 -0700 (PDT)
Received: from morpheus.roving-it.com.com (2.e.6.5.c.a.a.1.a.8.0.3.1.e.3.c.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:c3e1:308a:1aac:56e2])
        by smtp.googlemail.com with ESMTPSA id u6sm9120804wml.9.2019.06.30.15.14.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 15:14:18 -0700 (PDT)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] Bluetooth: btsdio: Do not bind to non-removable BCM4356
Date:   Sun, 30 Jun 2019 23:14:08 +0100
Message-Id: <20190630221408.8509-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BCM4356 devices soldered onto the PCB (non-removable) use an UART
connection for bluetooth, such as the Rock960, but it also advertise
btsdio support as a sdio function.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bluetooth/btsdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 83748b7b2033..fd9571d5fdac 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -286,6 +286,7 @@ static int btsdio_probe(struct sdio_func *func,
 		switch (func->device) {
 		case SDIO_DEVICE_ID_BROADCOM_43341:
 		case SDIO_DEVICE_ID_BROADCOM_43430:
+		case SDIO_DEVICE_ID_BROADCOM_4356:
 			return -ENODEV;
 		}
 	}
-- 
2.21.0

