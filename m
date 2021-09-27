Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD8DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEBE600CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhI0USm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbhI0USm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 16:18:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA5CC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:17:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso17578996ybq.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TcaDOnxPmb6Y+ucxYBcxC9sihD6ypsDrKfc5R4obwRk=;
        b=n+XfXLCVLxvjybdE5qklGTtlwHH+U+fKxx+P9771mSLPxiEof1aSitwqbAbDJJUb5G
         sbyouoywwyZSG568VVdgBIwK6gAT4HTVTMRJbfitbMWscAjnFHWrr6HlpRL6umgezYkV
         uaWPObIOfLGo0nGbfqhjyaeyUK3J1Xlss/Zz/+BrkLreKqHed4vewFfU3w9t4TKbhehP
         L7UOdy39H24FombNErDJ+99NZKwnBqGpCl44QVULmodmg1VNemMFXXcxF8dxSDWa3Yxg
         BsopEw0tIp7SHMPAhJEcewm5IANLTkKXwgfBbWT04WHegiSfHJOw+yjXsXWjnCe96YHy
         MqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TcaDOnxPmb6Y+ucxYBcxC9sihD6ypsDrKfc5R4obwRk=;
        b=VNFmy0NVecihV9U13Xdbci++aRL23MZ9vrSW2cbmnaorTK09YFVFlZT9eIJlIkn0bq
         oEPllVZV4l1aj/j4zxGMyGqlPwAe5dpgEmCTw+YFc4Ppn8LjwZHxerWGokItScX8Xj11
         hi/wG0w+LqVRefq1UjB57ZOFpMbMaZ76XHCMdlJH/3L5BBZmPfhNXImrPZ1ZBW+JxRev
         S0FbjQfqQ0IvwwkpRWE0sWnMyNl28LpWugVJQNfBwWW9F6SDHn0ECxCuNlDUc7dhyk3F
         VOXhPX72iWC0PgaSzpitHB5EnSsXhEj16bBsrsRCt8DXWjp6ZT6LgMdHm+GJYIAZc5ld
         x2NQ==
X-Gm-Message-State: AOAM531krNQ76ED5dElmgEHEoZPUYzCmONsD2f1o05RhW/ZoUa7XIa+o
        vozjLvhwbtbZdrjmbmYwVLMLhOv3udcmXA==
X-Google-Smtp-Source: ABdhPJwhP/nmULvyKGy6s/YII4kmTzOt9E4/iVYfTnJGP4w+6VGbp+mMFiI6j1oGtGLxY2u5GTQ0tQUMQqeMiw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:8f29:89eb:dfbc:3b00])
 (user=mmandlik job=sendgmr) by 2002:a5b:34e:: with SMTP id
 q14mr2171438ybp.42.1632773823084; Mon, 27 Sep 2021 13:17:03 -0700 (PDT)
Date:   Mon, 27 Sep 2021 13:16:54 -0700
Message-Id: <20210927201657.593569-1-mmandlik@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [BlueZ PATCH v1 0/3] Introduce Advertisement Monitor Device Tracking event
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hello Bt-Maintainers,

Bluetooth Advertisement Monitor API was introduced to support background
scanning and proximity detection based on the application specified RSSI
thresholds and content filters on LE advertisement packets.

To optimize the power consumption, the API offloads the content
filtering and RSSI tracking to the controller if the controller
offloading support is available. However, this monitoring is not
completely offloaded as the bluetoothd also handles RSSI thresholds and
timeouts in order to fulfill high/low thresholds/timeouts filtering with
D-bus clients.

There is further room to achieve better power optimization by supporting
the controller event HCI_VS_MSFT_LE_Monitor_Device_Event to fulfill true
monitor offloading. This is currently not supported as it was originally
desired to minimize the changes to the MGMT interface and reuse the
existing MGMT event - MGMT_EV_DEVICE_FOUND to pass advertisements to
bluetoothd and let bluetoothd handle the RSSI thresholds and timeouts in
order to fulfill the D-bus API requirements for the client.

This patch series introduces a new MGMT interface -
MGMT_EV_ADV_MONITOR_TRACKING to deliver the Monitor Device event
received from the controller to the bluetoothd.

Please let me know what you think about this or if you have any further
questions.

Thanks,
Manish.


Manish Mandlik (3):
  doc: Add Advertisement Monitor Device Tracking event
  lib: Add definition of AdvMonitor Tracking event
  adv_monitor: Receive Device Tracking event

 doc/mgmt-api.txt  | 27 ++++++++++++++++++++++++++-
 lib/mgmt.h        |  8 ++++++++
 src/adv_monitor.c | 25 +++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

-- 
2.33.0.685.g46640cef36-goog

