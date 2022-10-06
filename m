Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587A6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 10:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJFKZb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 06:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJFKZ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 06:25:28 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A42D87FBE
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 03:25:27 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n83so1495958oif.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Oct 2022 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K0B2vFIS3AoJOgPi2tJr/Unx2fMO2PXxopf6rVxsb7Q=;
        b=d/RO00f9B4u5mf7zvVskt9gFkkdryOPzHU1Qbp6orlzmcpaMJ+KCIURnf+zcoWnUif
         DIvVWbnwLPTN1WHE/HhbLWrNQ0XuhuHIuBY/GYT/ilySLD5rePyoVC+I++75irIZ4Zm0
         BM/hoD5e42W3f2QB967Slvgz1ueoO5akV6RCvynGnUbVM0TW+rwdnI/qEby79JQp/xKA
         qC70eJFPhp3tjJkJJ2O19seetjS2ztFx0reQ1QsDOjmATNRUGWFAgvFF6CcMfx2Xg2I4
         SyDnwZt4Bwh4p/L5gMjCYKzwrvD2ZHU9rFyaMiOyoXOWPp5yWDN3+ehGv1oY4qpSpbYM
         Dx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0B2vFIS3AoJOgPi2tJr/Unx2fMO2PXxopf6rVxsb7Q=;
        b=uozFzAPrPnGf4sL6SWo7uar+QVaS7y2QnK8F98Z6AzNXyrVHdGZD0iLjUtAXo6NFRd
         10xbDKVhQHzV90uvoFwWdZ5D5g0/4Rp53tnLbdXP1k3Hsl/ak81xOBieHKQkW/DAfmp7
         hNTPW1kOnv/yPz1C6nBUi1GOuOPZ+/R9TlGhmpbocgKcr7uYxsLv/xxhlKXfPR6fopIl
         N9fwlgdGzBys+sQJ6W9XXdXjwcYj6kiXxaIAQqW9+4E6YgYVz69X7hDg3Wtyo5AMNZrV
         2Ihi51DdScT2aBhb3RfckfTOBp5rsFS+YxaGg2IukuPeyNQmx5zCkC1bl96NKkNkjQ1b
         epVQ==
X-Gm-Message-State: ACrzQf1hrDybzXy5NFlOgLTE8fIctSvChkGakGx6ArVD7KTA/ttxoWAr
        wYwPZmvQhV+sqmjThgg6763lmfGVXnc=
X-Google-Smtp-Source: AMsMyM5QUH0xBuPmCaNeGI5lYU8EMRS+VVAeszKTrpHBSBwU48gc54BoiYmhUZgf82OtY5F9LjRlZA==
X-Received: by 2002:a05:6808:1186:b0:351:99bf:876c with SMTP id j6-20020a056808118600b0035199bf876cmr2027830oil.54.1665051926533;
        Thu, 06 Oct 2022 03:25:26 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.232.25])
        by smtp.gmail.com with ESMTPSA id v14-20020a056870424e00b0011e73536301sm3933116oac.52.2022.10.06.03.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:25:26 -0700 (PDT)
Message-ID: <633ead16.050a0220.66692.d3ff@mx.google.com>
Date:   Thu, 06 Oct 2022 03:25:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0790277253039120905=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [v3] Bluetooth: btusb: Introduce generic USB reset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221006170915.v3.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
References: <20221006170915.v3.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0790277253039120905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683424

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
GitLint                       FAIL      0.75 seconds
SubjectPrefix                 PASS      0.60 seconds
BuildKernel                   PASS      46.72 seconds
BuildKernel32                 PASS      42.25 seconds
Incremental Build with patchesPASS      60.62 seconds
TestRunner: Setup             PASS      680.50 seconds
TestRunner: l2cap-tester      PASS      21.32 seconds
TestRunner: iso-tester        PASS      22.32 seconds
TestRunner: bnep-tester       PASS      8.30 seconds
TestRunner: mgmt-tester       PASS      133.38 seconds
TestRunner: rfcomm-tester     PASS      13.11 seconds
TestRunner: sco-tester        PASS      12.01 seconds
TestRunner: ioctl-tester      PASS      14.13 seconds
TestRunner: mesh-tester       PASS      10.04 seconds
TestRunner: smp-tester        PASS      12.03 seconds
TestRunner: userchan-tester   PASS      8.82 seconds

Details
##############################
Test: GitLint - FAIL - 0.75 seconds
Run gitlint with rule in .gitlint
[v3] Bluetooth: btusb: Introduce generic USB reset
18: B1 Line exceeds max length (87>80): "ERR kernel: [  716.929206] Bluetooth: hci_cmd_timeout() hci0: command 0x0000 tx timeout"
19: B1 Line exceeds max length (109>80): "ERR kernel: [  716.929218] Bluetooth: btusb_rtl_cmd_timeout() hci0: No gpio to reset Realtek device, ignoring"
22: B1 Line exceeds max length (87>80): "ERR kernel: [  225.270048] Bluetooth: hci_cmd_timeout() hci0: command 0x0000 tx timeout"
23: B1 Line exceeds max length (89>80): "ERR kernel: [  225.270060] Bluetooth: btusb_rtl_cmd_timeout() hci0: Resetting usb device."
24: B1 Line exceeds max length (88>80): "INFO kernel: [  225.386613] usb 3-3: reset full-speed USB device number 3 using xhci_hcd"




---
Regards,
Linux Bluetooth


--===============0790277253039120905==--
