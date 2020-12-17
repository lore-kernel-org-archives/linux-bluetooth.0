Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43833C2BB40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 11:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE41238A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 11:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgLQLpK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 06:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgLQLpI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 06:45:08 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18561C061794
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 03:44:28 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id i1so20473735qtw.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 03:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=FSVX+8nSBBUKQq1ZLrI+OmJKsVh41/L0xGiVpz1i4AM=;
        b=tNolRNyjYFl4/CM+BmGWkkLJ27d/574h4YXn/dCqCYSKVUdxG/9QTc4GEnPk2MkqXE
         DTHbgBNRthruiGciOj7vZtVQC13pfTREHVVl0yuMWbECPgbNMjf3rM6Tc8oJiPLB9+o/
         cudm1SQEgce7S3dNHUzKzYXtwG1pZbM4Bg2LyzeaXDp3BZxNDO2jzZAkwhiew+6ZAwGE
         W3iRx2I/fJRjmon2uzt7/0E3c1/0xgH0CkyMprSImhp+6s39xyKGQ/sZIMx9Hd4Z8VHM
         3Wcw4A618xQba8Fbpe/PvfVHbE+NGHj41IJkGXfZIVVXZ8DaHguuTPkz/rjFm4WXILPf
         A1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=FSVX+8nSBBUKQq1ZLrI+OmJKsVh41/L0xGiVpz1i4AM=;
        b=nktsro81IXmLQnV4riqv08efzCKfBxJdn5w07scYyrlfamve9PvWMJvRsc0MeC3bn3
         57IJ797Xzp3J3fxiUtbhQY4ypXCRQPUpdQllKq6KFMj8B7t3m9W7tk6F8OIntIAsdPSb
         MJYDSbsmojsKFw84T4TAlHsvcjrzK4PpEyunUcEHB0fsoPqZGiXRkYHxZqdSiPo4avdM
         Seleqj3pLM6ZzURST/a1Hg9KKl4CitH8WHSDGRBAY5kmyeG5fmdVkgBdhH85bL1ZqVzB
         o53IwZAom+vZbAXsGm3pr2eHktOcThwtMeNZR7SOszgcfxgpTmsInp5g6AKA1KgxybQJ
         TNzA==
X-Gm-Message-State: AOAM533AHgy865CJz/F5KQLmsrxvUL20vgl+y21vQC4pcgIq5DYEEN4+
        x56x5TVBEjaqmLDlQLQlhD6WKa4XXO2AtynC
X-Google-Smtp-Source: ABdhPJy/LLFKWoEyeoStLlr+OHOzO4UVSmtsrS6K/D2VffllSmeLjG7LvQwUVkOWmLClSdYA6t3i3IXYORbbkMqm
Sender: "jpawlowski via sendgmr" 
        <jpawlowski@jpawlowski-920.waw.corp.google.com>
X-Received: from jpawlowski-920.waw.corp.google.com ([2a00:79e0:2:11:7220:84ff:fe09:132a])
 (user=jpawlowski job=sendgmr) by 2002:a0c:bf0f:: with SMTP id
 m15mr47506939qvi.23.1608205467237; Thu, 17 Dec 2020 03:44:27 -0800 (PST)
Date:   Thu, 17 Dec 2020 12:44:22 +0100
Message-Id: <20201217114422.3617812-1-jpawlowski@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] Bluetooth: hci_bcm: Add support for ISO packets
From:   Jakub Pawlowski <jpawlowski@google.com>
To:     jpawlowski@google.com
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This enables bcm driver to properly handle ISO packets.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 8ea5ca8d71d6..3764ceb6fa0d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -654,6 +654,7 @@ static const struct h4_recv_pkt bcm_recv_pkts[] = {
 	{ H4_RECV_ACL,      .recv = hci_recv_frame },
 	{ H4_RECV_SCO,      .recv = hci_recv_frame },
 	{ H4_RECV_EVENT,    .recv = hci_recv_frame },
+	{ H4_RECV_ISO,      .recv = hci_recv_frame },
 	{ BCM_RECV_LM_DIAG, .recv = hci_recv_diag  },
 	{ BCM_RECV_NULL,    .recv = hci_recv_diag  },
 	{ BCM_RECV_TYPE49,  .recv = hci_recv_diag  },
-- 
2.29.2.729.g45daf8777d-goog

