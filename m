Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0103C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B111B208D5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l8NTvh6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgFQEAg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgFQEAg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 00:00:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF45C06174E
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 21:00:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 35so337378ple.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 21:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SB6NyllJ5c5QB2g83Rjs0/yw2ziAGwA5U5ta98dnIWI=;
        b=l8NTvh6NB0BN6VPtWGd2MQ+oChxu/lYfMhCaPIFk3rpRmFXKlI/bxKFlggLgyXTa3x
         /ZPad1Y3c/G2emO3S+dkCprNZ+AuF9POHsuUGhGQKJL3ddt6bkjC5MTaU83zGeL5vSrX
         3dmvSZ9XiCrlE3jjBwACVs/mrgnE7ha9wjMDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SB6NyllJ5c5QB2g83Rjs0/yw2ziAGwA5U5ta98dnIWI=;
        b=VLXjWDLeJKNMXn4fkO1k5ef6lAURhOJqt9uthb1KQx1bIXw5uvZNAgVP2PY9UGC5FY
         uoVfKUBeuOWCVtiyzFjKxBHcGVwTvMdT3+eD6IeH7LHxC0Jp/MprVKk8/FdhxnqkDaiX
         Afyz9jjq3m0WHnnYDeOJ4kyw9EZ3kAuiI3E3bsz44wdSyD+l9OFQx5tQI94H5z0EnbjA
         kYrc5VSma1s/HCnY5bsVdVyOjO2agvzzo1nw8LqfkDG7CcJ6eR/7nw2QRBMld1GshKpo
         fdB1jSrBq5GFfSpnydlnxgE06Sesz6cDr70JzpERHnRyu3GX6BEVFJ2AtOkuMEa9mPLS
         80Dg==
X-Gm-Message-State: AOAM530ADjqZOwiPxVtjNZXX7KTuvZHfhPTJNuAyB6uUBDJ8Czs9WXuo
        eezcsWhaoGlYncq9oRvRtjSuEA==
X-Google-Smtp-Source: ABdhPJyTI/VLL17J/OWOTs8c/3WLZNCAlQ/tnQ6y8hYmbQqn2Rmvw+OvZRZajSEcKcD6/Ttyxi4QyA==
X-Received: by 2002:a17:90a:4d4e:: with SMTP id l14mr5967423pjh.10.1592366435399;
        Tue, 16 Jun 2020 21:00:35 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id q1sm20013089pfk.132.2020.06.16.21.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 21:00:34 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/4] Bluetooth: Implement get/set device flags and device flags changed
Date:   Tue, 16 Jun 2020 21:00:18 -0700
Message-Id: <20200617040022.174448-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi linux-bluetooth,

This series adds support for configuring the Remote Wakeup flag on
devices by implementing Get Device Flags, Set Device Flags and Device
Flags Changed.

This was tested with some userspace changes to update the Remote Wakeup
flag (these changes will be upstreamed as Bluez patches once they're
cleaned up). I verified that Add Device generates the Device Flags
changed on all mgmt interfaces and Set Device Flags skips the one that
requested it.

This was tested on a Chromebook running kernel 5.4.

Abhishek



Abhishek Pandit-Subedi (4):
  Bluetooth: Add bdaddr_list_with_flags for classic whitelist
  Bluetooth: Replace wakeable list with flag
  Bluetooth: Replace wakeable in hci_conn_params
  Bluetooth: Add get/set device flags mgmt op

 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |  31 ++++++-
 include/net/bluetooth/mgmt.h     |  28 +++++++
 net/bluetooth/hci_core.c         |  59 ++++++++++++-
 net/bluetooth/hci_event.c        |   8 +-
 net/bluetooth/hci_request.c      |  15 ++--
 net/bluetooth/hci_sock.c         |   1 +
 net/bluetooth/mgmt.c             | 139 ++++++++++++++++++++++++++++++-
 8 files changed, 266 insertions(+), 16 deletions(-)

-- 
2.27.0.290.gba653c62da-goog

