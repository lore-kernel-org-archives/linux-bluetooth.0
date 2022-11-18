Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39B1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiKRFw5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRFwz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:52:55 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31D597AA6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:52:54 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id r2so2058863ilg.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4TqU3lhwkKwgmR1Il7fiXUrNGeB9+tvbeH3djIrRoHs=;
        b=S52jwp3w5xyRe54Y4SXIvi2COWs6MsPita1HH388rAeQYm+KRSPWWRINl6IYbc8tL5
         KZ6zbrr28GIT3mmnVeUADgifdQQrxqdkAeuP1uGRyLciJKIqRIb7XjzOpr7WGwPBDZxy
         i4wI3dRE9UUavVPYgYbkWvyTU4aG00JBowee9UR9fdkITLO6lhytP5SoqgclIUBRwPEd
         Cvg4ORTPipTqX630XTkhDFEh2nFmemFOa4j1n/RWLmtBvULHyNzBQlMzAaXFaie0qSuL
         NgDJ4X58ORaXJrP7uCznZVRH9EX0MxUY02Zi1ycEmQgJg6YIwQeTkhyl9YQwd1nenewY
         BiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TqU3lhwkKwgmR1Il7fiXUrNGeB9+tvbeH3djIrRoHs=;
        b=nZE6FmhQHODya5Vu6MSRtSUz1oI/rQQriOgR3r3KVG4kyKa9N+ZvSVYKn/aK4Eux8U
         pv++CvNAuxUFkfN0PtzOyD5mgTSDqNUFzbfrDd/D8OsKpfGksepxa7Gel0aLUyvHJ2Yx
         yGB9P1fK1o1LTVSB90uTo+nW2sa89KInSP1+b1TEstLqgsIvPR/MpJbMXLdct7LYHUFA
         oaNcNAJguY+OoIfZwN3Lp8iLwbP2RI30t90vNxuCVoOp5kze+0F/XD8ytbnrNP+wjx+D
         K5oPrOn6a96DMDNW5Ro68KcQmV/bhpTRrlWRTlTS0MEpeyKZkqPIiCTqVOB5FSB01KBy
         UanA==
X-Gm-Message-State: ANoB5pkHvg4fDNt3LRTf8dx3Kbtc+h9yEeBBI4EGcCl8S1GOCHs54KKC
        kzPlCLvxw52O3fZCVJ/9+wBZTH1uOjY=
X-Google-Smtp-Source: AA0mqf6rkK/zmu96GU3VuUVwMvHsFDfBIeyi/Kz4m1+t4K9IZY2Y6Wvm9OLXTCzajaUUHH93qN2gNA==
X-Received: by 2002:a05:6e02:d47:b0:2f8:f87a:d23d with SMTP id h7-20020a056e020d4700b002f8f87ad23dmr2779139ilj.130.1668750774205;
        Thu, 17 Nov 2022 21:52:54 -0800 (PST)
Received: from [172.17.0.2] ([20.9.60.210])
        by smtp.gmail.com with ESMTPSA id e9-20020a056602044900b006cfdf33825asm1026316iov.41.2022.11.17.21.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:52:53 -0800 (PST)
Message-ID: <63771db5.050a0220.ad14f.26b1@mx.google.com>
Date:   Thu, 17 Nov 2022 21:52:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5531134166165183767=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/2] Bluetooth: Remove codec id field in vendor codec definition
In-Reply-To: <20221116062918.11879-1-kiran.k@intel.com>
References: <20221116062918.11879-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5531134166165183767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695805

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
GitLint                       PASS      0.50 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      25.26 seconds
BuildKernel32                 PASS      22.63 seconds
TestRunnerSetup               PASS      313.62 seconds
TestRunner_l2cap-tester       PASS      12.86 seconds
TestRunner_iso-tester         PASS      11.44 seconds
TestRunner_bnep-tester        PASS      4.03 seconds
TestRunner_mgmt-tester        PASS      83.17 seconds
TestRunner_rfcomm-tester      PASS      7.31 seconds
TestRunner_sco-tester         PASS      6.78 seconds
TestRunner_ioctl-tester       PASS      7.52 seconds
TestRunner_mesh-tester        PASS      5.07 seconds
TestRunner_smp-tester         PASS      6.74 seconds
TestRunner_userchan-tester    PASS      4.22 seconds
IncrementalBuild              PASS      27.25 seconds



---
Regards,
Linux Bluetooth


--===============5531134166165183767==--
