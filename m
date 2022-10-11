Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC0CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 20:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJKUKe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 16:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJKUKd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 16:10:33 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533013EA4B
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 13:10:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n73so6973069iod.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NfKZh2D4azdbreWRzr2bxHq0hs73pXSfiNfFCVafg5A=;
        b=d61GZvx56ovlRuylpL19VtPmekyka7Gf89GS/hQ6vE7UTYfamtUO3hyTA1NMSG9taR
         BlW/cPgLVbmnDteES5VoAPpkrwBwVf4rSID44jNFWOCF4kdwVjONKfGnOn6nq0gB/h5M
         j2a6Cp4/z31dEuKBldm5bCE4+hHV4T5ka/5qzPvk3Q3AWNvPJfltW7ESB/9NtFVMUJiV
         /K9FjrbYBP/PjzD/kzfTtd2RM6WEkQIq2ASFroWUJTcJW3n2MUZbHZ+RxrOXfux69GLY
         9MNtjlerWqKJBgn9omXlb+ZRqklnUbV5P65sT0Pd7wOP30EJdn52vg/Q1VggPdoY8kME
         dzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfKZh2D4azdbreWRzr2bxHq0hs73pXSfiNfFCVafg5A=;
        b=JRO9xA8Oem/+S8Zc66dcl7QwdlT9SFvXGNaElRM0X/cotnX8FQMBbjqco2eD8Nifz3
         foZkvhf+VfT+MHtEGOz3lH3JHAiFOfCaT4HZsG5iWAfzRiIC5r6U/R+niLg1hWw1F/S6
         e6jA94raMj6Cs42ttM7QZtvkb0cNaVNyv63hKvcMIz2/CLkesbXL8xF7Cjf25YLi9YfI
         G2pvEWr3LTPCv7I7c15LI0kb7P/hqult63OY3wHLOTkNDAm7fhNpGjKd1CY8JFvv1RPc
         3I3C0rn55l9Wo9H0IqYNtrZDLbGJWcZr8LLxTtiIKdZB6U7UqEedGS2jtrQrklTCn0yx
         /8qw==
X-Gm-Message-State: ACrzQf1Wn0OljahIEhWheKY99qR8gdqS65b4yrXfxPaGWyjG+42c3bOV
        gkB1UXbC8oBqIfWyDmmFTni0m5EcsDo=
X-Google-Smtp-Source: AMsMyM7tQjYLfWRNLhpTCiKDn71fPTTMif8qqhltkoBCv1UzJS+fEYSP58gw4hCueXWd0kKdWCUv2Q==
X-Received: by 2002:a05:6602:1595:b0:6bc:a65a:48ec with SMTP id e21-20020a056602159500b006bca65a48ecmr364945iow.157.1665519030433;
        Tue, 11 Oct 2022 13:10:30 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.174.155])
        by smtp.gmail.com with ESMTPSA id m62-20020a6b3f41000000b006bc7de823ccsm942149ioa.53.2022.10.11.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:10:30 -0700 (PDT)
Message-ID: <6345cdb6.6b0a0220.73344.1a2d@mx.google.com>
Date:   Tue, 11 Oct 2022 13:10:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4077819159169193443=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2,1/2] Bluetooth: hci_conn: Fix CIS connection dst_type handling
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221011192534.16281-1-pav@iki.fi>
References: <20221011192534.16281-1-pav@iki.fi>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4077819159169193443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=684592

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
GitLint                       PASS      0.80 seconds
SubjectPrefix                 PASS      0.72 seconds
BuildKernel                   PASS      35.70 seconds
BuildKernel32                 PASS      31.84 seconds
Incremental Build with patchesPASS      46.06 seconds
TestRunner: Setup             PASS      517.07 seconds
TestRunner: l2cap-tester      PASS      17.73 seconds
TestRunner: iso-tester        PASS      16.95 seconds
TestRunner: bnep-tester       PASS      6.67 seconds
TestRunner: mgmt-tester       PASS      107.93 seconds
TestRunner: rfcomm-tester     PASS      10.51 seconds
TestRunner: sco-tester        PASS      10.09 seconds
TestRunner: ioctl-tester      PASS      11.15 seconds
TestRunner: mesh-tester       PASS      8.07 seconds
TestRunner: smp-tester        PASS      9.89 seconds
TestRunner: userchan-tester   PASS      6.85 seconds



---
Regards,
Linux Bluetooth


--===============4077819159169193443==--
