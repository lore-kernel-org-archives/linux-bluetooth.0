Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE4C41513
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 04:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjG1EIq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 00:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjG1EIP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 00:08:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BC130EA
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 21:08:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso1606784b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 21:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690517293; x=1691122093;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=luEVQ91JY89zk7omC5oaT7lM+afRX0yz38/xOHRQf+8=;
        b=rsWSPGSON8Jnl0ufEd5MZTnYRxXLCIFpxbwONfIAeF/gKPtx2SCGpKawISDLz7arEV
         F19mCY4GSL2hH/dSWlaBvai7Zte1/pTXnZRgRoJ8Wy3b2pSwgeU9+PmpVK4nmSZ1fB5L
         CNdhsiveGELtuWYaCeW48tSDF6XLOxOgiq6HRjGeMOgn8ouPKAp0/4McGYuJU5kS9NCS
         /GSLtDAatPzmAokROl0iYNObSAraW3TaO8IO4gfMChX3VYkKUc9SCCSIAOo12ZnDyAb+
         yq3DAelSSYZnqvxo1f5UzjNHtEWz0Aqd3zo77A/xa/otMEJ3p8bTWzIQ+Rpq/gvHOpFV
         trbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690517293; x=1691122093;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luEVQ91JY89zk7omC5oaT7lM+afRX0yz38/xOHRQf+8=;
        b=AWHrEPvD1PAyQtJ1uwjux+vbrUO34Tt2mdhgGCdTrYahT8ucnRtfrtlmD1hQWGCE4j
         wW43GcU6l1JvVNv58jEb5+tocQfYTOQW07zDTPugdbW/g+fwJLU2wFl866JNfuRbOVey
         r9nxkizp2QJrloJGSV3yxTiYrdljvZ9S39n6vDpkWaXYLoX8VnYdhCX1cswXldY35iWe
         DviSLK0kf+JC/4V2X+z/dOLM0VhUfUgorjmBIN9zt2MAO9kYOOM0XruTeILuhWu9fR8K
         /7m/Qj74HWvgXHB2HkMdLLde/HicIQ5E4qkhgK53eGTjXtwuDJAm1FtFCODg3hM7ABsJ
         raiw==
X-Gm-Message-State: ABy/qLb8BbwK/83pwUqtTRFD+o5/+S3FoX891o4sHuHkiLYarOGg+qzv
        u8CvFEyvidgjJEO2I7n0aoiUT2xT3p4=
X-Google-Smtp-Source: APBJJlE4nQ0sFpj4i4Fn/bLAlGniJehMrh8jveHIK7B7g0DhoDh/pg0W00X7Al/hdn5hQTfYzRvpuQ==
X-Received: by 2002:a05:6a21:47c7:b0:137:a3c9:aaa2 with SMTP id as7-20020a056a2147c700b00137a3c9aaa2mr748726pzc.30.1690517292878;
        Thu, 27 Jul 2023 21:08:12 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.178.114])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79111000000b0064f76992905sm2185760pfh.202.2023.07.27.21.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 21:08:12 -0700 (PDT)
Message-ID: <64c33f2c.a70a0220.df0d3.47cc@mx.google.com>
Date:   Thu, 27 Jul 2023 21:08:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1316508460966096745=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yuehaibing@huawei.com
Subject: RE: [v3,-next] Bluetooth: Remove unused declaration amp_read_loc_info()
In-Reply-To: <20230728033011.12096-1-yuehaibing@huawei.com>
References: <20230728033011.12096-1-yuehaibing@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1316508460966096745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770377

---Test result---

Test Summary:
CheckPatch                    FAIL      1.14 seconds
GitLint                       FAIL      0.51 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      46.08 seconds
CheckAllWarning               PASS      50.01 seconds
CheckSparse                   PASS      56.71 seconds
CheckSmatch                   PASS      150.92 seconds
BuildKernel32                 PASS      44.04 seconds
TestRunnerSetup               PASS      666.49 seconds
TestRunner_l2cap-tester       PASS      33.05 seconds
TestRunner_iso-tester         PASS      84.52 seconds
TestRunner_bnep-tester        PASS      15.39 seconds
TestRunner_mgmt-tester        PASS      268.37 seconds
TestRunner_rfcomm-tester      PASS      23.46 seconds
TestRunner_sco-tester         PASS      23.12 seconds
TestRunner_ioctl-tester       PASS      26.15 seconds
TestRunner_mesh-tester        PASS      20.02 seconds
TestRunner_smp-tester         PASS      20.42 seconds
TestRunner_userchan-tester    PASS      16.26 seconds
IncrementalBuild              PASS      42.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,-next] Bluetooth: Remove unused declaration amp_read_loc_info()
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#52: 
This is introduced in commit 903e45411099 ("Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc")

total: 0 errors, 1 warnings, 0 checks, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13331122.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,-next] Bluetooth: Remove unused declaration amp_read_loc_info()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
3: B1 Line exceeds max length (95>80): "This is introduced in commit 903e45411099 ("Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc")"
4: B2 Line has trailing whitespace: "and never be implemented. "


---
Regards,
Linux Bluetooth


--===============1316508460966096745==--
