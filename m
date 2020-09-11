Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C8EC433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 17:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76397221E7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 17:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GZDyuoKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgIKRR5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIKRNM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 13:13:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE44C061786
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 10:13:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so7092676pgd.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 10:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9xx/aNqVyo8F+vwS35kGQGZUtQETH2qUMc7jEIvGGiw=;
        b=GZDyuoKHjUGYRo0q4YPBblihRY7pVBrudliixlJ7RLgVwDc+Kb5t+Undpb8QD8ma1k
         LxcEc4G4bBSIQ2egiR316Cnaz8Lb6jVplZhJXxXv4s5AQPe7Bhs1z9tnzvyqBP56gnxi
         fxVvfLI3EnCu4SpB/ycK4W7PuhQE1S57liyYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9xx/aNqVyo8F+vwS35kGQGZUtQETH2qUMc7jEIvGGiw=;
        b=TnCnbk+TFYXnEgpKEp/Lg0hAvl/wh/MMF3ufZnZlZnStibh6CKxh4ofQ5bjjKF8Qmf
         /q3L3jJFcDXtxCSEQ4ob0pK2BVTBtZv7VpUlHIuxRAYjqEq2Ef7u6dfhs73YA3xCcgID
         Qqizq2LJ1PHHA5mNiNoJGsBOP5fDTOSQxCxZ6G6O+H2+La1Xt1XrAgrXA7lGBnf/Yvne
         Xri7PBfthXFwoOCkf8Z9kMpSnKU0ydASNb5cleXC6zcMYnfNcRSTbY3tdm0x7H3AJ9Rz
         LRuc8FNEpn0nfYoZlTS8anzf71bHsoOG5tjB+M3z5yeo0FlmyPg311hJNARvGQAOibR2
         yF5w==
X-Gm-Message-State: AOAM530KFyQsQq/4ljFCVxaOAxIs5j7l2j9GoyPITBNHOtliDWIMnafF
        /GKcBcOFO9iwZGK2MZ+7J9HSBA==
X-Google-Smtp-Source: ABdhPJydKYhFb52mw7so7AX3H27Z2tg1yZLck6RxPp1D+3/fVJBJsaDGZl3UZMOdjs43ONG+bWVCPA==
X-Received: by 2002:a63:4d5:: with SMTP id 204mr2422300pge.0.1599844391141;
        Fri, 11 Sep 2020 10:13:11 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id h9sm2787452pfc.28.2020.09.11.10.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:13:10 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RESEND PATCH 0/3] Bluetooth: Emit events for suspend/resume
Date:   Fri, 11 Sep 2020 10:13:03 -0700
Message-Id: <20200911171306.3758642-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Marcel,

This series adds the suspend/resume events suggested in
https://patchwork.kernel.org/patch/11771001/.

I have tested it with some userspace changes that monitors the
controller resumed event to trigger audio device reconnection and
verified that the events are correctly emitted.

Patch for btmon changes: https://patchwork.kernel.org/patch/11743863/

Please take a look.
Abhishek


Abhishek Pandit-Subedi (3):
  Bluetooth: Add mgmt suspend and resume events
  Bluetooth: Add suspend reason for device disconnect
  Bluetooth: Emit controller suspend and resume events

 include/net/bluetooth/hci_core.h |  6 +++
 include/net/bluetooth/mgmt.h     | 16 +++++++
 net/bluetooth/hci_core.c         | 26 +++++++++++-
 net/bluetooth/hci_event.c        | 73 ++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 28 ++++++++++++
 5 files changed, 148 insertions(+), 1 deletion(-)

-- 
2.28.0.618.gf4bc123cb7-goog

