Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E3FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 21:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiI3VNe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI3VNd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 17:13:33 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92252BE2EA
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 14:13:28 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id z9-20020a4a4909000000b0047651b95fbdso3052733ooa.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=jX2TcyfRhVQyhsF0n2B/RmXsgHx3O26mJCPTpiV/zXY=;
        b=Ol+YYgrdiBDnbISK8Jlc/2uqm1C5g3+orNgiZpGuIX7Ywdmf7coTKsJw8eoLqvMfpF
         9UTsgCeW6bQy+HeqELDaAm8x8IjNdZn3pxJBqqViQ422XpqaQ1Kar25EbXoYEWj48PIG
         sf6+umlKJLiSyQvP256eshly5t7ks9u837GpfDCQ/XHIbjVWjZFXo/gxG6tkegSB/7/r
         onD4EtqYZyCDzs0yZwOJPm9udXla3Q4rtUaoCIuq41Zh9GXqVVnvaVbBP8a7cFESTSd8
         N3/M3u4+JyPuWcWF8lCB0aiuxBjtvWjTi/eJAY7ih+fpv8XuFcX5+khyzWEUVxRnS6FI
         NkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=jX2TcyfRhVQyhsF0n2B/RmXsgHx3O26mJCPTpiV/zXY=;
        b=hiVppnIZTSPtjoSQpYwTiefROTUcdZtwI/e/b/A1ctQKlw9/AtTVVSefEWkE2UATTM
         4KsRf1rvzEZU35ermtDRAkUJeugqBHpFMyym00w9PwJ7ou/ow/hQsg2kqMNJCmEPez9F
         JhMNXLmonFE8eiPCNPyutuIVvxrod94KIIMXNhXIEFX+W29h2SMO+BPm6ckbV9CnN87a
         NUMoN65osgUbRjSQEeZoYMissXNWMHdNM0pgbLQWORfjSeVmsv9O2IngAw2fxpzffg2m
         J4Tw8G/57BoVS9Q+5XRo9wj4lZOqEWpOwXzfgqR9Whe4Dk6GB7KCP1bD8jaIfvDljkgE
         1Dpw==
X-Gm-Message-State: ACrzQf0RVujaGEwNYNxsXu6lNA3AmeZxahw4pN3rg8W7LU1r4pbY5yUL
        TzBJqKSCRhvAFgA/R3BTgP12v8KJGnY=
X-Google-Smtp-Source: AMsMyM6tLNPXVq3I58SRN5yyRbtLqsqDgHaALUMYT95bh+8LHZky+PUlhFWBmXA5i/YrFNuS17pDqw==
X-Received: by 2002:a4a:9e82:0:b0:475:655f:45c4 with SMTP id u2-20020a4a9e82000000b00475655f45c4mr4007824ook.77.1664572407485;
        Fri, 30 Sep 2022 14:13:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.220.154])
        by smtp.gmail.com with ESMTPSA id g7-20020a9d6187000000b00655bab150d6sm790522otk.59.2022.09.30.14.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 14:13:27 -0700 (PDT)
Message-ID: <63375bf7.9d0a0220.17443.3932@mx.google.com>
Date:   Fri, 30 Sep 2022 14:13:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4374515065799485597=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix not indicating power state
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220930201920.225767-1-luiz.dentz@gmail.com>
References: <20220930201920.225767-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4374515065799485597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682381

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       PASS      0.74 seconds
SubjectPrefix                 PASS      0.66 seconds
BuildKernel                   PASS      33.38 seconds
BuildKernel32                 PASS      29.42 seconds
Incremental Build with patchesPASS      42.04 seconds
TestRunner: Setup             PASS      501.62 seconds
TestRunner: l2cap-tester      PASS      16.92 seconds
TestRunner: iso-tester        PASS      15.39 seconds
TestRunner: bnep-tester       PASS      6.08 seconds
TestRunner: mgmt-tester       PASS      99.46 seconds
TestRunner: rfcomm-tester     PASS      9.76 seconds
TestRunner: sco-tester        PASS      9.14 seconds
TestRunner: ioctl-tester      PASS      10.29 seconds
TestRunner: smp-tester        PASS      9.22 seconds
TestRunner: userchan-tester   PASS      6.38 seconds



---
Regards,
Linux Bluetooth


--===============4374515065799485597==--
