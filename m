Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B1C4346E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 00:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6295D23977
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 00:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6lxj6hU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgIYAkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 20:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgIYAkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 20:40:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7569C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 17:40:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q2so1060118ybo.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 17:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=QVeShVtMdp4a174VS3P0sBlwkGRZjcje3Ux+yepnn44=;
        b=n6lxj6hUkBy9w631PC222S+Fu+Ljqm4V7FZomxqgLupTEWK70SrY/OXKF0Kgoymasw
         1FkVAAD+pv3EwdUuMT7CrFc2iQFGl0ZbWE6p49Xdl1Cc2GEkk2ySpZ7wPpiO/qxgXVtG
         wrtBlPXHx4J3766447sH7o2yT5piQY6LudOBPuvSH2W8odYggVETezcRTWnssc8S3Fy4
         8rMM3LtTo+NgDDCBFsu37RPOjizrr2X2RTYZPRoreYuIdviDtQ91m8quxJYDPVIhYcwM
         9SU3eySfw99FOH8PTxNkb256jAuyMBJ8a01V+XbfKo7ToU9oj4GOVWYLlQQrYEKKB/gR
         +Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=QVeShVtMdp4a174VS3P0sBlwkGRZjcje3Ux+yepnn44=;
        b=uMefZ8GFNtIe7+djUtslhjXadWD7973UnWs2VU+n6SXFHok7Gv5a66U1BLLgzswkwF
         /6P9Bqu7Xb0RMgInR1z+69zmzJiI5qDZ8PHOnmn3NjApSud0xOiwY+MJzcB6cEKbKGRV
         OajcHxWNv7vNY/qWwmCeJPhGwTVvZ9PihF3bmyN1Jr7Wa4E28fJeTgOTzRxax7rHG//M
         B5mrDlJMXfE9I0+EM3E9X5rdUxPNSgAqYQrbiYCOq2C9276ZjJIKPGIqNcNJfix9vui5
         3lz6bSq2pHJy82wH8U0uDz4+FlDJf6UqaWEdkpYtM7QnvFioabMzH2XvUaVyMUDeAtqf
         CXug==
X-Gm-Message-State: AOAM531LtFUYyUBCh843ZESuyYiQCwkrWGGYjJO8/S/3KQEXmU4Ql9Ya
        Qj0jZEDeS2RZiy+2jixmqRY2kl/A8II28ty7ngbD
X-Google-Smtp-Source: ABdhPJx0Z4DBHrWe5yn8IYsBxsFzD2aBfvOO0GX90aL4TlWzvg85lLR9WzUQFp7mDHwUIuoyqpoP3sE/39gm0a7xVBjS
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a5b:5ce:: with SMTP id
 w14mr2279927ybp.83.1600994420900; Thu, 24 Sep 2020 17:40:20 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:40:02 -0700
Message-Id: <20200925004007.2378410-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v3 0/5] Bluetooth: Add new MGMT interface for advertising add
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers,

This patch series defines the new two-call MGMT interface for adding
new advertising instances. Similarly to the hci advertising commands, a
mgmt call to set parameters is expected to be first, followed by a mgmt
call to set advertising data/scan response. The members of the
parameters request are optional; the caller defines a "params" bitfield
in the structure that indicates which parameters were intentionally set,
and others are set to defaults.

The main feature here is the introduction of min/max parameters and tx
power that can be requested by the client. Min/max parameters will be
used both with and without extended advertising support, and tx power
will be used with extended advertising support. After a call for hci
advertising parameters, a new TX_POWER_SELECTED event will be emitted to
alert userspace to the actual chosen tx power.

Additionally, to inform userspace of the controller LE Tx power
capabilities for the client's benefit, this series also changes the
security info MGMT command to more flexibly contain other capabilities,
such as LE min and max tx power.

All changes have been tested on hatch (extended advertising) and kukui
(no extended advertising) chromebooks with manual testing verifying
correctness of parameters/data in btmon traces, and our automated test
suite of 25 single- and multi-advertising usage scenarios.

A separate patch series will add support in bluetoothd. Thanks in
advance for your feedback!

Daniel Winkler


Changes in v3:
- Adding selected tx power to adv params mgmt response, removing event
- Re-using security info MGMT command to carry controller capabilities

Changes in v2:
- Fixed sparse error in Capabilities MGMT command

Daniel Winkler (5):
  Bluetooth: Add helper to set adv data
  Bluetooth: Break add adv into two mgmt commands
  Bluetooth: Use intervals and tx power from mgmt cmds
  Bluetooth: Query LE tx power on startup
  Bluetooth: Change MGMT security info CMD to be more generic

 include/net/bluetooth/hci.h      |   7 +
 include/net/bluetooth/hci_core.h |  12 +-
 include/net/bluetooth/mgmt.h     |  50 +++-
 net/bluetooth/hci_core.c         |  47 +++-
 net/bluetooth/hci_event.c        |  19 ++
 net/bluetooth/hci_request.c      |  29 ++-
 net/bluetooth/mgmt.c             | 412 +++++++++++++++++++++++++++++--
 7 files changed, 531 insertions(+), 45 deletions(-)

-- 
2.28.0.709.gb0816b6eb0-goog

