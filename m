Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9447C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 06:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B941613C8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 06:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhEGGsh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 02:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhEGGsg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 02:48:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF4C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 May 2021 23:47:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lp4so4609696pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 May 2021 23:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YNajHgnzo5wKXb9iuy70o1RVcijtz3IMMe8CErLwgpw=;
        b=JZfs9gLzrP0tjHRibZQZIhJg5gR0fUYPYC9Rhn/msky6i0qDcojgJRVGdWpS61OV34
         x2LXiX8MAKkMLYAnCRVY1YbuQfyYZ7pTUpWPwDKfVSaTwkmzrHjaKrM4lkd+sBK1eBX+
         +uwSeIwcm3ElRtffJkkOLd6jlDZHFC+Unf6ZFXIN0hBxVovERo5/5841UKehGt90MWPw
         KtF4OWW1nHfgx/xOqpzV0HaHfMejTBCQRxvAPbH6CjUBLHMC/rhcWVDUV71MXbk8FxOV
         KrZpWCiVO1ZwmIohz/XuVeFi8bwAuntRGHfm5qTpc0W5XbsoGwW2RDh7/xcm4RiRW0qB
         JAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YNajHgnzo5wKXb9iuy70o1RVcijtz3IMMe8CErLwgpw=;
        b=HwilK310+f7+Cb7TVNOdPpeXrQbnrQ3ucQEu0j96pHGpzUct+ZqVBDBACJhkGREr/3
         v7Sn1tWMLtlTH+BABdrGLiGx9aUxeoSl9MCgUml9fw39koBHOsMv2gxrDgIHcrWyzt8+
         SllJu2FWhAbgkdLhY2qqlW36tuN652OYA0G8QQy1QO9xHLJVpOfp97fEM8sKWz/yzJ5+
         Sk1bz+ZdBNUVFeNSAZWZkv7KirBr/9TsvKxouQwTqnd7hgUN07ioyiUKXE9nyaS9d6th
         yvq+fyBu1iCzm2d+CPUUA+DFY0/qCKeEo8zk5aq15XTsmtNdst1sJWGVX74gBZfqnGp1
         rf2A==
X-Gm-Message-State: AOAM533nruO5ks2UIDvSGPNTDv0NuOIbP1O5z4Q+NTijt5UuUcLk+lGt
        L0wqP2QpPmG2XB0oyKME9EUUc/scgpY=
X-Google-Smtp-Source: ABdhPJyQL6uTC8BMktFg+TTPk9yDfQ0L4nplszG53x73wHOgYTN/6tzdH1/8kg/AYS0e7sdtClYEpQ==
X-Received: by 2002:a17:90b:1b03:: with SMTP id nu3mr21714678pjb.62.1620370056995;
        Thu, 06 May 2021 23:47:36 -0700 (PDT)
Received: from [172.17.0.2] ([51.143.95.70])
        by smtp.gmail.com with ESMTPSA id z18sm3818941pfa.39.2021.05.06.23.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 23:47:36 -0700 (PDT)
Message-ID: <6094e288.1c69fb81.de8db.bdb7@mx.google.com>
Date:   Thu, 06 May 2021 23:47:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1516034128688389912=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Convert tester tools to use ELL
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210507055629.338409-2-inga.stotland@intel.com>
References: <20210507055629.338409-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1516034128688389912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=478219

---Test result---

Test Summary:
CheckPatch                    FAIL      6.11 seconds
GitLint                       PASS      1.32 seconds
Prep - Setup ELL              PASS      49.74 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.71 seconds
Build - Make                  PASS      205.50 seconds
Make Check                    PASS      9.41 seconds
Make Dist                     PASS      12.95 seconds
Make Dist - Configure         PASS      5.34 seconds
Make Dist - Make              PASS      82.53 seconds
Build w/ext ELL - Configure   PASS      8.54 seconds
Build w/ext ELL - Make        PASS      193.98 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
shared/bttester: tester framework wrapper to use ELL
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#80: FILE: src/shared/bttester.c:51:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#85: FILE: src/shared/bttester.c:56:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(1, 2) over __attribute__((format(printf, 1, 2)))
#336: FILE: src/shared/bttester.h:22:
+				__attribute__((format(printf, 1, 2)));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(1, 2) over __attribute__((format(printf, 1, 2)))
#338: FILE: src/shared/bttester.h:24:
+				__attribute__((format(printf, 1, 2)));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(1, 2) over __attribute__((format(printf, 1, 2)))
#340: FILE: src/shared/bttester.h:26:
+				__attribute__((format(printf, 1, 2)));

- total: 0 errors, 5 warnings, 317 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] shared/bttester: tester framework wrapper to use ELL" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

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
Test: Make Check - PASS
Desc: Run 'make check'

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


--===============1516034128688389912==--
