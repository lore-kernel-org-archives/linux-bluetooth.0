Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF43C636D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Feb 2023 00:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjBVAJ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Feb 2023 19:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBVAJ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Feb 2023 19:09:28 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F830299
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 16:09:23 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id j18-20020a170903025200b00198aa765a9dso3046254plh.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 16:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UL0yRbeKpZcUS7oK0Keg6M2sHdVnxq6xd5IYXope5uY=;
        b=nK8EhIa3on6tNIjcrLIcrc+52eoe1UNMPTBON95D+w8PUIMo0Y8J7N+EwAb5a+Nq2m
         zUuXEIK63sTwf9iAVYoWXIyQPQvwgpnDmNiMlYRWjtiKdWtNIYMWc78gayh0KdsZw9Ke
         z/j3T07SMoF1qWbhKRV2WJbkSuCuWIjsse9WsBFwz/5hdaImod85lG/N3L6Kqdf3omnC
         op6n+uexiIQuhqwrEB9jZZEg2jUcB2+aL3Uig8LQsv/Rjm6etP4j1YdxgVY/Hn4F9c6r
         IEAC8yomjq/DyciVjxvRaPaTSIAzT0LVWUO486m/KUIOh46qVNlyTCbmK3UQrhLjSQwY
         lM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UL0yRbeKpZcUS7oK0Keg6M2sHdVnxq6xd5IYXope5uY=;
        b=ITdvG+CUj10gC/NQGYF2ESPCFAzLsxsBNofLfnA3oDzMEYqSckinaMVoizcxSyy31b
         Y+wX0G7iwpGnqJf1eIRBRNRkF8+y74PszwiAXi46EYRC9pRRYjOUZjuoLfrfAvko54iD
         gDreB3ovDzzxnFcmI/A0LhvcUWzoyRvd0QbKvGkNowdAgVHy0CLH7lgMG/oZtco0EZZT
         LVFm9HFASTCE+6h8ZbAa787c7xMqg2+/49Yc2OWZohDdTaE+QCwID+DisLx1D36fVBsP
         qqWDcl3afbzVJbM9JKOFZMMtkZqfLeRbVnV78G438zlPrCm7/Eq2xnL1cmaowpVmimYy
         FRTA==
X-Gm-Message-State: AO0yUKXNdYk7jkTtfEmkQhX7qiCw6+DczSDnK+NB/XZbZANbeH/nizZ2
        ILD4SOYwFlDlfYRyWQJZVg8A4v7AVK5f4YNOApF8GERbkLqdLA0qyAhfHj8dGAgRc8hY18WAPVD
        YlnkjPi2xX+V999Udrqgxp4L37tmt40rC15ADBMxlUpxBcCSQ9Vkwj8h+2i36lpUQpvypZW8fK4
        tQ
X-Google-Smtp-Source: AK7set9uUrJFSUvsKgKPY2E5kYay1tfSQR7nxQxSfHMsjQJNToCgtmPwuLDiapTw9S5iadiMFd4jTr/vbUkb
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a63:3e41:0:b0:4df:6f34:48f8 with SMTP id
 l62-20020a633e41000000b004df6f3448f8mr874990pga.8.1677024562362; Tue, 21 Feb
 2023 16:09:22 -0800 (PST)
Date:   Tue, 21 Feb 2023 16:09:13 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230222000915.2843208-1-jiangzp@google.com>
Subject: [kernel PATCH v1 0/1] Clear workqueue to avoid use-after-free
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


After the hci_sync rework, cmd_sync_work was cleared when calling
hci_unregister_dev, but not when powering off the adapter.
Use-after-free errors happened because a work is still scheduled
when cmd is freed by __mgmt_power_off.

Changes in v1:
- Clear cmd_sync_work queue before clearing the mgmt cmd list

Zhengping Jiang (1):
  Bluetooth: hci_sync: clear workqueue before clear mgmt cmd

 net/bluetooth/hci_sync.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.39.2.637.g21b0678d19-goog

