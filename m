Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E77C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 19:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9495610EA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 19:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbhJMTCs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbhJMTCq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 15:02:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2301BC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 12:00:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so4255986ybb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IWuuhlIKRosdEBL6rQjGU4vIiE800u+U3smRxZuRX4g=;
        b=CcB5QioGadoZMtNsP4VqK78XN/BKxpGaqiCy/7uNIgJxkag6wy1f+3bgZAgQ7b5qfz
         3s9c1kxroNk00Kebrro1T2nyy9IifAnAmyWScayxkYf1FuZM9JK11PVYBibhnxCaDhwb
         fzu8Qm0gV/AuN3nq43FY2uVIl38W5QmsbzIeBs/LfWSwFoqDPHueTS5HXIkhlDn44Gea
         /K+AGO+2GB7+H3/nzClcIqyusKHlPyNlr32FdM/NFfwbCehNXJAYamkvBzfFxFpf4kr8
         5QpejfTYpigDntWKaw9SPmf9CtYybrmXDLAxVboiyG2cJcMThre8V5aE8g9p0s0g9EhZ
         ysWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IWuuhlIKRosdEBL6rQjGU4vIiE800u+U3smRxZuRX4g=;
        b=qeP/2mi8HSBmkeE2Nhq5BY+a4TO6iAYuVFTUxRmbPWS2n9nJapyHzFMJz6kTwLlfAg
         xEKDT4ICkKZcYNqsRstv6wI13jmMoWenqs/sFSLntP61nFyK9glTMeenMMl+7962TPpV
         QByYkGkM99NPUW9b+O/mvL+CF9H/Pn+9FgqBItP9G8o58iKaRimcqMgihfI/UcwJiQvF
         pTshRH4LHIgIQNrFOnsPRJlm0YLAYAGNFBNWKIaW8Q6T+HGW6lqbAdje5WgfGCl9iCXU
         xVgjRU2bqSIdzPqsyYPNd2ygAi6QWPOLvkHu0D0NXcCxjoYMgJpLbsg3NiVsdUTEEvc1
         PpCA==
X-Gm-Message-State: AOAM531C8DlpCv45p9FGKIL8YuxhokZ8jZilYi8v5sCgrVmM/PpSvjg8
        wwzfKbiq8xLWQNVEqmZ6UCcztNij+Wh73Q==
X-Google-Smtp-Source: ABdhPJw1K0uTOTh0VoGWuPGzpBa7w/fiPUDzcz90TzCcV8O7kV+P4eaBFFEp5naDQP6V5Y9U4K1Cw4yBJWl2Bg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:9910:f10f:1467:c3f])
 (user=mmandlik job=sendgmr) by 2002:a25:dc82:: with SMTP id
 y124mr1195274ybe.521.1634151642354; Wed, 13 Oct 2021 12:00:42 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:00:32 -0700
Message-Id: <20211013190035.1876237-1-mmandlik@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [BlueZ PATCH v3 0/3] Add Advertisement Monitor Device Lost event
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
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

This patch introduces a new MGMT event 'Device Lost' to indicate that
the controller has stopped tracking a particular device. There is no
need to send another event when the controller starts tracking a device
as 'Device Found' event is sent anyway.

Please let me know what you think about this or if you have any further
questions.

Thanks,
Manish.

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
  doc: Introduce the Adv Monitor Device Lost event
  lib: Add definition of the Adv Monitor Device Lost event
  adv_monitor: Receive the Device Lost event

 doc/mgmt-api.txt  | 26 +++++++++++++++++++++++++-
 lib/mgmt.h        |  7 +++++++
 src/adv_monitor.c | 25 +++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

-- 
2.33.0.882.g93a45727a2-goog

