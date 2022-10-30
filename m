Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532B0ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Oct 2022 19:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJ3TON (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Oct 2022 15:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3TOM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Oct 2022 15:14:12 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF6E65F5
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 12:14:12 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a5so6494542qkl.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kKbb2FT/H3q8XzwoRFSGkfFy0ULEfneXvhTLLRgxKQw=;
        b=K/kSIErssW6rFsiOZgQf+WFVmwP5V+/cJZcOfBQWUEFcXNyFuU7X7NZBFL+3NG/pYt
         owZ6s9Es5f5bI1sWIalewsGg6z7nrNAJezYO7TcrczjYO48CNlMMg2kFfV0SzS1VWLL0
         UHNdiPQXQLbbF0BTEZumsT/Py6z/o5uFaoqmEwQ6JdTFRrUVQD3lJksfusLB1fkD7S1O
         y7tBOGY88mcnKc5rMUjjyzH5apRkCrmVr5plGnibGR+Xp3kix/nZ6hNe4sEyy3LZnBv5
         /CZqD4P1rmDYPrgaQkZryNRKd2clAHFlmVlcRDGcd96lbGlTqbINC4rOH1Ri9I6mXXFm
         jPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKbb2FT/H3q8XzwoRFSGkfFy0ULEfneXvhTLLRgxKQw=;
        b=TSNfoMP9KaOBs7g+tcMLm/IfURsV1zgN25+Hvae3lmAI4rK1WU1d+PVZnmOJwcSeio
         iIPNB29CQScFwiF33XH9YxhiErS71YX52crYUO2MG0zxqNTfvrD7WF2Hi6hXjq6f3k9M
         pcUTCIYqLopm1DV0L9a5ocRVPuo0CjI4zPBfgkCDz2gRlDMWNN2XwDcvUJA7TGqH/8Xo
         tJwkHlv1DhYRq5B4oydueu2mZ7HgoWFpnhTZrIPRknsQSreypwECsOtdrfVspZuhuULR
         iViV/N+h/EmBA4gJHYwpDnTsyLSWhJFFxcPrFZPb1SvrtGiB8qjU6A7Ukfvu3z9Io1SI
         CAZQ==
X-Gm-Message-State: ACrzQf2eEx7mVbcisCxRttYAZhz+KnMozhFL7ljQrf+5owbVW26pSq1E
        KLWXfjykCappAcgFNs3j00anVjQbEYymrw==
X-Google-Smtp-Source: AMsMyM5CdHzh+89Qr55za0B9pzCzzBxDaeL2oeS2M3x7ioInLDj01mCOv3o77LRACgscIi0/c2iNHQ==
X-Received: by 2002:a37:6488:0:b0:6fa:1af7:f68f with SMTP id y130-20020a376488000000b006fa1af7f68fmr4609324qkb.432.1667157251121;
        Sun, 30 Oct 2022 12:14:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.17.28])
        by smtp.gmail.com with ESMTPSA id ez5-20020a05622a4c8500b0039c37a7914csm2582636qtb.23.2022.10.30.12.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 12:14:10 -0700 (PDT)
Message-ID: <635ecd02.050a0220.c8cb3.50bc@mx.google.com>
Date:   Sun, 30 Oct 2022 12:14:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5331803322362666400=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tegongkang@gmail.com
Subject: RE: [v3] Bluetooth: Use kzalloc instead of kmalloc/memset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221030181722.34788-1-tegongkang@gmail.com>
References: <20221030181722.34788-1-tegongkang@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5331803322362666400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690281

---Test result---

Test Summary:
CheckPatch                    PASS      1.65 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.89 seconds
BuildKernel                   PASS      34.67 seconds
BuildKernel32                 PASS      31.46 seconds
Incremental Build with patchesPASS      48.47 seconds
TestRunner: Setup             PASS      523.11 seconds
TestRunner: l2cap-tester      PASS      17.60 seconds
TestRunner: iso-tester        PASS      16.99 seconds
TestRunner: bnep-tester       PASS      6.77 seconds
TestRunner: mgmt-tester       PASS      108.06 seconds
TestRunner: rfcomm-tester     PASS      10.56 seconds
TestRunner: sco-tester        PASS      10.04 seconds
TestRunner: ioctl-tester      PASS      11.28 seconds
TestRunner: mesh-tester       PASS      8.28 seconds
TestRunner: smp-tester        PASS      10.09 seconds
TestRunner: userchan-tester   PASS      6.97 seconds



---
Regards,
Linux Bluetooth


--===============5331803322362666400==--
