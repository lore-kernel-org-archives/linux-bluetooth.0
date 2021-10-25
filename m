Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D8FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 19:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB21960F70
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 19:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhJYT3V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 15:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhJYT06 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 15:26:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F04FC0432FF
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 12:18:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i128-20020a252286000000b005beea522aa8so18841606ybi.17
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mbfLGv9lLQLKU6Akq+ardZ7ThhtJaj3Po9FdmyZRfew=;
        b=ewQB4RZ64rcdnezzlFTnJLinDi0oZIESgmz5LDWVjhn4aE6wce2qwsC/3J5y6wNeDE
         ovPi4tVm2KYVJP588a6bVKSqUMrEnyfPvweunu8KUwlORlG3Z6GBaxGACKbBMyG2cA50
         3RhwIotMtsS17f+Qe+kl2mcVtJi4HoOjOGXnQVdAs/z6mMfk0sWV4pIB7LXzb4rg9NIM
         MN0tag10ho1EK4rjMEbAr1dbzs2+ucobXGtYeFEDCO8zIl8WJMu/fClMs2P+Q6kUouFK
         YcZRVPIxwbFtfZEtmh12wLlMJXseUT+n/DheK+Ky3UhIhEBvkMUBQgzntYVLu5bXk4wY
         3f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mbfLGv9lLQLKU6Akq+ardZ7ThhtJaj3Po9FdmyZRfew=;
        b=TCjE0sMcMx6jL6vH24GbUyg59k1GfyX90O8/3ZaI6kuzIGkVp/oLcmdxokK1Fqa83/
         p4DzVarcDHQZmZ7GsUaWXfe8tisAIsOAouh3cBxiX+WLsKFsNnOqiQBY5kGU1Enyrr/E
         xSJKmcIVjcMDi1OYj8zbYdzpfrQ0Vqn2rciGTarjUTYnL8tyJ/ZbolSZakC7ZWz+KECy
         clJ+v+mikFJ207QXsiylxyWTqBzv3MiRSnAbvGKd/iakpfwnYjnXwEgF2se8wckZ033m
         GxUsc2KzMaLf2AZyVKFsMe3uP26kj5sqBTueMuTNWfX5aEl53+niaXCFxvBsSEP3S197
         WytA==
X-Gm-Message-State: AOAM5335HdnFqQ9mpfwwwhoYWZNoLPjnnXiwyhaqnIefEqlobiGXKKhN
        f7sWi8sidolFHI2oB0uViHxdFvXN1bVY8A==
X-Google-Smtp-Source: ABdhPJzDMXBOZAKNFdAtKaWX+gnX0DCbLnXUmp1bQBlX22S1aHeI2zcXyNcjmpp1cIioX3WQQcm1UyR4r7BJRw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e7c3:c740:ce43:5358])
 (user=mmandlik job=sendgmr) by 2002:a25:7415:: with SMTP id
 p21mr18780742ybc.78.1635189509474; Mon, 25 Oct 2021 12:18:29 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:18:08 -0700
Message-Id: <20211025191811.3575708-1-mmandlik@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [BlueZ PATCH v4 0/3] Add Advertisement Monitor Device Found/Lost events
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

This patch series introduces MGMT event MGMT_EV_ADV_MONITOR_DEVICE_FOUND
and MGMT_EV_ADV_MONITOR_DEVICE_LOST to indicate that the controller has
started/stopped monitoring a particular device.

Please let me know what you think about this or if you have any further
questions.

Thanks,
Manish.

Changes in v4:
- Add Advertisement Monitor Device Found event, make Address_Type 0 as
  reserved.
- Add Advertisement Monitor Device Found event.
- Add Advertisement Monitor Device Found event.

Changes in v3:
- Discard changes to the Device Found event and notify bluetoothd only
  when the controller stops monitoring the device via new Device Lost
  event.
- Discard changes to the Device Found event and notify bluetoothd only
  when the controller stops monitoring the device via new Device Lost
  event.
- Fix indentation of the adv_monitor_device_lost_callback() name and
  it's arguments.

Changes in v2:
- Instead of creating a new 'Device Tracking' event, add a flag 'Device
  Tracked' in the existing 'Device Found' event and add a new 'Device
  Lost' event to indicate that the controller has stopped tracking that
  device.
- Instead of creating a new 'Device Tracking' event, add a flag 'Device
  Tracked' in the existing 'Device Found' event and add a new 'Device
  Lost' event to indicate that the controller has stopped tracking that
  device.
- Update function name adv_monitor_tracking_callback() to
  adv_monitor_device_lost_callback() as it will receive only Device Lost
  event.

Manish Mandlik (3):
  doc: Introduce the Adv Monitor Device Found/Lost events
  lib: Add definitions of the Adv Monitor Device Found/Lost events
  adv_monitor: Receive the Device Found/Lost events

 doc/mgmt-api.txt  | 50 ++++++++++++++++++++++++++++++++++++++++++++++-
 lib/mgmt.h        | 14 +++++++++++++
 src/adv_monitor.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)

-- 
2.33.0.1079.g6e70778dc9-goog

