Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDDAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Feb 2022 16:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiBZQEi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Feb 2022 11:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiBZQEg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Feb 2022 11:04:36 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEE8B91DA
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 08:04:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c9so7292997pll.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 08:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TVwSC6h5s3cXSOcRC0Vxua/JTzVdi+I6yHLZX7k2RBU=;
        b=gZ6DkWVXPtn/gxhcWmtQ6LHAeMOorxzEEqyGYkYnMtG+TDqu1PEpM8Lee/71w54vPx
         bbZ1Eqy1zT//6gyubD10Wtngew+99LmxhfRRrk8q7rt5zjSgtxmcKqQaiXj80/55FrRE
         fgHR0ehiXQf2qbVsnixMOwHM3xiXYGKzWba2qa6SJrKiLBgwO4Mqw11y5uSWMc0FC0X5
         d3kiRwsv5cKjittch9WpYUiKrodisRcwXZItiEspwfqrwLxd9JVevQT/xocHIEeP0kOX
         zoiGXZJjMr5Zor5utxn8Qi3nKs/qMw/PryX5oXjeC0OkJi4XiJVC16u0xxWudTF5/vK7
         CZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TVwSC6h5s3cXSOcRC0Vxua/JTzVdi+I6yHLZX7k2RBU=;
        b=ib7X7okPCTq9/IJtAaUiUBeTdOCZEzoMr1GCzemJ6RmcQZ1O87XvTJY6DdsZniIVll
         gt+eSCO0ZTSNErXCizotkPDAE+spOavdPw/vtY+utZ4HcUZnwAYQf5P8c6NKiZ8yHb4E
         vwzZL4DhMFOL+lIU7IRkRQn0zZHiszv1iu1oFjQbZyae1U+qC1b4FRVUKeGbuE0WSDPy
         XQmu0V5OvZZjuXDWaDBv1eEbUB4vnS6/7vfh0vBnjfd/RVvga5nRQbxfeAXO6feCXu1d
         Kr1G4dj+ekd+0bls3hFT66pfuWv7yCkN0eclRv7ZUUQY67BAr5odExBwMsLzbkWMLQ0a
         guHQ==
X-Gm-Message-State: AOAM533d/BTKhcON5XxackodiT1r5y5us3fH3RH5mPQG7H1XazKce9Xi
        XXmTbR6Hf05C2BcINq5Cf4+YiD+z9GU=
X-Google-Smtp-Source: ABdhPJzhq29MWjz4aeKQdEY7ZVBiRAgoU6oKzP2rIo/85JKLdEWYrfvPRwON8rGrHGBKA6PF3vXDpw==
X-Received: by 2002:a17:902:694c:b0:14f:bb61:e7bf with SMTP id k12-20020a170902694c00b0014fbb61e7bfmr12107726plt.159.1645891441135;
        Sat, 26 Feb 2022 08:04:01 -0800 (PST)
Received: from [172.17.0.2] ([52.156.135.168])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a0015c300b004e17afd9af9sm7782605pfu.92.2022.02.26.08.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 08:04:00 -0800 (PST)
Message-ID: <621a4f70.1c69fb81.d3b37.2fd3@mx.google.com>
Date:   Sat, 26 Feb 2022 08:04:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1891115587734098992=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, helmut@subdivi.de
Subject: RE: Bluetooth: btusb: Add another Realtek 8761BU
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <YhpF0JdpCmRXZtrG@alf.mars>
References: <YhpF0JdpCmRXZtrG@alf.mars>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1891115587734098992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618306

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.41 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      38.76 seconds
BuildKernel32                 PASS      33.68 seconds
Incremental Build with patchesPASS      45.28 seconds
TestRunner: Setup             PASS      590.81 seconds
TestRunner: l2cap-tester      PASS      15.51 seconds
TestRunner: bnep-tester       PASS      6.98 seconds
TestRunner: mgmt-tester       PASS      126.10 seconds
TestRunner: rfcomm-tester     PASS      9.33 seconds
TestRunner: sco-tester        PASS      9.27 seconds
TestRunner: smp-tester        PASS      9.03 seconds
TestRunner: userchan-tester   PASS      7.51 seconds



---
Regards,
Linux Bluetooth


--===============1891115587734098992==--
