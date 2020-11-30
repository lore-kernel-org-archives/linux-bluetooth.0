Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A661C83017
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 22:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204212076C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 22:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEc5VvYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbgK3W6w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 17:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388705AbgK3W6w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 17:58:52 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5010AC061A48
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 14:57:51 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id f29so7713459qtv.23
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 14:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Dy6XabYltzDFFz13ChKYqu9T0LvhtUKRAOX7IwyjQ7E=;
        b=dEc5VvYi5t+NBouAT/ZIGYMPddy8e3Yra8lkPDcyvSZ55Ml9hS3zvkynvCqSstBTfM
         Bbc8CoLSfd0I9i/UpAZ9T9xUIvMpnEgKUsJbkSjDkAMC87QVrPDQ3vmgdQJrOzGE5iJe
         tIJXIiLdE6SL+tFD+GLUKW9lXLrCiHSR+cBHerY3jMbmQo06ynOSLzUJ83Lre4ni0DFx
         4Dzh9c64K26+7KJmkmJmMWY92x2Gf9yJiFVynBYPXmAv+oresiLxFn4FVSjewzVW5kZN
         O3XhQ/DokyrqDpeJ67Nf2z8hIWxPfdJ3hHSAXwzCOqlRfdkdHWtUoxLHduAwENnj1t39
         HdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Dy6XabYltzDFFz13ChKYqu9T0LvhtUKRAOX7IwyjQ7E=;
        b=XlTMHXhc72e/Q+BS+QfjJG2v4fWEspoUJDmvc4UTSw+Y5Tc6JZDLJuigcZRz6Gdy+I
         Pmg5f3Oxe+dUDit+huBd0cYEIAQHiEARO/Y2jMso6biY0z3dVbXfHsTXfdOO7iNMDBsV
         iQuV0c8EPqzJeF2k1HvV+vLbvEnRlWHtkUuTozZPZccxhFCpRwFa7jNR/JqIW+ELqm8U
         4gKMIUad0Co0Pnr1NEAxrDs5I13B41tt4j14+ZEq5XGLBRcwwGZThiU+txwsfBk8o6hJ
         QH5xM0207O5t58zTXDyoSK0AqDzaCICIY/mfKqnMrjlBbRBqz4CYCS62mR+9Ct408xKj
         7bUQ==
X-Gm-Message-State: AOAM532+Wof7+H/YQOdwGwNLnHnmGWw5AWJwNdCFDlPllEU0FL/zYNgN
        jkv44MvU1HL91FkXdq2up7AABZzvk6/fHdT8VVFU
X-Google-Smtp-Source: ABdhPJy2dRmE6ae2DjfLyY8TSQlOGUXwrHCtfVYT2ZRwseNezxmF6I88pISzuaNxMRG4fBOFOpban8s1hk02ftjKQxLV
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a0c:be02:: with SMTP id
 k2mr25630951qvg.49.1606777070464; Mon, 30 Nov 2020 14:57:50 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:57:39 -0800
Message-Id: <20201130225744.3793244-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v6 0/5] Bluetooth: Add new MGMT interface for advertising add
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
2.29.2.454.gaff20da3a2-goog

