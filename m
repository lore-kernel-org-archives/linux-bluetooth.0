Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2A1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiBXAbB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBXAbA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:00 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712B76D95D
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:31 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id l19so422410pfu.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M4n2dfSgOn7fSyz3kM2OSr+Y1CQv2yBSdZHlI0VaKvQ=;
        b=cefSseh6MZUtK72XOBvTUcXvKWCQxK5CGDuRYbhBF5kGZVXsfx3NTT20jlYfrRRe6b
         4WNqpW0pgpzp5rCzNcTZlLNjMoM08TUk1dTJFMLN6D9BxlrGY2O2OitpqaKWx3Lneyae
         OUWGXiIgsCXg3+sR3d9jTEdvX0tTo5+9w1PXnWPqzgmJVqBRDpLLLmvxuw/UgEVVi12E
         PyhXwGC5K7DqI+lPTbTq4TYts8XFT5SyvsPy6eRzs8xFXzqok9atUbJUMXL+8NQCF2S2
         sJYHqI0yuRvPkQIS69U6SpLU9WeNEn8IZiOUMx37Odehovk4krYUYyvovZpgjUB1fzPR
         RPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M4n2dfSgOn7fSyz3kM2OSr+Y1CQv2yBSdZHlI0VaKvQ=;
        b=1ZD50oittvGc4NAZhRUQkP+Kw6Nf40axXzKBV5hX/pY24+J4ZNKJy0QXc6RXPWWcgK
         ydz1xtZmYKVdASVhWlmI+Yu6kMk46h725xOYBPFxv/1Z/JTPY7BrC2STXvcELAogDyJn
         kN7g70b+c//fh0PVcdwi02quKg25kIVGlpV0SsURBqQbLecG492zuR32bTrnampiGq+b
         BvjZrN4RC9wEiYMvZE01pvyyZEmTEoU+TDgcytbBF2/grOUt1faDLBC8Sj6E3KettSER
         E9HgmQ+DeXCzvclEzmQGzeZ1cirJIVgXWH3BRw0CYdIhbZ6ybqi+SdueQ5H+EJ96xwbG
         g9Ng==
X-Gm-Message-State: AOAM530blKRsMB48QRZTy8AN/1a7FmwDZ/iDqcab4i0Q86o5b0gXH+9K
        YIK+vImAADI1NJFomjOsE/ASDC7ybwU=
X-Google-Smtp-Source: ABdhPJxHDfCajx43Yc6J1RGjHMBvYO4yoVhSKmMs4yuldITHjzHxZ846LRLn/V4m1IW6bzhGOHHLBQ==
X-Received: by 2002:a05:6a00:a92:b0:4e0:57a7:2d5d with SMTP id b18-20020a056a000a9200b004e057a72d5dmr177885pfl.81.1645662630734;
        Wed, 23 Feb 2022 16:30:30 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/11] emulator: Initial Broacast Receiver
Date:   Wed, 23 Feb 2022 16:30:18 -0800
Message-Id: <20220224003029.706163-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements the necessary commands to be able to emulate a Broadcast
Receiver:

BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC
BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL
BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC
BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED
BT_HCI_CMD_LE_BIG_CREATE_SYNC
BT_HCI_CMD_LE_BIG_TERM_SYNC

Luiz Augusto von Dentz (11):
  monitor: Fix Create BIG PDU
  btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC
  btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL
  btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC
  btdev: Send BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED when scan is initiated
  btdev: Send BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED if remote start pa
  monitor: Rename Periodic Advertising terms to PA/pa
  btdev: Implements BT_HCI_CMD_LE_BIG_CREATE_SYNC
  btdev: Implements BT_HCI_CMD_LE_BIG_TERM_SYNC
  bthost: Add support for Periodic Advertising
  bthost: Add support for Create BIG

 emulator/btdev.c  | 455 +++++++++++++++++++++++++++++++++++++++-------
 emulator/bthost.c |  32 ++++
 emulator/bthost.h |   3 +
 monitor/bt.h      |  91 +++++-----
 monitor/packet.c  | 113 ++++++------
 5 files changed, 530 insertions(+), 164 deletions(-)

-- 
2.35.1

