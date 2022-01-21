Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FF9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 11:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbiAUL5D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiAUL5D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 06:57:03 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2109C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 03:57:02 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id k4so10126803qvt.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 03:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5GQ23AP/Ral0gnPlhKoj3X1SlQdl5VlLLjj8+LfYBCQ=;
        b=fdLhsfnq55en1AOsdnvbQsfvQCBEBwPKzc8ir1+NnwL2rNkL5A9030RInGLhOzoykP
         Iomg9iDp42In14+vQJNGYW15Yw/5VLnfajK1xw7nV5mvGQ2XOhfkwU4d1cwP0Lvvoqua
         jx2MyqExp63VLE2oVGVE7eUuLu3WydfsbsK9HElNcdE7WzKmwpF74j/O6TeWz4+MxGYZ
         OXUQbiR1/FUdxFBbFmTbSaaONihBO9t4Ui+OwTl5LHa1eiS0DaDO0lFlA4tg/vZrQchb
         vQXDA9t8JkJqF/nphP5An+AWuXLYoJdcDj5PQLusF5LxWtZ2VYKUscjrTTYsYTZF9utR
         YAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5GQ23AP/Ral0gnPlhKoj3X1SlQdl5VlLLjj8+LfYBCQ=;
        b=S/34sbB5z6cCuUzx4aNm02sSKRku1cKnLh4H2gLn7rrMbYKVcnVqahbYs0jegWeCn0
         OszDxe17WNhfILWMR/oe0juZ/KS14devWOQ4ql+l/LJ5Vlg07mx77KLsZPxo0UglyIRt
         CfJVq4ecGseWFWca+lG0EUR0m+ar048KLMVTCHjy/9M6QvX+fl9eoHEv4mC3uX6qswWk
         NMxBFgaLoWDWJFqLLKO9pEXeJFQMkijnXfsWEx53Y6Bi9AKEJH+v1r6iGzOEg8WvJ6wA
         CMNzTqz8omW86lV2EI3tib2YLcH1GDRV3yrU9h2BokJP8Xij+jqtzg7UNsefUmeKxYNL
         d5QQ==
X-Gm-Message-State: AOAM531y+QAXO/M97INy60NVNdLszLVv43G8j3YBGlekG8tyjTktwb6l
        XYhGIunb1Bh/kUk1+3B+zbsFI3WLd0I=
X-Google-Smtp-Source: ABdhPJwYcTSAT4GA4x9TA2r/zMs8H3y8JyHg3nVcWIbs/S5BNLgZr7A95cdBHNxp5ZpyZmqXn6LEDw==
X-Received: by 2002:ad4:5cef:: with SMTP id iv15mr3086313qvb.102.1642766221958;
        Fri, 21 Jan 2022 03:57:01 -0800 (PST)
Received: from [172.17.0.2] ([20.119.164.142])
        by smtp.gmail.com with ESMTPSA id az30sm2858383qkb.124.2022.01.21.03.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 03:57:01 -0800 (PST)
Message-ID: <61ea9f8d.1c69fb81.6e5ca.22df@mx.google.com>
Date:   Fri, 21 Jan 2022 03:57:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9122150031830931795=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [v1,1/2] Bluetooth: aosp: surface AOSP quality report through mgmt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220121192152.v1.1.I2015b42d2d0a502334c9c3a2983438b89716d4f0@changeid>
References: <20220121192152.v1.1.I2015b42d2d0a502334c9c3a2983438b89716d4f0@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9122150031830931795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607231

---Test result---

Test Summary:
CheckPatch                    PASS      4.77 seconds
GitLint                       PASS      1.99 seconds
SubjectPrefix                 PASS      1.69 seconds
BuildKernel                   PASS      36.40 seconds
BuildKernel32                 PASS      32.88 seconds
Incremental Build with patchesPASS      74.26 seconds
TestRunner: Setup             PASS      564.84 seconds
TestRunner: l2cap-tester      PASS      15.78 seconds
TestRunner: bnep-tester       PASS      7.40 seconds
TestRunner: mgmt-tester       PASS      126.11 seconds
TestRunner: rfcomm-tester     PASS      9.67 seconds
TestRunner: sco-tester        PASS      10.10 seconds
TestRunner: smp-tester        PASS      9.89 seconds
TestRunner: userchan-tester   PASS      8.40 seconds



---
Regards,
Linux Bluetooth


--===============9122150031830931795==--
