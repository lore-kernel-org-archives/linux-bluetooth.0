Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DAAC63777
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 10:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC92B21D1A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 10:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbgLCKa0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 05:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbgLCKa0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 05:30:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D42C061A52
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 02:29:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i184so2084605ybg.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 02:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=zRqNYgUmSE76iYT5WRcqvOInql38s1jQQXDR9piPn7M=;
        b=n5DdBTUwOmAwYQskeWVbaZtHC1SPMDNbu8+e+yWVTQuHx2H4+2gSDCxEm7djuFVraU
         H9K3dx/xs4w3ujH0yaqvLe7YODEWKLwv3DHY0n29N1g2UG5+p8i/waa/CVyPEBAO3kPe
         GxanXBUhYMb24wbEswuhd/6ZT3XIzsao5to86dzVbO0PzByNZQcfsYf9p9w6BQ8gqnsS
         kr/WD8a2er+QUCdm10fZbN0dpT7HUD37TtF6W47L+F9eAxj+huPwv6mRoKmecdkp6G7P
         QdPPiyYI9nEjhOVT2JwkYOVDhYeyBIm9Xqc5ZZhzM54f3xKX2RDANZ/g+YXqaLKv5K/2
         1nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=zRqNYgUmSE76iYT5WRcqvOInql38s1jQQXDR9piPn7M=;
        b=mfsZwFztIw0l5/QjRRjIFHlkWID8//vYanXgcnX03kom0tfcBxhOIBQbZMH3do7cMP
         4tuzdoGxxY/MoUCtQWKFXLFV70hz0tGyjvRUbc84D65rJ0cHoX9SUekkizN1d3BcplQA
         cKHm9mOZ51f8AKJcL2MHSWpdGVCRpr5qqt/GOaEszSgJdHVCPyTlW28HkyfRRqYVbIpI
         +G/NZNgmUScPd+cpKGCvWAMlgQar0Tohq0AA5C7pvcF99PyETem9977Y7423R7wf6SIS
         ePthCBvSmslQc6d616Bqw1UoY5vZugUx6kgfPkZX5RrBhImDYLgMyx0MLt/pRGscl65C
         YtMg==
X-Gm-Message-State: AOAM5326SXa1lHVwzWRlkiVx5Tt3wLUHb+2PXhgrpkvpYZyGDdbK9igs
        NgzSrcn3mmLSKpGNgHSXcYhPLiJLav6peXA7pUo/X+KkRQvqa89BAj40YMUEjbC7pwy20UKWRB8
        ofswpnZJM31CEaXeCq7M+RsrR1AhR+19RsvtCtnTXShniKiyZHnLG0ys/7zuv4STpq64mPgW7qR
        fz
X-Google-Smtp-Source: ABdhPJzgThzsPymJjNZyRNKoGkPfrQvdGV5trnSCuPmuB7YXsIMWTsRyzBh/Pj8Fdo0Nxcw8NZbH3ibgxRhl
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:5442:: with SMTP id
 i63mr3997665ybb.344.1606991384895; Thu, 03 Dec 2020 02:29:44 -0800 (PST)
Date:   Thu,  3 Dec 2020 18:29:30 +0800
Message-Id: <20201203102936.4049556-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v1 0/5] MSFT offloading support for advertisement monitor
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Hi linux-bluetooth,

This series of patches manages the hardware offloading part of MSFT
extension API. The full documentation can be accessed by this link:
https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/microsoft-defined-bluetooth-hci-commands-and-events

Only four of the HCI commands are planned to be implemented:
HCI_VS_MSFT_Read_Supported_Features (implemented in previous patch),
HCI_VS_MSFT_LE_Monitor_Advertisement,
HCI_VS_MSFT_LE_Cancel_Monitor_Advertisement, and
HCI_VS_MSFT_LE_Set_Advertisement_Filter_Enable.
These are the commands which would be used for advertisement monitor
feature. Only if the controller supports the MSFT extension would
these commands be sent. Otherwise, software-based monitoring would be
performed in the user space instead.

Thanks in advance for your feedback!

Archie


Archie Pusaka (5):
  Bluetooth: advmon offload MSFT add rssi support
  Bluetooth: advmon offload MSFT add monitor
  Bluetooth: advmon offload MSFT remove monitor
  Bluetooth: advmon offload MSFT handle controller reset
  Bluetooth: advmon offload MSFT handle filter enablement

 include/net/bluetooth/hci_core.h |  34 ++-
 include/net/bluetooth/mgmt.h     |   9 +
 net/bluetooth/hci_core.c         | 173 +++++++++---
 net/bluetooth/mgmt.c             | 263 +++++++++++++-----
 net/bluetooth/msft.c             | 456 ++++++++++++++++++++++++++++++-
 net/bluetooth/msft.h             |  27 ++
 6 files changed, 853 insertions(+), 109 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

