Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8F4C4361A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 20:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200C7222B3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 20:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgLCUNx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 15:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgLCUNw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 15:13:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE632C061A4F
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 12:13:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7so4128807ybm.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 12:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=btTE2w9BbTs5elBO8g6GQzeY/qiJGlW6YLv984UAgDM=;
        b=L2BxuWWmA8ArI7guPa4vcAIDCmn2evZqAvGdG+VlnzIfw3CStLVSd2QTImdgQtcN0Z
         xONojVkLChQNArAIUKXjKTMa7GzVjvMqhlukkPpivHvkqRzNhLUCK/oz+FFQ/I6gM1FN
         im9hGqQqxGwleVFxv7WdZ+TLFmqqpz2hXgtN/KkrNebGlsZQWvF5btFjD+P9W3JrhA15
         0RvB6M85VVcG283Hw6uLx+4jGgTR/Id3JCJkbrxDqHqmU2P4FO3gpTosrN2Ce0khfxuX
         h4T+lBV9BOeCgXG43qU9Otjwai1YEgEhvw0qZbw+JGBFt3UYWeGVWkVGqbNqh3BC887S
         Deaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=btTE2w9BbTs5elBO8g6GQzeY/qiJGlW6YLv984UAgDM=;
        b=gf85p3MI6EgzRMvYXV5eBX1zAaW74JNE8fn6eEXlUC9F9j1AgN/REE5mysR+EhvVMQ
         VyuJY7bVpBr3fhcWG+tZXltjUTZy32xLlduYni/zpOcJxCIfGtAZAAprBn3HZELXvO2n
         CyX6eTLcYi17XnvFKSp8dnkMUqDF4oFRdac1KW77YiocQj3E7KSNkMtSsV31YbkxTRmj
         F/j8yJKDi56tWKxO6RB12TBRKTgREzqTcuC2bbqKKEw8pVC+c+VIqZ6JjVJE1Li8ETNe
         1DoTrFjqEuhpv4JIlc+9/rlFGfNdzXAzxgM3aIofdrn8dolV6ETnfooT6rY6UZEabN2z
         aDQw==
X-Gm-Message-State: AOAM531FAIfBojdSfm0w5uARcB6uiQoZQF7veKmstolm7iYDf+c445+Y
        zS7zSh3Mm5DdCMFbWKWOCG8pPJ04fDEdjn+/DMun
X-Google-Smtp-Source: ABdhPJxtHWfChFKZpuTj/LD66qwvtsotlU6iWdvFg6vaWDrv7Vj8HSMsxdTZP4H+j3VVxrKuvXuBHdDLqYsF0ido49XH
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:a2ce:: with SMTP id
 c14mr1185195ybn.393.1607026385919; Thu, 03 Dec 2020 12:13:05 -0800 (PST)
Date:   Thu,  3 Dec 2020 12:12:47 -0800
Message-Id: <20201203201252.807616-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v7 0/5] Bluetooth: Add new MGMT interface for advertising add
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
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
will be used with extended advertising support. After a call to set
advertising parameters, the selected transmission power will be
propagated in the reponse to alert userspace to the actual power used.

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


Changes in v7:
- Rebase onto bluetooth-next/master

Changes in v6:
- Only populate LE tx power range if controller reports it

Changes in v5:
- Ensure data/scan rsp length is returned for non-ext adv

Changes in v4:
- Add remaining data and scan response length to MGMT params response
- Moving optional params into 'flags' field of MGMT command
- Combine LE tx range into a single EIR field for MGMT capabilities cmd

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
 include/net/bluetooth/mgmt.h     |  49 +++-
 net/bluetooth/hci_core.c         |  47 +++-
 net/bluetooth/hci_event.c        |  19 ++
 net/bluetooth/hci_request.c      |  29 ++-
 net/bluetooth/mgmt.c             | 430 +++++++++++++++++++++++++++++--
 7 files changed, 548 insertions(+), 45 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

