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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B23DC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4BB610FD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhHDEku (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhHDEku (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:40:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15CC0613D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so1823789pji.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lH6A9tb0MdS9eVHxpvkMzNQtGnf7zEQKmyuQfNjfUE0=;
        b=HZxMHVBdM9NDQZUPKH1pHtDqNvhXQaRMCrQSkaG2zi4WBk8r3Spkvugbps9a4bc0AD
         3MyEm/pQQFsJmP76pn2V9rhALFhEhY/CsMS34YgzpaqQgd4gz/uYf/3HHVci0piM8d6O
         5Ierc3fJnowyFuDcc2s97sLibGuW0+1AT41UU75vfRZN59V8UCMc8fjh1HNVgyZH7Vk1
         Ld4igRAqV/SFqgaMhfGLIJGtsbEg8DZ/GZcuH+ScS+ZZQHK9RfOiRT6If5GrYtlgqW+n
         cNx8cxB1ZxBffVxk1NS0EDAjrL8Doac3yZioZcolsiGwT3CaEVFGbR+G+9udn3YKtL8h
         6bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lH6A9tb0MdS9eVHxpvkMzNQtGnf7zEQKmyuQfNjfUE0=;
        b=X3dGAFV/YlQx0luKBzpgVMqUHlqALKZobGklbheJfJfgzKxDJGwNjcG7smpxdem493
         8HM7/HfML5TZxwjAVApUsIlf3io2DXdlxP9A1IEi2gLGIAvCrt657qQjA/Qay/fIswVb
         znquwo9Oy6516NB3se0Fevx1jg59QW7MZFtrqISLqGKxl6WjMYa2Ini7jk3NbtfZ0jO6
         QACTXKIjnEwQWa80oq0yMYBgx9TXpyZvrVyarN4qKa7qj+8QsxHrtASlTwOLkdXtmTne
         2Az7Vz+CivQpoj/6bKqmV8BEX3WkqYhpgBZTmyzyMYpx8g9hvX7hBVQu+IlY6MEQdpfn
         pkpQ==
X-Gm-Message-State: AOAM532Hj5OenvbJdFwNqvSQQKxAZrcLF0sHFKy2qoIOVh13yzbHZxkp
        zB2OfVKrbJmcpXquVSRybKsvk+igCp4=
X-Google-Smtp-Source: ABdhPJyPclphGGRA6oN3oFvz9xr6038Ghq/hHrLoFFaj/IQvzzO7oGFhRCofE5s330AhHou9YiA/ew==
X-Received: by 2002:aa7:8750:0:b029:3be:347:a0d with SMTP id g16-20020aa787500000b02903be03470a0dmr12941075pfo.25.1628052036671;
        Tue, 03 Aug 2021 21:40:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:34 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 00/12] Bluetooth: btintel: Refactoring setup routines
Date:   Tue,  3 Aug 2021 21:40:20 -0700
Message-Id: <20210804044032.59729-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
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
  Bluetooth: btintel: Combine setting MSFT extension

 drivers/bluetooth/btintel.c      | 1307 ++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h      |  119 ++-
 drivers/bluetooth/btusb.c        | 1128 +-------------------------
 include/net/bluetooth/hci_core.h |   13 +-
 net/bluetooth/hci_core.c         |   13 +-
 5 files changed, 1358 insertions(+), 1222 deletions(-)

-- 
2.25.1

