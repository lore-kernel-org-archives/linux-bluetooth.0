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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E831DC433E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FF523405
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbhAMJt6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbhAMJt6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 04:49:58 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23630C061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:49:18 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 188so868807qkh.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=rKOAQANclabA/uCknSSdeYG6Y1zoRt0D/V/SCf/ujro=;
        b=bmBYbfGwdM3qLZ5rdkbI/V9KpUHigllhwcXLnm9kClokgLdyB050TRlkvLlbc5TRp0
         YCrc2T4axdvxt+i6ZGed3AtLYhcNr5ZD+cz0tyR6bNO5IdPcNZ/gEGV/VWHeK8X2IWsD
         VmZbGfmWfNeBFB4vcDfR8+V9n0pxcl2spBulXwvIoOu5uaprYkFnDka+JOQgpW3MJUNt
         jdKQr1LbhG3fdtOpN+dD1nu7Ia7HFRcDrUi+r4CiusIxI/3fgxlRIvQ3oz+cjFWc36AY
         HcdZurEMb1ZRY9pTnSSSXUoH2VWwtpDKOhKnSo5sa47efkwUOvZ54kl6XKXMFUytrebV
         bP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=rKOAQANclabA/uCknSSdeYG6Y1zoRt0D/V/SCf/ujro=;
        b=Flr1bYmtW22TFMq7APFJCl1JTgKlegnJPInziiz+ahY60aClReO0hpaZh+VuoAy6nK
         3jpvWbXvfTDn9ttVOlDIxzJOifFS776QvDtiKGKckTEQSHN/c/uxxir2jJYieMXldBcQ
         BZ2+wKRF4CdMTGGPnp8euBKUrfRpZHc1m8KzWuTASHVPUN1YykACML3nhqIwoUGulyM/
         tsyTrrjgiaioh3Y2zsfytJUEHJS5/DB9Y69TfFGBL2GQwgB74wKLEN558oCkiLTd8npA
         qZ/pc0QBFf4PzI8NL3ud69xTSvA3i0lNpaU/HI1551CFsS77ww3ih+ZIxH+ODgL1mvUO
         DljQ==
X-Gm-Message-State: AOAM530YsXf7m57Liry0DUGvkzDB8DbS40/xNicRPQ3J0PVPMS7LBb6/
        qBb75FLe7wypPB1QUy1FAO/d48i0ZUzXPlLc1dra3eR3ZW+NOzAqv59n8lSoqWIZYjzgKOuA0Es
        KarJgylWXJmVy0XJZYY3dCu1Ky+5QFPu/DhNltBhWAGDF973xMroNKuerKNJd5mNYpRwrhvvuek
        0D
X-Google-Smtp-Source: ABdhPJze23GlhDIK1JVYnYuVkVYhutbQhBzRSmfmqBz52Zx5yIfCytKGE3RoRnHYW7RIzQ09EJXxTMNZYIIj
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:ad4:4e09:: with SMTP id
 dl9mr1209959qvb.44.1610531357163; Wed, 13 Jan 2021 01:49:17 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:49:00 +0800
Message-Id: <20210113094905.2787919-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH v2 0/5] Support advertising monitor add pattern with
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

Changes in v2:
Remove trailing period and fix order of mgmt parameter

Archie Pusaka (5):
  lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode
  src/adv_monitor: add monitor with rssi support for mgmt
  btmgmt: advmon add rssi support
  bluetoothctl: advmon rssi support for mgmt
  monitor: Decode add advmon with RSSI parameter

 client/adv_monitor.c |  90 ++++++++++++------------
 client/adv_monitor.h |   1 +
 client/main.c        |  29 ++++----
 lib/mgmt.h           |  15 ++++
 monitor/packet.c     |  43 ++++++++++--
 src/adv_monitor.c    | 143 +++++++++++++++++++++++++++++---------
 tools/btmgmt.c       | 160 ++++++++++++++++++++++++++++++++++++-------
 7 files changed, 357 insertions(+), 124 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

