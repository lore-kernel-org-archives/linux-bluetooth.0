Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49DCC433ED
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Apr 2021 02:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E83260FE8
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Apr 2021 02:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhDKCm5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Apr 2021 22:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhDKCm4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Apr 2021 22:42:56 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511F1C06138B
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Apr 2021 19:42:41 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c123so5067104qke.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Apr 2021 19:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CvH4a+LBs9wU3npA9uYdYh3jZDB03nBxEx+LGp3bVik=;
        b=Cb+7Nz6Wpourq+ne6By25JKxTrr3pDGmX2FiKUVcmCfhOf6Zwtr9HgNa+tZuaE//ZG
         yXLztTBHg6TSfOZYPn0u68nCAfzJw1mKzzy/I4qDtKHpt53XHBXgwGjDbrlURJIht5Mc
         E5v7SWlIz/RiRN5qrjfZWLO68JgwYB3giICLrOFJ50oVRTO1mzbbtxYPFcK3KxdxXE85
         1vmHOY0MwxE02eWmujFwRoyTWJjJtVAWFAUfz7ca9eqdCz6ghpDm9PAcnsoCKZf8BRFa
         gcHoUD2gOLuGsZ7eIXnXJS6JVE3I5eSMCGwImzRxR+fEma3jv8LauqGlYxPXDTtWPDqt
         gvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CvH4a+LBs9wU3npA9uYdYh3jZDB03nBxEx+LGp3bVik=;
        b=DdSoGt+eaEiPqloB+LDW/WoQ/C/jU+g6GL+22FMrYE+/F9EguR5Jl4QcMS7PLVdTA+
         MMS/RD79B6EVTo5byAbc5q7t+o2F/m6XWRmMi1MbzofoINqoNNwP9ZppZzgtMySll6EU
         8lMctKwEcouM4aw5trjg3+zTTCc158RAwXQgUt/rHiNYPUgVkuvLPpEMsBxm3w9TamTl
         j7YO2QPbrWpB63l3DDeJyxXnkhWK5/8rGTlgr1O4WVs+q2diTOdh66+w0RUsAKNK8M3w
         8bxmokJL4GOsnFXOiGpzvuEQeCgsGB0f9zbnOQbZguIm1wG057TbDnvdLGdbz24GsKyg
         7HeQ==
X-Gm-Message-State: AOAM530sINCI28391WLMw6q7UMgS61mYMFVTU5tzJgG7lQpbgFQHfCNY
        PT7mrwOjQiW24yhu4UCDXF2EPYgUXTbGIg==
X-Google-Smtp-Source: ABdhPJzQ6HXtkbdPsXUk1zt0e7C3OFp9bud9qP9tPivRNzf3lKiOEJhNGcGJByNwuxndbS3iZyUV8g==
X-Received: by 2002:a05:620a:1388:: with SMTP id k8mr15088997qki.387.1618108959655;
        Sat, 10 Apr 2021 19:42:39 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.135.102])
        by smtp.gmail.com with ESMTPSA id f14sm852930qka.54.2021.04.10.19.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 19:42:39 -0700 (PDT)
Message-ID: <6072621f.1c69fb81.99f4c.50c8@mx.google.com>
Date:   Sat, 10 Apr 2021 19:42:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6378104048402607207=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, curtis@maves.io
Subject: RE: [Bluez] Select either notifications or indications, not both
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210411011730.31780-1-curtis@maves.io>
References: <20210411011730.31780-1-curtis@maves.io>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6378104048402607207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=465019

---Test result---

Test Summary:
CheckPatch                    FAIL      0.29 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      47.10 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.11 seconds
Build - Make                  PASS      205.52 seconds
Make Check                    FAIL      10.01 seconds
Make Dist                     PASS      13.21 seconds
Make Dist - Configure         PASS      5.40 seconds
Make Dist - Make              PASS      84.23 seconds
Build w/ext ELL - Configure   PASS      8.42 seconds
Build w/ext ELL - Make        PASS      192.19 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
Select either notifications or indications, not both
WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#29: FILE: src/shared/gatt-client.c:1599:
+		else if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_INDICATE)

- total: 0 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Select either notifications or indications, not both" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - FAIL
Desc: Run 'make check'
Output:
./test-driver: line 107: 28304 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[3]: *** [Makefile:9811: test-suite.log] Error 1
make[2]: *** [Makefile:9919: check-TESTS] Error 2
make[1]: *** [Makefile:10313: check-am] Error 2
make: *** [Makefile:10315: check] Error 2


##############################
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============6378104048402607207==--
