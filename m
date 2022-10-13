Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED73DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Oct 2022 21:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJMVpR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJMVpQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 17:45:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D453A76
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 14:45:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b14-20020a056902030e00b006a827d81fd8so2623298ybs.17
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 14:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q2R/hsm49uk88OerGE7g+BdKMkZvbcCHzaGf+dnABps=;
        b=Zm4JNi59McSgtrZO3mTQE5c795q2xbejWFdsYn2FLal8WgYRezz4RsjUb9EegTCKF4
         1+NnxEFTQgcvq29EQpQ8XxZnLIDXWY4Gbc1yUAa+0e9WrWHGaLztknyIUeOfsCEVjJzO
         6MelgFtufgP93wq3/AYgv+NfsuBT+9Gmy/m4w6E8jlds9Dgy6E8CKdG9/zRn4cZ+jg/a
         E3KBJoheGEd4rtN2YtBXFyMUkD8xm82haWrPa9yAcxU0a1Nu0yCLUeR2EToqlf9qfjtM
         6oKWfRCm38QN92WUPgaKVL9vZRBsUcTZeO2i6CcVh8uq5QptXvsPWlCkRG/iKED0Fh+A
         tZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2R/hsm49uk88OerGE7g+BdKMkZvbcCHzaGf+dnABps=;
        b=lwbqUv5hVyDnPXCyNJ84lhV9Z3nCsibazMrqb+nuAdEUyp28OlhjCyGKs/Pn/CDf7q
         qfKoUWVECDYCJxXaLNFPvVvUlqwq84j5VxqIRtbCdJhhtRwgDrrjlAqyJnLs7j2gnDRi
         p4lIGwljee4EtKeD/Hlkndyjj3V1hb4QSA3xR8fO2tAq96NEksCOP1SpdYEEcWTgPTNA
         CRAZO1LksYwDIcAcdzhl1CQiI1+S49NPqvflvEZndgmmTzVN2EMVUV0wAbStVP7RqCoM
         5e+IMuglxnKGE0mHsQj7/6dzzwSRtlSBQorhBI2xDkOD+ewD4Eebxb6aFuLdByhDnvuP
         fehA==
X-Gm-Message-State: ACrzQf3xka3+eH78yOYmZvjoMat2U9TZsRtRyGznYridBAw+dQDW6BZ5
        d//xMq1hw9YKM/+CV6YTUJHm3EmqoCaI8rH3YBdQ/0sI2YGPlmG72FZt+B4yIubvwkXeIaJwHc5
        17ZaB2/H12bFevTO8J3veF+gxP3u5eUtozG0Ub5zS8+QwBYtLdhNsoChcp6PbZ/qq/zUqPAIXSL
        3L
X-Google-Smtp-Source: AMsMyM6A+6LUVQQdIiV2XphAdHir7CheNdf1l8TPeEh1HPXHTo6V9a4uDUfdS5Oi1nF0vQP8MwWXn9lR2rEO
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a81:9e42:0:b0:361:4dad:7a95 with SMTP id
 n2-20020a819e42000000b003614dad7a95mr1959497ywj.256.1665697513640; Thu, 13
 Oct 2022 14:45:13 -0700 (PDT)
Date:   Thu, 13 Oct 2022 14:45:07 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013214508.2195347-1-jiangzp@google.com>
Subject: [PATCH v1 0/1] Bluetooth: hci_qca: only assign wakeup with serial
 port support
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     Zhengping Jiang <jiangzp@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


This patch will check if the serial port supports wakeup before assigning
the hdev->wakeup callback. After landing the 'commit c1a74160eaf1a
("Bluetooth: hci_qca: Add device_may_wakeup support")', the wake-on-bt
was broken in Jacuzzi because the qca_wakeup returns false. In this case
it will fall back to the default hci_uart_wakeup.

Changes in v1:
- Check serial port support before assigning wakeup callback

Zhengping Jiang (1):
  Bluetooth: hci_qca: only assign wakeup with serial port support

 drivers/bluetooth/hci_qca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.38.0.413.g74048e4d9e-goog

