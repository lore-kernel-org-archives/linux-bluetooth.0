Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB4DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 10:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiFBKDc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 06:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiFBKDc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 06:03:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A63813F7
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 03:03:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y187so4359743pgd.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=BM6cReBWxOQr+q/lJ+G08OfdjthvrIx76iEROIR3ynk=;
        b=ilPgbygiYx3UIFjwF/Vxhwzpd389e5cSi5vkNYtoSUsHTiyKG4L1aTYdBKoEr8PVsr
         EiM4Q9xGhOJiDWHm0m3KhOkAFBefMb0gtzaaveyouZyDlZZY3ETr3q0+ZFesIFYoraPB
         6yBy3wq43JjG6OR3wMSahMbJBcG/5HwOeD1dnrPQiW5bEqC/5wkE265A4ectgvfK9cWn
         jTyfL+MMRXCt5x8fAQw3LB0TF37F4uvaHIX5NhxBVHTprYDn50VbsHrU6b6NGpK8aD+C
         AU9foGV33meXIQZ1jVctouziwd8XaP9VGiGW+TtxNibUe5xiBYNtqPaeYL/VEWlpiLcu
         ZG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=BM6cReBWxOQr+q/lJ+G08OfdjthvrIx76iEROIR3ynk=;
        b=XVxLTUtsCbtwQxHigNCyRmuhYjVM26KOOFPOcCnkg5nSJ00Vu1qr9oe16fDLgaxinz
         hgp8S9JRBcg86Of3eV6hpU7D+5evaycCvjb8Jt48jnCiXpV6zFXUypj8Fp2XcDNqJJKo
         lc4cmMLNYR6u1mdqJpcb26K07x7XxqA2qdNHTmKg5XEejUrcNsu2UN9F2TmV9Urs0M83
         aDwWiiTuC0BwmE6f814RNY+0Iy5mYJvwK6hAmjxy//+zU879BjZsEV/HilzBD9r4j8By
         T1zdwP7ztOyZj8FFDsZtfKqgceZjzrIh2zKZzvR2soyilBF1RupVUUYilNiOGg+61eCQ
         TQyw==
X-Gm-Message-State: AOAM533JL0/ha9EraPEkjr+3d3Z//HsUjusARifZ1EosZe9VELXSNG8f
        7AFy5S2HiiJMWcXxo1MFhwC/5ze36Lc=
X-Google-Smtp-Source: ABdhPJxpv/OI0Zp0VzHsmqp82WI2p4omZNOXdYCJv9ylDVTBiHkUMYombuls5DMGo+NdYCP44icW+Q==
X-Received: by 2002:a05:6a02:11a:b0:3fb:d90c:b3f8 with SMTP id bg26-20020a056a02011a00b003fbd90cb3f8mr3675989pgb.192.1654164209181;
        Thu, 02 Jun 2022 03:03:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.135.4])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902e84300b00161e50e2245sm3121710plg.178.2022.06.02.03.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 03:03:28 -0700 (PDT)
Message-ID: <62988af0.1c69fb81.b5c5a.75f0@mx.google.com>
Date:   Thu, 02 Jun 2022 03:03:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2108016701004758676=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aaron.ma@canonical.com
Subject: RE: Bluetooth: btusb: Add support of IMC Networks PID 0x3568
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220602092822.953521-1-aaron.ma@canonical.com>
References: <20220602092822.953521-1-aaron.ma@canonical.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2108016701004758676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646825

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.53 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      30.25 seconds
BuildKernel32                 PASS      26.66 seconds
Incremental Build with patchesPASS      37.02 seconds
TestRunner: Setup             PASS      456.68 seconds
TestRunner: l2cap-tester      PASS      16.28 seconds
TestRunner: bnep-tester       PASS      5.50 seconds
TestRunner: mgmt-tester       PASS      96.75 seconds
TestRunner: rfcomm-tester     PASS      8.91 seconds
TestRunner: sco-tester        PASS      8.73 seconds
TestRunner: smp-tester        PASS      8.76 seconds
TestRunner: userchan-tester   PASS      5.82 seconds



---
Regards,
Linux Bluetooth


--===============2108016701004758676==--
