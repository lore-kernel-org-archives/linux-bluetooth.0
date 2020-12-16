Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE532C0018C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 04:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52302311B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 04:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgLPEee (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 23:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgLPEee (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 23:34:34 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC4BC0617A7
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 20:33:41 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id x19so15800487qvv.16
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 20:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=6HUv5xBPfwv697/YWNrZvCYxuhXudwcF4fT9FoZkAj4=;
        b=GmyxLUYdRz9+qga62iB6VIcK1jnoR5/TAbHFy9VUjQtjHaJx/uUyS5DMypsnLs/cBX
         dzdEt4JLhaZ8fccclYkvDInRiBrG+OIQqEA8LRQPu+1b5MKPfeEMOICrIGRT9rS0qIEG
         tPBb3rdkfEbpdHA/ptKfMD/M8jBz1UD6/40/P3Kbd5Iv5mRkSY3ao9nRwxfYr0B1p241
         J365D4IKT2W5gaqmXpDQudeLgd0BJSgy9+RtAseAR/GHdYhjXmCj4f9KElkUO5fKbmTq
         uTXkgzsHBkQ1vhiWYdEHzMRNWyk/HdhmUwG3NxdLzzQtgEPhGQuefCV1HRkHwdoqeAhE
         oO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=6HUv5xBPfwv697/YWNrZvCYxuhXudwcF4fT9FoZkAj4=;
        b=RW6p/gf5nU00W6sIzf3RSZuZ2kluF6he00Ymn2QrSwY3bWT0ricqcw2+BqZ56TaspI
         vnYfuSO7/lhvIY1GuV1W1e+D/aARigs3weqArKDCjua3oqwJRXoWjhLzUp8KG/I4xvv6
         MCUczXHWv2A6FedZKFIHXbE4E7xyau0VILHjcwy0li4yDEs4YMDt3WZrI17K9++ezHMS
         hK0dQf8UjNt5CByODLLF8Pu5Ji+aL22lG8lf0Wv7fqP26cx2prq6iV02xvL0egQQy/wL
         PmgwjMh+NiYUuTxKk6fptq/P5oLH+H3OBKQ3nqCMQkIRocCmoP02VOhhKd87TOP+pZnC
         ZQWQ==
X-Gm-Message-State: AOAM530SxR7i0o2m0z4fuaLqCEH0ie6gkvAbGVdMzHVj+9REMmwfiM9m
        +EiNK2oaySwQgwmCzrzDELL5zcDKWTVhcfhuXKYG100MXLwEz4unC9bMYump7QggLp3n329q099
        Gm/eD7D5+sEDBlXNffr6XAR8uoHn1GIC15R1madlsbIrJkl/OpOO87oqPWrVn1P6hSgojET75iK
        Po
X-Google-Smtp-Source: ABdhPJzrIlUctDldqUAWGAIaZEe64YkVK+9nRfWWqMetOJ/7CR7627hcwImixzIAnRQZrAjKfSSoAVt26J0K
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:f38a:: with SMTP id
 i10mr41879713qvk.32.1608093220706; Tue, 15 Dec 2020 20:33:40 -0800 (PST)
Date:   Wed, 16 Dec 2020 12:33:30 +0800
Message-Id: <20201216043335.2185278-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v3 0/5] MSFT offloading support for advertisement monitor
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
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

Changes in v3:
* Flips the order of rssi and pattern_count on mgmt struct
* Fix return type of msft_remove_monitor

Changes in v2:
* Add a new opcode instead of modifying an existing one
* Also implement the new MGMT opcode and merge the functionality with
  the old one.

Archie Pusaka (5):
  Bluetooth: advmon offload MSFT add rssi support
  Bluetooth: advmon offload MSFT add monitor
  Bluetooth: advmon offload MSFT remove monitor
  Bluetooth: advmon offload MSFT handle controller reset
  Bluetooth: advmon offload MSFT handle filter enablement

 include/net/bluetooth/hci_core.h |  34 ++-
 include/net/bluetooth/mgmt.h     |  16 ++
 net/bluetooth/hci_core.c         | 173 +++++++++---
 net/bluetooth/mgmt.c             | 333 ++++++++++++++++------
 net/bluetooth/msft.c             | 456 ++++++++++++++++++++++++++++++-
 net/bluetooth/msft.h             |  27 ++
 6 files changed, 919 insertions(+), 120 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog

