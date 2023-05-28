Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482A1C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 09:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjE1Jfg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjE1Jff (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 05:35:35 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3971B9
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 02:35:32 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-38dec65ab50so1425952b6e.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685266532; x=1687858532;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pxBM46diqFVlPOWeyG/4gKjhq+qvJvgyQFv1VjUT7Qg=;
        b=U+HERZSGI3dS4ofMpaVarT1MvStLWFWBUM5Ib2G5Bsv43I6WogNXAi8VFpN+0G25PG
         2kkoaUZEu3kVAjV3bLXmQERIiK1g2G4XnQ7/HJSkarYSMCQ1vCTIs1KDdqiEIHIv7Lii
         Ng478JyXhaBOK4anWCgVmSjfilICOuYQB+vdOQIASCx4E5a3mBQpXymhua+T5v0PXPX8
         OGOrE1Q85cWA8JppK/FbOPh0Irwl6LNrnCSDoNTcEeQsNE9U+5jy2B6V00G2KUlkQZk2
         IAvzL5cHonhunmkrtla3BLbKjKmD4uwKnOG3f4TyHFqjJGLgfuNpQ8VdQTgG92Ocb63P
         6h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685266532; x=1687858532;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxBM46diqFVlPOWeyG/4gKjhq+qvJvgyQFv1VjUT7Qg=;
        b=Sws45rjfGrZ+fX7WQT3ANYUgcHueWWJqwIEbs1ErQclBWOV/g0cr5FdPKme2kP7cTn
         bT+zX9l77IybBe2RcbNK4KihDi2QfdoU1Ahb/xTsn0KkUE26pMwABvqv2HpH9JzaWhes
         BkLgOTYIInGSUsLkXASuNwU2y/IFNRDnE561yjN0keneuDbL4ltmNkS4vnfpVp8yJ12l
         qNx8PQ2UrOFYho4goXaYshSsBFtOi52LKWxyklyDlNPQiMMJ1e0RnFwP+fEPP7qoEK7G
         TlBJlA2JeIr1C650iNPxUD3mtq4vWVzY3WeBCl68Uhv7DZpBYV2Kfox7F1s6f938lbsm
         4pRQ==
X-Gm-Message-State: AC+VfDxCISh27jEe5SOmoMNoWIv32E/hTsnIgq29MrkJROyoldVujeuY
        pQGh37jWK6n9QTBMpStHTxKSISI7EDw=
X-Google-Smtp-Source: ACHHUZ43WrQYUUdu9V8QPKD/zHpTpnkpyIBA20+FxqXzadsdB/4T60GS9ErLPiiWMZjy+u+1Ce1H1g==
X-Received: by 2002:a05:6808:1411:b0:398:f48:eaf with SMTP id w17-20020a056808141100b003980f480eafmr5055553oiv.26.1685266531919;
        Sun, 28 May 2023 02:35:31 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.182.65])
        by smtp.gmail.com with ESMTPSA id r2-20020a4aea82000000b00552502f3ae1sm3152044ooh.39.2023.05.28.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 02:35:31 -0700 (PDT)
Message-ID: <64732063.4a0a0220.add82.f2d7@mx.google.com>
Date:   Sun, 28 May 2023 02:35:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3689453344405158867=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] battery: Check interface before getting property
In-Reply-To: <20230528074445.694554-1-arkadiusz.bokowy@gmail.com>
References: <20230528074445.694554-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3689453344405158867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751640

---Test result---

Test Summary:
CheckPatch                    FAIL      0.74 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      33.90 seconds
BluezMake                     PASS      1196.98 seconds
MakeCheck                     PASS      13.52 seconds
MakeDistcheck                 PASS      195.72 seconds
CheckValgrind                 PASS      319.77 seconds
CheckSmatch                   PASS      439.07 seconds
bluezmakeextell               PASS      131.39 seconds
IncrementalBuild              PASS      1032.03 seconds
ScanBuild                     PASS      1401.45 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] battery: Check interface before getting property
WARNING:TYPO_SPELLING: 'manger' may be misspelled - perhaps 'manager'?
#84: 
This change will allow client to implement only one object manger for
                                                           ^^^^^^

/github/workspace/src/src/13257782.patch total: 0 errors, 1 warnings, 39 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13257782.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3689453344405158867==--
