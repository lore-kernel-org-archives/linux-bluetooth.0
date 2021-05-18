Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D528AC43600
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 16:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7925611CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 16:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350830AbhERQhA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 12:37:00 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:22767 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350816AbhERQgp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 12:36:45 -0400
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 18 May 2021 09:35:26 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 May 2021 09:35:24 -0700
X-QCInternal: smtphost
Received: from gubbaven-linux.qualcomm.com ([10.206.64.32])
  by ironmsg02-blr.qualcomm.com with ESMTP; 18 May 2021 22:04:49 +0530
Received: by gubbaven-linux.qualcomm.com (Postfix, from userid 2365015)
        id 37DF822170; Tue, 18 May 2021 22:04:48 +0530 (IST)
From:   Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Subject: [PATCH v4 0/5] Enable Bluetooth functionality for WCN6750
Date:   Tue, 18 May 2021 22:04:41 +0530
Message-Id: <1621355686-29550-1-git-send-email-gubbaven@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

These patches enables Bluetooth functionalties for new Qualcomm
Bluetooth SoC wcn6750.

Venkata Lakshmi Narayana Gubba (5):
  Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750
  Bluetooth: btqca: Add support for firmware image with mbn type for
    WCN6750
  Bluetooth: btqca: Moved extracting rom version info to common place
  dt-bindings: net: bluetooth: Convert Qualcomm BT binding to DT schema
  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
    wcn6750

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  69 --------
 .../bindings/net/qualcomm-bluetooth.yaml           | 183 +++++++++++++++++++++
 drivers/bluetooth/btqca.c                          |  90 +++++++---
 drivers/bluetooth/btqca.h                          |  14 +-
 drivers/bluetooth/hci_qca.c                        | 114 ++++++++++---
 5 files changed, 354 insertions(+), 116 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
 create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

