Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DB5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 May 2022 21:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbiEUVHN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 May 2022 17:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiEUVHL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 May 2022 17:07:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385A552E69
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 May 2022 14:07:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so14238693pjb.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 May 2022 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ei6+VviC1dh7COt7rLp1jappuR1l162UAfBxhuzKI2U=;
        b=Rqd6nQ7sX3zM8tLE72QJ1MTMzBHZdg6ynrKNbO8lL9/KYqIwV9tL3Xg+8Dd47YdWbq
         BP6sBUocCpALbtW0bMREoggqgsHqBD2mKmWxmkHqtASMfJKjGWuZJZDLkRO92bCuZcck
         FCl/zZmqrKtP1e7ryBgxdt3KC39/6Dfn8Ma0SduDpJACljXxaz4z7OoWL4Y7Q2vldbZ8
         6avmPKnvuyAF1pit9/Gifvu3a4Fn/UQpZHGTqRnOeaGP/LpEflT+PsBTQ6mju+j4lS94
         5RP/Z8J6CJBIePxAOJaNMmZjL1BYkX/n7PSqPMBinmezRJ3u1De827QNoQG6n7hVVCJ5
         XYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ei6+VviC1dh7COt7rLp1jappuR1l162UAfBxhuzKI2U=;
        b=EY1U5YKKCOmiUYsOyHBvATj8cITJVYVk0fRCwXty4k+eM3qn/ZA/FUZ6uXiNaOfT8T
         mdnc9JjhqSs/BnNZQEQnv5uX1S+xNn8UD6jeg4Ai5IdhgaLc5LniRyNlMxKpNgsq91kP
         Nn9Vyp8uLX7LJheUfk73Xjz9O9euyGwvfyZ9nSjyQjN+1VU8mORA+lFX4HIgQ7zwuSDy
         NZHucssZWGwdnEgMNi6qlrMKOw7/kONm12UJYtsc2I48pnCAYkAn8/IAChrESMtGJ7Vm
         eSpB71EwXUEUKUrkljE0puYNARcuD1idTh2+Ivjd4gH8LzjGg03rF155jKxBg3ppOavR
         joaQ==
X-Gm-Message-State: AOAM532jYganT0v2EFedresqPpt+Xfi3h6TIDs1BRbPXBVq/RY2BLkM5
        5Ykj+IMZJzx0jBSh5jLfJ3SOvVzzIBE=
X-Google-Smtp-Source: ABdhPJznPE/LLqdDMFj18WHiHC59wRH6Gu60k3R9bA0Zp1gg+m5dJATTdvE3ruRsBvP1PyhmiJv9GQ==
X-Received: by 2002:a17:902:c7cd:b0:161:8b6f:73c3 with SMTP id r13-20020a170902c7cd00b001618b6f73c3mr15760468pla.156.1653167230078;
        Sat, 21 May 2022 14:07:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.192.212])
        by smtp.gmail.com with ESMTPSA id s7-20020a056a001c4700b0050dc76281dcsm4065334pfw.182.2022.05.21.14.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 14:07:09 -0700 (PDT)
Message-ID: <6289547d.1c69fb81.26b26.9cd0@mx.google.com>
Date:   Sat, 21 May 2022 14:07:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4745508266313431343=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, a.fatoum@pengutronix.de
Subject: RE: Bluetooth: hci_sync: use hci_skb_event() helper
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220521201050.424197-1-a.fatoum@pengutronix.de>
References: <20220521201050.424197-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4745508266313431343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=644018

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
GitLint                       PASS      0.43 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      38.61 seconds
BuildKernel32                 PASS      34.38 seconds
Incremental Build with patchesPASS      46.30 seconds
TestRunner: Setup             PASS      583.58 seconds
TestRunner: l2cap-tester      PASS      19.27 seconds
TestRunner: bnep-tester       PASS      6.91 seconds
TestRunner: mgmt-tester       PASS      119.04 seconds
TestRunner: rfcomm-tester     PASS      10.90 seconds
TestRunner: sco-tester        PASS      10.66 seconds
TestRunner: smp-tester        PASS      10.76 seconds
TestRunner: userchan-tester   PASS      7.29 seconds



---
Regards,
Linux Bluetooth


--===============4745508266313431343==--
