Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF372C33C99
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F10E206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwC02UK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgAHAdp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:33:45 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:39451 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAHAdo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:33:44 -0500
Received: by mail-pg1-f178.google.com with SMTP id b137so672462pga.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sX1IhntGLgD4b+CVg8XTNW9d+Ec424eEbQexIym8f0o=;
        b=mwC02UK9il57gK6VkQszBD+p25K+T2PDsSptVosHEia8Ru2ZmRhg6UzL2JT4aOGLax
         3zlh8994H0NENQqtiak9G988q1UYO1h4pbdjdgjyj/LqI34cLVXzzx92GV1rxv4J2wpA
         OLJ1KK9QubgtHHmp2nT1SPBz2xDaDhHX/EHFD5bzD6Vani5PoSNIZgp7vpD6ZlGempdS
         V5XX+spTMq0LCYIkMGIvfX28B/Vi/5g3kZDom2Jz0Nnhj+/hRuRW98bqJ2c2MXV4Gje3
         6ErcawpNV56vsnW0iSQCLm1FWLpeccy9WAaf8/S7Igt97BztEphyQZRbp/1kMx3ztfbf
         xhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sX1IhntGLgD4b+CVg8XTNW9d+Ec424eEbQexIym8f0o=;
        b=tk1vZkFRe7b0ixbLjMVI2ly/u08ajJQXfIUIsGrfxw6BKuDI3w/MayY6xdDh+pCtSC
         TR/P9KP5SmcF2FNp+h/35NAvMGTidNxJPB9mfp91EwOxsH7oBOMB2teEqvQogsoEeQx+
         /S9BKUIDnaLl7DRE3lLFbJ2CXCIPUu+Z7DLWQIeRGYlThWp0DuAT8pjTaldFz4niA9il
         nj/pJXOBn18C9Md5W0pqyMkaJadw7+Z838ELxcbuSK3LzB3WOJVkaVA0U++EaNJKRcz7
         al8/GdtJaEpGKB1QJIOZOG9iNRQDlQ/UE0t8mAKb+aHHBcXFMN3ae59IlltimlFLb9Ee
         oUyw==
X-Gm-Message-State: APjAAAUC1G+CKt9yCrkDE1FmC7AvPLTQJ9AQMtegtIBwBcUZ6vsXY43k
        IgBj4Tj4J40MgNYvRJafHXGbTrfgzIM=
X-Google-Smtp-Source: APXvYqypnA3DotT91kJNeGa1jEPsVQ8HJHIjNkUdYbjuo1EjP84kooQuWkMh1TuQ1wuuQHJISgnV2w==
X-Received: by 2002:a65:4203:: with SMTP id c3mr2378297pgq.368.1578443623675;
        Tue, 07 Jan 2020 16:33:43 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:43 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/22] Userspace Bluetooth 5.2 initial support
Date:   Tue,  7 Jan 2020 16:33:20 -0800
Message-Id: <20200108003342.15458-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces the initial support for Bluetooth 5.2 features:

* ISO channels:
	+ tools/isotest command line tool to run validation tests

* L2CAP Enhanced Credit Based Flow Control Mode
	+ tools/l2test has been update to include the new mode

* Enhanced ATT Bearer:
	+ Client and Server support
	+ Include all new procedures
	+ Automaticlly detects and enables channels
	+ Number of channels configurable via main.conf

* Monitor:
	+ HCI/LL Bluetooth 5.2 command/event decoding
	+ ISO packets decoding
	+ L2CAP Enhanced Credit Based Flow Control Mode decoding
	+ Enhanced ATT packets decoding

* Emulator:
	+ CIS/Unicast emulation support
	- BIS/Broadcast emulation not yet supported

Kernel changes:
https://lore.kernel.org/linux-bluetooth/20200107074056.25453-1-luiz.dentz@gmail.com/T/#t

Luiz Augusto von Dentz (22):
  monitor: Add support for decoding ISO related commands
  monitor: Add decoding of ISO related Link Layer PDUs
  lib: Add definitions for ISO socket
  tools: Add isotest tool
  emulator: Add initial support for BT 5.2
  monitor: Add support for ISO packets
  tools/btproxy: Add support for ISO packets
  monitor: Fix decoding of CIS estabilished event
  emulator/btdev: Add parameter to CIS Estabilished
  lib: Add definitions for Enhanced Credits Based Mode
  btio: Add mode to for Enhanced Credit Mode
  monitor: Add decoding for L2CAP Enhanced Credit Based PDUs
  l2test: Add support for L2CAP_ECRED_MODE
  share/att: Add EATT support
  shared/gatt-client: Add support for EATT features
  gatt: Enable EATT bearer support
  shared/gatt-server: Add support for Read Multiple Variable Length
  shared/gatt-client: Add support for Read Multiple Variable Length
  shared/gatt: Add support for Handle Value Multiple Notifications
  gatt: Add support for Notify Multiple
  core: Add support for setting the number of GATT bearers
  monitor: Add support for decoding EATT

 Makefile.tools           |    5 +-
 attrib/gattrib.c         |    5 +-
 btio/btio.c              |    2 +-
 btio/btio.h              |    3 +-
 emulator/btdev.c         |  293 +++++++++--
 emulator/btdev.h         |    1 +
 emulator/hciemu.c        |    3 +
 emulator/hciemu.h        |    1 +
 emulator/vhci.c          |    3 +-
 lib/bluetooth.h          |   14 +
 lib/iso.h                |   45 ++
 lib/l2cap.h              |    1 +
 lib/uuid.h               |    3 +
 monitor/bt.h             |  385 ++++++++++++++
 monitor/l2cap.c          |  192 +++++++
 monitor/ll.c             |  100 ++++
 monitor/packet.c         |  714 ++++++++++++++++++++++++++
 monitor/packet.h         |    2 +
 peripheral/gatt.c        |    2 +-
 src/device.c             |   18 +-
 src/gatt-client.c        |   85 ++++
 src/gatt-database.c      |  125 +++--
 src/hcid.h               |    1 +
 src/main.c               |   14 +
 src/main.conf            |    5 +
 src/shared/att-types.h   |   25 +-
 src/shared/att.c         |  780 +++++++++++++++++++----------
 src/shared/att.h         |   18 +-
 src/shared/btsnoop.h     |    2 +
 src/shared/gatt-client.c |  279 +++++++++--
 src/shared/gatt-client.h |    5 +-
 src/shared/gatt-server.c |  388 ++++++++++-----
 src/shared/gatt-server.h |    2 +-
 tools/btgatt-client.c    |    2 +-
 tools/btgatt-server.c    |    4 +-
 tools/btproxy.c          |   20 +-
 tools/isotest.c          | 1019 ++++++++++++++++++++++++++++++++++++++
 tools/l2test.c           |    5 +-
 unit/test-gatt.c         |    4 +-
 39 files changed, 4046 insertions(+), 529 deletions(-)
 create mode 100644 lib/iso.h
 create mode 100644 tools/isotest.c

-- 
2.21.0

