Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20478C38142
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 19:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiHWTBn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiHWTAm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 15:00:42 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC3BD4BFF
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 10:31:37 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i16-20020a170902c95000b00172c39b3fb0so7510349pla.22
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=I6bMwOogiDnVs957h7gTrEm/KH2DteHWZdYaUy0awII=;
        b=rdInFjbHwlhVn7+i3nZ6Y12p5lXLrwsbNkPcgncgA7HvITdYAiDyEnC0kjbOnjkXUP
         pLYZLdPOWUr0/n6ojM5/Qe4akp/Jf0brbN4tkyI45ztB6F9OfRyuTKzqQs2ffQIBi/VN
         iHtv0YzIQfsPSgNSpagswtPxKHOJA9+n8O+QNjB0mW1MI3WczSUVwrqvKzwaD1OmxuC5
         iOBqYqnIz0BsYXRiy0bICYqW4ntgny9Vm1a648eDXS3+IfghTn9ERmUKQ+h9fE85E3Hb
         1OA6joKJtlg/9fI1evThuF8fJehMmbskQrbfvXsqlnAYh1paxIgCQ73PDpqE1/VNfmLF
         hBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=I6bMwOogiDnVs957h7gTrEm/KH2DteHWZdYaUy0awII=;
        b=huk7NN9VhROwlql3wuasQEamu/hwIXKOw7N3sc0lCiHA5kLBR9Ui4GviaVNME5obWs
         B+9/u0fxOfVdnridjbIgpk5BfLgBjJmshs2KnpKxsI5rs/E0wgGBCim5ncaYs4W/xSYs
         6Z/ugQ7lMgAC0Gu2kY+TIfVbMsRxGh0soWSYeGtA6M2u3eTa7BZ/vbB5wO8v1w0yWX8D
         xPrsaNEXDmp4ZdGKNiDRMhV+753JnAamlMeqz7F9BEgrjomuT2mXPukACZ0dptmQAZi7
         RnYUxwvHoY3s1VoFJCbUBDfwTvSehjvqzoeA3jd4cMiQ0vERGMarmU9jdK0QvQO5BMOs
         pFfw==
X-Gm-Message-State: ACgBeo2gXiW3mZ4Bb/OI98GlP/iPfibHtMnTKK/sBzLOHyIyFYTYSq+u
        NXSrpHU1Sc2/Vvxre1misTjEqQP005jUlrZuVQx4LNOoe9XFKZ53JyKcwZ1lq93ggJv4BOIkL/A
        BIuIELsc/mPgmlmDwlCwRBmqTaXQHFKthLIdlbOe6jJfixD6FN7j7dP5rAVbgWgCbKxf7GSvF82
        zW
X-Google-Smtp-Source: AA6agR60ZyeTBw6tZHFNcbprgIuARloWgtV1XU8puB3UATvbmBX359d3oKeDBQw+t5yfz66Q9bup5ekspmsR
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a62:55c3:0:b0:536:729:71d8 with SMTP id
 j186-20020a6255c3000000b00536072971d8mr22486752pfb.53.1661275692394; Tue, 23
 Aug 2022 10:28:12 -0700 (PDT)
Date:   Tue, 23 Aug 2022 10:28:07 -0700
Message-Id: <20220823172808.3477638-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [kernel PATCH v3 0/1] Bluetooth: hci_sync: hold hdev->lock when
 cleanup hci_conn
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hold hdev->lock for hci_conn_failed. There are possible race conditions
which may cause kernel crash.

Changes in v3:
- Remove an empty line in commit message between Fixes and SoB

Changes in v2:
- Update commit message

Changes in v1:
- Hold hdev->lock for hci_conn_failed

Zhengping Jiang (1):
  Bluetooth: hci_sync: hold hdev->lock when cleanup hci_conn

 net/bluetooth/hci_sync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.37.1.595.g718a3a8f04-goog

