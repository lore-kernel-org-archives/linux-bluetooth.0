Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94556C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C83A2467C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPwMocuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgAOGf0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:35:26 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:38477 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgAOGfZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:35:25 -0500
Received: by mail-pg1-f178.google.com with SMTP id a33so7720743pgm.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zuw/g7yooLqFRRvPJ3hVAhhKmFcvSvY92aZ4Scgvaj8=;
        b=TPwMocuUPRmYjLEx+SOQDvMH1a8Twl61f2dtyupuF3ksO7HnBP2woSPW9pbsOL/T0j
         Y4Yd5NvMNjWgnFRYr6A6TXbAl2Lah3awlMXstZvppj3pIFyBgQK+qasqGY96dUyGC4Ts
         i5r494Ej15VDCvgx7c8wW3CdfIvlscznIAa+rQu8YRM51NAtJjDbQuKnwIjKSKzxi9kh
         wn6yMY33jkilCrhEPALmOajQzepxDTkQLOMc6qz3qUv1PKTEX8YgDsxb3p4UBbRXFvGS
         E2hrNiUclf5OzNltXK7tTcBUEdqxGw7XZgn4VwomXhkushZs3GyKksJJ6WCDNXTmluad
         56gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zuw/g7yooLqFRRvPJ3hVAhhKmFcvSvY92aZ4Scgvaj8=;
        b=ryxI2hseWeJVazdoZzTYyQIJ9NzMNTwLa+f/I5WMRqBZ7j9CUyOgonpKPnurcsDDa3
         xC7Pe6DW5GNwzGnWyU/PNzk893EBgbiVjPmdMq+lXkc5o/eCbrHng85biiqzBT14wnUC
         UR7744iyqYEDh5JVtsNBxM7M6Iys7FLrh6SATe09L+iQHOw7aBNXwDqGBM5JgdkRs+l0
         n1QJTXbwfW/n0mHQhU0Cd2RqrC+pai0SlCTbqhtECm/jDmPCFT+Dxi0/Q/wzXNDAcC1Y
         rmOCnPA7CYOUBM3TLRRmNAAJmKrx8bZtUWwiuUDZ9/tnNPkN50eA2dkm+F2lFTdNKdv3
         mHdw==
X-Gm-Message-State: APjAAAXNkFAHfD8MZFK8XX1l7S15/DOr740VaIEehGNXj2cueJX9LFE+
        meq1EfWFEwSLn8zEWo77DqydlQcMBC0=
X-Google-Smtp-Source: APXvYqyTuMqwQyqFJtGXVooSZP66zFm6/96Cz0275C6BfW4QaRppeGhlO65kEpT3Ga8CVjG6wFfBIw==
X-Received: by 2002:a63:483:: with SMTP id 125mr31067898pge.217.1579070124804;
        Tue, 14 Jan 2020 22:35:24 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q21sm19637469pff.105.2020.01.14.22.35.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:35:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 00/11] Bluetooth 5.2 initial support
Date:   Tue, 14 Jan 2020 22:35:08 -0800
Message-Id: <20200115063523.32127-1-luiz.dentz@gmail.com>
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
	+ CIS/Unicast support
	+ ISO socket family with QoS support
	- BIS/Broadcast not yet supported

* L2CAP Enhanced Credit Based Flow Control Mode
	+ Support all new procedures
	+ New L2CAP socket mode
	- Initiating multiple connections at once does not map to any existing
	  socket APIs

* Monitor:
	+ ISO packets support

* Drivers:
	+ H4,H5,sdio ISO packets support

* Emulator:
	+ CIS/Unicast emulation support
	- BIS/Broadcast emulation not yet supported

* Userspace support to follow once Kernel changes are merged.

Bluetooth 5.2 spec:
https://www.bluetooth.org/docman/handlers/downloaddoc.ashx?doc_id=478726

ChangeLog:
- v2: Only attempt to fix up packet type when an ISO connection exists, remove
  L2CAP_ECRED_MASK.
- v3: Dropped USB changes since that has not clear way to support ISO packets
  with existing endpoints. Renamed ECRED to EXT_FLOWCTL.
- v4: Fix not using __le16 for HCI PDU definitions, renamed
  FLAG_LE_CONN_REQ_SENT to FLAG_LE_FLOWCTL_CONN_REQ_SENT.

Luiz Augusto von Dentz (11):
  Bluetooth: Add definitions for CIS connections
  Bluetooth: Add initial implementation of CIS connections
  Bluetooth: L2CAP: Add definitions for Enhanced Credit Based Mode
  Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode
  Bluetooth: L2CAP: Rename FLAG_LE_CONN_REQ_SENT to
    FLAG_LE_FLOWCTL_CONN_REQ_SENT
  Bluetooth: hci_vhci: Add support for ISO packets
  Bluetooth: monitor: Add support for ISO packets
  Bluetooth: Make use of __check_timeout on hci_sched_le
  Bluetooth: hci_h4: Add support for ISO packets
  Bluetooth: hci_h5: Add support for ISO packets
  Bluetooth: btsdio: Check for valid packet type

 drivers/bluetooth/btsdio.c        |   19 +-
 drivers/bluetooth/hci_h4.c        |    1 +
 drivers/bluetooth/hci_h5.c        |    3 +
 drivers/bluetooth/hci_uart.h      |    7 +
 drivers/bluetooth/hci_vhci.c      |    1 +
 include/net/bluetooth/bluetooth.h |   35 +
 include/net/bluetooth/hci.h       |  159 +++-
 include/net/bluetooth/hci_core.h  |   68 +-
 include/net/bluetooth/hci_mon.h   |    2 +
 include/net/bluetooth/hci_sock.h  |    2 +
 include/net/bluetooth/iso.h       |   36 +
 include/net/bluetooth/l2cap.h     |   47 +-
 net/bluetooth/Kconfig             |    1 +
 net/bluetooth/Makefile            |    1 +
 net/bluetooth/af_bluetooth.c      |   12 +-
 net/bluetooth/hci_conn.c          |  169 ++++
 net/bluetooth/hci_core.c          |  254 ++++--
 net/bluetooth/hci_event.c         |  230 +++++
 net/bluetooth/hci_sock.c          |    6 +
 net/bluetooth/iso.c               | 1393 +++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c        |  514 ++++++++++-
 net/bluetooth/l2cap_sock.c        |   39 +-
 22 files changed, 2898 insertions(+), 101 deletions(-)
 create mode 100644 include/net/bluetooth/iso.h
 create mode 100644 net/bluetooth/iso.c

-- 
2.21.0

