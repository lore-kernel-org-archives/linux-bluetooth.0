Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5971C0502C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 23:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbiHZXUl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 19:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345496AbiHZXUj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 19:20:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7953B4E85
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y127so2907113pfy.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=QvzAk+A2ozPWcOxjr76K8Ht0+7Z5ASWg5l9DtopaZmo=;
        b=ZbfZ7VuCYJs0TeSmV+rO6oKOyJEhSkxYbNLb6aOFQTC4yhb5e/77C+KBP66nNRb56n
         LFIgqj+CnPQm8uONlwN5X9RFdELkTo/+q/ycsMXTXVHfRl/+F+G/ny96Qd5TIT19mJaI
         GtfXIxBW6TsvpQztyM8OKPvV05nuq2YniNivB9rELwd0xCHfuaSKpEQzkCVyc6/wXHnV
         9oXIKw5lzZjO0gpSUp4c/WoYf6Ihq1cYzZkW5l9gDFxfi26rt/mfyX3cyRmghH4wfuds
         jolC/TxI5MnNuCX8/K0upTscLi09gvi4FP1KvA5+dsHY69W14p5glLvwmU9IDN02HVpQ
         TOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=QvzAk+A2ozPWcOxjr76K8Ht0+7Z5ASWg5l9DtopaZmo=;
        b=icWTtd5riGdP9C4DcivOU1tdJ9+v/AONxmdgo9ScZ14IPVBSx+jqCFIttp3mF/33nH
         BO4booVkfCtVCF47K3u1f8o09w+stzcfO+djFgGt3e6NZPx5avazs/GcV4nCEuE5wTvL
         jP/nhJVRrbqzUH3VCtYnGjLTliN+xoj8i+Zs2OJHZev2HBRerKcxEWTUMd8uz/Nxh7q8
         8a4MKArTvFtJ3KGLvujpZZ++gFvZbrzcLiliX/NDkCmabzQP10O0JteoaMVzFSip43Li
         BuGh7NQlaXvmmNcoGFXW9Aovs4TeXAnXzpwvz5f5fxWhCzcBKSt9SU8YyIlkeHAw5dqH
         hrSA==
X-Gm-Message-State: ACgBeo2GYSuQWSFh5vRGNmh8uy7Pm/hvJul6swqaQO1Ev8C9hlfOgxP+
        HX1ASJxNMwAdiyGbwbkSFFpv3+5EMXY=
X-Google-Smtp-Source: AA6agR5r4cznYnBJfLrgJIHELdv03otrSNbFstrg5GbsNbq3CJBrUn2J7ianIwIRCKA6iCoEWQ6ykw==
X-Received: by 2002:a63:2b8e:0:b0:41d:6d37:b259 with SMTP id r136-20020a632b8e000000b0041d6d37b259mr4954780pgr.208.1661556033670;
        Fri, 26 Aug 2022 16:20:33 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7984f000000b0053645475a6dsm2312338pfq.66.2022.08.26.16.20.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:20:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/9] Initial BAP support
Date:   Fri, 26 Aug 2022 16:20:22 -0700
Message-Id: <20220826232031.20391-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set add initial support for BAP (Basic Audio Profile) which is
an essential part of LE Audio responsible for stream control.

The plugin is considered experimental and depends on ISO socket in order
to work so the following setting needs to be changed in order to enable it:

 # Enables D-Bus experimental interfaces
 # Possible values: true or false
+Experimental = true

 # Enables kernel experimental features, alternatively a list of UUIDs
 # can be given.
@@ -126,7 +126,7 @@
 # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
 # 6fbaf188-05e0-496a-9885-d6ddfdb4e03e (BlueZ Experimental ISO socket)
 # Defaults to false.
+KernelExperimental = 6fbaf188-05e0-496a-9885-d6ddfdb4e03e

While proper support to the likes of PulseAudio and Pipewire are still
in progress it is possible to test using bluetoothctl with the following
commands:

[Server/Peripheral]
[bluetooth]# power on
[bluetooth]# advertise on
[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] CIG (auto/value): a
[/local/endpoint/ep0] CIS (auto/value): a
Capabilities:
  03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
Endpoint /local/endpoint/ep0 registered
[bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep1] Auto Accept (yes/no): y
[/local/endpoint/ep1] CIG (auto/value): a
[/local/endpoint/ep1] CIS (auto/value): a
Capabilities:
  03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
Endpoint /local/endpoint/ep1 registered

[Client/Central]
[bluetooth]# power on
[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] CIG (auto/value): a
[/local/endpoint/ep0] CIS (auto/value): a
Capabilities:
  03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
Endpoint /local/endpoint/ep0 registered
[bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep1] Auto Accept (yes/no): y
[/local/endpoint/ep1] CIG (auto/value): a
[/local/endpoint/ep1] CIS (auto/value): a
Capabilities:
  03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
Endpoint /local/endpoint/ep1 registered
[bluetooth]# scan on
[bluetooth]# scan off
[bluetooth]# connect <bdaddr>
[NEW] Transport /org/bluez/hci0/dev_00_AA_01_01_00_02/pac_source0/fd0
Endpoint: SetConfiguration
        Transport /org/bluez/hci0/dev_00_AA_01_01_00_02/pac_source0/fd0
        Device: /org/bluez/hci0/dev_00_AA_01_01_00_02
Auto Accepting...
[NEW] Transport /org/bluez/hci0/dev_00_AA_01_01_00_02/pac_sink0/fd1
Endpoint: SetConfiguration
        Transport /org/bluez/hci0/dev_00_AA_01_01_00_02/pac_sink0/fd1
        Device: /org/bluez/hci0/dev_00_AA_01_01_00_02
Auto Accepting...
[bluetooth]# transport.acquire /org/bluez/hci0/dev_00_AA_01_01_00_02/pac_sink0/fd1

Luiz Augusto von Dentz (9):
  adapter: Add btd_adapter_find_device_by_fd
  lib/uuid: Add PACS/ASCS UUIDs
  shared/bap: Add initial code for handling BAP
  profiles: Add initial code for bap plugin
  shared: Add definition for LC3 codec
  media-api: Add SelectProperties
  test/simple-endpoint: Add support for LC3 endpoints
  client/player: Add support for PACS endpoints
  client/player: Use QoS interval on transport.send

 Makefile.am                |    3 +-
 Makefile.plugins           |    5 +
 client/player.c            |  688 +++++-
 configure.ac               |    4 +
 doc/media-api.txt          |   88 +-
 lib/uuid.h                 |   18 +
 profiles/audio/bap.c       | 1324 ++++++++++
 profiles/audio/media.c     |  678 ++++-
 profiles/audio/transport.c |  552 ++++-
 profiles/audio/transport.h |    3 +-
 src/adapter.c              |   33 +
 src/adapter.h              |    1 +
 src/device.c               |   10 +-
 src/shared/ascs.h          |  196 ++
 src/shared/bap.c           | 4776 ++++++++++++++++++++++++++++++++++++
 src/shared/bap.h           |  269 ++
 src/shared/lc3.h           |  112 +
 test/simple-endpoint       |   17 +
 tools/bluetooth-player.c   |    1 -
 19 files changed, 8634 insertions(+), 144 deletions(-)
 create mode 100644 profiles/audio/bap.c
 create mode 100644 src/shared/ascs.h
 create mode 100644 src/shared/bap.c
 create mode 100644 src/shared/bap.h
 create mode 100644 src/shared/lc3.h

-- 
2.37.2

