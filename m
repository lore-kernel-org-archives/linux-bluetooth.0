Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE053C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Aug 2023 11:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjHKLEc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Aug 2023 07:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjHKLEb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Aug 2023 07:04:31 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A09FD
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 04:04:31 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a5ad6087a1so1328247b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691751870; x=1692356670;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bD0qRVxAXSF46x11YmHY+3NkF/kDUbfM5jx/+cVMLBg=;
        b=nasVjabSZfeo/vBQqjzOOrQSu2z2FZihTeKhb06WbLjBS6VlunMEC+ayhxAKEEtR+M
         ESJ60OP7m+5DYu5j4sV5RBRtjQX7nJN54LdvW4aNtcjteWMFwiyuls2CjrJn2qYXtmtB
         LGPo3nTffe9lmRj5G2csz+bMEukvK1Gu1P2N1jLKIbYKgLJnP2NS3ghIspw2HXv3e2S2
         MW0HDuJqveRevajfwOGjUnv0MUETSZpr8V5UhImZndIfk2vKftkvv1xxIfYh6qKQYbBX
         lG0CDQLL8/RAsCFyv9QK09Kz4CFyE1g/VoxRKw467A+WxptC03dDyCvzCKkgemuS5Ffg
         Uv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691751870; x=1692356670;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bD0qRVxAXSF46x11YmHY+3NkF/kDUbfM5jx/+cVMLBg=;
        b=BJxZyWjqYRzmD4k09jzsaEMxjfZ/oUPqrlSJ0/10WKyrb1w012tSe7cDvlS3/2GiVU
         Qwi2ZD6uE9+IlK+Sf52YK1lHa3kDWFWGwstVcus9oXNxRQ7xgfPTQYsYqfT8W6CCnT+h
         rsVts2xAB8u7/DQYjfZiR06mu6a8a57l2AYLI3ap6dDe5sGTX6BGh6wn7+FuVcqAmBr2
         wsTb15PRgBr45RqtjtGM2KU3LVx0d/ndyNdqiC1RUhrISkVZ/aCG5qTldIbRA6VfaUdg
         2SeJKQUmjd7PmMufWE6EeLiIpaA7JHe8fugFujvDj7QgrV2cez6eqIXcBnHiI23g710e
         NQfg==
X-Gm-Message-State: AOJu0YxnxzoNQuKK616rCmtmRIPifJyJqCt6nVEvx0GC3Th3lgIIufLr
        /wR6epTmhWX3FNH5DB+fn9UQSzBE0Nc=
X-Google-Smtp-Source: AGHT+IEToQ9CYBs2z6AA4OtdZPByEZPsKS9UbjfXCwkBfdfDChl23T/j6xMvuqJxC4OlyTnd5rmIWg==
X-Received: by 2002:a05:6808:21a8:b0:3a7:3c6b:f05f with SMTP id be40-20020a05680821a800b003a73c6bf05fmr1778715oib.40.1691751870155;
        Fri, 11 Aug 2023 04:04:30 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.139.181])
        by smtp.gmail.com with ESMTPSA id b12-20020aca674c000000b003a7b5193909sm1562339oiy.19.2023.08.11.04.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:04:29 -0700 (PDT)
Message-ID: <64d615bd.ca0a0220.53360.aa33@mx.google.com>
Date:   Fri, 11 Aug 2023 04:04:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5334853941240344536=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Bluetooth: btnxpuart: Add support for IW624 chipset
In-Reply-To: <20230811101232.844769-2-neeraj.sanjaykale@nxp.com>
References: <20230811101232.844769-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5334853941240344536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=775278

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
GitLint                       PASS      0.63 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      39.13 seconds
CheckAllWarning               PASS      42.76 seconds
CheckSparse                   PASS      49.81 seconds
CheckSmatch                   PASS      131.24 seconds
BuildKernel32                 PASS      38.38 seconds
TestRunnerSetup               PASS      585.10 seconds
TestRunner_l2cap-tester       PASS      27.72 seconds
TestRunner_iso-tester         PASS      65.77 seconds
TestRunner_bnep-tester        PASS      12.55 seconds
TestRunner_mgmt-tester        PASS      244.85 seconds
TestRunner_rfcomm-tester      PASS      19.17 seconds
TestRunner_sco-tester         PASS      21.78 seconds
TestRunner_ioctl-tester       PASS      21.71 seconds
TestRunner_mesh-tester        PASS      16.01 seconds
TestRunner_smp-tester         PASS      17.11 seconds
TestRunner_userchan-tester    PASS      13.46 seconds
IncrementalBuild              PASS      40.76 seconds



---
Regards,
Linux Bluetooth


--===============5334853941240344536==--
