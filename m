Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E0CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1172D20674
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LNvimZU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGFUZb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFUZb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 16:25:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC51C061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 13:25:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so14883335plm.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFa8f5h40SxZunFFosO+SN5tP3OS76FTxNl6Rbhd3ek=;
        b=LNvimZU7D4zgBbzEbUKtnYiDajuoKUt/lfFSoqKHR2xvldFeIewtwiBKEFCKywAXAO
         F5CSmIoP5akHs0Bu4HSaTYjaI5IqeXBhfkFqE/m4DRZf5Tu9JGjdcIrajdx8N5yKc+C9
         KsAFO/WBrI4w4CioVlfkCigVK1EQNZVw7D8So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFa8f5h40SxZunFFosO+SN5tP3OS76FTxNl6Rbhd3ek=;
        b=EOHcB1IFRyMcnmBztrPtxHQbkzU4EtErWhXMakdq9NTjlrxHbm+SE4rIJfFfTKMSTH
         tgl1TVL/Q5Vsi5ILWxBASpEYyCD8fvZSHKr9va6BJHCNDo88l0bmUws2zC+f3laHn/mC
         kl35sw414GLdKQJE78Tw+SziyLwmRoKAruuHocNZqJ4oUq2Hp+EJd2fA+zUeYIA47fec
         n0C8g8ix78XwZquZ45nPIAi1Yv3XqHg90HWudqqsvPFDhEbXm/0iLqv2oFUbT5mosqRU
         1qmVrVZMMRUJSwRCzqhJ+epXnx9fuFJMqKO3dLbxhxTNMVE09JX6Nw9C4UySPteNaTcq
         vCGA==
X-Gm-Message-State: AOAM531wfTluu3lM1I8NYZAMiRyWzFzaKqC/6SWUE9QeKK/7vzWygjEo
        7YcBchPCHjMbehJkPWfUH5K3wA==
X-Google-Smtp-Source: ABdhPJxhddIkmc8QQu5TMHvbwi3u8RjaSIwGjjGXGzgBNbFfZGvISjRZRtyhM/k6a6lnG5BUdh5fCQ==
X-Received: by 2002:a17:90b:188b:: with SMTP id mn11mr835984pjb.179.1594067130894;
        Mon, 06 Jul 2020 13:25:30 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id n25sm3320226pff.51.2020.07.06.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:25:30 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v7 0/6] device: Allow devices to be marked as wake capable
Date:   Mon,  6 Jul 2020 13:25:12 -0700
Message-Id: <20200706202518.1153647-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
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

Changes in v7:
* Fix more build issues reported by bluez.test.bot

Changes in v6:
* Fix up some build issues reported by bluez.test.bot
* Save pending property id and emit success only after set flags returns
* Ignore multiple calls to set_wake_allowed to the same value
* Emit property error busy if same value is already sent to mgmt
* Fix up build issues reported by bluez.test.bot

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
 doc/device-api.txt      |   5 +
 lib/mgmt.h              |  33 +++++++
 monitor/packet.c        |  70 ++++++++++++++
 profiles/input/device.c |   1 +
 profiles/input/hog.c    |   1 +
 src/adapter.c           |  93 ++++++++++++++++++
 src/adapter.h           |   3 +-
 src/device.c            | 210 ++++++++++++++++++++++++++++++++++++++++
 src/device.h            |  10 ++
 10 files changed, 426 insertions(+), 1 deletion(-)

-- 
2.27.0.212.ge8ba1cc988-goog

