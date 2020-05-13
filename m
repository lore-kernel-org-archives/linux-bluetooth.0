Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3488C2D0F6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 02:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A171207BC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 02:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i4oyZDha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgEMCTd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 May 2020 22:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgEMCTd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 May 2020 22:19:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30411C061A0E
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 19:19:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id j13so294436pjm.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 19:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkqIDoib68FB2JDTnUdkS+sJ6c0KSJCfPM4XCGL9+wo=;
        b=i4oyZDhasB3BK4N58xBJKFV7wb9fn+1SGRZKwR34UdXB63m/A0ctudRtq27LnDuPzX
         TLoqbyusguNq5jwMxryJrk5tkyJWysGVxhcZ+27xGGZmOdC3T+RzhjNVrpG1o6ewhF9f
         MtCITc7U9pKFK3h0/jGDni3RSnjduO3gFObFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkqIDoib68FB2JDTnUdkS+sJ6c0KSJCfPM4XCGL9+wo=;
        b=OVlJOb4J5CTYQ4UPmz2sM3U57ru6Kojpuz6XhKz5pKLrUBiGiL+bEcH/kkXZsQph1q
         u3DqkwFnzKlb34Q768T1DPYTRC8VaZ7fUgJK0BmI+ynd66HhNTE5xqH9Cdt1B/Hcv3+Q
         68wJ6cVo5mNOYIroUVvXbCQZ1O7xYbZ4XtgQiXeh4TdP+BJD+lwrDdCOGhHLgREkPhO5
         4Otr304jq0CzLkatA1VD34YrtuP4zjstfiFrTfAoalAS/xIUsYSwBJNiBNLe+w4CCMTf
         6JMOBXOVYC/Y+fe2aa87Oz40VFRhjt2k5JF2MUO5wtBWkJInR4La0wq3V71dgEZ26Bet
         P0Ug==
X-Gm-Message-State: AOAM533S9Ll+ywSQjdpMw0cMYGwVK3HyaNv2Grr5UhokIyUGTvsY2TRQ
        GrKqLf2wfQK9V2qet9I9wSoIlQ==
X-Google-Smtp-Source: ABdhPJy1z/U/SgoeHL7kpt3JfXpLpI+JwdlQqILbEJfVHiYHPh4Qblisl0P/YTYl50n/NcdWbdpM8Q==
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr1122508plm.198.1589336372539;
        Tue, 12 May 2020 19:19:32 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w2sm14170600pja.53.2020.05.12.19.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 19:19:32 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/3] Bluetooth: Prevent scanning when device is not configured for wakeup
Date:   Tue, 12 May 2020 19:19:24 -0700
Message-Id: <20200513021927.115700-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi linux-bluetooth,

This patch series adds a hook to prevent Bluetooth from scanning during
suspend if it is not configured to wake up. It's not always clear who
the wakeup owner is from looking at hdev->dev so we need the driver to
inform us whether to set up scanning.

By default, when no `prevent_wake` hook is implemented, we always
configure scanning for wake-up.

Thanks
Abhishek



Abhishek Pandit-Subedi (3):
  Bluetooth: Rename BT_SUSPEND_COMPLETE
  Bluetooth: Add hook for driver to prevent wake from suspend
  Bluetooth: btusb: Implement hdev->prevent_wake

 drivers/bluetooth/btusb.c        | 8 ++++++++
 include/net/bluetooth/hci_core.h | 3 ++-
 net/bluetooth/hci_core.c         | 8 +++++---
 net/bluetooth/hci_request.c      | 2 +-
 4 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.26.2.645.ge9eca65c58-goog

