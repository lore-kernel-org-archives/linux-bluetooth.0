Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D8FC25B08
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 23:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiHQXl6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 19:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiHQXl5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 19:41:57 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81AF98A41
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:41:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id n21so52158qkk.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=GdEdyMOAx3hPsCbsEHMTRC6v3KQtf84BHdk4+rO+K64=;
        b=l4NrFOzgvxLW040JLx8uH2fdRRykELfR28Ppl3t7WKxCedioP8PRB+PuIAsWMF/2BB
         gIaiNhszcOLk+H+ind4Td5LJkP2A+mdZoy2eXyf3QwsPT6gOSwhm28ZAabOjzc1uFQKS
         ow0FuXXgzLYqvo2GwuiOaQ+EDWg8T0RTOZtg4OevCv2RLaoKhzl/4mqcBb2T6nMQKXAt
         Q1Ea6rrrBdRNHQH7xE/g9eMIg8Po1+h+WI/o2A8fgdCve+Qry7arb1iAcEfbABN6pL9q
         kwvu06nj3JqNRW6QFVXZp2+V9Ec7tdLSMwb/KPTHXaTI55++c5hW4F2bC7X+w+eLfqoA
         9Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=GdEdyMOAx3hPsCbsEHMTRC6v3KQtf84BHdk4+rO+K64=;
        b=7RzhgR0sTddL1AxrUDpAtjBqJS6JhHhgYadlofNRTNuPeK8REOYTB29Yo/nponUvPk
         7wwzhvo5L+xnhO2y0H1tFz18dIKBzRapXM7JgHmZ6xJnZSUL5gmyTHGCiOidh6tT0H/E
         ulKUCFPjmXO1xDT8tT4Rh4/Q3AVt0PMN0GRkpICljG7whKVZNEteAuYwp1ubd0R+aVb3
         g92HIL9G0xfobCJyBICWVEJdqGJ0lIk3jGEBn9oUtvSyWeGi/0lOF7HDdAudveqaIozR
         S76/ADwm9/GPFHms4TYP7bZiQcZrJFli2buC64bS9mngtLjmGNSLPYbWommzaR1Kha1A
         1Ucw==
X-Gm-Message-State: ACgBeo0nzXafMw2FXTVs4aTbGzpJHkRmxItPpsBvc7AEiDS4WU8p3iwe
        mBtMIu9aoKg7PXSx8yMkNPKNclI0UuceLoiQ
X-Google-Smtp-Source: AA6agR7duM8CkdpiFZGTMyzeLI1cxwVrCpyal3pQkLT9Ti2jdkrsSR+fGOHzBPPXp+Q2iULF/xLGLA==
X-Received: by 2002:a05:620a:756:b0:6b9:91b5:cbb2 with SMTP id i22-20020a05620a075600b006b991b5cbb2mr329877qki.211.1660779709488;
        Wed, 17 Aug 2022 16:41:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r25-20020ae9d619000000b006bb2f555ba4sm189637qkk.41.2022.08.17.16.41.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:41:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/9] Initial BAP support
Date:   Wed, 17 Aug 2022 16:41:37 -0700
Message-Id: <20220817234146.224081-1-luiz.dentz@gmail.com>
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
 profiles/audio/bap.c       | 1302 ++++++++++
 profiles/audio/media.c     |  678 ++++-
 profiles/audio/transport.c |  552 ++++-
 profiles/audio/transport.h |    3 +-
 src/adapter.c              |   33 +
 src/adapter.h              |    1 +
 src/shared/ascs.h          |  196 ++
 src/shared/bap.c           | 4780 ++++++++++++++++++++++++++++++++++++
 src/shared/bap.h           |  269 ++
 src/shared/lc3.h           |  112 +
 test/simple-endpoint       |   17 +
 tools/bluetooth-player.c   |    1 -
 18 files changed, 8609 insertions(+), 141 deletions(-)
 create mode 100644 profiles/audio/bap.c
 create mode 100644 src/shared/ascs.h
 create mode 100644 src/shared/bap.c
 create mode 100644 src/shared/bap.h
 create mode 100644 src/shared/lc3.h

-- 
2.37.2

