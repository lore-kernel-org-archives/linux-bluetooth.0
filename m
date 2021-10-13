Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7A5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43EB16023D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhJMMo5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbhJMMoz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 08:44:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80770C061753
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 05:42:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p8-20020a056902114800b005bad2571fbeso2873698ybu.23
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1mAFPS/bGBXyFYGcprUNaHQCPmzvwa9glEucWATbAv0=;
        b=redqpoknCLS2ICQffg8NGQxkU3fHMeMs5+mPK3cclAGMlFUaYPoc4KA+tj+1ndIWRp
         lsQQc6p+M0XIvtQcCpDV2Il++6vBXaQwD9IR+wIIKF5tl0PHuKTIZRz+eiuX8mBxxe8A
         CZTyaWm+Ax3kAug+q962D8br+N/0kbv0dX9dFii3e5NPu26e8dU0/aYt2w7rDrXSCEpH
         qPLTFHeAlD1/SHHkKlqfR9A5/c+QfvGrRFsMz4FwZhkfgQlHcBqCzg5EpK1xHTUItdIZ
         jNEix5NRXRwz05NGBCnvnceWkJ2yanM+YERoQFBgn1IV0QWTufJkl2lHk3kOkrOZA4/a
         1Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1mAFPS/bGBXyFYGcprUNaHQCPmzvwa9glEucWATbAv0=;
        b=KQ/OviYmme+aUmgKLeSToUkFZYiVa7SrWYyiYBTabbNWtrynSeUx8+ZBzVV9m6g+uR
         pUPtz3e9mTYYrIfslsm0cyZN9Qja1o+osfpxtknyGAougRXuhY/nuka/cLSUeRFxcIyy
         E49cUBhAg9RaTriSXWNjnfQOrouKDBH9sDD8dgZHa6e6HF6Ewh3pQyab0+R/0F8ovlvc
         4U7n6ifawNXjAONx8SdcpEV8yK7+5ll9fShoRpVDpNbMqDR+Edlp1ElapO4su6q/CeYJ
         kuIS8kjeRbgRLt6nFDabO3bFOR/QmgpaHD0XZemOpyN5RNjDCZyIYWFRb2vslZyGsUx9
         CAGQ==
X-Gm-Message-State: AOAM530xs62pKqhePaBhOWC1XKjrBHwmAURJAjuBt5p2na2/P8mDpofS
        6+v3/j9bXsUPw4DT6TlHa/2Z15fSPW51kQ==
X-Google-Smtp-Source: ABdhPJy2y5rUQE5cAjQ6Y6wX0fcqBmfrfQ0nwYnKIX1s47aR5z5WQMttFs8QihkGCv18ZirA6Ke8fLz7mqJFZQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f8a0:57c1:fc2b:3837])
 (user=mmandlik job=sendgmr) by 2002:a25:bd04:: with SMTP id
 f4mr34120640ybk.372.1634128971744; Wed, 13 Oct 2021 05:42:51 -0700 (PDT)
Date:   Wed, 13 Oct 2021 05:42:07 -0700
Message-Id: <20211013124210.1454876-1-mmandlik@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [BlueZ PATCH v2 0/3] Update Device Found event and add Adv Monitor
 Device Lost event
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

This patch series adds a flag in the exiting 'Device Found' event to
indicate that the device is being tracked by an Advertisement Monitor.
Kernel updates this flag based on the receipt of the controller event
HCI_VS_MSFT_LE_Monitor_Device_Event. A new MGMT event - 'Device Lost'
has been added to indicate that the controller has stopped tracking a
device already being tracked.

Please let me know what you think about this or if you have any further
questions.

Thanks,
Manish.

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

 doc/mgmt-api.txt  | 32 +++++++++++++++++++++++++++++++-
 lib/mgmt.h        |  9 +++++++++
 src/adv_monitor.c | 25 +++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)

-- 
2.33.0.882.g93a45727a2-goog

