Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0174C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A612E206E9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FAesKcm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgF2XCa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgF2XC3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 19:02:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB122C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:02:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h22so8655819pjf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpK10RsIQyhFnWLIQgZogMpfVqYM7ibEl5dNPJdpSbY=;
        b=FAesKcm0x5H9d9CEQaMcXiy3DOtMNEHZxFoOaQXSvWlOEdNOSOlh6RVC4kBwuTIbQT
         qjkSV2BYSDkktTqxaKWXGfCOrMLqyN/smqaB12/WftIFktxrOKkCMxOvdPPAizR0piNT
         rD1mZdAzbnFlfgginsLVtvvGHktkDY+9ja5Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpK10RsIQyhFnWLIQgZogMpfVqYM7ibEl5dNPJdpSbY=;
        b=LCvnKaozfFjlSY4+SdOZsk+QsOiHei/jDKKvD12qVVdnLZqEIemPkgd80qXNDofkvN
         yZOUXCiRT3k/8vKKwpqOo62AR5KIZpCqf8u1LK5ii68o9svYma28FLKLr31MQEGsjHfu
         FldEh7N5jQDian6k0ILlrqaDvgS2g5g9+gYgmiwSRJOXZOFTBbX55sOCk92CDlY/XMrY
         /Ade1akl0ON6k6lklMb4DAWtwUIV/2L7MoKwv/gG4W3DEr7YnZO/sXMoms4XgD6VoCCT
         C2unkG2RKZs+AZ3AEcgo23AhFhsbMpeYQNqalrqtlx4ntrR9Zsj/SEMIMzjPNAOeNVq+
         42UA==
X-Gm-Message-State: AOAM5309GgxypzsvzGQ5sGMMzRS/eQV4IhxX0rOqpf38sSPrHzTVRUXG
        MVbO2wTN0OES1YPuTbgkqAVYxw==
X-Google-Smtp-Source: ABdhPJwz9ag9XB380mHgc3A4Rq/pLMomTdFgmcj7ETK+zm+xVVPlbNMUMj8KzmK/yIy5kXXxMnIdvg==
X-Received: by 2002:a17:902:301:: with SMTP id 1mr15718275pld.214.1593471749325;
        Mon, 29 Jun 2020 16:02:29 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id i13sm467275pjd.33.2020.06.29.16.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:02:28 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v6 0/6] device: Allow devices to be marked as wake capable
Date:   Mon, 29 Jun 2020 16:02:17 -0700
Message-Id: <20200629230223.3538949-1-abhishekpandit@chromium.org>
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
 monitor/packet.c        |  70 +++++++++++++
 profiles/input/device.c |   1 +
 profiles/input/hog.c    |   1 +
 src/adapter.c           |  93 ++++++++++++++++++
 src/adapter.h           |   3 +-
 src/device.c            | 212 ++++++++++++++++++++++++++++++++++++++++
 src/device.h            |  10 ++
 10 files changed, 428 insertions(+), 1 deletion(-)

-- 
2.27.0.212.ge8ba1cc988-goog

