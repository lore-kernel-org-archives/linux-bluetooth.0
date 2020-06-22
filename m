Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C8BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4542A20720
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KZ3hx3Ea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgFVXlG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgFVXlG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 19:41:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C38C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k1so8296716pls.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVOvWdK8xY/j3LcGWv+oRPzo7VqGCN69Jsgmx2xKb3E=;
        b=KZ3hx3Ea5RK85VGLI7XCoZs1yUy/jtu1X/gwKL+43bubwLeRUsgADGNLCXv5O8p0Sa
         7OnHXQs5qQ/0ivubT9VXjSDmOJGRQPB3/x2E4zn8uwYbMv+yQvccYxtYnD1b+QX+jei3
         QEKjfKy3RPypd5TYqWz3mJG9pQ9ObuzmTr8js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVOvWdK8xY/j3LcGWv+oRPzo7VqGCN69Jsgmx2xKb3E=;
        b=l5rFDLlt3u3Azul1WAnh9sK7Yh3gpBI7wdZoW+yHjyuVfGPbOlFiYcxqcrW17kou7S
         /ikkYmOOZSXKPWQH4dl2ThTas0i6YkaZ6A1GTyDo48HZWPBPIpJ8vDON53YfLQUCi3eb
         0Ub+6XvnIsGUtBQ89exBNWRn+NeZ88quusaJ3i7xeUNpr+DWRbU5UNMhpCfnS8BbRGgH
         ZUoJoNH2z3rtHRQplIaoTala87i+Duw1qf/4Zlz0HUwxZfyEzO/7FPulVwAuyoip1LPd
         xwmQGcfzSRo6k3QMOY9X/2mGk2picJeqXlc+yGHjhjZzuOcUiSsWs9ymUmDrDpL6aPnM
         FprA==
X-Gm-Message-State: AOAM530auQcZmOCvBdP4/aK1iLcT4eCahamJv8ZkRt5usA4suxhkmpBC
        WuzJ0zIYPFvqtklSiYtsFnUxfw==
X-Google-Smtp-Source: ABdhPJxee7sm0VnZHHo2eKw7aYGuuhcwCujDloqJv5Wa+4CBiasVTuK6hx6jXpm48pMMyYGgjiW5ew==
X-Received: by 2002:a17:902:301:: with SMTP id 1mr22145018pld.214.1592869265433;
        Mon, 22 Jun 2020 16:41:05 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w22sm15049500pfq.193.2020.06.22.16.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:41:04 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v5 0/6] device: Allow devices to be marked as wake capable
Date:   Mon, 22 Jun 2020 16:40:45 -0700
Message-Id: <20200622234051.206800-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Luiz,

This change accompanies a change in the kernel to allow marking devices
as wakeable so they can wake the system from suspend. Currently, only
HID devices support this and will be configured to allow this setting to
be changed via the WakeAllowed property.

Accompanying kernel change: https://patchwork.kernel.org/patch/11609999/

In order to set this flag, Bluez must call Set Device Flags with the
Remote Wakeup bit set. This change was tested with the accompanying
kernel changes on v5.4 with both manual tests and automated tests.

Here's the tests that I ran manually:
  - Pair new HID device and confirm it has Wake Allowed to True
  (default). Verify device can be woken from suspend with device.
  - Restart bluetoothd, confirm Device Flags Changed event after Add
  Device has no Remote Wakeup flag and Set Device Flags is called
  afterwards to restore it. Verify wake from suspend still works.
  - Disable Wake allowed via dbus and confirm wake from suspend no
  longer works.
  - Restart bluetoothd and confirm Wake Allowed is still false. Verify
  wake from suspend does not work.

Thanks
Abhishek

Changes in v5:
- Use device_flags mgmt op
* Decode device flags
* Refactor to use set_wake_flags and respond to device flags changed
* Add wake_override so we can keep track of user/profile configuration
  vs what is currently active
* Only call device_set_wake_support

Changes in v4:
* Renamed wake_capable to wake_allowed
* Removed set_wake_capable mgmt op and updated add_device to accept
  flags to set whether a device is wakeable
* Refactored adapter_whitelist_add and adapter_auto_connect_add to call
  adapter_add_device
* Renamed WakeCapable to WakeAllowed
* Renamed WakeCapable to WakeAllowed
* Renamed device_set_profile_wake_support to just
device_set_wake_support

Changes in v3:
* Added profile_wake_support and made wake_capable dependent on it
* Added documentation for WakeCapable
* Mark HID device to support wake from suspend

Changes in v2:
* Added dbus api "WakeCapable" to set value
* Update device_set_wake_capable to be called by
  adapter_set_wake_capable_complete so we can emit property changed
* Newly added to show whether device is wake capable
* Removed automatically setting wake capable for HID devices

Abhishek Pandit-Subedi (6):
  mgmt: Add mgmt op and events for device flags
  monitor: Decode device flags mgmt ops and event
  device: Support marking a device with wake allowed
  client: Display wake allowed property with info
  doc/device-api: Add WakeAllowed
  input: Make HID devices support wake

 client/main.c           |   1 +
 doc/device-api.txt      |   5 ++
 lib/mgmt.h              |  33 +++++++
 monitor/packet.c        |  68 +++++++++++++++
 profiles/input/device.c |   1 +
 profiles/input/hog.c    |   1 +
 src/adapter.c           |  98 +++++++++++++++++++++
 src/adapter.h           |   3 +-
 src/device.c            | 184 ++++++++++++++++++++++++++++++++++++++++
 src/device.h            |   9 ++
 10 files changed, 402 insertions(+), 1 deletion(-)

-- 
2.27.0.111.gc72c7da667-goog

