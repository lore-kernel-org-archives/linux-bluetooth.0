Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B6CC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52378207FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz9aEkst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgAOVCZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:02:25 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:47094 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgAOVCY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:02:24 -0500
Received: by mail-pl1-f177.google.com with SMTP id y8so7329047pll.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 13:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2RY691eRVEN94jJBGcNoY5d/M3/QUatx7QLFtKQ95wo=;
        b=Qz9aEkstMHitLqZwpsHGKw4rHlsmzSfeGkXR/eqQ6okex3TczxozZNCB18xE3Yq3ta
         j4K9EpdeQOnGUwBpHFtI7zuMPfo0PdB0J/IQoTnkH+x6Xcj8dZdRHWajhkcGTJpsj5RO
         EidWwLgWE4FN8UVznTftUfyH2VQuq6loeSZDPHQg7g+5+bdZpAYGkbds5MA7p2Ay3cCH
         l9OGPzQZqfyIzOu7+kdUjd0/X0T4qDJWJZNNHJHZeddF+f739sHcH9WVURyUe5ooxI7e
         Tw0N/8B5vB+xyOF6a/1A+b7erzrPcA6RPZzebWHq6o+eojld/mXmieCE+LtbGX1DR8Vf
         XQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2RY691eRVEN94jJBGcNoY5d/M3/QUatx7QLFtKQ95wo=;
        b=Oi26pV/5sSaMHCQekGWbb1Lq0X8z/LHtSH5xAmDymisuEPfwSlutm+tVXImRtuCJET
         xpKZbQuSIugKd1hTcYn6T+xKKXfQKY//39PaSyUEWKsXyUkm5Bqly/IaqPFym2KRSKOd
         Epq5vw4k+hfsC4HUEr7DMCyNlGAAjfWXVnlRfEy6UdRt87LN/eg1b4/Mmb2GyT4bQR+g
         Rrty9xcVKHppZfqR/ewuZIPVBQ5sK+7Ng0xwf+zJco6CLdPMhKsmk68FVhXORMkjx8+N
         Ixlm4dsoVyOuWKYTE4OG+tWO1SrL5xN6frEZBCxtXks5YHFw6mksR5FndIpyE+vVAUsP
         tMpA==
X-Gm-Message-State: APjAAAWvqzYTDG4KtHZlbzMVIkYLn/llLmrFcKvWiLBiQwNyPHqdpysn
        JeNLfxhQk2jVh2qVZGbBWfs9b5U6MKk=
X-Google-Smtp-Source: APXvYqzhtGGXhIB1LoVg8zXfLSArjS1VWVtpyrRHNTRbJE9Mii6E+5egxJFjyzPN7pC7md+3Xq3YVA==
X-Received: by 2002:a17:90a:31cf:: with SMTP id j15mr2240868pjf.120.1579122143712;
        Wed, 15 Jan 2020 13:02:23 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.41])
        by smtp.gmail.com with ESMTPSA id s24sm23290976pfd.161.2020.01.15.13.02.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 13:02:22 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 00/11] Bluetooth 5.2 initial support
Date:   Wed, 15 Jan 2020 13:02:10 -0800
Message-Id: <20200115210221.13096-1-luiz.dentz@gmail.com>
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
- v5: Fix spacing and use of __attribute (packed).

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

