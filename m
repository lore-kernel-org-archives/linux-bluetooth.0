Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EA1EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 10:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjF3KfC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 06:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjF3Kep (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 06:34:45 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F91D358A
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 03:34:44 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a28de15c8aso1512183fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688121284; x=1690713284;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iVV0bLMT3HFvjb40Nov2ObnYio2XuNvD7jF1zy1gnd8=;
        b=QskI1Hhffw+qQJkpHsBjETbqnPh9sdSnEKUNJwzyX6D2ROe8wuiv3MelIXVvxNpfXj
         QR/73JQmFWrU4DSsfLI+8uf3YE0x4ByYMVXdn7SkoYQcaejOHTYtYv2vIYKy3vfzWGcb
         vFkurg/aVt4hoK+70zjizPk5Ai7La+fBFCJyn/q0dYqKRSNPY3sV+MPU3Gxq4WUPda2A
         /qz6JugK7zycAv5RN+qAO0q/JLCLMcA9qZXT0nGG/CBrOIPSfgjb1Whgz1rdc2TQw9I7
         H3sgkrGi0UtQf2ESOst6i2wCRHWS+REEG5oMJiOORh2ZybTi1sTNLxYrcugjbnpDXLBg
         LurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688121284; x=1690713284;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVV0bLMT3HFvjb40Nov2ObnYio2XuNvD7jF1zy1gnd8=;
        b=Fkg9Nywz5X+OGq1m2N8wpNT1o2IXwNTQefw695WbqQhVqvhY2Zy4sav9JWaqvYwxry
         e6axpPl7Ft+OlP722Pnk8eXfX4vwlE6arFmHWvzJG8nuhsRkkgYFPBCxMHEf+4X08sof
         mP0Kh/Pk0uwrwWPAymOiOGCww8X4JpqfAXpKjGfqvd2qtErdON19N2RIzWZOvoAuWObf
         fjXLtGiJRGzE6Y6oe9KHJL70Dfpd9bC3SChHSSLaQ5MHtg9osVZh+aHbJYo7ybbjbf1i
         FyhrKy2Y/y2Tu2uuYvGqYVr4bvhwbICCcNyhbKO2qIFHaBrXiEMa2fFutEBsGm6IA/vN
         Zt/A==
X-Gm-Message-State: AC+VfDyML6/RaJOc0IGEiZ5i5ryo2aogzk4cmkG9oLTWV9jpkYRuXuc6
        bApzyreHB8twhI+JjvYIquJS8p+LXfw=
X-Google-Smtp-Source: APBJJlG72mak2itAq85zQv7rVKx53/1r6GEpsMvbbTp27LxKLECfkjejGq7f/1js5teubIrtokf4Iw==
X-Received: by 2002:a05:6871:711:b0:1ad:3204:1d4b with SMTP id f17-20020a056871071100b001ad32041d4bmr3076793oap.22.1688121283643;
        Fri, 30 Jun 2023 03:34:43 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.138.241])
        by smtp.gmail.com with ESMTPSA id el35-20020a056870f6a300b001962e45f0d4sm8707966oab.24.2023.06.30.03.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 03:34:43 -0700 (PDT)
Message-ID: <649eafc3.050a0220.fb40e.b7a8@mx.google.com>
Date:   Fri, 30 Jun 2023 03:34:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6289777442242087809=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Bluetooth: ISO: Add support for periodic adv reports processing
In-Reply-To: <20230630095928.436569-2-claudia.rosu@nxp.com>
References: <20230630095928.436569-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6289777442242087809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761482

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.65 seconds
CheckAllWarning               PASS      36.48 seconds
CheckSparse                   WARNING   41.53 seconds
CheckSmatch                   WARNING   114.35 seconds
BuildKernel32                 PASS      32.14 seconds
TestRunnerSetup               PASS      456.92 seconds
TestRunner_l2cap-tester       PASS      13.41 seconds
TestRunner_iso-tester         PASS      23.90 seconds
TestRunner_bnep-tester        PASS      5.65 seconds
TestRunner_mgmt-tester        PASS      133.09 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      10.55 seconds
TestRunner_ioctl-tester       PASS      9.84 seconds
TestRunner_mesh-tester        PASS      7.05 seconds
TestRunner_smp-tester         PASS      8.23 seconds
TestRunner_userchan-tester    PASS      5.90 seconds
IncrementalBuild              PASS      30.53 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============6289777442242087809==--
