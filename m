Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FBDC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Oct 2022 21:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJMVpU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJMVpT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 17:45:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0356AE85
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 14:45:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 130-20020a251188000000b006be249d0a70so2646687ybr.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 14:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OC2TRA3RaKZigj+gmSjzr1uEQcbYSV2Diu4v9YA/yVc=;
        b=Jvauj2Q8iA9kDTzQWwJBKr0DPFzDpCVXLD9hYoQepUDDEB1Pcjr9WF6SSuCE0VhizD
         VDPJcwpU5AwyBpUWvY0drVpP4zS6ILIfXzmj8qUTV+03IFJwb+AVAwHRDoPx6BVlJuVs
         Sa044RS7mErdfOSGrjDUfsSgxPCxhxDA7qIEv3lTeuyZm6WT6cWlnXOzXNwhkYrWGKAd
         R4pCjTV4Iq+Zc8ULAR8mM7W5r3xGZ1A4o2AnB6XddaaCv/bIQYc1/ul2AckiFUZrTxK3
         s85kK+WkMfKX1SYEjBFVpk4f+KGUSDYSlO5iItD8px/jVuFIAosl+jLeqCEEmUCGXZMl
         +q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OC2TRA3RaKZigj+gmSjzr1uEQcbYSV2Diu4v9YA/yVc=;
        b=CSfGqxCUD36qrbsR4iHYrZbIe5USZs6EBS7YfqvF4F7HcOuGbNf0PkcxhFrxv0Jho9
         CsmokDFuo/K/bl1x3svoiqGJpuRt98tXZyckHSeGbHPcpNeZ4YVDcBAbjqyidWjYNJ6r
         bglrCcmwkZXRTxaG5z0Gpa0fd2Xlhb4K4oAX7vQvCHuglXLyy602dojF0VbFh2nz+1fn
         GIkwbzvIk2UvMBZBk+Bvg0hAGO5brTNa6TqK77m7g1BglojWK7bSUmGWk0OrvCvHv1hD
         GHc0w3KPr4mFaSjOhezA/2tQDa9Jg3oQk0VnxZkV0gqw/2FvW6NwY8bvpCrfEk3WQy4o
         7C/A==
X-Gm-Message-State: ACrzQf2K1IqYftZO8F9IBgWLwSlSFuf64N0gsGkbkqnKXnYgb4GIHQqH
        ut4uFg1vHBU6Sx8mCjrPxyMw2gh5ESO1RBhxWeGUql102gXWWhtssjRi5x4TFsZQCQ/7hfEkpH5
        oiLQ3cpFeM3e5fAzPmJC00axpaL29JIgmqf2Pp841Tsx/cyg4t+HgkVAunokmWZf3gRdIOQP6rn
        r2
X-Google-Smtp-Source: AMsMyM4AJHKhvfkmvHItxuzNajgyI8OQNsNSRQ+SRT+HvEQTaurv0wK9KSgha+RuRm7FSJewIibC+DbXofiW
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a0d:c942:0:b0:337:5cf9:1c04 with SMTP id
 l63-20020a0dc942000000b003375cf91c04mr1907615ywd.39.1665697517001; Thu, 13
 Oct 2022 14:45:17 -0700 (PDT)
Date:   Thu, 13 Oct 2022 14:45:08 -0700
In-Reply-To: <20221013214508.2195347-1-jiangzp@google.com>
Mime-Version: 1.0
References: <20221013214508.2195347-1-jiangzp@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013144431.v1.1.I47f1918a2786b34e7649387233377c57a8bdcdac@changeid>
Subject: [PATCH v1 1/1] Bluetooth: hci_qca: only assign wakeup with serial
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

Only assign hdev->wakeup if the serial port supports wakeup. Otherwise
it will fall back to the hci_uart_wakeup or the behavior that can be
overridden before calling the hci_uart_register_device().

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Check serial port support before assigning wakeup callback

 drivers/bluetooth/hci_qca.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 8df11016fd51..dacb6f5efd29 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1765,7 +1765,8 @@ static int qca_setup(struct hci_uart *hu)
 		qca_debugfs_init(hdev);
 		hu->hdev->hw_error = qca_hw_error;
 		hu->hdev->cmd_timeout = qca_cmd_timeout;
-		hu->hdev->wakeup = qca_wakeup;
+		if (device_can_wakeup(hu->serdev->ctrl->dev.parent))
+			hu->hdev->wakeup = qca_wakeup;
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
 		set_bit(QCA_ROM_FW, &qca->flags);
-- 
2.38.0.413.g74048e4d9e-goog

