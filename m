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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF72C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A4D60EE6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhG2SgJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhG2SgI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 14:36:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB0CC061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t21so7954604plr.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVNx9HOGYdotzXiZ7QX/bAu5HeN5hETIURDhKqU+xlw=;
        b=Vjs1UDmC/zSev36wK5o1PhCzVohdw4faAHhylPRI+tHLoWTQUFqFsst7Ifp23eFeuM
         6iouYbFB9QA9+RLPAbn22ISov53L8t5UD2oSIUJqCQpcB2JulXnWbsIwCU7DvRbmrjvb
         2+z0U32Cyh1Zn/EZQ3mLlIercWXFc0MY8nyNWGFzr+vOGdZbVvGnoZSC+yWoiJZYrJUo
         aWKeJ/fqfgxpRsmd0+ToxlP9v1HQqtdXfEJouIxaz0JSElcp/aBJjhkeGYVIPqtZ5pm+
         nQ3nQNWpLbzeyLYcl6l/EeDkFGOKt4eK3O2d5hqdnPz4w4R7+Xn4jz1KIrYhnF909lIy
         MFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVNx9HOGYdotzXiZ7QX/bAu5HeN5hETIURDhKqU+xlw=;
        b=hL6AhSaXNuNGm2rSwOvBSaFUSui4Mr8/E5h4Xg3CTSHBK7yPJS7A+Bjjt5SYKUfr3v
         zZPeLaey7cGyUuSq6XqA1OzXIFIjYpiRZof/zVC12nor8ic4IDi9cuuprc6mrx2a9jsk
         IJwIO36Zk5PSLE2eeKOybg6E50e/iX+cTsap4HZOfn4/K7aKX5rZ4Amt57zCz5DKXmvh
         zb1cOjbyCjH1w2+eJqRgr7RrNC3vgFPpByR65ZDcTa6yjyvIaec6xKE/ouE/NPbGWW4t
         CUsi1bNbfDvsIaT7Os2grqivwv5oXVXBEGtz08TWmsAIy0h4F3RoXhJIEsWSuN3ioNMy
         kaYA==
X-Gm-Message-State: AOAM530FEtnX3fkY4+gNAax/SQuDjcnqL5AyMK5k080FrLQwZrSRKeVk
        fWYop7S2giyORoH0waI3tWYHM5jjBoY=
X-Google-Smtp-Source: ABdhPJz7Ze0xXEDwNyEoBj3NSXlrVCRCRGvPr3ITVxZPcNxWSchNFkx9JlZNbINf1+u0hO8xfYf1iA==
X-Received: by 2002:a63:494f:: with SMTP id y15mr4922363pgk.185.1627583764371;
        Thu, 29 Jul 2021 11:36:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6349:1ee2:dda3:7891])
        by smtp.gmail.com with ESMTPSA id i1sm10943130pjs.31.2021.07.29.11.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:36:03 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v5 00/11] Bluetooth: btintel: Refactoring setup routines
Date:   Thu, 29 Jul 2021 11:35:49 -0700
Message-Id: <20210729183600.281586-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Changes in v5
- Added hci_alloc_dev_priv() to allocate the hdev with private data.
  This will also minimize the changes to other code that uses
  hci_alloc_dev().

- Minor fixes with checkpatch result.

Tedd Ho-Jeong An (11):
  Bluetooth: Add support hdev to allocate private data
  Bluetooth: btintel: Add combined setup and shutdown functions
  Bluetooth: btintel: Refactoring setup routine for legacy ROM sku
  Bluetooth: btintel: Add btintel data struct
  Bluetooth: btintel: Fix the first HCI command not work with ROM device
  Bluetooth: btintel: Fix the LED is not turning off immediately
  Bluetooth: btintel: Add combined set_diag functions
  Bluetooth: btintel: Refactoring setup routine for legacy bootloader
  Bluetooth: btintel: Refactoring setup routine for TLV based booloader
  Bluetooth: btintel: Clean the exported function to static
  Bluetooth: btintel: Fix the legacy bootloader returns tlv based
    version

 drivers/bluetooth/btintel.c      | 1214 ++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h      |   83 +-
 drivers/bluetooth/btusb.c        | 1105 ++-------------------------
 include/net/bluetooth/hci_core.h |   13 +-
 net/bluetooth/hci_core.c         |   13 +-
 5 files changed, 1254 insertions(+), 1174 deletions(-)

-- 
2.25.1

