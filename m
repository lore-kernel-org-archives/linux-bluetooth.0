Return-Path: <SRS0=igZI=Y6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507CAC5DF62
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 00:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0188214D8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 00:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jVQXC8Be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfKFA3z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:29:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37278 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfKFA3y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Nov 2019 19:29:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id p24so10913400pfn.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Nov 2019 16:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQn/hdpJtUBU4JXLBcANmsUsqxv2qw1rKwGzmCMjZAo=;
        b=jVQXC8BeCX0FWiJOeHNFnoeR6xuVmIEDLWUFVGMVeNOeMPLue9DiXC0Y5jsqZffeEq
         K+uA83vP0MSdkAlNO3OEvMar2FnfGklHxXcwEjSfGc1TkskmgkKWO0AcZ99Hm2bidAVJ
         Z5YgmVJ1CoPXXGmspjNqyaK63qbOVauqjo39Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQn/hdpJtUBU4JXLBcANmsUsqxv2qw1rKwGzmCMjZAo=;
        b=NYC9GCQ8jqRUDSHYXmnct+crTWL0EMCiQpaohWJliTdNptGx+6FzDHvUli8rJKNxAZ
         B186zSlhNIt9odbXmoH4ePgz0hk+8/s+j+HuKTEb3Of5lApu7v7s6KnDpEkoyGbF+IIs
         Ui9KmFq5mAt8l1XUwS1Xh0h3I7BhpSJCGh2nE44q9bh41gDnxNe+66ffo5RNtrDYiD90
         n5bTMP9KCh3cejf1MGWDqp8ALryT7l7gl2+OcCl4NDUAdUmwsfVT0TDuy8lSWl6gSFAK
         BkQh1SCNRz7yCdpXKJq/6aBfFv6AT2KFTgakJK2661uCSp8wSWcY5G6JOX+qUpuSVmGz
         K0tw==
X-Gm-Message-State: APjAAAVXg1ZfFyzoVS7fzHEg1YxrWjcOc+HGK34zMicOQnKZ2OieFc4/
        KwjRmS1jksHhYcmhfb4VZDCcqA==
X-Google-Smtp-Source: APXvYqz2rCG/lEPlEh0vSeU192FAuw+9LsfJpkmg1K9UcojLZZPcV3opoR4zPGAyq7kqAjnbGyRGMQ==
X-Received: by 2002:a65:4c8b:: with SMTP id m11mr40815673pgt.25.1573000193870;
        Tue, 05 Nov 2019 16:29:53 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id k9sm21032835pfk.72.2019.11.05.16.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 16:29:53 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 0/4] Bluetooth: hci_bcm: Additional changes for BCM4354 support
Date:   Tue,  5 Nov 2019 16:29:19 -0800
Message-Id: <20191106002923.109344-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


While adding support for the BCM4354, I discovered a few more things
that weren't working as they should have.

First, we disallow serdev from setting the baudrate on BCM4354. Serdev
sets the oper_speed first before calling hu->setup() in
hci_uart_setup(). On the BCM4354, this results in bcm_setup() failing
when the hci reset times out.

Next, we add support for setting the PCM parameters, which consists of
a pair of vendor specific opcodes to set the pcm parameters. The
documentation for these params are available in the brcm_patchram_plus
package (i.e. https://github.com/balena-os/brcm_patchram_plus). This is
necessary for PCM to work properly.

All changes were tested with rk3288-veyron-minnie.dts.



Abhishek Pandit-Subedi (4):
  Bluetooth: hci_bcm: Disallow set_baudrate for BCM4354
  Bluetooth: btbcm: Support pcm configuration
  Bluetooth: hci_bcm: Support pcm params in dts
  dt-bindings: net: bluetooth: update broadcom-bluetooth

 .../bindings/net/broadcom-bluetooth.txt       |  4 ++
 drivers/bluetooth/btbcm.c                     | 27 ++++++++++
 drivers/bluetooth/btbcm.h                     | 12 +++++
 drivers/bluetooth/hci_bcm.c                   | 52 ++++++++++++++++++-
 4 files changed, 94 insertions(+), 1 deletion(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

