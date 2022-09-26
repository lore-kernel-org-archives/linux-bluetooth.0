Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF0DC32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 21:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiIZVL3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiIZVL1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 17:11:27 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C5427140
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 14:11:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id j188so9884338oih.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=PXJJMWev6zHk1iqcXbIz4hCLyYNpOK5dTLIByElrv4k=;
        b=fE0nnGyQh66e2L80+grPwvXJ2Ue980Pga47uIbs4CJ4DqK+ezAx6RW1p3pHUbIExfr
         T8JC92YyiISrZuH2TTkeOJSRdq59O5pWkfAUaNYNnayk+lkVVxejkzvyx9bB5BISlidp
         PsnZfqq2IQGxUDFESRFNmJPyMSFAPVEiFu9JwFFGnn5aerghbj+QBA8BGOBvu5vp0h2r
         5Qwhef0LGJvh1R4MRObmtuRsGZGzxMdlS7BktiisxxqwSUWjhF3Y/VNpKGEcNQ4nt5Rt
         ibjDrs/Q25tqHcHd1cRmOomhxeZJSaEZk+Id1/wI3Yx7tLcw5EmUTf0ls8II76kufBVj
         fEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=PXJJMWev6zHk1iqcXbIz4hCLyYNpOK5dTLIByElrv4k=;
        b=JazRZS30ief5A3TpcFa8e0nPyZ46ioW069uyx32Apf9Q5MX2Ll7S/acRU+OihIYI8X
         39nFzFFsDK8F3Uagp860jwRtaduJqkArQDO+8w9hqxKdLPcyq3p2Jwf3dR12WsndHiJJ
         oV8WArvAJrXBCQXW1vgH/OuyhCMvNsvdffty8/SGmfKLocslbvh2hki2VLp6NcVWkLR6
         SArgyTjk3HU73pXE3qRMYUwpS6U2ydK4OmzszY1ZZpbpLMMxtu5571Ga/CR4dzqUJetK
         4vWZl7gLkrxfBG6nthqUzaM8ygpf9nt74fOZjw+5jlSK+kjjr3C0spVM5KfB6KLVEEx7
         na6w==
X-Gm-Message-State: ACrzQf2jcOhlhhngN4Q+erBZp8pnvyJgmRzX5MIuhU7W0ISwWHhgwN73
        kXp4o5ytbZlZBTGg3JM9joBMLFjuHkw=
X-Google-Smtp-Source: AMsMyM44OX81gWufbemuzcl9AKSjF4QTEbzlVmTT5adtKRytGgblWvJ00OFczg37WngxF/B0caQWwA==
X-Received: by 2002:a05:6808:2194:b0:350:cb3d:ecd2 with SMTP id be20-20020a056808219400b00350cb3decd2mr358222oib.46.1664226684939;
        Mon, 26 Sep 2022 14:11:24 -0700 (PDT)
Received: from [172.17.0.2] ([40.74.251.171])
        by smtp.gmail.com with ESMTPSA id w19-20020a056870231300b00118281a1227sm9314558oao.39.2022.09.26.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:11:24 -0700 (PDT)
Message-ID: <6332157c.050a0220.fb71a.0fe1@mx.google.com>
Date:   Mon, 26 Sep 2022 14:11:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4034801941430671229=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: L2CAP: fix an illegal state transition from BT_DISCONN
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220926204657.3147968-1-iam@sung-woo.kim>
References: <20220926204657.3147968-1-iam@sung-woo.kim>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4034801941430671229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=680700

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       PASS      0.73 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      35.46 seconds
BuildKernel32                 PASS      31.10 seconds
Incremental Build with patchesPASS      44.66 seconds
TestRunner: Setup             PASS      521.84 seconds
TestRunner: l2cap-tester      PASS      17.49 seconds
TestRunner: iso-tester        PASS      16.58 seconds
TestRunner: bnep-tester       PASS      6.52 seconds
TestRunner: mgmt-tester       PASS      106.05 seconds
TestRunner: rfcomm-tester     PASS      10.22 seconds
TestRunner: sco-tester        PASS      9.72 seconds
TestRunner: ioctl-tester      PASS      11.05 seconds
TestRunner: smp-tester        PASS      9.76 seconds
TestRunner: userchan-tester   PASS      6.77 seconds



---
Regards,
Linux Bluetooth


--===============4034801941430671229==--
