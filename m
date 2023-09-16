Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76528CD37B1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Sep 2023 01:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjIPBPt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 21:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238841AbjIPBP3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 21:15:29 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7118F199
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 18:15:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf6ea270b2so21859855ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 18:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694826921; x=1695431721; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zNfe+ZIfnam2snSoaxyNUes/MpYg1SzAUONe/hMoYNM=;
        b=bzt/lemisjyFCK2zlQ8iek7sAMH3Ry321aHodq9IjUO2tSIT78ErjN31MfD9zqVkMW
         z4B9C01gTa7yUYLKxvKdK9EF3/ejSlQXQPYyNF4zZNxpz08f3kO/2NDTWT0jamEUMm6s
         Lg51rHbwImXmMRl0CO08si1btupY5mtWuuYot+8fXFr2I4Nn3LaEqzxnYQ8nrp9HOMxk
         ItF/NU7DCCb5eNPwYyPSk+Wz7oF2NdEkRYIsg1wxZdx/9LVshhFnBijQtcNfbJmwMCmi
         I84uBh6GeJskIQwiKZf87mJjO5XNPfs05y9EWUOn14OWFFzN35euTUqGcMc8XW3mNhhb
         4jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694826921; x=1695431721;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNfe+ZIfnam2snSoaxyNUes/MpYg1SzAUONe/hMoYNM=;
        b=sDeUoatKL7wecdgrK7F0ApdaAZpSwA8dwUuEKtZBpQpQNR7kiLPXqdMH2b9OWcMURn
         LI5HMuOWW30wzJz8qbs3YdLCP+zzww6wnIoRFFylrLFeXP3y8FmOSm9WZDwsTtM73myB
         ept/j/N6r5JhGORWmC633PEU6VgyYMPhVA8KtiEQadTt9qb6YxN4P1wcPjDILM/5DvJ9
         uBIw0HS6p4ouqTZIB22LqsO2t8AjzS5mpAX9JiHudXmnVImsQRg1UNVAKaaLB/A80BI8
         zXNIbGuXaWw3IOEZ3AdTAuduGu1HdCU8BwtptHSL0jqD68ABI2qMwoFHNEbn2YKM+UVL
         aMQg==
X-Gm-Message-State: AOJu0YyuYpEeZKl478SSmDT/743kqxwSpY+uDa/TyrjLdXjsX4NGEFkP
        nLmRtbzplNKLxsc+oaNzTZRmFeKoOqc=
X-Google-Smtp-Source: AGHT+IEfcT86XwH9Qb8l7SSXTUGIvsqUo13RmoPlSL+oaCiUVm6YzKA+MKwbIGZMHLO+jKzjsuQXJw==
X-Received: by 2002:a17:902:da8e:b0:1c0:c640:3f3e with SMTP id j14-20020a170902da8e00b001c0c6403f3emr3777940plx.42.1694826920619;
        Fri, 15 Sep 2023 18:15:20 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.244.135])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902868b00b001bdb8f757besm4090320plo.23.2023.09.15.18.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 18:15:20 -0700 (PDT)
Message-ID: <650501a8.170a0220.e99f5.144a@mx.google.com>
Date:   Fri, 15 Sep 2023 18:15:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6763243736029134325=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/2] Bluetooth: hci_core: Fix build warnings
In-Reply-To: <20230915234742.3739283-1-luiz.dentz@gmail.com>
References: <20230915234742.3739283-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6763243736029134325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=784859

---Test result---

Test Summary:
CheckPatch                    PASS      6.97 seconds
GitLint                       PASS      0.76 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      46.49 seconds
CheckAllWarning               PASS      50.70 seconds
CheckSparse                   WARNING   57.30 seconds
CheckSmatch                   WARNING   152.74 seconds
BuildKernel32                 PASS      44.81 seconds
TestRunnerSetup               PASS      682.73 seconds
TestRunner_l2cap-tester       PASS      40.54 seconds
TestRunner_iso-tester         PASS      82.57 seconds
TestRunner_bnep-tester        PASS      14.22 seconds
TestRunner_mgmt-tester        PASS      286.68 seconds
TestRunner_rfcomm-tester      PASS      21.54 seconds
TestRunner_sco-tester         PASS      24.71 seconds
TestRunner_ioctl-tester       PASS      25.51 seconds
TestRunner_mesh-tester        PASS      18.49 seconds
TestRunner_smp-tester         PASS      19.47 seconds
TestRunner_userchan-tester    PASS      15.43 seconds
IncrementalBuild              PASS      53.32 seconds

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


--===============6763243736029134325==--
