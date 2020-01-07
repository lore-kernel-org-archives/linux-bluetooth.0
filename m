Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AFDC33C99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735B9207E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XroquEyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgAGHk6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:40:58 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:33048 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgAGHk6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 02:40:58 -0500
Received: by mail-pg1-f178.google.com with SMTP id 6so28102158pgk.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 23:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bi0zHSl2r+TnRkHH5zdAqstwU5dVjBXorarrNBuG3XI=;
        b=XroquEyDG1okP+urm8+9pK8HRKv6qvML1jXAD/H1e7OD8zD1exrHH3MEZfX+LcZMUI
         mOdTAZxHvurDKCpGARQ4fblJ4Bc7YbbV7Fl3O0mTygDcnfCAaA2b0V6dIPn3EuciQdpX
         6YOb1vS1fNVemmPhohVIw9vfw/WmNDq4a6JK0WIb5unzoSHgiUwAVLc8+ScxXtmOqKoX
         rBW9qks5bCJe+wfxTOlCk5Wqhy2X1+L8j8i0fyFOOEICE3WL177KZy9xbp20RiLM28Nf
         zWAbDeyUdwKbn1792PqnNhEFwmrCAy2Ba5wpeLCBAsfzSXKMpXsJV3pxxeGPyrlPLfr3
         Jz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bi0zHSl2r+TnRkHH5zdAqstwU5dVjBXorarrNBuG3XI=;
        b=V2809NaURjuTCU/oXpB5wF1LvVenElqt9WoI2DOYnqtYvYTgzgGurhaJgvMYdUpWGs
         NPCGzLuF5jXRgpU9wyePSe6FjMVLVdWgi359FuOVf5eRF0xv27J2EwKv62giq3owKzYa
         dnRRtv7Rk+SlfVKAfXOr8t8EJJVkhyUImWPxs0fFd3AEUn0XwcyEdGBPXjb3GKgfzDiX
         oKxqnF9cq6a01yxf2BqfV8WVNnX8HSNmDk/n7D3DBlK8bnFZyWZHl7rXxFM5pzPSMqg1
         LtejCUUoUbMP3xLKs9P2DVTugy8xZ3ALQWhCcEBjGyDgHQkvxoFC1naHbEljOOMv8wLM
         YM3g==
X-Gm-Message-State: APjAAAX9nh/BcbP33KIFCLRizjKzhH0sTz01sgO2W7C6Xj5/vUXbh5aN
        B2OJhYkRhuFqQWzvRWkGlpcXyKE0HwY=
X-Google-Smtp-Source: APXvYqy4zRNPxtFc0CKGFA6mSlClrpwjsHQkFDs7EhlOXH+wcF/7snCtvQtaj+BYw+BnaKiZuyIhDA==
X-Received: by 2002:a62:1c95:: with SMTP id c143mr109928815pfc.219.1578382857780;
        Mon, 06 Jan 2020 23:40:57 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id k21sm67725388pfa.63.2020.01.06.23.40.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 23:40:56 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/10] Bluetooth 5.2 initial support
Date:   Mon,  6 Jan 2020 23:40:46 -0800
Message-Id: <20200107074056.25453-1-luiz.dentz@gmail.com>
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

