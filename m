Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA48C4361B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 19:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821F421D7F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 19:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgLGT5S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgLGT5R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 14:57:17 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA6DC06179C
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 11:56:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y23so383861wmi.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 11:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=iQJLk4korq+Q3a0+AkzD0p7/FPQghlmc6y6vyTQzSj0=;
        b=dfTiW6MPOrh3AAxP7QrDsqzHRkqaVNv/MtgzDWRv5iYp8ZzWdzVzYRc1954HzH18sA
         9tSa0gXONdqP0LzwFGuXFyKYJ/12pQBx/alb/i9CJ5FxkIxeW9uvnZh7avlA2GNZ2NmO
         Z0+TyR1L5JSdTt9p4hYkHLNSv7rBOKc6X4Bx0A6s1NGocU/W2MVQWhoB/4nikpUq8zho
         qlzsUY1WvSsvZxjfCt3RvfAFBeH5UUa5hKqDbHcWLCBsUixmGAWAe2344+w/JuUkainH
         YYWHZ1ZvF5xA4WK1RBIWfehVRArccLqHm/WZj7brXUoIbCa6sFTcL9wdM3CCcQsQx0N6
         CH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=iQJLk4korq+Q3a0+AkzD0p7/FPQghlmc6y6vyTQzSj0=;
        b=kAILR4rsj5lIEKoiMMRSLBKK4v7yPioRv/p5dr0F0CXaAxaAihMfL8uSXGQWBPm4nQ
         GJuUAfPCAhrXXtuQd6AD0hkfykkFAuDx9+oF0R3IISdNwK8NiRuXLla3PFOzACHsSxPp
         SwpaC+U+KaJeU22aUbA5lH3c946ZbWarBZ33tzmDzVndsJRBM58bDucERvPDRkpfmpO9
         vcDyqsI/+OcH/8PyEu9ITA9y+R5cDriU61omF0sGCi9qVRYAcsYWJx0hslyds1apgueN
         35O+o5yuwy/jXCk+fj8tUsN92V/+MNH4TC9rLdzK7OJ0qpceGLO3ZwxdUKFAr3+sj01q
         ih+g==
X-Gm-Message-State: AOAM533aZkYfSse8hpS35Kx5woMqDCPrhBNXO+eCjZ9YGIvaMmqWhBte
        GK3bvdi0rkF20+sB92mVYgGmDenL3po=
X-Google-Smtp-Source: ABdhPJz5dd49nkotnl722HWWiaa63XU6/HSPWl697VCA7vJfH2Wbkzpt9xyvHbPeumPs+mTh3N6brg==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr465106wmi.35.1607370995801;
        Mon, 07 Dec 2020 11:56:35 -0800 (PST)
Received: from ?IPv6:2003:ea:8f07:3b00:dcd:bf30:f72b:9f3a? (p200300ea8f073b000dcdbf30f72b9f3a.dip0.t-ipconnect.de. [2003:ea:8f07:3b00:dcd:bf30:f72b:9f3a])
        by smtp.googlemail.com with ESMTPSA id y2sm381017wma.6.2020.12.07.11.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 11:56:35 -0800 (PST)
To:     Kiran K <kiran.k@intel.com>, Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: linux-next-2020-12-04: Failed to send firmware data (-38) with AX210
Message-ID: <ece7cd5c-14ff-5a6d-29b5-c6a16b2638e8@gmail.com>
Date:   Mon, 7 Dec 2020 20:56:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With an AX210 card I get "Failed to send firmware data (-38)" on linux-next
from Dec 4th in case of a cold-boot after power-cycle.

"hk: bt code = 0x001f" is a private debug message to check which BT code
is mapped to ENOSYS (-38). From what I found 0x1f is "Unspecified error".

The second attempt to load the firmware is successful then.


[    4.192718] Bluetooth: Core ver 2.22
[    4.192756] Bluetooth: Starting self testing
[    4.192785] Bluetooth: Finished self testing
[    4.192937] Bluetooth: HCI device and connection manager initialized
[    4.193067] Bluetooth: HCI socket layer initialized
[    4.193108] Bluetooth: L2CAP socket layer initialized
[    4.193195] Bluetooth: SCO socket layer initialized
[    4.242342] Bluetooth: hci0: Device revision is 0
[    4.242435] Bluetooth: hci0: Secure boot is enabled
[    4.242495] Bluetooth: hci0: OTP lock is enabled
[    4.242533] Bluetooth: hci0: API lock is enabled
[    4.242570] Bluetooth: hci0: Debug lock is disabled
[    4.242609] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    4.242657] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
[    4.261977] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
[    4.855813] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.855873] Bluetooth: BNEP socket layer initialized
[    5.819388] Bluetooth: hk: bt code = 0x001f
[    5.819438] Bluetooth: hci0: Failed to send firmware data (-38)
[    5.820069] Bluetooth: hci0: Intel reset sent to retry FW download
[    6.362248] Bluetooth: hci0: Device revision is 0
[    6.362384] Bluetooth: hci0: Secure boot is enabled
[    6.362439] Bluetooth: hci0: OTP lock is enabled
[    6.362551] Bluetooth: hci0: API lock is enabled
[    6.362605] Bluetooth: hci0: Debug lock is disabled
[    6.362660] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    6.362726] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
[    6.364508] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
[    9.020540] Bluetooth: hci0: Waiting for firmware download to complete
[    9.021443] Bluetooth: hci0: Firmware loaded in 2599136 usecs
[    9.022778] Bluetooth: hci0: Waiting for device to boot
[    9.050099] Bluetooth: hci0: Device booted in 27723 usecs
[    9.052633] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0041-0041.ddc
[    9.055224] Bluetooth: hci0: Applying Intel DDC parameters completed
[    9.060184] Bluetooth: hci0: Firmware timestamp 2020.42 buildtype 1 build 15791

