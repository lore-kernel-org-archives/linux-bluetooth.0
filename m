Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C871560F9C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhG0Xvl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhG0Xvk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 19:51:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D4AC061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so7180400pja.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7uqKsHOjKFDzXmrVzfs8eABudguq7ELjFCwWTdH7t6g=;
        b=uRfPBmwwk+s/6I+/bR85gaTf9MPBl86T6neXYuGSPQlQT7/SxaJLUZ5nY1eFXQ2GVn
         wxN8RmFPsmYgmyvTcL5q15azPONKRVinF9bKMimZMPdN0G87o7Se57xrOACsdq4MTZCg
         EJWM9OsikLaBvc/9SCJLvVSMibzWJqIfHAZHZWmqMzf/eZ7WeM0heyUufqTugV6aipSn
         iXqG7SPclAHdjsGcWocyJ/++c8dI4xyvYZg2OBZr2Fmvz05mLGM3GBbw26aoMyTT+koO
         Bcs0zKNksMMaC8p45VIiR1VcBIX7UqB7ZC+ckevUk85WvveOXZqh6fTjX6nHdOs2sY0V
         8Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7uqKsHOjKFDzXmrVzfs8eABudguq7ELjFCwWTdH7t6g=;
        b=nMGvsGYrhVoQvpR6YVej4Xr6L8L5XfHe/ZY9T1owfxJxFn55OWdVqKUrJUemz7xBwr
         h3OZJQ4Tv62y+PmKEowin+8+M1LhMbJSKu8v8frt49LZolj+XqnBvOPXeTKKoTJUcr1E
         hqE5h95pXOpMuj2YyUMtz6VP7jKGqLA1Pqg7i6MoFZY/RERCOyoCOa6kStOyUK1RVFeh
         noljSm2u0Yx1ArAeDWIO2HIBOgJTqUHkKypV9vWdRA8SmmLbu9eiYpVt0CspbVWLTYPb
         ZJp33L9HEnU0gxiYd0LpzSnNz0EY/SpUysRqT+8d+/TRPPyHPjqm6FzJhvm7760PVHGx
         LdOQ==
X-Gm-Message-State: AOAM532Zxe7Y+Tgmqant/HOdr+EI9MjkEEvjwZWL80wXsH+mqntYuarT
        DzRtxrwbIx1P5NHl+6Bkt2PdLdOB1Jc=
X-Google-Smtp-Source: ABdhPJz1qGN3E1VMx6jDmhTBDD03b8ZRtqqeqNSiqih1SfqO2VfKtNbe7LkPfsXSzk394h0W3N0KtA==
X-Received: by 2002:a17:902:dace:b029:12b:7713:6c3e with SMTP id q14-20020a170902daceb029012b77136c3emr20968651plx.72.1627429898461;
        Tue, 27 Jul 2021 16:51:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::7cb2])
        by smtp.gmail.com with ESMTPSA id y9sm1545332pfq.199.2021.07.27.16.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:51:37 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v4 00/11] Bluetooth: btintel: Refactoring setup routines
Date:   Tue, 27 Jul 2021 16:51:16 -0700
Message-Id: <20210727235127.173149-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch set refactors the multiple setup routines for various Intel devices
to a combined single entry. Here are the highlight of the changes:

0. Sync with the current tip of the master:
   acd5aea400 ("Bluetooth: btusb: Add valid le states quirk")

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

6. From the JfP/ThP, the operational firmware support the new TLV based
   HCI_Intel_Read_Version command, which confues the usage during the
   setup routine. So, the check for firmware variant of those legacy
   bootloader sku is added to use the legacy bootloader setup call.

Tedd Ho-Jeong An (11):
  Bluetooth: Add support hdev to allocate private data
  Bluetooth: btintel: Add combined setup and shutdown functions
  Bluetooth: btintel: Refactoring setup routine for legacy ROM sku
  Bluetooth: btintel: Add btintel data struct
  Bluetooth: btintel: Fix the first HCI command not work with ROM
    device.
  Bluetooth: btintel: Fix the LED is not turning off immediately
  Bluetooth: btintel: Add combined set_diag functions
  Bluetooth: btintel: Refactoring setup routine for legacy bootloader
  Bluetooth: btintel: Refactoring setup routine for TLV based booloader
  Bluetooth: btintel: Clean the exported function to static
  Bluetooth: btintel: Fix the legacy bootloader returns tlv based
    version

 drivers/bluetooth/bfusb.c        |    2 +-
 drivers/bluetooth/bluecard_cs.c  |    2 +-
 drivers/bluetooth/bpa10x.c       |    2 +-
 drivers/bluetooth/bt3c_cs.c      |    2 +-
 drivers/bluetooth/btintel.c      | 1214 ++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h      |   83 +-
 drivers/bluetooth/btmrvl_main.c  |    2 +-
 drivers/bluetooth/btmtksdio.c    |    2 +-
 drivers/bluetooth/btmtkuart.c    |    2 +-
 drivers/bluetooth/btqcomsmd.c    |    2 +-
 drivers/bluetooth/btrsi.c        |    2 +-
 drivers/bluetooth/btsdio.c       |    2 +-
 drivers/bluetooth/btusb.c        | 1105 ++-------------------------
 drivers/bluetooth/dtl1_cs.c      |    2 +-
 drivers/bluetooth/hci_ldisc.c    |    2 +-
 drivers/bluetooth/hci_serdev.c   |    2 +-
 drivers/bluetooth/hci_vhci.c     |    2 +-
 drivers/bluetooth/virtio_bt.c    |    2 +-
 include/net/bluetooth/hci_core.h |    7 +-
 net/bluetooth/hci_core.c         |   11 +-
 20 files changed, 1262 insertions(+), 1188 deletions(-)

-- 
2.26.3

