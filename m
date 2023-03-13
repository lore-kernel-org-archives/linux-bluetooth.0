Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECEEC74A4B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 09:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCMJgy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 05:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCMJgh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 05:36:37 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F5856782
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 02:34:28 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id bd3-20020a4aee03000000b00517affa07c0so1724743oob.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678700062;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7cszE2r1N+Zt8OxF2TvZIksF25sudASnrRMj/UX9UAY=;
        b=VMYgCQSnFUiBFoPQ3ITGP0RN4Yh8Ompc3+4fIfDOpJYo2jl+2NLHG800qn9jtIxelC
         02Z3tAH1vHExVvW4QWbJ7O2YiwwQIXQcS0gpOH3Mywcou3HC4wJFqEMbVv0JJjghUdal
         qpmhYynlD4xQH2wBWl9rytsEfF6eGlZEcoGhoAgIl5VUr623xHd7jDLYiWvibAuKIHx/
         gaAKAqGz/YsFo1hpR4bPsDlPqRHfQzRZjQh4VlhmkEWmco0IAoYGcUppi06CH1PHRp6D
         euly4/beN/Vm5ZNyWkfChp1gFSx96uK+wlDFdOG8wwVW3nJLR1wNYYo440AtVho0ddMG
         iNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678700062;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cszE2r1N+Zt8OxF2TvZIksF25sudASnrRMj/UX9UAY=;
        b=mFe+TVurMIw5oc0uMri05qluE0aX4f04mn+pVACDgK5GBXhM/GvVjqUjUR/SubF+aq
         7v7Q7xGJ+yMHzOHZIwXaomgm8+rCcW2TnS8T995RQ/qRDSJMQ3hpt/XhY0YSHUwSurAs
         fuGN/0ixdd45JwB7wt6jSr7YD32U5UklNseyz1uQ+rKYck385ItZpcLEPvRlZP2HRWDh
         RxnH/rx/Dhrn4SCv7i8NIyE1GRoxC9xjaZYjKForXKgvLsS5pEJZD4E11oCNJJlYqqwh
         EGhrSfma79fJ0NrBtaxTQbhDgZbf2MyEoc5nKvGDzFMEfTYmW5iRrrkp9em4eQ763z9p
         RIIA==
X-Gm-Message-State: AO0yUKUle86qHF//AUYkmdo444Gg2M8rFTphxBGgi2eXD1oJ2tKvmbkv
        1Da6DIPIZXDnrBuYd25m4OHZCIom9nw=
X-Google-Smtp-Source: AK7set+A+vcG2qDTPm4MfhC4b+FElsqM/xV3ShWSAMLsBsyTnLm27CsEWo+Kpv7Kbg/iic5aJNcZZw==
X-Received: by 2002:a05:6820:3cb:b0:525:3c47:a9bf with SMTP id s11-20020a05682003cb00b005253c47a9bfmr16513705ooj.8.1678700062725;
        Mon, 13 Mar 2023 02:34:22 -0700 (PDT)
Received: from [172.17.0.2] ([52.248.87.135])
        by smtp.gmail.com with ESMTPSA id 63-20020a9d0845000000b00690f6d9a737sm2931732oty.8.2023.03.13.02.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:34:22 -0700 (PDT)
Message-ID: <640eee1e.9d0a0220.18b4d.b601@mx.google.com>
Date:   Mon, 13 Mar 2023 02:34:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3283805090833296573=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiasheng@iscas.ac.cn
Subject: RE: Bluetooth: 6LoWPAN: Add missing check for skb_clone
In-Reply-To: <20230313090346.48778-1-jiasheng@iscas.ac.cn>
References: <20230313090346.48778-1-jiasheng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3283805090833296573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=729360

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.73 seconds
CheckAllWarning               PASS      35.05 seconds
CheckSparse                   PASS      39.86 seconds
CheckSmatch                   PASS      107.69 seconds
BuildKernel32                 PASS      31.26 seconds
TestRunnerSetup               PASS      444.70 seconds
TestRunner_l2cap-tester       PASS      17.17 seconds
TestRunner_iso-tester         PASS      17.53 seconds
TestRunner_bnep-tester        PASS      5.62 seconds
TestRunner_mgmt-tester        PASS      114.29 seconds
TestRunner_rfcomm-tester      PASS      9.09 seconds
TestRunner_sco-tester         PASS      8.41 seconds
TestRunner_ioctl-tester       PASS      9.86 seconds
TestRunner_mesh-tester        PASS      7.27 seconds
TestRunner_smp-tester         PASS      8.31 seconds
TestRunner_userchan-tester    PASS      5.97 seconds
IncrementalBuild              PASS      28.66 seconds



---
Regards,
Linux Bluetooth


--===============3283805090833296573==--
