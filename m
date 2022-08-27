Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F097C0502A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 00:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbiH0AFt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiH0AFt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 20:05:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB025B9FB5
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y1so1030915plb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=/E/FudZcalWzJ6CeBuqTFqv8RTSS+M2m1fRNEnLJTvY=;
        b=JvbAfYwuChOi1DPcO7gcDfoV0N32mJJFiqPi5TL27NHCXiDsuhpi4CHErJzow9bolz
         JoLwAf4fUWbVWXX7XmZTodNjDz5amdcqXAqB2YHbBXBkLyDgmIN39uuqkyZjkhCWffO8
         AVjUeNTzLt7kwGHfsQLFE+wCU51c3+N8eKqmvMC1lYJN8CnvkBTOd82TxfcHubSKraKi
         QowucVJ/ANrpYWXI0ldxcRSBdSrx3gcpq0VaUGMel326mbFPwWt5V5rsv+/ZMd70IZDU
         1bnVBY0Sbfl/0DzG1UjrrAsbQXmrY0n4LEeMbzGuuXW2rr44BY+k3QHcyWBT6E09V5rR
         /LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=/E/FudZcalWzJ6CeBuqTFqv8RTSS+M2m1fRNEnLJTvY=;
        b=37tKMcslMRzRIqIScJehuU9c6ui7gGuMmLe3//g85S1FnISs21ejUqTcgMzM42GqUH
         jHUf0kU+ST0OHV8bJyR5qMgMY00dWib720UwAbfBKwoRIrR420On97tRG/Q05TkY29v9
         YvJNfD9x+v56PNBvKQk8gPJqagZvTV0moo+3b8ppqvpX383vsi2LVPNP9434NGifxAq8
         dApbpfrLO0fqFKDi5AKaxaQKSJagfALETdPL0OumW5OTDvKtPVZPP6q6vEIf7gqZCeMA
         zPGyVAT04hUw+YE1Wl2kwguI25U84W4oyoIRVYYWyUIu54RgmIPm1fMjWEvp15ArepsS
         MKrw==
X-Gm-Message-State: ACgBeo3sksE9MA4Tf7RTOx8EyRVlioSqnjYC6BbhzfVETKEhZbdEsBbN
        xd4RwpZzm/PTarnSkF1S5fxvR9+p1a4=
X-Google-Smtp-Source: AA6agR6XRAQwpQGwlfQBZI+iNbqCUC+qo5nDUfVlvwuBH17IKmP0gIHp0Hv2seqLIHjKp3I635Inmw==
X-Received: by 2002:a17:902:7003:b0:172:cbb0:9af8 with SMTP id y3-20020a170902700300b00172cbb09af8mr6012965plk.57.1661558742597;
        Fri, 26 Aug 2022 17:05:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a168100b001fa8b909ef0sm2249487pja.7.2022.08.26.17.05.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:05:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 00/11] Initial BAP support
Date:   Fri, 26 Aug 2022 17:05:29 -0700
Message-Id: <20220827000540.113414-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

iThis set add initial support for BAP (Basic Audio Profile) which is
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

Frédéric Danis (2):
  profiles: Allow linked transport to release the fd
  profiles: Update transport Links property on state change to QoS

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
 profiles/audio/transport.c |  596 ++++-
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
 19 files changed, 8678 insertions(+), 144 deletions(-)
 create mode 100644 profiles/audio/bap.c
 create mode 100644 src/shared/ascs.h
 create mode 100644 src/shared/bap.c
 create mode 100644 src/shared/bap.h
 create mode 100644 src/shared/lc3.h

-- 
2.37.2

