Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E5CC33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A6B222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UInPB6GB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAOB7V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:59:21 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:39651 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgAOB7V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 20:59:21 -0500
Received: by mail-pf1-f173.google.com with SMTP id q10so7621684pfs.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 17:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T67bh54HrODBKW0YAUyFTdqO128dgJCLOMHAidG1lEs=;
        b=UInPB6GBB8akWOJSaesfeYbpD/VaH8T08fHaEZqnBHB8DGM7IFGLy65Areyqzzrxml
         6sHQosEtY3Anz9rd62Ep+brm4qd6efkax2MHN3ZB+5h/D5UHDHDcggwpgwAutl+7QGFj
         LGACzKtXI2/NJdmK4nQgLW61MAiM0sJJetUUC4EFBPQn8XHtYSEzVIAT87m/L6OMWuOK
         lED1Ou7pAWjbF5TxOzZ0ucwtu6A0qtiXKOhBBaDdourBzqPpvgbj9E7CBaRoB/40UWvb
         Ulj+njj3ATzYvxk2lM8Vo6OVpucK+nZYKGVBKHLus37Ux1W+L6mbQrUVg0KSRT37nv3j
         RIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T67bh54HrODBKW0YAUyFTdqO128dgJCLOMHAidG1lEs=;
        b=J0p3ObBO1te/xxB7HaBMFqK+i3Nusc7iddpmZSZ2j+2QOfsUtNYviVyCgYzua+uTsW
         QUFuDc70CpZuDw63n1JnLdNJpajO0sf06chQcRl0mht/dcwClJCTY2ZC+Mt+NmvZ1t71
         edvEkwALWPunLrMxEPu0m9Rtxw338WqBRUZjdmNISOFsnMqsqIg/hkH2/6dF0SrCuaim
         T/sLZRrNWecnkNtVB10taC8IXk/ovNd307DT43bYhLmMpr1YM5tfDzlc+hWubgp3UUaI
         YgEzSUbI5Nn4/6Qaqaz066nlmKTYsA+jcRkaEGgz/A8N56PxIDaEFVxJmpFe3bVEwAiv
         BR8w==
X-Gm-Message-State: APjAAAVmlyixpFPOQ0cT2ENwiIFi2+sthD2TLkQ0mGHqi0sAHLwlGMGC
        jUEE4EBFBJOfuOse7huB2vvLeU42gDc=
X-Google-Smtp-Source: APXvYqwXzVNv1Q3jnnhqCu/vNAlCK2mJl+pOHQVTTF32Y+vl1HF31cFNL9tHhLe4ArMmcnZDO+3g9w==
X-Received: by 2002:a63:de03:: with SMTP id f3mr31052509pgg.141.1579053560404;
        Tue, 14 Jan 2020 17:59:20 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q10sm20263573pfn.5.2020.01.14.17.59.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:59:19 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/8] Bluetooth 5.2 initial support
Date:   Tue, 14 Jan 2020 17:59:10 -0800
Message-Id: <20200115015918.1187-1-luiz.dentz@gmail.com>
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
	+ H4 ISO packets support

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

Luiz Augusto von Dentz (8):
  Bluetooth: Add definitions for CIS connections
  Bluetooth: Add initial implementation of CIS connections
  Bluetooth: L2CAP: Add definitions for Enhanced Credit Based Mode
  Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode
  Bluetooth: hci_vhci: Add support for ISO packets
  Bluetooth: monitor: Add support for ISO packets
  Bluetooth: Make use of __check_timeout on hci_sched_le
  Bluetooth: hci_h4: Add support for ISO packets

 drivers/bluetooth/hci_h4.c        |    1 +
 drivers/bluetooth/hci_uart.h      |    7 +
 drivers/bluetooth/hci_vhci.c      |    1 +
 include/net/bluetooth/bluetooth.h |   35 +
 include/net/bluetooth/hci.h       |  157 ++++
 include/net/bluetooth/hci_core.h  |   68 +-
 include/net/bluetooth/hci_mon.h   |    2 +
 include/net/bluetooth/hci_sock.h  |    2 +
 include/net/bluetooth/iso.h       |   36 +
 include/net/bluetooth/l2cap.h     |   45 +
 net/bluetooth/Kconfig             |    1 +
 net/bluetooth/Makefile            |    1 +
 net/bluetooth/af_bluetooth.c      |   12 +-
 net/bluetooth/hci_conn.c          |  169 ++++
 net/bluetooth/hci_core.c          |  254 ++++--
 net/bluetooth/hci_event.c         |  230 +++++
 net/bluetooth/hci_sock.c          |    6 +
 net/bluetooth/iso.c               | 1393 +++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c        |  510 ++++++++++-
 net/bluetooth/l2cap_sock.c        |   39 +-
 20 files changed, 2877 insertions(+), 92 deletions(-)
 create mode 100644 include/net/bluetooth/iso.h
 create mode 100644 net/bluetooth/iso.c

-- 
2.21.0

