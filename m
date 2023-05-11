Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45CEC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 May 2023 02:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjEKCWA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 22:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEKCV7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 22:21:59 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646183591
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 19:21:58 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-61b6101a166so38697276d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 19:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683771717; x=1686363717;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yM+oue/tBK/gOwVkt363gybBLlVgUxwPyVLetZJDe7o=;
        b=lAQP6U9Z7yLPORhUxLoPhHl5cvIjZTxvjZ9q6HIWHJ5/usgYi2R2o0g2ru+zIhqLO0
         mkyUw7aMQDHQuVWAvEm1bEz/nvTOwvXOCYQyFkIqcOFlUEEijxA6H3gzeqRO+6GcGcCA
         MV3Qradj/1SHajTps6TwJ+8v/Vz2KhnhtFBabj8lF+9cY84CMkGlOQ0mWaVEeVnZXrRe
         LYiqcNvVdvow/ph9bP3RrMUy4MGPfhfnkM+qcR/eUQGTsm0a3zBitvhMorOHNSk2gMht
         0VEZeIuj3UKqP5R6WviQBYr4hpAP7fYXLEWjcpJAB5qyb+jlYKVktcm1JLhpHmFQoxxV
         Nikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683771717; x=1686363717;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yM+oue/tBK/gOwVkt363gybBLlVgUxwPyVLetZJDe7o=;
        b=SQOtPJtH2jpWRQh4Kbgjspp+Nhm3pM6u4R5+8/v62XxI9fQuSGtAMZX2nNj3KH0W2O
         7CROE7LfuJ4yseppkBHYgKAqPSjynxTyiLno+nV/rc13InkhMoh5gWUS1ImxCVxhyd5e
         E9JsPAry5zfzqoocOnyQpJl+uLoMjHPUlHsfiTScy5Y1+ag8GEBGO54/BiQPIcbpas05
         UYYDzTTIdgwL544wQTFBD9+gBTvWuHXvE2VGByLne6R0SA5p/fFTAu5F2md3OzlT2GDX
         ixhqfsrfKfHUz5Dp8XAFo3uHRPLk6+auMb4sxw197P+NY4MwVIFiU88mSAoQnu018Uiv
         LheA==
X-Gm-Message-State: AC+VfDxhp+gpBRBkSMkJ0U9nZ5gZrZIHekBbIHbSzfzWKg2+5SWtwI87
        3T2N/pVMCpvFIPUEfVi+qJceyYyXT7I=
X-Google-Smtp-Source: ACHHUZ5IFoEbR1pvCRc2Biz1o+g/3ree0d7ITgwS2AIzuhn+vT9NyO/F15dRZoItldkGGD01PtxJZg==
X-Received: by 2002:a05:6214:20a7:b0:5e9:429b:559f with SMTP id 7-20020a05621420a700b005e9429b559fmr25360681qvd.13.1683771717361;
        Wed, 10 May 2023 19:21:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.120.60])
        by smtp.gmail.com with ESMTPSA id y5-20020a0cd985000000b005f4964785b1sm1952840qvj.0.2023.05.10.19.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 19:21:57 -0700 (PDT)
Message-ID: <645c5145.0c0a0220.49100.ba99@mx.google.com>
Date:   Wed, 10 May 2023 19:21:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5324238554115782563=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] client/player: Fix crashes accessing metadata
In-Reply-To: <20230511000155.3721222-1-luiz.dentz@gmail.com>
References: <20230511000155.3721222-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5324238554115782563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=746595

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.71 seconds
BuildEll                      PASS      26.91 seconds
BluezMake                     PASS      1003.92 seconds
MakeCheck                     PASS      12.50 seconds
MakeDistcheck                 PASS      155.98 seconds
CheckValgrind                 PASS      252.51 seconds
CheckSmatch                   PASS      338.80 seconds
bluezmakeextell               PASS      102.02 seconds
IncrementalBuild              PASS      1716.07 seconds
ScanBuild                     PASS      1049.43 seconds



---
Regards,
Linux Bluetooth


--===============5324238554115782563==--
