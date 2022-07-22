Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4529BC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 20:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiGVUxp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVUxn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 16:53:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B637461738
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 13:53:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g12so5423860pfb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XunZYN18xVq5E9Gg2sKwwr3NassRtXFbRrHXf6W4tBY=;
        b=HzFig1wtVhoOewVGSuf0qNCDKIoElDltJDtKMg9Swv2OI14vwjDaR/aksLeOh/UiQ5
         zOK6fu9A8F4PnlBmKwhuCWAuJ3GeOpIKMfT14rXlptH8jUbNnuneaG36HEymk36g80QT
         fNs0ozqnhHAYuQPteiUeDquPxz5M1nd0XLgiLB6b3m/mtRRcE3qcBPhte4OuxBYagN0K
         BlS2N0vQFVMJ9/i/cEiZq3r+N17chTgpw/Yxipk7hnX/vHI85UdGr5T9F/zipZSYFoOW
         MqXDadFpHWo+rXEKQyVvRa6N4+zJCVTnx6jTGVBxKh9D/EHZIhampkN3l5hd0R8L5Q7Q
         lWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XunZYN18xVq5E9Gg2sKwwr3NassRtXFbRrHXf6W4tBY=;
        b=p3YP6YmhKav9hb5DcxHsCUiZL+3FowJDcsnFKda4hlUsoTtlpgZFhExU4Q0WH2aMph
         hykSQywDtn+HEg7SQsOkSRLcPrKqxr/lyIpKOACBm4HChfNMIcRwv2VNulUSv+vT2IvN
         67JvtVNPmFerfnUoEzCXGsm7aeTKWbfXmva7aKhNHWrXmisboCO5CpxzFhWx4U5H9DJe
         l9p1ME5BXeUPMfbxBj+k+D8UW/Bmb6A83d+ey8Sw6lY8VynAMTchAxDWyo9/r0HIOgIn
         CVQxa7sgLvPzpUJpPURrisVV1EGoMr8bR6KQKq4yHujjR1rJ+EdhJqaptxrj2MC6L47q
         9OzA==
X-Gm-Message-State: AJIora9A6gNTYt9dI9WPdI9Zt4as7l/gLEyl2UpethLlIDt0XgRtO3Gm
        olyihqtLvBtembatzNN+cUK/7U3gC9UgUA==
X-Google-Smtp-Source: AGRyM1vS4qQWvnse6+Ps4sN3C+0JgduAyH1t+wfeHdGvTIPfq9sbF8LmpJgRL7vAUGOmHvLV4aMS/Q==
X-Received: by 2002:a05:6a00:230a:b0:52a:d0e8:c936 with SMTP id h10-20020a056a00230a00b0052ad0e8c936mr1753153pfh.67.1658523221481;
        Fri, 22 Jul 2022 13:53:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d2-20020a17090a3b0200b001f1abb8de2bsm5799930pjc.49.2022.07.22.13.53.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:53:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth-next 2022-07-22
Date:   Fri, 22 Jul 2022 13:53:39 -0700
Message-Id: <20220722205339.846915-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following changes since commit 6e0e846ee2ab01bc44254e6a0a6a6a0db1cba16d:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-07-21 13:03:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2022-07-22

for you to fetch changes up to 768677808478ee7ffabf9c9128f345b7ec62b5f3:

  Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet (2022-07-22 13:24:55 -0700)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - Add support for IM Networks PID 0x3568
 - Add support for BCM4349B1
 - Add support for CYW55572
 - Add support for MT7922 VID/PID 0489/e0e2
 - Add support for Realtek RTL8852C
 - Initial support for Isochronous Channels/ISO sockets
 - Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING quirk

----------------------------------------------------------------
Aaron Ma (1):
      Bluetooth: btusb: Add support of IMC Networks PID 0x3568

Abhishek Pandit-Subedi (2):
      Bluetooth: Fix index added after unregister
      Bluetooth: Unregister suspend with userchannel

Ahmad Fatoum (2):
      dt-bindings: bluetooth: broadcom: Add BCM4349B1 DT binding
      Bluetooth: hci_bcm: Add BCM4349B1 variant

Alain Michaud (1):
      Bluetooth: clear the temporary linkkey in hci_conn_cleanup

Brian Gix (3):
      Bluetooth: Remove dead code from hci_request.c
      Bluetooth: Remove update_scan hci_request dependancy
      Bluetooth: Convert delayed discov_off to hci_sync

Dan Carpenter (2):
      Bluetooth: fix an error code in hci_register_dev()
      Bluetooth: clean up error pointer checking

Hakan Jansson (7):
      dt-bindings: net: broadcom-bluetooth: Add property for autobaud mode
      Bluetooth: hci_bcm: Add support for FW loading in autobaud mode
      dt-bindings: net: broadcom-bluetooth: Add CYW55572 DT binding
      dt-bindings: net: broadcom-bluetooth: Add conditional constraints
      Bluetooth: hci_bcm: Add DT compatible for CYW55572
      Bluetooth: hci_bcm: Prevent early baudrate setting in autobaud mode
      Bluetooth: hci_bcm: Increase host baudrate for CYW55572 in autobaud mode

He Wang (1):
      Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922

Hilda Wu (5):
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x04CA:0x4007
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x04C5:0x1675
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x0CB8:0xC558
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x13D3:0x3587
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x13D3:0x3586

Jiasheng Jiang (1):
      Bluetooth: hci_intel: Add check for platform_driver_register

Luiz Augusto von Dentz (16):
      Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
      Bluetooth: HCI: Fix not always setting Scan Response/Advertising Data
      Bluetooth: hci_sync: Fix not updating privacy_mode
      Bluetooth: hci_sync: Don't remove connected devices from accept list
      Bluetooth: hci_sync: Split hci_dev_open_sync
      Bluetooth: Add bt_status
      Bluetooth: Use bt_status to convert from errno
      Bluetooth: mgmt: Fix using hci_conn_abort
      Bluetooth: MGMT: Fix holding hci_conn reference while command is queued
      Bluetooth: hci_core: Introduce hci_recv_event_data
      Bluetooth: Add initial implementation of CIS connections
      Bluetooth: Add BTPROTO_ISO socket type
      Bluetooth: Add initial implementation of BIS connections
      Bluetooth: ISO: Add broadcast support
      Bluetooth: btusb: Add support for ISO packets
      Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet

Manish Mandlik (2):
      Bluetooth: hci_sync: Refactor add Adv Monitor
      Bluetooth: hci_sync: Refactor remove Adv Monitor

Sai Teja Aluvala (1):
      Bluetooth: hci_qca: Return wakeup for qca_wakeup

Schspa Shi (1):
      Bluetooth: When HCI work queue is drained, only queue chained work

Sean Wang (1):
      Bluetooth: btmtksdio: Add in-band wakeup support

Tamas Koczka (1):
      Bluetooth: Collect kcov coverage from hci_rx_work

Xiaohui Zhang (1):
      Bluetooth: use memset avoid memory leaks

Ying Hsu (1):
      Bluetooth: Add default wakeup callback for HCI UART driver

Yuri D'Elia (1):
      Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for MTK

Zhengping Jiang (2):
      Bluetooth: mgmt: Fix refresh cached connection info
      Bluetooth: hci_sync: Fix resuming scan after suspend resume

Zijun Hu (5):
      Bluetooth: hci_sync: Correct hci_set_event_mask_page_2_sync() event mask
      Bluetooth: hci_sync: Check LMP feature bit instead of quirk
      Bluetooth: btusb: Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA
      Bluetooth: btusb: Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for fake CSR
      Bluetooth: hci_sync: Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING

shaomin Deng (1):
      Bluetooth: btrtl: Fix typo in comment

 .../bindings/net/broadcom-bluetooth.yaml           |   25 +
 drivers/bluetooth/btbcm.c                          |   33 +-
 drivers/bluetooth/btbcm.h                          |    8 +-
 drivers/bluetooth/btmtksdio.c                      |   15 +
 drivers/bluetooth/btrtl.c                          |    2 +-
 drivers/bluetooth/btusb.c                          |   45 +-
 drivers/bluetooth/hci_bcm.c                        |   35 +-
 drivers/bluetooth/hci_intel.c                      |    6 +-
 drivers/bluetooth/hci_qca.c                        |    2 +-
 drivers/bluetooth/hci_serdev.c                     |   11 +
 include/net/bluetooth/bluetooth.h                  |   71 +-
 include/net/bluetooth/hci.h                        |  203 ++-
 include/net/bluetooth/hci_core.h                   |  234 ++-
 include/net/bluetooth/hci_sock.h                   |    2 +
 include/net/bluetooth/hci_sync.h                   |   16 +
 include/net/bluetooth/iso.h                        |   32 +
 net/bluetooth/Kconfig                              |    1 +
 net/bluetooth/Makefile                             |    1 +
 net/bluetooth/af_bluetooth.c                       |    4 +-
 net/bluetooth/eir.c                                |   62 +-
 net/bluetooth/eir.h                                |    1 +
 net/bluetooth/hci_conn.c                           |  900 +++++++++-
 net/bluetooth/hci_core.c                           |  569 ++++--
 net/bluetooth/hci_event.c                          |  529 +++++-
 net/bluetooth/hci_request.c                        |  429 +----
 net/bluetooth/hci_request.h                        |   16 +-
 net/bluetooth/hci_sock.c                           |   11 +-
 net/bluetooth/hci_sync.c                           |  628 +++++--
 net/bluetooth/iso.c                                | 1824 ++++++++++++++++++++
 net/bluetooth/l2cap_core.c                         |    1 +
 net/bluetooth/lib.c                                |   71 +
 net/bluetooth/mgmt.c                               |  338 ++--
 net/bluetooth/msft.c                               |  269 +--
 net/bluetooth/msft.h                               |    6 +-
 34 files changed, 5224 insertions(+), 1176 deletions(-)
 create mode 100644 include/net/bluetooth/iso.h
 create mode 100644 net/bluetooth/iso.c
