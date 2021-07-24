Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D94C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A213860EB1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhGXGtq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 02:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhGXGtj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 02:49:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AC1C06175F
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k1so5610953plt.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1CpBl5mY0p2RfQRLB4s0Fjznb7qXVJN+FiwMEwnizY=;
        b=jIkEtVzzLltAT3IM5BemqW7btKcFIxz9qkTd4FOItwBJh5fCO9JRE+/didYQmrMgm2
         EuHP43hSvbl9lvBNR4bNvu54tTUHsEY0WTlcFA9s2+fwUDnYqRAbNs3/IFIUPu8/yfPS
         lyMvGs80rNBL/lkhCYqbDJi6d7SVQurBjImtitbvD58mosEtvasbtxQ9gJ/dymoSxcni
         NrmXlyV2uTh7RyY9qscrSy9MNh9tSy7+b8kp/lEOgx/uKHlAdVLgfE1znKVy+VM9WcFl
         /tYvFhj/OIJmY1KeeE4UFJW4bVw+nU2d8OfB81ZPlvUyC+WLj1PxZhKBqIXSOzAO8QdZ
         Dw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1CpBl5mY0p2RfQRLB4s0Fjznb7qXVJN+FiwMEwnizY=;
        b=g1wT76Q2ANz20AeawnraS9TvqtPoMBUfGx1bDgXZbVuKoUv7QvOhNu/NJAW/nMGtaw
         an10/Cv3dOZCkAohJ82FHDGAgKPyisuLNfW3vsYAtG92VkL5AI1KHdbaSK7QV/RPBe02
         4Cb1BUPrk4nisiSwQsnQRQtUcYzJPWd9yAqVg9h9R0PLwy9jkQsKluHTqA8X+zHNkNFP
         WD8qIQnyi7M4j2smKE9714m/3LrRbLfPBrLqNllJ8MB22qr06gSrUUNU2E9gbOUSXNH1
         +7LO9FEI7BbthPJonz8PSFiqCrdW/ymTU8VGZ21q5ff4YIgQ23mWJkt33c+cCHBkU4s3
         ZCAQ==
X-Gm-Message-State: AOAM533ithTHWpiWi1Lt3vxkXC2HPVajHRRGbpRba24PKq/5xOUjt1Uk
        lUE4Tvwzf/WGQVqu2XCxMYsUx9IhiLE=
X-Google-Smtp-Source: ABdhPJyMEGpvZAalq59pEh1tyS+gc2CVyG4l5mccpWVrdeAm1MoTqYn14B1GQELGGDa6oWT54pCb4Q==
X-Received: by 2002:a17:90a:6be1:: with SMTP id w88mr7921583pjj.121.1627111809395;
        Sat, 24 Jul 2021 00:30:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::1291])
        by smtp.gmail.com with ESMTPSA id u24sm38510919pfm.141.2021.07.24.00.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:30:08 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v3 0/9] Bluetooth: btintel: Refactoring setup routines
Date:   Sat, 24 Jul 2021 00:29:56 -0700
Message-Id: <20210724073005.714003-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch set refactors the multiple setup routines for various Intel devices
to a combined single entry. Here are the highlight of the changes:

1. Updated hci_alloc_dev() to allocate the hdev object with an extra buffer
   for the private data. btintel introduces the btintel_data struct and
   store it to the private data in hdev object.

2. Added a single entry for setup and shutdown and uses the
   HCI_Intel_Read_Version command to identify the device, instead of
   relying on the USB VID and PID.

   Also, it uses the new format of HCI_Intel_Read_Version command for
   legacy ROM and legacy bootloader devices. Luckly legacy devices
   support the new format.

3. Keep the state of bootloader in btintel object. The bootloader state
   is agnostic to the transport type, so btintel uses the btintel_data
   to keep track of the state in the private data section in hdev.

4. After identifying the setup type for the device, it uses the
   correspond setup routines based on the setup type, and the setup
   routines were moved from btusb to btintel.
   However, actual work for the setup routines were not changed or very
   minimal.

5. Since many functions were moved from btusb to btintel, clean up the
   exported functions and make them static if possible.

Tedd Ho-Jeong An (9):
  Bluetooth: Add support hdev to allocate private data
  Bluetooth: btintel: Add combined setup and shutdown functions
  Bluetooth: btintel: Refactoring setup routine for legacy ROM sku
  Bluetooth: btintel: Add btintel data struct
  Bluetooth: btintel: Fix the first HCI command not work with ROM
    device.
  Bluetooth: btintel: Add combined set_diag functions
  Bluetooth: btintel: Refactoring setup routine for legacy bootloader
  Bluetooth: btintel: Refactoring setup routine for TLV based booloader
  Bluetooth: btintel: Clean the exported function to static

 drivers/bluetooth/bfusb.c        |    2 +-
 drivers/bluetooth/bluecard_cs.c  |    2 +-
 drivers/bluetooth/bpa10x.c       |    2 +-
 drivers/bluetooth/bt3c_cs.c      |    2 +-
 drivers/bluetooth/btintel.c      | 1184 ++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h      |   82 +--
 drivers/bluetooth/btmrvl_main.c  |    2 +-
 drivers/bluetooth/btmtksdio.c    |    2 +-
 drivers/bluetooth/btmtkuart.c    |    2 +-
 drivers/bluetooth/btqcomsmd.c    |    2 +-
 drivers/bluetooth/btrsi.c        |    2 +-
 drivers/bluetooth/btsdio.c       |    2 +-
 drivers/bluetooth/btusb.c        | 1098 ++-------------------------
 drivers/bluetooth/dtl1_cs.c      |    2 +-
 drivers/bluetooth/hci_ldisc.c    |    2 +-
 drivers/bluetooth/hci_serdev.c   |    2 +-
 drivers/bluetooth/hci_vhci.c     |    2 +-
 drivers/bluetooth/virtio_bt.c    |    2 +-
 include/net/bluetooth/hci_core.h |    7 +-
 net/bluetooth/hci_core.c         |   11 +-
 20 files changed, 1225 insertions(+), 1187 deletions(-)

-- 
2.26.3

