Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8801C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9822187F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9L3gxLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgAOGgg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:36:36 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:34703 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOGgf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:36:35 -0500
Received: by mail-pg1-f171.google.com with SMTP id r11so7737867pgf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zuw/g7yooLqFRRvPJ3hVAhhKmFcvSvY92aZ4Scgvaj8=;
        b=S9L3gxLRQfIliY+HhDLpX0grOhfIwHI6LiqoFnVrd3ZrVBi7OicoPqz14v3zYidYiF
         1AbS18Kt8wZiW5KiZlw6Fb3xN32l9PMfv5GH7XB09bCwgUkXi0NeQ8BdgGaWjBHHFgGL
         0nt2BF+w0lkaDUo9oYnCfWefIS4gphz+nFRrKW3uCymdLmPH4YogbO/3hvww3Sghnyni
         GPxpCeK7rqk0aBuvojG4O1au81gxGWqgtpDRZS+OBzTdRpUhC6iJ4u8NAwboQ6bWrSdU
         toKqxZlri3GlQ78jjMYie9ybXHdTP4vpABiV3ERIJiq7uTIVKMzXhsjvfe2jOZIwkwI1
         RS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zuw/g7yooLqFRRvPJ3hVAhhKmFcvSvY92aZ4Scgvaj8=;
        b=i4Y/6B+5Q+uX6GCQbzIgdTsKjF0Z9oJGI/q64RbHS8gjbFjUXJHAAOqxso4NZm+TdQ
         LhylE4sgiv+Z4copCLgZt6yQY5oR8jI2r7tmICSPBjwQGHiHaR0SGd848bNniBBAup5+
         cxnrjOXVBxHiG5K2tltbbvHoJqBXMnRDlN1CFFDXBLqW3WAGaF3NXNFkyevgrEkfKPwH
         aZoT6HEXRnN8q9m2Pey8C5jXY2u+K3aYAIzIhQsR8VQ7hrvXpS/mOWyZLSKM5U9nUMMR
         d3+RSLW+mMxD8RLR136nJlXlZxvtuqgdVMjx05ssCE9JxznUnu3IvZj1MLfGy1HXQPPh
         w9wg==
X-Gm-Message-State: APjAAAV18WIU+KioP8Pe8Nm0pkpXKemh6eY4CQTv7FMezrOY+NQ35uOP
        AZeXh4GiR3LT3EXTZToaFJfLVrJDdvU=
X-Google-Smtp-Source: APXvYqxAR78BtJldA0xVondVcctD2sbrjiTC6WqKxqT2fPWnmeU6De47K2yhMROWC8BA7ydOsnDGqw==
X-Received: by 2002:a63:2842:: with SMTP id o63mr31904353pgo.317.1579070195016;
        Tue, 14 Jan 2020 22:36:35 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id z19sm19725594pfn.49.2020.01.14.22.36.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:36:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 00/11] Bluetooth 5.2 initial support
Date:   Tue, 14 Jan 2020 22:36:22 -0800
Message-Id: <20200115063633.32441-1-luiz.dentz@gmail.com>
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

