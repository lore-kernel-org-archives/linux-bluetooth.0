Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E62EC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jul 2022 09:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiGMJIb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 05:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiGMJIa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 05:08:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44742EA179
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 02:08:29 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id j27so828247qtv.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 02:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=y8BD8V+QKxL7tkh9zpDOCOgoOtuVELtJ2H26hZJMdUk=;
        b=pzwpkipL6JicI/hm5miVum0mhGR7XPVup04dC8eaVnB+F4Fim7ego/dh9w1lVOeCu1
         CVBgv69z72MMjxgO7TLF2CGEn6yeXjFtcrbK/FNryb1tqY727vCGItDAhhBOkZXRD2zo
         57H4EWA9N/lXFbOT8ypfoo7e/4Ie3ZLvqY8uCRUje8sWZfVvF5UaRpkquhqcgNg+5u5o
         cP0thyjK2PQjsrUtr7E60d59ioNVucIci/LkY9I6tJCz3hBuy8RRVQ8cdR89oOs7fi2c
         /De4kHXVaJLskn/9KSpvh82V56Gy8QtVm74ltoIVgmTwzeAnjqFcFDQITDK30GHcxFiT
         /eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=y8BD8V+QKxL7tkh9zpDOCOgoOtuVELtJ2H26hZJMdUk=;
        b=EGvu0K96Ohl3YgTnC6YvSGMLvDyMoL8hCZ3IN6Mj79IbQ6PESBD7CrEqxiu1WpCwNB
         oc0gKIEDx354nvGjJxLdNyFHejplyFaWFOILcoHTe/R0cIP8l/D3LLJM20g3/R4p9h1b
         imwUAIX7eg9MCG7f6ZAsY42Vc459JlTug/P2t7/y9ggzecm3SiELLAjG8ZoIhNlP+bgh
         LZyZ/Nnr7CJAzwTkc9iT6WucZicYzvUQQAGDglRX00dRMpxwdgs7UlkRcOWDIDTX3Kh9
         YpboOm78vLUXSlq9ZwtRHip5TfFCa7wUVdn5spYpFUCj4bQZ0XgcGmASiy0xa9B4yz4Z
         3fJw==
X-Gm-Message-State: AJIora+fzNQlcyk9Z7DK/lR+uwkbm/czHqc2Gs/iZ1e6MpJGZRvT/a9q
        rFgbSsbBJrK+Lv7Ygq7xxHhX1c2jqhM=
X-Google-Smtp-Source: AGRyM1sL/F93yrX5mRwGN5FrKGMm2lRNLiQ85ptA21hG/1Ho0N5eSn/p75xTrS/4cOQ/2aQRuilL8w==
X-Received: by 2002:ac8:7dce:0:b0:31e:adad:f546 with SMTP id c14-20020ac87dce000000b0031eadadf546mr1933535qte.492.1657703307825;
        Wed, 13 Jul 2022 02:08:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.100.162])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b006b5683ee311sm10354567qki.100.2022.07.13.02.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 02:08:27 -0700 (PDT)
Message-ID: <62ce8b8b.1c69fb81.da3fa.1e9f@mx.google.com>
Date:   Wed, 13 Jul 2022 02:08:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3120431601865323118=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: btusb: Add support IDs for Realtek RTL8852C
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220713075318.18176-2-hildawu@realtek.com>
References: <20220713075318.18176-2-hildawu@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3120431601865323118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659212

---Test result---

Test Summary:
CheckPatch                    PASS      8.28 seconds
GitLint                       PASS      4.87 seconds
SubjectPrefix                 PASS      4.25 seconds
BuildKernel                   PASS      32.82 seconds
BuildKernel32                 PASS      29.21 seconds
Incremental Build with patchesPASS      66.81 seconds
TestRunner: Setup             PASS      483.79 seconds
TestRunner: l2cap-tester      PASS      17.21 seconds
TestRunner: bnep-tester       PASS      5.91 seconds
TestRunner: mgmt-tester       PASS      100.28 seconds
TestRunner: rfcomm-tester     PASS      9.52 seconds
TestRunner: sco-tester        PASS      12.41 seconds
TestRunner: smp-tester        PASS      9.30 seconds
TestRunner: userchan-tester   PASS      6.21 seconds



---
Regards,
Linux Bluetooth


--===============3120431601865323118==--
