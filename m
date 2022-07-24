Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEA4C43334
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Jul 2022 19:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiGXTNg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Jul 2022 15:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiGXTNa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Jul 2022 15:13:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F6A11456
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jul 2022 12:13:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i3so4160766pld.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jul 2022 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zx7qV/IZ9ieMLkGi3YmGUHEKgVJ9dyTfDUwH3KdFMSA=;
        b=Hm9dFNfcaYXMxrLiQQsVoUYdrptJR6nKF5VLZT4fHbDRhob8DzLRkJyGKB/QrsdOhV
         J7cBYvZdQIbNKCvJLJYGH0tucnNQYde+jp8M4s9v9T8wsXT9a6teoP0J1h1d+iY6SV7V
         AgymyW6ncmXYUgQZxFOXVr2xy3/7EqJkmGjV6R07jrq3lrs0I7Jb0PTMZoZoijaaTk9Y
         1MGjHqjYBauLMBUjlq9ojBVagXE6QNsycjDpnDtvkfTlCnO27SjjLggZZB5y0UT+l8xc
         OYg+croDCaKbxToU9pa0vr6N5vN85PSLbj66ZG2s9MP0wo74FLRmLbrDuLYJlcfhb9wl
         LN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zx7qV/IZ9ieMLkGi3YmGUHEKgVJ9dyTfDUwH3KdFMSA=;
        b=vgCfnf78Am1n/BqcMNfP7sTTyw9PyqtUpqqhYYqDnOBmfGqQWclmbIoEp/FOtwvgLZ
         lwUpjMHZXEmr+RcHcYDFraN/eHVGW9BiUWkZgf9p08M/rzmMSPeIBqLCUOJSB8iIXWb/
         2Wj56X2/67vCB4FKQkPCsDhmR3RlGr4jO7rwwQj4ySCeRLjDPkm+bKAs9IneAZ5nMfcF
         CY0+fLe4EN8DSDpjHNHSBjWUBc1ZYPYkLYFw6mltH7QgHGSizlHTUK2xs9g04yGwqmPd
         KM7LTG+/z2mtS7bclDGpNmTIaeOEMIv0RNNIjp1Srh1fLxETn2UKOQg4QSl28TTBVdOl
         JVDQ==
X-Gm-Message-State: AJIora+8Xc7+Be8fl0q9uRkiTexjLKvVkj+TGo/0Gm9pLHl3oewcjHLc
        1Ye6nmjwAzKSbYtjRm+j60+TWr5JpqQ=
X-Google-Smtp-Source: AGRyM1vIb/bkqolvwIPNEaDQ2+L+2TZF6GItfLlA0xidchGe9KnOuCyrIp2vI4s9XVenyBQAVA9n+A==
X-Received: by 2002:a17:90b:1e4d:b0:1f0:462b:b573 with SMTP id pi13-20020a17090b1e4d00b001f0462bb573mr10996475pjb.164.1658690008464;
        Sun, 24 Jul 2022 12:13:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.148.12])
        by smtp.gmail.com with ESMTPSA id iz15-20020a170902ef8f00b0016bcc35000asm7499176plb.302.2022.07.24.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 12:13:27 -0700 (PDT)
Message-ID: <62dd99d7.1c69fb81.264dc.b100@mx.google.com>
Date:   Sun, 24 Jul 2022 12:13:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4169449492107217292=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, faenkhauser@gmail.com
Subject: RE: Bluetooth: Add VID/PID 0489/e0e0 for MediaTek MT7921
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220724182501.5351-1-faenkhauser@gmail.com>
References: <20220724182501.5351-1-faenkhauser@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4169449492107217292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662583

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       PASS      0.55 seconds
SubjectPrefix                 PASS      0.59 seconds
BuildKernel                   PASS      36.46 seconds
BuildKernel32                 PASS      31.22 seconds
Incremental Build with patchesPASS      49.42 seconds
TestRunner: Setup             PASS      534.62 seconds
TestRunner: l2cap-tester      PASS      16.94 seconds
TestRunner: bnep-tester       PASS      6.17 seconds
TestRunner: mgmt-tester       PASS      100.16 seconds
TestRunner: rfcomm-tester     PASS      9.47 seconds
TestRunner: sco-tester        PASS      9.18 seconds
TestRunner: smp-tester        PASS      9.16 seconds
TestRunner: userchan-tester   PASS      6.24 seconds



---
Regards,
Linux Bluetooth


--===============4169449492107217292==--
