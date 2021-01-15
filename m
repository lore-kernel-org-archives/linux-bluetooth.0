Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A46C433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE862371F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbhAOLvx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 06:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbhAOLvx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 06:51:53 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF1DC0613C1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:51:12 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id u17so7661955qku.17
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=IFpe3dn8pstixEZLhn7ancheEqYMrAoPdvBifxwYKOY=;
        b=GJ6ETI/Iw/TsohHtvzQ3llmu5ytcvnVsYc+026idRoHu6u1ITZiBqnoXLpm6oC3PV8
         x9XzuZFqKVBp4BaVtBOUek8M8WFIc9uFJYjxKlO0NoGCLa820QEKrRQBWXh55FKP8to+
         lCirHlhsTBvbA5lTtMxAlephkJRDXqE8aq3Srqd5Yznz6Tls8eAU+efza3DPdV8s31P1
         D4o94PPSS3/3Jhdcow+hX+0BUmCP4yTihmOcFNjXISmzXSxP2DD7j8kOOHEl/VasgBNh
         uZjAwwX9xCVx56vrBkmxSKc4+w83NXzPvrpsp31lzLClAym1zwVJS5eBAZZiemUH+g9O
         VgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=IFpe3dn8pstixEZLhn7ancheEqYMrAoPdvBifxwYKOY=;
        b=RQ7FDV5Y9ear/EYDNIgzaL8uoluMrTqmPo69l+hZXXX5SOIwG5WrqgcanpjC6CcAsl
         uco3WzyBeJcoLw1vW2IBHN4iiLEezo+uCvIMs9LLLVgCAts8WU739EkWNpw138O725GC
         XVGJ99GDbNwHcLWlneT23yLWch6MEAdrC6MYLrZrQw25bpu/XPCJdkNF5iIbAJxSR9H7
         YOvR88DZn9d00GGXxJmGkPQTDFP8FPOAtR8/W0smID31ED3B4D7fr38hLukznLzHaBc+
         8fuWQyhWA+PYIKxIqMEYic34+/x1lhqpikRrH95p4qToYSBzcBCfiNNgjHKOyQZIqe/A
         QGuQ==
X-Gm-Message-State: AOAM532ullau2JDdqY45Sf8TskJBuzCh/rW1iHZXQ/SPeCO25jjj1iAC
        J+2StpNwavLnsqZzQttZZLuP7b+OvzkfBtGmcaueecg4O8eHvpZERLfPEh8nQkH0o6dfaqyFxKu
        HXP6yyYXpoc73VKrPD7Qu9So/zIcmVQBG7AuUDTueVTytXrHHTI/iO0I84XcyPDxftBJU2W1ZFI
        D8
X-Google-Smtp-Source: ABdhPJzk/Psx6oI8RStTwkS+0vffw4wdN3PZI6egRXIPn7BG+plvfEx2CUs7ZqF+7edy+TrBNuCASAhFxeve
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:fb0d:: with SMTP id
 c13mr11707031qvp.1.1610711471767; Fri, 15 Jan 2021 03:51:11 -0800 (PST)
Date:   Fri, 15 Jan 2021 19:50:32 +0800
Message-Id: <20210115115036.3973761-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [Bluez PATCH v4 0/6] Support advertising monitor add pattern with
 RSSI opcode
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Hi linux-bluetooth,

This series of patches adds a new MGMT command for adding a monitor
with RSSI parameter. Changes are focused on passing parameters to
the kernel via btmgmt and bluetoothctl.

PTAL and thanks for your feedback!
Archie

Changes in v4:
* split the add-or-pattern-rssi command
* update doc

Changes in v3:
* split the struct RSSIThresholdsAndTimers

Changes in v2:
* Remove trailing period and fix order of mgmt parameter

Archie Pusaka (6):
  lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode
  doc/advmon-api: Introduce sampling period property
  src/adv_monitor: add monitor with rssi support for mgmt
  btmgmt: advmon add rssi support
  bluetoothctl: advmon rssi support for mgmt
  monitor: Decode add advmon with RSSI parameter

 client/adv_monitor.c              | 258 +++++++++++++++++++----------
 client/adv_monitor.h              |  11 +-
 client/main.c                     |  72 ++++----
 doc/advertisement-monitor-api.txt |  78 ++++++---
 lib/mgmt.h                        |  15 ++
 monitor/packet.c                  |  43 ++++-
 src/adv_monitor.c                 | 267 +++++++++++++++++++-----------
 tools/btmgmt.c                    | 160 +++++++++++++++---
 8 files changed, 625 insertions(+), 279 deletions(-)

-- 
2.30.0.296.g2bfb1c46d8-goog

