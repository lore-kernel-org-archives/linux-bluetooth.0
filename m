Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDF8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 May 2022 02:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiEQCdJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 May 2022 22:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiEQCdH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 May 2022 22:33:07 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5472FFD9
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 19:33:05 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t16so13438928qtr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=0MHsGAErNX6MRT223MrhTJbEE2MkIvKdTPI59Mr0ecw=;
        b=lnxVmSxmjM9RBRja37ZGWHwAbISVQ3X/RuVrNQLXPEf2U0b5ltmM5J2QKThprC3/xU
         P4jZgC7C6D67oEHlyx98cMiEZCp4GVsSXYlNMe+R9wTb79ZqQLxp4oUIfsqBu4ODWJDc
         U95nJrqFMkaAW53baoenfnZ2Z3GD1qznxbxREuUhKKNVY10PfYL4VLNshEfif2FHrYiG
         U9woiSpeYXVqWYLZXIXF5tW65y+KgB63iBVR4rr+YWnm71azUgUZWPBKl3LsrTD8WdQ8
         HOJdhnc47wUJIhl/058sweFCvn1cPe/xjxDjCvVnenttPnDcuwpd2TE+MXdNoOTt749H
         uGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=0MHsGAErNX6MRT223MrhTJbEE2MkIvKdTPI59Mr0ecw=;
        b=G5BDFfu5fYKrXkpM65VJqsUEFN5LxhytGGsk+FvqKH4EnfjAEgiU96xbMCBD8EW0Id
         dNl7NWJ+q3vK7DW3bLzLBj5NmQ2WA2iDsNDKdnjB0SvOvRHwzNiyifKx/p8PRMTUXGxt
         giYUfJW0vhjKku7uLu6fzOKcI+dyKRw6NGi1EuSCO1v2zHfEqxebXaZUCp/LxnfdHBzq
         jUmRcLU4MmOOwQquQxQZhXEOsFedfg33hhdJSG3/4DPmdcGpSbu2Wstr3W3l/grejbh8
         LOS0iB0pdhy4zNdVUEssVzrynZTgM2qd6qaFPQgNnHpuzYbnbheuj33aAORC/hpb0WDR
         GquA==
X-Gm-Message-State: AOAM5316KRXRb10Cv9VrE/SPsnF1HKQWFD/a4rpOOODsOxs6o1oSjQlh
        TRyYoGysJaiD5DSmvPuM644r/I46frH0bw==
X-Google-Smtp-Source: ABdhPJx9p+f2fiakpQMdC/QIfoe9AVWKNHgyM+pWdvM/IqZ9Sjqs8+J35fw1JJlr+Wilw7FAw+5HRA==
X-Received: by 2002:a05:622a:206:b0:2f3:b1de:9a70 with SMTP id b6-20020a05622a020600b002f3b1de9a70mr18136601qtx.397.1652754784346;
        Mon, 16 May 2022 19:33:04 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.103.0])
        by smtp.gmail.com with ESMTPSA id d6-20020ac84e26000000b002f39b99f6bbsm6698937qtw.85.2022.05.16.19.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 19:33:04 -0700 (PDT)
Message-ID: <62830960.1c69fb81.743ca.419c@mx.google.com>
Date:   Mon, 16 May 2022 19:33:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5070629067397484914=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/8] lib: Add definitions for ISO socket
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220516221304.1744026-1-luiz.dentz@gmail.com>
References: <20220516221304.1744026-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5070629067397484914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=642117

---Test result---

Test Summary:
CheckPatch                    FAIL      14.39 seconds
GitLint                       PASS      8.14 seconds
Prep - Setup ELL              PASS      45.93 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      9.26 seconds
Build - Make                  PASS      1359.77 seconds
Make Check                    PASS      12.62 seconds
Make Check w/Valgrind         PASS      460.20 seconds
Make Distcheck                PASS      248.84 seconds
Build w/ext ELL - Configure   PASS      9.29 seconds
Build w/ext ELL - Make        PASS      1361.08 seconds
Incremental Build with patchesPASS      11151.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v4,7/8] tools: Add isotest tool
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1222: FILE: tools/isotest.c:1106:
+		/* fall through */

/github/workspace/src/12851538.patch total: 0 errors, 1 warnings, 1219 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12851538.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5070629067397484914==--
