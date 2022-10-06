Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D69C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 23:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiJFXRP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 19:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiJFXRO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 19:17:14 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D6DCAE6A
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 16:17:13 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-132af5e5543so3898480fac.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Oct 2022 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rXn1On8PMDqKmQ10p7iROoYl2mAj/AESAv4pxoT1Fuc=;
        b=IIa1Ckw8jPZh1uGDq8xIGGmC3VwHx0E7wxyjBZwbRvoGhA1VoQnZY6nfAR6OE+a1q9
         dvvtKxlEU5XbHH8lCS6ufu6kmlqkiCpuGqZf1fRirEnR8Z8B1w+vYoDG55ajNSTUgbOn
         ZejYiUOCgYNd/gNK3eccmSGvR7XSCu98bdtyek0s89UmeMrj0EsytHlnE83rfRP7L/bo
         taa5P4PHWzQNshpMmdgvmsUOqBVAE6hlfL7dNNWooVRqx2wh8mWAQUVmVjRxVsfVzx11
         hQcV0QFC36hVmHxuqf3/pBduhrmOvXle3t6ydsSKfyyHbCGaEKpdBNY46siNwqk8UAxs
         WiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXn1On8PMDqKmQ10p7iROoYl2mAj/AESAv4pxoT1Fuc=;
        b=5fR9ARfgv30H9t3Ed45mERXZgf23eansXjS5NDqmEz8P1w2oRqvwnHOodZZ2qoOdHs
         jkC+K/cyFdvyWvq05Kv2XvU3tn5X6nij7kTgpBtak1p6c4Ub3315402ErGRppnS2xNe7
         R9K8yvMZpDFiE2FQ2IQSlmH5cGs7HrSIAXZsqRaj1KaV/It1WomCRDrBMPT81UEkUbXM
         femMoeT7HFQLmwx9dyOSY4Mh3AXMZ6O8gr+KOnlQXNzIT1LrN7UHroxEl4ib1y18jc6y
         vjAtwI7clIOwVCXBzhVNyidEH0x44OilvsAwFRyS6WXuze6nHPpbhsRA2ITUdMcHydaT
         1qLA==
X-Gm-Message-State: ACrzQf3DxSuoR4dJnNyTom7GLJIIz5vhE+0TKyztGYgOML+N7LSi2X6A
        QWDVhlVMruXCkydkkRhgzTG5RorhcMQ=
X-Google-Smtp-Source: AMsMyM7jU66PvrIuGx0Fka+CFN3NaZdwDbNy/o/+hLzZOH1iG4SbUicxImIUTrVO6JPu1wA8ROMkBw==
X-Received: by 2002:a05:6870:601a:b0:132:7b87:1616 with SMTP id t26-20020a056870601a00b001327b871616mr1119595oaa.192.1665098231860;
        Thu, 06 Oct 2022 16:17:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.50.64])
        by smtp.gmail.com with ESMTPSA id j19-20020acaeb13000000b003430d6696e8sm237494oih.8.2022.10.06.16.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:17:11 -0700 (PDT)
Message-ID: <633f61f7.ca0a0220.1bd66.1264@mx.google.com>
Date:   Thu, 06 Oct 2022 16:17:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6381904212916095823=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Bluetooth: Call HCI cmd to set random addr during MGMT call
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221006224937.641179-1-brian.gix@intel.com>
References: <20221006224937.641179-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6381904212916095823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683607

---Test result---

Test Summary:
CheckPatch                    PASS      1.83 seconds
GitLint                       PASS      0.77 seconds
SubjectPrefix                 PASS      0.63 seconds
BuildKernel                   PASS      42.25 seconds
BuildKernel32                 PASS      38.27 seconds
Incremental Build with patchesPASS      55.85 seconds
TestRunner: Setup             PASS      626.27 seconds
TestRunner: l2cap-tester      PASS      19.94 seconds
TestRunner: iso-tester        PASS      19.87 seconds
TestRunner: bnep-tester       PASS      7.94 seconds
TestRunner: mgmt-tester       PASS      124.37 seconds
TestRunner: rfcomm-tester     PASS      12.21 seconds
TestRunner: sco-tester        PASS      11.46 seconds
TestRunner: ioctl-tester      PASS      13.02 seconds
TestRunner: mesh-tester       PASS      9.50 seconds
TestRunner: smp-tester        PASS      11.40 seconds
TestRunner: userchan-tester   PASS      8.15 seconds



---
Regards,
Linux Bluetooth


--===============6381904212916095823==--
