Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25137C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 23:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiHAXIA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 19:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiHAXH7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 19:07:59 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CAA2A431
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 16:07:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id i4so14745180oif.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 16:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=4VbHKDnDnvCg25eFKiNjDDswesz5EkPRiul74mSjHKA=;
        b=UHz3zDZorg6kTM3Hwap+OwAUMyvwYb8wmJokeIGT0662PT91WQy13UIEf8aSx51Lz1
         WkEyt0DUAzghum5aFjBCEiG0JM660b4JDtLIg+vPiM586Qco0UY/ZFJ6IzjdT2aQijrZ
         7qPKo23+JpQZ5vg+u0AEZ7olw+Gjh61uGm7Z97ZrlvQ5Kuap7Kk4dgX4pVgnM8pAvPSt
         pVi8ygPP5iVN4+dh1Xl9AT8yULhrVJ+WxERp+ehYNP++sttQgfnvGginGQ3+HZeHZ2Gj
         jU8mFqpsDFD6a6kVP7MpGHBT4gSBhGF63yTTDoxipwHoMxLlBSEX0isY6oLX9GuAJIFU
         trPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=4VbHKDnDnvCg25eFKiNjDDswesz5EkPRiul74mSjHKA=;
        b=QQ+MWs093Mljl9JVkq+PLJ9PwWQmFiTsIm1IrmjuY9j5sdXBRD8iv7XFieahcp2BFP
         qlID3a3fGZCmnuxH/bP5kau6dfyN8t8bu5ZWUVwzdp4SXwjF6zcdoqns3FhziuOD8U8l
         Hsb42B1QS69WaLwSarANVwa6cRBjLBUTkcJrCrmDge8wF3J62L/isFL2cr7FcBTWVFqj
         jlck0diQwqU7tl047ndzRGHUeXo3tcvvc8RS+fxLr1W0MiArPP5Xl5x66KZdtSa9NlTD
         ygcD94qe5PUotRJ7Sky/0zNnERELCbKoTjzNBSyLuLi5CegkdbzfsUm73VAFbWmDBTKy
         dieQ==
X-Gm-Message-State: AJIora/CelQ8XPsSvYao3btgi0cIrQE5ztOmDbPptdkI1cwGNoveCqTw
        MBT6lUOUr4+YUVvJdxRKVUyx80Oj64elOA==
X-Google-Smtp-Source: AGRyM1vkamAf667H8+zaD8UKEnffOCh93TWSXZ559BfEXgJpqKTJBU4kHQ9x7wkg0RQPUxiz272sPw==
X-Received: by 2002:aca:d1a:0:b0:33a:b34b:e46e with SMTP id 26-20020aca0d1a000000b0033ab34be46emr7459845oin.132.1659395276554;
        Mon, 01 Aug 2022 16:07:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.51.148])
        by smtp.gmail.com with ESMTPSA id f50-20020a9d03b5000000b0061c9bbac1f9sm3082817otf.16.2022.08.01.16.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 16:07:56 -0700 (PDT)
Message-ID: <62e85ccc.9d0a0220.d58d7.d24b@mx.google.com>
Date:   Mon, 01 Aug 2022 16:07:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4134092999461305043=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220801220426.2198967-1-luiz.dentz@gmail.com>
References: <20220801220426.2198967-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4134092999461305043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=664631

---Test result---

Test Summary:
CheckPatch                    PASS      1.86 seconds
GitLint                       PASS      0.76 seconds
SubjectPrefix                 PASS      0.69 seconds
BuildKernel                   PASS      40.33 seconds
BuildKernel32                 PASS      35.03 seconds
Incremental Build with patchesPASS      48.21 seconds
TestRunner: Setup             PASS      575.07 seconds
TestRunner: l2cap-tester      PASS      19.89 seconds
TestRunner: bnep-tester       PASS      7.90 seconds
TestRunner: mgmt-tester       PASS      118.88 seconds
TestRunner: rfcomm-tester     PASS      11.58 seconds
TestRunner: sco-tester        PASS      11.33 seconds
TestRunner: smp-tester        PASS      10.88 seconds
TestRunner: userchan-tester   PASS      7.65 seconds



---
Regards,
Linux Bluetooth


--===============4134092999461305043==--
