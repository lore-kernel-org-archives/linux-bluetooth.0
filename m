Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C0BC4332B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C558420753
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="htsh1BsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCTBu2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:50:28 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:33616 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgCTBu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Mar 2020 21:50:27 -0400
Received: by mail-pg1-f179.google.com with SMTP id d17so1696274pgo.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2020 18:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PU9kgEpwwuugzuBur1kbsdnAZUff4cZ6r30c+t/EDPo=;
        b=htsh1BsIw/p7dOlQFwSVIjtvBlNnQQBXdQHQTuQF3StdBMVFSVUxzIfacwg2jrIsJ+
         eB2DXlJPRxuCzrGfnlxhGp2iyaekqTuAbvOvl8ZqRI0IgVhWsN9IRznxLnVgpcZDMxdN
         qGSTjoR+PG5aRIB8b5DYDkOmAa+mdOR/bKVb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PU9kgEpwwuugzuBur1kbsdnAZUff4cZ6r30c+t/EDPo=;
        b=AEeB/Wy8+A7yNBdOhoV3Ki/YAiHlAwH1N9vIgNgriHv8oLrMponh8kiW/ZTdqMxcQg
         xIDn4z1SMSxr1ypz2Iro3EjmTzwd0fO+9GFbv9bLq4RjqB62gh30NCruL7VO5hqgVUaF
         y0ZKqNmQN8pDn558yUuXdxiw9RsPxOdv9w1q7jQG2C9YoFJdc3OC3bR5ZgGFIcgSdh80
         vSJ6ONkZpjYT1pHy8Kh3irFCWyHssP9+mg8D2w9RaU8EX+7DNKCnzIFfroem2rQEsubp
         8jrzNejXKn2Fyy7Z/GrMg+BKia0QqMOptmpU6kw9waHQA8t/wltwiJKp6//S1JB8F1in
         k69Q==
X-Gm-Message-State: ANhLgQ1FdUdo4S4Hl/Wql/jyggeQilysiKDgFUZ7W8EpWuYwfC2HtVbD
        L/ezMxCV6GjiDftBuXGu4hiQxQ==
X-Google-Smtp-Source: ADFU+vuNGk1q3voL+KRzq2IxinBDyIMJGrndR83ZhF17Nmqo01Y7Zbj4XJ57TmhpoNgRNpN0lf+bWA==
X-Received: by 2002:a63:c550:: with SMTP id g16mr6481154pgd.9.1584669026690;
        Thu, 19 Mar 2020 18:50:26 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id 136sm3410485pgh.26.2020.03.19.18.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:50:26 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v4 0/5] device: Allow devices to be marked as wake capable
Date:   Thu, 19 Mar 2020 18:50:18 -0700
Message-Id: <20200320015023.85896-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Luiz and Marcel,

Please do not merge this until the accompanying kernel change is
accepted. I am sending this series to show how I plan on using the
changes to the Add Device management operation.

Pending questions I have for this series:
* Do I need to distinguish whether the kernel supports the updated Add
  Device structure? (It will probably reject it if the size isn't
  correct)
* Can we allow HID devices to default to Wake Allowed? I think its
  preferable to allow newly paired HID devices to wake the system from
  sleep without any additional changes.

--

This change accompanies a change in the kernel to allow marking devices
as wakeable so they can wake the system from suspend. Currently, only
HID devices support this and will be configured to allow this setting to
be changed via the WakeAllowed property.

In order to set this flag, Bluez must call the Add Device management
operation with the DEVICE_FLAG_WAKEABLE flag mask and value set. This
call can be made multiple times with the same address (the kernel will
add the device the first time but only update the action or flags on
subsequent calls).

This change was tested with appropriate kernel changes on v4.19
(verified that HID devices were being marked as wake capable in the
kernel).

Thanks
Abhishek

Changes in v4:
* Newly added support in Add Device for flags
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

Abhishek Pandit-Subedi (5):
  mgmt: Update docs for Add Device
  device: Support marking a device with wake allowed
  client: Display wake allowed property with info
  doc/device-api: Add WakeAllowed
  input: Make HID devices support wake

 client/main.c           |   1 +
 doc/device-api.txt      |   5 ++
 doc/mgmt-api.txt        |  12 ++++
 lib/mgmt.h              |   3 +
 profiles/input/device.c |   1 +
 profiles/input/hog.c    |   1 +
 src/adapter.c           | 112 +++++++++++++----------------------
 src/adapter.h           |   1 +
 src/device.c            | 125 ++++++++++++++++++++++++++++++++++++++++
 src/device.h            |   8 +++
 10 files changed, 197 insertions(+), 72 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

