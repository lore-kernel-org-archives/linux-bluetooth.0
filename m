Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90376C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 05:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiGNFeG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 01:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiGNFeE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 01:34:04 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D8A222AC
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 22:34:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i2so522959qkm.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 22:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RkcymgIfv8u1OqaoAWu8G9f70JB2PCeva9V9qkcKa/Y=;
        b=TB2Pkf8ZoVssKntRYmvwXcBLRWhC4d08sXCEizOlC+2XdPR9JFv/Qg+sX14mrA52lv
         4akbrJ2Bgy1SFX+KyHvQj/Rv0R1Gdgt+1VOl1EvKvN0lQUEDYH1jeYMok0v5pYoMXaS8
         DkjpvGoh3kT2IwECEpIiHs8QkEkoHgPGjS00nwtn7k+TsW9UxE97T+XZczZwPr4PPk+A
         ZvdD5OTCrQ4bDxiG1muXr6BF40cM4LFxApWUPabESsISTjkRY12Yai3ozsPgqFVAfII/
         1T47P7VUe8SB/CsODtN4swV9n4RFk1hJSS14eTo+feUjtNRn5+IldDrTGsR1jfD7Q9fI
         o6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RkcymgIfv8u1OqaoAWu8G9f70JB2PCeva9V9qkcKa/Y=;
        b=LzFSyUGEdqEunmpNxjebqToeZfpbA5NC87nIMYO/WfX+ixw8aGdAlopacaV1VA71QS
         fpEKlIw/uuvUFqbl/8bsRb6apE3D0W0HEmaurZ6XyqDIENEf5ogyznked9RkLpxvqwcM
         3W0Tb6oXyTvZZQTDMYq6fjLRXi0VKA/rslEy39g6A8utfUnlPue5HfSeP4nPfPqMku6u
         8dvfXPpEaWyL8Ozq0LXQxH71UPT9u359rthAQIB1gIvH1Ct6b2wniX1+oi+AXm33OhNg
         elL3ltBCeWRqzCiz7MXcqGp75OFmBU/nkTu8mLDzXxbZPklbVoo20J21eO/dOx7CuLY3
         Qrig==
X-Gm-Message-State: AJIora/56R9OHFkvBPCcSZdmK/LwkGvZcog3O2kHVM+ACjV9HtpRSMvV
        01EQy/FgacmI1jiIyALAh6L6tTzqyo0=
X-Google-Smtp-Source: AGRyM1uLn5Ar4O/OLbe2mzmtyNg5gKfkcNtuyC1uIwPtcsSEelgmGNyE6NmvYLm2MmbQ2NXGbSVYPw==
X-Received: by 2002:a37:5a45:0:b0:6b5:bc59:1705 with SMTP id o66-20020a375a45000000b006b5bc591705mr3626151qkb.524.1657776842569;
        Wed, 13 Jul 2022 22:34:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.11.150])
        by smtp.gmail.com with ESMTPSA id z4-20020a05622a124400b0031ea9aa916bsm660751qtx.95.2022.07.13.22.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 22:34:02 -0700 (PDT)
Message-ID: <62cfaaca.1c69fb81.53f2f.0ef1@mx.google.com>
Date:   Wed, 13 Jul 2022 22:34:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5731272469896125159=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: hci_sync: Remove redundant func definition
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1657774452-4497-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1657774452-4497-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5731272469896125159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659533

---Test result---

Test Summary:
CheckPatch                    PASS      1.93 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      32.08 seconds
BuildKernel32                 PASS      27.77 seconds
Incremental Build with patchesPASS      38.56 seconds
TestRunner: Setup             PASS      473.17 seconds
TestRunner: l2cap-tester      PASS      17.06 seconds
TestRunner: bnep-tester       PASS      5.96 seconds
TestRunner: mgmt-tester       PASS      98.14 seconds
TestRunner: rfcomm-tester     PASS      9.44 seconds
TestRunner: sco-tester        PASS      9.20 seconds
TestRunner: smp-tester        PASS      9.38 seconds
TestRunner: userchan-tester   PASS      6.22 seconds



---
Regards,
Linux Bluetooth


--===============5731272469896125159==--
