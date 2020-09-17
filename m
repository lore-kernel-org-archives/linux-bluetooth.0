Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C845DC43464
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9159E2087D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LuOayWOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIQWW3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgIQWW3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 18:22:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F40C061788
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:22:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i199so3474769ybg.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=R8WEgJrMetWJNrqEtzBhqLHZfLiSdt4Hll3zS+w3mL4=;
        b=LuOayWOT30KhGQ64pljmo3YZfT4n3AMOP/VuhP+krwnQDGkwHABX+yw/BJsJ+hLIIe
         Ulh6WTje8RSbruv70Sc+kpgMhfyVGiOcQdzEbA/zmIqOnyNoBGHbNLs27GaikevQvtz4
         89asAVFiS2S7t6g2SJ41MWbbHseZIbwnoxtzpM2divOrFyqEnBTHt74tmz/8+/b62THJ
         B5sMI3P3XWOLDazTsZVJUlEi/yz46xEc5jTC+GbNKeb56ncrSey5uH41g54M6UfqiSPH
         0EJnuth2sPqAPpRvVhY3lx4xR4LM/1qnN9buIPIy4MSHGr6Y89aPFkUt+2oA66ViB7qj
         87Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=R8WEgJrMetWJNrqEtzBhqLHZfLiSdt4Hll3zS+w3mL4=;
        b=em3Ul2ZSh02QGmMh9YjT+eisuMqYBb4RCx9gEpFFGqiKr93lByL2wz/oGIDcedSFtK
         Dp0H28+ZoP45Z6MhLkCIrWZocE1ho/EIA7Y+Gq1BiefL7SF+vznFY7urtT/a/+oUcyxB
         WsNJ2Mcxhr0DW96uR/q+GsOA/wgifgVZibWx9775uzfsoJbfnSPR7jQwRLBOQHQ05zV1
         yf65z0WFfoFStlW0pJMUUOA3LO7+b8Ehf563BUmU4L13ZgI3RplxVdf3mwGN80n4+z5E
         cS//fI/+SefbTH36Wsc6XNT+1XKZCt7/ivVKq+X00QKBiW0G/S1PD9S4B89WEHr06qnZ
         HQ8Q==
X-Gm-Message-State: AOAM532u0J+VjoTW5Q88IXo5xO+ucSvhQELW3+xxdYxSE92SWXjCnpWn
        ocsqubLNT1Qb4vu8pfuzg0Xjgc3vqp8bk//w2If0
X-Google-Smtp-Source: ABdhPJwxgj4oj1GzHKD3/4dU+VhpN0mjUP7crNTQPhZayLjhtttuxehZiouwKLTbDrq27Bd6SbFZV61Q7bZj+I0+QlEY
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:ad46:: with SMTP id
 l6mr20065498ybe.492.1600381347766; Thu, 17 Sep 2020 15:22:27 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:22:11 -0700
Message-Id: <20200917222217.2534502-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v2 0/6] Bluetooth: Add new MGMT interface for advertising add
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
capabilities for the client's benefit, this series also adds an MGMT
command to query controller capabilities, which returns a flexible TLV
format for future flexibility.

All changes have been tested on hatch (extended advertising) and kukui
(no extended advertising) chromebooks with manual testing verifying
correctness of parameters/data in btmon traces, and our automated test
suite of 25 single- and multi-advertising usage scenarios.

A separate patch series will add support in bluetoothd. Thanks in
advance for your feedback!

Daniel Winkler


Changes in v2:
- Fixed sparse error in Capabilities MGMT command

Daniel Winkler (6):
  Bluetooth: Add helper to set adv data
  Bluetooth: Break add adv into two mgmt commands
  Bluetooth: Use intervals and tx power from mgmt cmds
  Bluetooth: Emit tx power chosen on ext adv params completion
  Bluetooth: Query LE tx power on startup
  Bluetooth: Add MGMT command for controller capabilities

 include/net/bluetooth/hci.h      |   7 +
 include/net/bluetooth/hci_core.h |  14 +-
 include/net/bluetooth/mgmt.h     |  48 ++++
 net/bluetooth/hci_core.c         |  47 +++-
 net/bluetooth/hci_event.c        |  22 ++
 net/bluetooth/hci_request.c      |  29 ++-
 net/bluetooth/mgmt.c             | 420 ++++++++++++++++++++++++++++++-
 7 files changed, 561 insertions(+), 26 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog

