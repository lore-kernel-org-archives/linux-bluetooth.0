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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF71C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 07:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397AA239EC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 07:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbhANHpx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbhANHpv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jan 2021 02:45:51 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEA1C061786
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 23:45:05 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id h1so3723852qvr.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 23:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=o13ADg4iI9l11EURz4a5gjc99wv2IkOwdAm6OfanhYM=;
        b=mi0yIY04KbLjdAoQMgU+zet+R85MRSKEPouuMJUMuGkj9FZSJsj+VgQ0NZmBB0qs7R
         r/4uiBVPCSLU79Gg/UDOm9yQaJ9TJ1ALNrAGEX/8gOx6Oy97pa3nh3evI1YLEiYD+oEP
         Hg4JUPvY6u221kPLbuYRk50a5cCGfPHwUCg6ff3U2Z0LSxMw86yi6SRdI8E4C72MRHs/
         e0BZD/AoOo20RNsVRq2/LSl6HrN+zi75atE9wC7+iPI6D2B+itl1W5eO+my4/ApHmrrH
         yI2JceUn4tWSS3gco94FBPd/uA0Xgc/2Swm97gzHDxSCejVIWlhYH6K0p4zmVuD59GIh
         6WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=o13ADg4iI9l11EURz4a5gjc99wv2IkOwdAm6OfanhYM=;
        b=deiT7rt8wpquMHHck0NjGgGc0K/PzbK0O0tavh4dNX1nj4rztcRhUMVz8ovzRTZ62a
         YIr4yf/3t68xaKCneaZNo4Ji0BKwspvQyPdUjmF9QmHTD85P8G1G1LtpsGaLFhaIXMmz
         8PBQoqjvstH93lE0qCvkEInXcwZMQej5ANC6biusmo8RXygpq2ocE4KR9tepVT3ORQOO
         zguKvTpfUiJdxSMIkW71yawlgXFC6hcy0iNBtb5LAS8RysLZTNbM2836nVtAX75600z6
         JNmvlR4Yr8l/+PVsRgS5OEakD/4OCHKtHa+dfxcj5je79WKFkXjdoin+MIMbZTt7gSQ3
         paow==
X-Gm-Message-State: AOAM5302BZWqYQdf6bJcx7XsYSgRRqgRzfc4Mzrkgdo/Mx5t0L6XU9yY
        7GI4TfovDwFjDWWd1O1nV+gXB4LS9zIEWBeNDfot1RxzfPydLq8Bn05zert7liPoOo472D0v5Cq
        m3Nfzr0RoLy4iFL+U2eezJ5NtGg+4z0draeZkC1wbETjpZuXSxRLGJORvJFxPP1T/wfmeRZrTUK
        iA
X-Google-Smtp-Source: ABdhPJy6+hVNOodLTo0/zHC0Uo0rjR3kpVZ+uxuSUgO3Y79yXkRk7iZAJ2/WiOsgIaa1l/yYeJnw7bZUP00z
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:8445:: with SMTP id
 l63mr6097884qva.60.1610610304798; Wed, 13 Jan 2021 23:45:04 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:44:53 +0800
Message-Id: <20210114074458.3399055-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH v3 0/5] Support advertising monitor add pattern with
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

Changes in v3:
* split the struct RSSIThresholdsAndTimers

Changes in v2:
* Remove trailing period and fix order of mgmt parameter

Archie Pusaka (5):
  lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode
  src/adv_monitor: add monitor with rssi support for mgmt
  btmgmt: advmon add rssi support
  bluetoothctl: advmon rssi support for mgmt
  monitor: Decode add advmon with RSSI parameter

 client/adv_monitor.c | 162 ++++++++++++++++----------
 client/adv_monitor.h |   1 +
 client/main.c        |  29 +++--
 lib/mgmt.h           |  15 +++
 monitor/packet.c     |  43 ++++++-
 src/adv_monitor.c    | 267 ++++++++++++++++++++++++++++---------------
 tools/btmgmt.c       | 160 +++++++++++++++++++++-----
 7 files changed, 475 insertions(+), 202 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

