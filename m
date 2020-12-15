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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD077C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F932229C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgLOIcv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 03:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgLOIcv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 03:32:51 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3283AC06179C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:32:11 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id f3so13687115pgg.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=fe1km3yfxmczncgouQwLa2uCpf9EDAfkHINKI/Vhceg=;
        b=pg0LTRa3ZvcyZMwu51VdorUHI4theOfbNwh9Hw7ALeyxmHoQyminTLmEnX0FrDAbRZ
         WlV+gujM42wj7dIzbmuwatahwhDQW2nLEo8a2+NhZCGM7Z0lBUgqUDoOcZ5lgx20eHz5
         W4dNpeuRH2/EoL6JfOM+MJwwGGIa5kLXAmXV42U8f/Kzhr0yM5C/5mwaKe7nJ6yrbLtl
         NbkiKkX+HFVJvjGyQmRG4ZgYirB/wBiU2pkk2tNP7q+fJrVnZu1IL2mmM0hDAWF+VN7+
         wp+4a30W12k4OqvqtYyytodm33EGLTV1vYN2GdBT+Uedne9B3BG25K+gErJ9LD9G8F3N
         ZkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=fe1km3yfxmczncgouQwLa2uCpf9EDAfkHINKI/Vhceg=;
        b=gtpkGNxU6BulWDeRpsv8Gm9CA/SQqvUU4VQCRiW4bsPKh0PBGAFhc9b0KLou7ggQSS
         rOLmVCgUc07v5ES/OFXoUq6yxpD37s3y1s2T8qsraVM2eRl3JypcY5LcCZGk0ElEruAC
         /ObgVC7OVSYCqpd6REkstXb2PFXF0w5epa/G88u+wbsXGtZx653/3aw+s37f0Bf9hcfI
         5R5gfHwom6KC/WreDOjNJdamoVbn4zPDobNe1OqFadfE4sB0ipDig9tD0PActG67pxEf
         76odzAQ8bSbnh8MJVi20zWxU/NAztcYRP3D6PlVELI/5adZMW8fEM+eQXtEaMggP2ThV
         6mhg==
X-Gm-Message-State: AOAM533Q3DpJ+n3GhJrf5RfCGpQjzByH8G1NmpWgUukY4321w2e8LJov
        HKznBql73/TZhjGtn+YTqxeOa8iTMOOWMO46oB25bDdYq3ZUeuMj1j3bweoK/aUnpdqhMqoMMJG
        9iGDAWKo2CFnRCfu2V5kXmxUHoRiCK91DROBnI3JW7ixeE23ARdYXDyRMVdv0wvkT/xI4V0naPk
        Ad
X-Google-Smtp-Source: ABdhPJyHFmFx1T+NbiSbfwLZtAeXJfRairfMEb0kbPranBvrnu+mqbSUtYTxVlceam5btLIAyr9WjgGQ0hgN
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90a:cb8d:: with SMTP id
 a13mr28800707pju.155.1608021129175; Tue, 15 Dec 2020 00:32:09 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:31:56 +0800
Message-Id: <20201215083201.1343692-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v2 0/5] MSFT offloading support for advertisement monitor
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

