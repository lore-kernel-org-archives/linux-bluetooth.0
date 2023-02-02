Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7B4C63797
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Feb 2023 09:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjBBJeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjBBJd6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Feb 2023 04:33:58 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504ED8A7F
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Feb 2023 01:33:39 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id a23so865573pga.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Feb 2023 01:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1/rViS2PySHA2FfFOpX46EGOSH684t6/0QTU5SbX3FM=;
        b=hR3Lo8/PVIkGtgyxXXSICUcGSsrnWtP/rvBOXDPKyKRQqMrARsEBZ1w3QNL3X7t/3N
         DcnmUNv4tDWzqUzYJS2PVx7jryDcsZRSyeoR0tUxfBSe4qbpviiFQi5DuYLDq1PEvXKV
         VTVhQ3eLB9axSt6aS38dmqDWbilrVf0qdzqMXOTKUdmz3eMqteuXS81IEqe6nwhYvqW4
         hxeXjbXXs3eRQ5yIPXxqYQpwiImaSFlqiW30rsel5rnR3LdBGzJhT02o7D/RfhhcHOY3
         8cgMndx3UknKTRsZCyG6xoF4CKNawv21qXtbAHeOxCziFzMTt5L+BLJGiQmr9vXeejN0
         lRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/rViS2PySHA2FfFOpX46EGOSH684t6/0QTU5SbX3FM=;
        b=j59pK8Za+XHUv0mykut7eRrqXOGzV4Dq/DKGRKDm2ALUU8hDn0gYuc7Rtoiegnghcg
         ITitYlBPaTlZwybUuLHwGjA9q1Pm0uxbqGarAh7RbhjJvn2FJpLQSI0DnVgUV/Yq0xae
         F5FclYdQd4qYE3iMdHX5mT+bUb+emePFxhBr5eTQjA//q34Tdfw9NezuT+Q9jCiUX2pk
         lvlsI8TYkyy6aGOVGwdDGDPgW5niJi9JEyvuX9ImaVFTwOVwpmdCma8v0I8NSElRnwsG
         i3MVeasUIjHp3b36M9xiaWFBkG6aCp7tOujX0j6QIW7l8f4WvcIT4UmiPP4ELbbVV8Yd
         R7Yw==
X-Gm-Message-State: AO0yUKVx28zeOzrUdwINkK2Fmn4m3ZYQf6ldSPRzKLlRjGtwALPS+uAC
        RVVN4CcCwBI3BV/DsCxRnYJLNWaDNoo=
X-Google-Smtp-Source: AK7set80jFijUJiV9k+BdprvVgwVGK7uxwWOluzAP8onN9Y1MupLinV0X83HFT81ZKckv+cZm0HRVA==
X-Received: by 2002:a05:6a00:882:b0:58d:987b:2e9 with SMTP id q2-20020a056a00088200b0058d987b02e9mr7642823pfj.24.1675330418636;
        Thu, 02 Feb 2023 01:33:38 -0800 (PST)
Received: from [172.17.0.2] ([4.227.0.67])
        by smtp.gmail.com with ESMTPSA id g20-20020a056a001a1400b0058bc60dd98dsm5908469pfv.23.2023.02.02.01.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:33:38 -0800 (PST)
Message-ID: <63db8372.050a0220.a0193.bfd4@mx.google.com>
Date:   Thu, 02 Feb 2023 01:33:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0367738397906029550=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: L2CAP: Fix use-after-free
In-Reply-To: <20230202090509.2774062-1-iam@sung-woo.kim>
References: <20230202090509.2774062-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0367738397906029550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=718047

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      31.44 seconds
CheckAllWarning               PASS      33.94 seconds
CheckSparse                   PASS      38.44 seconds
CheckSmatch                   PASS      106.53 seconds
BuildKernel32                 PASS      29.79 seconds
TestRunnerSetup               PASS      433.73 seconds
TestRunner_l2cap-tester       PASS      16.20 seconds
TestRunner_iso-tester         PASS      16.63 seconds
TestRunner_bnep-tester        PASS      5.44 seconds
TestRunner_mgmt-tester        PASS      108.30 seconds
TestRunner_rfcomm-tester      PASS      8.67 seconds
TestRunner_sco-tester         PASS      8.01 seconds
TestRunner_ioctl-tester       PASS      9.31 seconds
TestRunner_mesh-tester        PASS      6.86 seconds
TestRunner_smp-tester         PASS      7.90 seconds
TestRunner_userchan-tester    PASS      5.67 seconds
IncrementalBuild              PASS      27.87 seconds



---
Regards,
Linux Bluetooth


--===============0367738397906029550==--
