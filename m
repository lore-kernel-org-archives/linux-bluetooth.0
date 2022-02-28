Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAE3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 18:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbiB1Sez (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbiB1Seu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 13:34:50 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E62541B6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 10:19:36 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id w7so13977344qvr.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HxH4ydq14Auf3j9KEtnpF2aqEsCm0xJjvkXxoxhIotE=;
        b=HQ6nO2Txe17xmiNPfDei74rQWFb/eWq1yWKJT+DVjDY4gyGACPm0pSAYCqBEQ6+l6J
         MsJxnp2/10HaOGyxZlN2GPisGNYB6mNNXUEmcAgeB9Z30xHOr+rQQk9oTUfu3+I1YWPq
         zXZFpXvblcRrzt24RyQ+2o24UIUk0ShBKfnQD9pr46onnaV34Qv2se65a1V27URWVs7H
         Q+8WWotLrSM85OgdPM3QhMPhrY2YLq0AwQEhooA+JEpceCWWwyEx094O9qeyjJRYvxFb
         TnXeIYOv9BN12j2ZzNS3QZDN1tLy/DT6WT9ZAWd8K1FElLy0easeaFpEvAftOd5i9PBN
         ylpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HxH4ydq14Auf3j9KEtnpF2aqEsCm0xJjvkXxoxhIotE=;
        b=X1LECLdEe+G/S1gXoa56Dtc5h49w+ll286AtUNf8J2DJoWxpi/iYGh7eREo3r4idn8
         CSmKsT9h3T3F01zxmsYPeDeV5fYdavapCyXe8TvwKQNs1mtPHXpKCgb4GQ+K4nQj/f07
         JW+FTOZuYee4nEjXfsS7Sf3+kFfaGVC42/IqGV4+ImG8od6162Q9wrYbGiRUEopGPX/f
         zWUoc2nwv0pXYrxgQANqg07os5BGDw9NtTbwnbSt9WsKdnzeHxlp1ISmagemJb0hp/Vw
         ZU5+li2aMGYynYLQWjMvVez8far82DHSbsW48Gj9q/KIJY0zYnp53+vN6//MOmGd3J+M
         1c6A==
X-Gm-Message-State: AOAM532CeO/mv86QNQ5Dzk0kg+5UZQZENAGirlskwDFRSK/k7JbrSKa2
        fsmZ9BYITXuildpv7olvnIOUdeKd52fjQA==
X-Google-Smtp-Source: ABdhPJwvS4THK3HaSQJTHg/7pSGrfOpGfi2vbjRLjRQmeHy/HI8EcxuTcncIvw7yHQPdd2oXyb4bNw==
X-Received: by 2002:ac8:5e4c:0:b0:2df:ed12:3853 with SMTP id i12-20020ac85e4c000000b002dfed123853mr11748396qtx.654.1646072375826;
        Mon, 28 Feb 2022 10:19:35 -0800 (PST)
Received: from [172.17.0.2] ([20.122.24.138])
        by smtp.gmail.com with ESMTPSA id e14-20020a05622a110e00b002d9d03dfe06sm7373275qty.2.2022.02.28.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:19:35 -0800 (PST)
Message-ID: <621d1237.1c69fb81.7401a.6358@mx.google.com>
Date:   Mon, 28 Feb 2022 10:19:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5032967076779703056=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [v2] Bluetooth: Scrub MGMT cmd pending queue for consistency
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220228173918.524733-1-brian.gix@intel.com>
References: <20220228173918.524733-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5032967076779703056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618815

---Test result---

Test Summary:
CheckPatch                    FAIL      1.86 seconds
GitLint                       PASS      1.04 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      41.34 seconds
BuildKernel32                 PASS      34.81 seconds
Incremental Build with patchesPASS      48.61 seconds
TestRunner: Setup             PASS      614.96 seconds
TestRunner: l2cap-tester      PASS      17.24 seconds
TestRunner: bnep-tester       PASS      7.98 seconds
TestRunner: mgmt-tester       PASS      129.60 seconds
TestRunner: rfcomm-tester     PASS      10.36 seconds
TestRunner: sco-tester        PASS      10.00 seconds
TestRunner: smp-tester        PASS      9.84 seconds
TestRunner: userchan-tester   PASS      8.10 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.86 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2] Bluetooth: Scrub MGMT cmd pending queue for consistency\ERROR:RETURN_PARENTHESES: return is not a function, parentheses are not required
#319: FILE: net/bluetooth/mgmt.c:7986:
+	return (pending_find(MGMT_OP_SET_LE, hdev));

total: 1 errors, 0 warnings, 0 checks, 223 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12763596.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5032967076779703056==--
