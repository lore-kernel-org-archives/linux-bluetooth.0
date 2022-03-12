Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964FDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Mar 2022 11:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiCLLGd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Mar 2022 06:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiCLLGc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Mar 2022 06:06:32 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E364A20D53C
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 03:05:26 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id jx8so8493002qvb.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 03:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=k/8+O1sKvzlmmnFzTVQvV4nWuRdY3P0ImT0WmDikBA0=;
        b=M8gbLvY00EB28UT9W/SXk1EZwbinawIIPOYZv1ASCdt6QilMwbPKYO5f5zIRXEXz0J
         eopN5lpiCE+7wI1R5TkWPT0mMwCOl5Chh8KFo7RnUwKSkFkxFDGtWxp6CakaP8aGTkzr
         7LAaAE2w+T73aVYak6aGnnbwvU/hqM8hFjTZr+ahXFJ8oeIqYMx07lC/W+LhxLEW6Dfs
         fqJyWt4hn/be2nJSrSs1TFuoOaR7OCAO77JpKIF6gs+68x9tgXroCKVDuhMZ7u3cWpV3
         3h0D6tBCFwkCS+6idn7HcEtI4Kpgc1cJJJCKypDkmYS+AaYycGv8upnpVUE7p5qvvpNG
         0O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=k/8+O1sKvzlmmnFzTVQvV4nWuRdY3P0ImT0WmDikBA0=;
        b=lMaOOpQV7/UqFks2900HTZYTTA7YKLAZo9U/2a3fHtgyd8wO3Q8HCZWapsO1r9o1D/
         zR8NIKmTD1w1UqbnSUNVkwkK6f4YqWa5ab2r7vEc2FKTs5a5GuhtsOFeqb+Hme4BNzUH
         ZpMFtUrZP1e+eXDOHuShNL1u6Ao26tICLiULh9nqCfwHtPtfdEXfNZXc1wbJXF31iKXx
         0sqUbRm8CFU2o19Odwpxu97khegHRrk0uIkVrRD392yzkBMNERGh5VaHTpTAv8w1X24D
         SMoWgsJmUFFxT9j20wR/QoAlgiMjrVLgtSyJg3N5GkBDKN08+aJmu5eNAuV/U5kNOReX
         RzMQ==
X-Gm-Message-State: AOAM530x48b+T7PA3U3fYPuaiFoig0mwpOviZIKdlhu7hU1eyJCNF1H/
        ALlMMsSrl2r9DT5N8nYFXlOrfuIz5cLRWQ==
X-Google-Smtp-Source: ABdhPJyZUhGKkyiMBMJrq3+GYwibdeE3qHuwYDb9WaOfwT0+Ab4Y9ERSYQA2Htvh6Ws9c5wt/gLVDw==
X-Received: by 2002:a05:6214:e61:b0:432:3518:1c6e with SMTP id jz1-20020a0562140e6100b0043235181c6emr11301959qvb.105.1647083125250;
        Sat, 12 Mar 2022 03:05:25 -0800 (PST)
Received: from [172.17.0.2] ([20.127.136.224])
        by smtp.gmail.com with ESMTPSA id p7-20020a05622a13c700b002de9f3894c2sm7705060qtk.50.2022.03.12.03.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 03:05:25 -0800 (PST)
Message-ID: <622c7e75.1c69fb81.78950.c3a3@mx.google.com>
Date:   Sat, 12 Mar 2022 03:05:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6158002240260744209=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [1/2] Bluetooth: msft: Clear tracked devices on resume
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220312020707.1.I2b7f789329979102339d7e0717522ba417b63109@changeid>
References: <20220312020707.1.I2b7f789329979102339d7e0717522ba417b63109@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6158002240260744209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=622845

---Test result---

Test Summary:
CheckPatch                    PASS      3.43 seconds
GitLint                       PASS      2.05 seconds
SubjectPrefix                 PASS      1.73 seconds
BuildKernel                   PASS      35.14 seconds
BuildKernel32                 PASS      31.60 seconds
Incremental Build with patchesPASS      52.52 seconds
TestRunner: Setup             PASS      568.49 seconds
TestRunner: l2cap-tester      PASS      17.60 seconds
TestRunner: bnep-tester       PASS      7.28 seconds
TestRunner: mgmt-tester       PASS      113.62 seconds
TestRunner: rfcomm-tester     PASS      9.33 seconds
TestRunner: sco-tester        PASS      9.00 seconds
TestRunner: smp-tester        PASS      8.92 seconds
TestRunner: userchan-tester   PASS      7.30 seconds



---
Regards,
Linux Bluetooth


--===============6158002240260744209==--
