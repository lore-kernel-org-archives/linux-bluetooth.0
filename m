Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577BCC636D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Feb 2023 00:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBVAJh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Feb 2023 19:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjBVAJe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Feb 2023 19:09:34 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA4B26876
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 16:09:26 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id ep2-20020a17090ae64200b0023699c4353eso2705563pjb.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 16:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCzl63HJ+kqOaqrd0SKFlWgpIbxPIOYTA/3AaIJbOmU=;
        b=DMsAdrwlOWOh+lDWt6KAWAmHY+xU0+Wppx7ZSEqrbMPVOJo75bTAz0oE7rAU5aScHL
         y3yRUJsXtkYzzZyQCaOYNHrLFlMcOW2iUhOoIwZww8hfseI/xNxZFeAvDBvsoxiVbruD
         GWVsEGPSv+JOxpaf7yocT6lph9F3h+7uoiaTY1atlpnAtHCmBgyUmPSxSR1yQ8OM9x66
         XfSmyIr5ycJiPjHdu+x8jE7aVqmZ/+bxMfq19a0xWq8an8UwG9GpYt6hBi1mNOpe1pFZ
         jjDSX5Yzmg9fpbpkD/OQDNYSRIc61CHYFDo/RZpLVBh3dl35ntqK1+zX9WQLbdowlf2V
         zbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCzl63HJ+kqOaqrd0SKFlWgpIbxPIOYTA/3AaIJbOmU=;
        b=3Tbg1U/Q4NY+t2HfNicBftKdPqrFXIGYKgB7Rmaw8LfynUrVoQ0xcJOIpW1vGLDFFQ
         OMpXRdGEptVYWK3IKSqlKLtGX+4kaweGdcsvV7fvgDXhrLsa5Z3Fh3Lc8/kdQyg+F6Hy
         ddrx3VoQdXoaADfiRrcRbD5sP32eJ4OHn+cMVIxndTQFGInSyGqLU2dOtftiXwOID2UQ
         mjAZkQNOhLKFst9FIQ5ftxbCU7uKrS3daHRheCOlrzM3wS7DKCDegMgt8kbfz7jIAIuJ
         xsJf2WBfAI/hByLveFecL2EV8kBUcslWg+bEvnWq9o/ZRzGhbBaBvXJ5OAFdaY7n6LGJ
         uCHg==
X-Gm-Message-State: AO0yUKUEfjZECNYljTu9g+TKRmMQ4lQMvWVaEoMyRNR4YhFLHie0jK02
        /5n05HLoEyjoyhBk34bN4av0ZCAM+MNtfz1lYrvgiS71Htb3znS2uZcqXlBtBnPNPAMDWUzebSd
        eZYM8YdZ80q9SASt29cGoYr9PqbdcqoEd5IFLMq0r9NrBOrS05bYAhEKnjckufO5g6yTqZtbfrW
        WZ
X-Google-Smtp-Source: AK7set9P8J2ZMVQnExTEr/f8yGKCAK1D2UMzTZK1yMvW4ey7FBf9mZbCeF6GCykBrVwQhj4fHaO1Y6PuOEwY
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a63:3c58:0:b0:4fb:933a:91d with SMTP id
 i24-20020a633c58000000b004fb933a091dmr874838pgn.11.1677024566128; Tue, 21 Feb
 2023 16:09:26 -0800 (PST)
Date:   Tue, 21 Feb 2023 16:09:14 -0800
In-Reply-To: <20230222000915.2843208-1-jiangzp@google.com>
Mime-Version: 1.0
References: <20230222000915.2843208-1-jiangzp@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221160910.kernel.v1.1.If0578b001c1f12567f2ebcac5856507f1adee745@changeid>
Subject: [kernel PATCH v1 1/1] Bluetooth: hci_sync: clear workqueue before
 clear mgmt cmd
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mmandlik@google.com,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Clear cmd_sync_work queue before clearing the mgmt cmd list to avoid
racing conditions which cause use-after-free.

When powering off the adapter, the mgmt cmd list will be cleared. If a
work is queued in the cmd_sync_work queue at the same time, it will
cause the risk of use-after-free, as the cmd pointer is not checked
before use.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Clear cmd_sync_work queue before clearing the mgmt cmd list

 net/bluetooth/hci_sync.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 117eedb6f709..6609434e3125 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4840,6 +4840,8 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	auto_off = hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF);
 
+	hci_cmd_sync_clear(hdev);
+
 	if (!auto_off && hdev->dev_type == HCI_PRIMARY &&
 	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 	    hci_dev_test_flag(hdev, HCI_MGMT))
-- 
2.39.2.637.g21b0678d19-goog

