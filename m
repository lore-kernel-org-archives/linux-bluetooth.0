Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A72C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F6061040
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhHEAci (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhHEAci (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 20:32:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0034BC061765
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 17:32:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nh14so5531428pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 17:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osg4FKtg5cgSwrQ6DqTA6abdKg35mOF91voVBjT6Tfg=;
        b=oPGvbrJ8QYPA7+TOx/RLbOemmw1k5cakE9QB+jm+tN3ma/95iA213J35SDKYO+hM6b
         f/7AJbsekQgrSMxLK2P+Bg49eFfWcN/8G3uy1Qdv4ztsH74fWxsjRyl1GA6052xFzWt0
         OvK+q0cDWbKiS0cgtv3BUjpuCg0moXLcuD8RAqr0fRD1ULOPfaKR4o0pUtq15mdJs1Ge
         KEu/Ybj8K1f1s/gM2wSL9JnngdbYydn1yNsqkhPui/NT35/CNYftm3M+H85Ivm6Auh4u
         oXYV8jQ1vxxB39mrPN4VcEiwA1u63BcHzaETuxNOyHUrHbGlUcjJGErFIDILwTe3ZfF3
         RTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osg4FKtg5cgSwrQ6DqTA6abdKg35mOF91voVBjT6Tfg=;
        b=ZeK7w0dX2xC4eLz81VJ5O1Hcl21SL05jsMRw7fZiWH2BwKr9CydN4B6gLW5fo5+xlr
         TUkI080I46tzWdVWucuNtfE56ZSYIK94o6ZBL1ZAerHGQwzKG/Nnj7cDKJ9kZe0w/Urx
         tmVHJxpIYaWhyzs3K9iyYVQR4IKtYwLyWcec7jtFeLwIWD9DRH5x2fsu8tvIjqhd8wGr
         KHB+96bU3n3yLj0sJdCucF3ocVggNbSz3a4W+32oSVfqeGTsJn2flziT42UkhqpaiYVd
         w22kO7/kIJ0raH27RVhT2zJ4NJmWko9cGfJ0mazFzeSsMLO9gQPFbk5sFtG9X2JG9AEJ
         FQmA==
X-Gm-Message-State: AOAM532QbqqsATELFtz9p7cfnlLNk3Or6ZPsFVnvYQmQchfKdwj6y+l7
        TsE8lzUKiBzh4sUO/ms1maJBGG8WcJY=
X-Google-Smtp-Source: ABdhPJw9o9Fzw3bhV6pNcbw1pbGZ9CuBUPXp3/v8yFWmIoiuZgEkWbnRAbSg2LGzEfHdf8bqu2ZoVw==
X-Received: by 2002:a62:7d58:0:b029:3c4:ccd8:1c12 with SMTP id y85-20020a627d580000b02903c4ccd81c12mr2194248pfc.12.1628123543368;
        Wed, 04 Aug 2021 17:32:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:e0b8:5332:84:7056])
        by smtp.gmail.com with ESMTPSA id q4sm4761787pgv.16.2021.08.04.17.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 17:32:21 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v7 00/12] Bluetooth: btintel: Refactoring setup routines
Date:   Wed,  4 Aug 2021 17:32:07 -0700
Message-Id: <20210805003219.23221-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Changes in v7:
- Rebase the patchsets to the tip of the bluetooth-next
  6eefec4a0 ("Bluetooth: Add additional Bluetooth part for Realtek 8852AE")

- Some basic testing were done with the following Intel devices to verify
  the firmware loading and some profiles (LE HID, A2DP, HFP)
	WP2_B3
	WP2_B5
	StP
	SdP
	SfP
	WsP
	ThP
	CcP
	TyP


This patch set refactors the multiple setup routines for various Intel devices
to a combined single entry. Here are the highlight of the changes:

1. Updated hci_alloc_dev() to allocate the hdev object with an extra buffer
   for the private data. btintel introduces the btintel_data struct and
   store it to the private data in hdev object.

2. Added a single entry for setup and shutdown and uses the
   HCI_Intel_Read_Version command to identify the device, instead of
   relying on the USB VID and PID. The new HCI_Intel_Read_Version command
   is used for both legacy ROM, legacy Bootloader and TLV based bootloader.
   
   Also, btintel_configure_setup() is added to setup the most of hdev
   callbacks, unless it is a transport specific functions.
   
   After identifying the device, it calls the corresponding setup routines.
   These routines were copied from btusb to btintel and changes are none or
   very minimal.

3. Keep the state of bootloader in btintel object. The bootloader state
   is agnostic to the transport type, so btintel uses the btintel_data
   to keep track of the state in the private data section in hdev.
   
   Also, added macros to set/clear/test flags to simplify the code.

5. Cleaned up the exported functions and make it static as much as possible
   if not necessary.

6. From the JfP/ThP, the operational firmware support the new TLV based
   HCI_Intel_Read_Version command, which confues the usage during the
   setup routine. So, the check for firmware variant of those legacy
   bootloader sku is added to use the legacy bootloader setup call.

7. All of HCI quirks for Intel devices are moved in the setup routines.
   There are several HCI quirks for Intel devices and some of them are
   for all Intel devices and some of them are for a specific devices.
   
   The flag for HCI quirks are removed from the .driver_info, and applying
   HCI quirks are done in combined setup routine depends on the hw_variant.

8. Combined the setting the MSFT extension support in the combined setup
   routine now depends on the hw_variant.
   

Tedd Ho-Jeong An (12):
  Bluetooth: Add support hdev to allocate private data
  Bluetooth: btintel: Add combined setup and shutdown functions
  Bluetooth: btintel: Refactoring setup routine for legacy ROM sku
  Bluetooth: btintel: Add btintel data struct
  Bluetooth: btintel: Fix the first HCI command not work with ROM device
  Bluetooth: btintel: Fix the LED is not turning off immediately
  Bluetooth: btintel: Add combined set_diag functions
  Bluetooth: btintel: Refactoring setup routine for bootloader devices
  Bluetooth: btintel: Move hci quirks to setup routine
  Bluetooth: btintel: Clean the exported function to static
  Bluetooth: btintel: Fix the legacy bootloader returns tlv based
    version
  Bluetooth: btintel: Combine setting up MSFT extension

 drivers/bluetooth/btintel.c      | 1314 ++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h      |  119 ++-
 drivers/bluetooth/btusb.c        | 1128 +------------------------
 include/net/bluetooth/hci_core.h |   13 +-
 net/bluetooth/hci_core.c         |   13 +-
 5 files changed, 1364 insertions(+), 1223 deletions(-)

-- 
2.25.1

