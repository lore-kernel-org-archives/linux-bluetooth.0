Return-Path: <SRS0=ORc3=EC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4E8C55179
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7567421D24
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBb0B8Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373344AbgJ0Uw7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:52:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34139 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373341AbgJ0Uw7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Oct 2020 16:52:59 -0400
Received: by mail-io1-f68.google.com with SMTP id z5so3083605iob.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2020 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vOVSyWcohFx2qT7pJE/x62PTVyaDcm45Y2SEA3UrbiM=;
        b=gBb0B8VglApb850PhxojYEhxnGkLTEJeXyd1x5Ka8z2DYY8yL4k0cU7isUwcAPPEE8
         FOCoJInNVXv2K/NpwbQf8tb8Plv/rXP12rMFzviNGU7ntpaFbXkNkRsIWdEiRbEQnVGi
         8NdtJnyohubxAXHJJRpMC1brQMrioKmSaJzeZZmYs8zN4bwON/Gid6R5zQ7IIlkNTv0g
         PpkopJtPFpr6QbhDntw5JOmxJFvPtB11370L4BCphRKBLoPz8tdxLS7iwWACOHRYC95a
         02ukpL1FYh5V7uKCGyT2agpviKTJtC6ctituFdaVnpzzK4b2RwzDeVPj808SKk2p2XXZ
         K7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vOVSyWcohFx2qT7pJE/x62PTVyaDcm45Y2SEA3UrbiM=;
        b=Forh85RtawSb+a+dt2J5FhUj9v2ao7B0VaVGRuGaZepFVmI+Cprky2bIAat8YiN+P0
         ryPVnMh0XxC40SPAo2nQN/wyOkPb7ASpc76081pyUtJPmbCUUqozD4yMe3YMA6Pgh6K5
         Xzf5H1kjRNNlgoboQ66O3hvjW49GCOBW449YOfx6PO21qwJ8KxcquUfWL9Ak6XjPmGZo
         YJXklFATqg9Tx4HrUE1ZmlGySTbXWnDfhKhl/4/IKcDp8XBBO/HnKkvkaUfpIv+n6u8D
         oRd2AnLwip/9vxcDw1w49cg6vzJy4KXd3mHeRa5NBXbPWZZdUAoyBHwF33UHKayB53w6
         8aAA==
X-Gm-Message-State: AOAM532EX86oh00fOY5rdJl4NkSLOTcQLwfKSoA1fLkg2O6e2vR7lgyb
        WDj3q2YCfkwASJz+ynN9fDSHybsJDDcykEIZUu/DjzxYs4/xFA==
X-Google-Smtp-Source: ABdhPJwn0fKpmkiiiJa84oDahy5ym47aChuupXeqPyihKAbtF8Y97w9qZApJ7YZCkD9uXp2se5K/z3ZDWcdYp2iAfS4=
X-Received: by 2002:a05:6638:1118:: with SMTP id n24mr4359175jal.142.1603831978149;
 Tue, 27 Oct 2020 13:52:58 -0700 (PDT)
MIME-Version: 1.0
From:   David Zakarias <david.zakarias@gmail.com>
Date:   Tue, 27 Oct 2020 21:52:47 +0100
Message-ID: <CAC_SeizxoD1PkNHWYg1FcV9x6tote2JyJNX3Kwu3XtHkCF+FPQ@mail.gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add support for 0cb5:c547 Realtek 8822CE device
To:     linux-bluetooth@vger.kernel.org
Cc:     David Zakarias <david.zakarias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

My Redmibook 16 AMD laptop contains the RTL8822CE chip having the USB
identifier 0cb5:c547. This patch adds this Id to btusb.c's blacklist
table, enabling the loading of the Realtek firmware.
This, together with another patch by Edward Vear (hci_core: Fix
attempting to set RPA timeout when unsupported, see
https://marc.info/?l=linux-bluetooth&m=160378222632366&w=2) makes my
bluetooth mouse work.

Signed-off-by: David Zakarias <david.zakarias@gmail.com>
---
--- bluetooth/drivers/bluetooth/btusb.c.orig 2020-10-27 21:24:51.331035974 +0100
+++ bluetooth/drivers/bluetooth/btusb.c 2020-10-27 21:21:46.000000000 +0100
@@ -386,6 +386,7 @@ static const struct usb_device_id blackl

  /* Additional Realtek 8822CE Bluetooth devices */
  { USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK },
+ { USB_DEVICE(0x0cb5, 0xc547), .driver_info = BTUSB_REALTEK },

  /* Silicon Wave based devices */
  { USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
