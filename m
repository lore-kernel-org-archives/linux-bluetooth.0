Return-Path: <SRS0=d6qz=3A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F40C33CA2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63882072E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhSbGxcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgAKCWU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 21:22:20 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:37258 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgAKCWU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 21:22:20 -0500
Received: by mail-pj1-f52.google.com with SMTP id m13so1778378pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 18:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Cg7THp73jKO904srJGSiN32HUbdoz7ZWIb+9fNEwtE=;
        b=jhSbGxcQXXM9UdyfnijmgwiO528XvMYKfVLanq8NcpjKZiJEukKG7cEn7C9SkV/oQ6
         uSQEiuHCWaS5nDx7+ZF0IMmPBLUudcLc49heLLpngCfD84kqSpkCNwTO/flJeRh1MXgh
         e1omHEc4elIU6AtbDymWl2AsVEy+UpYUcl94mqJlE2dS7ez3uEyDXpMdn+ax6Nzj6f9u
         CI2tlDRGt9fpViUVIMV+lMJUS+HIKj5r1kiSvhAqRjGbCIoZhFdP7pLRBLb7/tibwF/i
         jmMNrWGWTUaXTSxxV7Ww1gQrlc12drGE0f2ATxZh8LY7DD51m80PuWvPrNrWW2ZYvv8Z
         767Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Cg7THp73jKO904srJGSiN32HUbdoz7ZWIb+9fNEwtE=;
        b=d+HBDK22ILC2dRDbcT92OinMn3KUHd3D5ma98y2VPRbUX7OQWMHm14m9XlicRaLnAy
         vEcYgbgWP2CgvIndt0HT+dW2WUGxX86w0+60uzSzIpURl1WmNJcgoC8ZnnXnFYrboIWT
         vetvYZYrf2bpm3dd4i48gcdqZO/2oFYtrfTMiglym3pxVCLsVWpjVOY/mbv0eSTxwSbs
         0BDdAbaORyJn9UogKlJfktUJ4hVOpFhkd0lQ3OZrXPqdnFa7DC0lCdD60wys96ts42w5
         fYuuOEZodNhpxPeC5t2AI8H1EYbIXxf+2+7Jpr8r9W5Y1ndFZRLxK+GXcBS4it2se1tu
         12vg==
X-Gm-Message-State: APjAAAWBn1K3tvbZfcxApeIhTX8fOYe8aNS2jm/g2JxDFScUGIxUZd7s
        zu0C5TZeY3ypHQzdQz6XPVCO9zQWoKE=
X-Google-Smtp-Source: APXvYqwcEQDJ6CTpbFADlOaZ9JqMagLkrd3RmsRkHSsXN+5urSva4vyf/Fk8DlkVt791coFE6tUtCw==
X-Received: by 2002:a17:902:59cd:: with SMTP id d13mr8141269plj.146.1578709338832;
        Fri, 10 Jan 2020 18:22:18 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id g22sm4158906pgk.85.2020.01.10.18.22.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 18:22:17 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/10] Bluetooth 5.2 initial support
Date:   Fri, 10 Jan 2020 18:22:06 -0800
Message-Id: <20200111022216.30842-1-luiz.dentz@gmail.com>
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
	+ H4/USB ISO packets support

* Emulator:
	+ CIS/Unicast emulation support
	- BIS/Broadcast emulation not yet supported

* Userspace support to follow once Kernel changes are merged.

Bluetooth 5.2 spec:
https://www.bluetooth.org/docman/handlers/downloaddoc.ashx?doc_id=478726

ChangeLog:
- v2: Only attempt to fix up packet type when an ISO connection exists, remove
  L2CAP_ECRED_MASK.

Luiz Augusto von Dentz (10):
  Bluetooth: Add definitions for CIS connections
  Bluetooth: Add initial implementation of CIS connections
  Bluetooth: L2CAP: Add definitions for Enhanced Credit Based Mode
  Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode
  Bluetooth: hci_vhci: Add support for ISO packets
  Bluetooth: monitor: Add support for ISO packets
  Bluetooth: Make use of __check_timeout on hci_sched_le
  Bluetooth: hci_h4: Add support for ISO packets
  Bluetooth: btusb: Add support for ISO packets
  Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet

 drivers/bluetooth/btusb.c         |   21 +
 drivers/bluetooth/hci_h4.c        |    1 +
 drivers/bluetooth/hci_uart.h      |    7 +
 drivers/bluetooth/hci_vhci.c      |    1 +
 include/net/bluetooth/bluetooth.h |   24 +
 include/net/bluetooth/hci.h       |  157 ++++
 include/net/bluetooth/hci_core.h  |   56 +-
 include/net/bluetooth/hci_mon.h   |    2 +
 include/net/bluetooth/hci_sock.h  |    2 +
 include/net/bluetooth/iso.h       |   36 +
 include/net/bluetooth/l2cap.h     |   48 +
 net/bluetooth/Kconfig             |    1 +
 net/bluetooth/Makefile            |    1 +
 net/bluetooth/af_bluetooth.c      |   12 +-
 net/bluetooth/hci_conn.c          |  169 ++++
 net/bluetooth/hci_core.c          |  254 ++++--
 net/bluetooth/hci_event.c         |  230 +++++
 net/bluetooth/hci_sock.c          |    6 +
 net/bluetooth/iso.c               | 1393 +++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c        |  498 ++++++++++-
 net/bluetooth/l2cap_sock.c        |   39 +-
 21 files changed, 2866 insertions(+), 92 deletions(-)
 create mode 100644 include/net/bluetooth/iso.h
 create mode 100644 net/bluetooth/iso.c

-- 
2.21.0

