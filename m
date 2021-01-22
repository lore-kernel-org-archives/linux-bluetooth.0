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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8402AC433E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 10:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BDE323AA3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 10:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbhAVJaB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 04:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbhAVIhH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 03:37:07 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AB7C061793
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 00:36:27 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id e2so3072978pgg.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 00:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=9yWriwK7EWvY1B0DADj/z9t5RV53wrD6EZpi2cHGNNk=;
        b=kkLoVzDxbBO0oRerAnstdXZ9ifM0A7K8Yrbztb1MatyqH5aoA9KF97HBBEMlBsCArf
         rl1y3LW7Lr26HvVJN8+PhVUmy6afckppcI3+R2z5BXvv8kYWs+dlxVDOtucbTBie2QeP
         U4Fu1CX8/b5zgUZKm2Y+redJG9YFKJKsttjuvJU+M7Tm4dad0g7bWBlV9V1MhV5ZnIWS
         gWKhYSmESRfTk+aJU+LI/vqsS0q6yrcXvWCozMD7DD5oGSjPXONOijx52c27nVgk9Rhg
         hC5cfbTaY9IHd2kVyCA8ryG2dSVxbHQXzkDRC1gLWFeIT18Kr9jvsfctat8fkwCaoCB7
         QMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=9yWriwK7EWvY1B0DADj/z9t5RV53wrD6EZpi2cHGNNk=;
        b=qtRuW4+kmv1a5qB437ZLXK5HYeLWw7JR4aunYTmRtOmPApe8yiHvqhN/6VSY96IqFc
         nONQYTKcSruP8TYitJvSsJM67ubdX33Kp8PG+NBO+1j3Zkd5uZDj+5+NpwkHSj1ZZLUc
         3bMGcJ0aW5ZI0h0d+RUSQrRDrF+XCIcvSkv7MoF8hOkNlWrazBHA90HeEbvkYHq/r1XA
         qBQFVzpGvLKW+EE4wIX7KNDBqXCOAdyiI/xkzkx1JcPdfBEnCJ927uuIDf8t82Whgl4t
         zkCe2fmDm/qTJDzhfpvQhhT4pDKFYkaKEsNtMFwzTuDnbkj/yEWTaj0sClDDfEfnSgLq
         HOCw==
X-Gm-Message-State: AOAM532Q6F95GvO3uyweqXAo0X6kpzHanlC18GReZThk2484AyhlL7Dt
        xrscz6Z5eoSIfwbCHihD0pfsTeIP5xNvx5S0Xd52/M50rh9MbMIH8+X7uexvPKPvqgyKh1GOHaB
        CiL3dklc8cOsHtqYWpBsiLMSATQePDqi4ph9NT1YWU90SCKc4ZRact2ItNmsNPRUcY2VrKhV/X6
        6G
X-Google-Smtp-Source: ABdhPJzrZ8CueWCmlvWFpkaEt7xQ4Y9Krhax6KJBN/wa9NyGEVUmuBDZXCDa7rev4GsucMwnUo5X9yb4p4GT
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:902:ed83:b029:de:84d2:9ce6 with SMTP
 id e3-20020a170902ed83b02900de84d29ce6mr3570976plj.4.1611304586351; Fri, 22
 Jan 2021 00:36:26 -0800 (PST)
Date:   Fri, 22 Jan 2021 16:36:10 +0800
Message-Id: <20210122083617.3163489-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v6 0/7] MSFT offloading support for advertisement monitor
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

Changes in v6:
* New patch "advmon offload MSFT interleave scanning integration"
* New patch "disable advertisement filters during suspend"

Changes in v5:
* Discard struct flags on msft_data and use it's members directly

Changes in v4:
* Change the logic of merging add_adv_patterns_monitor with rssi
* Aligning variable declaration on mgmt.h
* Replacing the usage of BT_DBG with bt_dev_dbg

Changes in v3:
* Flips the order of rssi and pattern_count on mgmt struct
* Fix return type of msft_remove_monitor

Changes in v2:
* Add a new opcode instead of modifying an existing one
* Also implement the new MGMT opcode and merge the functionality with
  the old one.

Archie Pusaka (6):
  Bluetooth: advmon offload MSFT add rssi support
  Bluetooth: advmon offload MSFT add monitor
  Bluetooth: advmon offload MSFT remove monitor
  Bluetooth: advmon offload MSFT handle controller reset
  Bluetooth: advmon offload MSFT handle filter enablement
  Bluetooth: advmon offload MSFT interleave scanning integration

Howard Chung (1):
  Bluetooth: disable advertisement filters during suspend

 include/net/bluetooth/hci_core.h |  36 ++-
 include/net/bluetooth/mgmt.h     |  16 ++
 net/bluetooth/hci_core.c         | 174 +++++++++---
 net/bluetooth/hci_request.c      |  49 +++-
 net/bluetooth/mgmt.c             | 391 +++++++++++++++++++-------
 net/bluetooth/msft.c             | 460 ++++++++++++++++++++++++++++++-
 net/bluetooth/msft.h             |  30 ++
 7 files changed, 1015 insertions(+), 141 deletions(-)

-- 
2.30.0.280.ga3ce27912f-goog

