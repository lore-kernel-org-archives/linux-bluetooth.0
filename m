Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A52BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA0464EDB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbhCDAds (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbhCCQfP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Mar 2021 11:35:15 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C31DC061756
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Mar 2021 08:34:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ba1so14343614plb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Mar 2021 08:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyynLq8oNgsdRcq781UggdGgBFy7WDx8dH3cl7LA92c=;
        b=ceDBj2t/llHpk+rrrZDaEoCVbRxB6QyxGyVd/vBbz+W9RkHeJMwURrduxhcKFEsNTy
         JfnpMu3ayxmdI2o/FTvnXcLYQIQLvuqzxNX3jf3WTxU5hKFBqlP3/8KG4bIvQkDikv59
         UtctDcf2vktO2RYldfZ2/WiP1hH1f0UJpgUMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyynLq8oNgsdRcq781UggdGgBFy7WDx8dH3cl7LA92c=;
        b=a3NlLSEWari62unNLhwOXs2+CeeF+gJqeEUYDNlufkxapOs24XYjknay5GwurUHE2o
         cBvGvU8Az7CPJA8kFWJhGR/LICyznB1J7xxYPYst6OrY+4dgZLYTD93n6N69LvS1pEwo
         GcWkpvfObzRy4z6k0RUGL4jaO3+iUjCUcI6rVpGsOG9TkgzSMBz0CT3mw04YdNdJ/2M/
         sAszMVmB1U/XPaWrNKyocm9cOmCeU/VfAERTqMsZk92RH+azVfl19x9MnbzouVrtZe6j
         bNri+ZBM2vY1yKpcfli2t7hN1unAz1KCWA2L3XJy0zI2XDZAVgSCStF5r0pvxpWQVog/
         iCOA==
X-Gm-Message-State: AOAM532DLGg43bfD8GTf7odp9z9o4nFGe+a89/XPySVOob2KaXvsaGeI
        asw+jIR6D4Yz3CcMqrxl2I/ObQ==
X-Google-Smtp-Source: ABdhPJxzjXLS2F9xJ4TXaML5kwnyCkDuGc3a3XxOb2mwCC/6u5nrQqqJYKpUj1lDI1E/zTZKHRckdA==
X-Received: by 2002:a17:903:2301:b029:e4:700b:6d91 with SMTP id d1-20020a1709032301b02900e4700b6d91mr61218plh.19.1614789251798;
        Wed, 03 Mar 2021 08:34:11 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:9c83:cccc:4c1:7b17])
        by smtp.gmail.com with ESMTPSA id a21sm3171172pfk.83.2021.03.03.08.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 08:34:11 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v3 0/1] Bluetooth: Suspend improvements
Date:   Wed,  3 Mar 2021 08:34:03 -0800
Message-Id: <20210303163404.1779850-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.31.0.rc0.254.gbdcc3b1a9d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Marcel (and linux bluetooth),

Here are a few suspend improvements based on user reports we saw on
ChromeOS and feedback from Hans de Goede on the mailing list.

I have tested this using our ChromeOS suspend/resume automated tests
(full SRHealth test coverage and some suspend resume stress tests).

Thanks
Abhishek


Changes in v3:
* Minor change to if statement

Changes in v2:
* Removed hci_dev_lock from hci_cc_set_event_filter since flags are
  set/cleared atomically

Abhishek Pandit-Subedi (1):
  Bluetooth: Remove unneeded commands for suspend

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 27 +++++++++++++++++++++++
 net/bluetooth/hci_request.c | 44 +++++++++++++++++++++++--------------
 3 files changed, 55 insertions(+), 17 deletions(-)

-- 
2.31.0.rc0.254.gbdcc3b1a9d-goog

