Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00FDC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 09:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiGUJHI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiGUJHH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 05:07:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A9F3B944
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 02:07:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b10so998094pjq.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7Oot2FEHxE+6jDIkcA+Hhg8tHdpSsGd2pZ5aN+mnqZ4=;
        b=K1086hwujIa5vQ3Vf8AzE4ff7eY8m5+lRQyea/jAWI7OGy3gbIThd5DcLWSkk2XLAX
         SKWVTS6rUt2XHCOX415r7Sh+wuWP1XX4SU/14mpzQkGYBBTVT2Sb0LdKIP8cK9QWwUBm
         EJbMXRjNBAT6PEYfgC/+UN9mb8+2Xl2OYLVP71mB4TR6IA4c/DO90COmMRh9o2t5sdgC
         iOERLu2G0O6Hu2QuS4WYOYw8QxwmhTYDzAnlfcFsV/WXfdd8EkqUyVu3rbozDA5lClHL
         Eq1fvWYYRe9FgG+fCMr5kA30Rt8hFsM+7c1egLbRwt4X1sPJXLyjitHbJBmKw6UQb8mG
         Kadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7Oot2FEHxE+6jDIkcA+Hhg8tHdpSsGd2pZ5aN+mnqZ4=;
        b=ry81QYJUFCW1x1iKwRFnjjbDSSIfa1OD297sdz+3FUSHEceT3MWb0nUGVsvIw90jfh
         UtFCvcWu89ySPLQvgOVDqdL46InsHHugPEiDelVuJJ/CEGjNZcjdlPjZyBjLPGEDHxmL
         hzq8GRdVjOCYDjlmTA450JkC5NTDLDA643qVLl29KZawXjoEQ07fIiC70VGQwuclwVuF
         MnN9JPONJPc3QD8dL02f3UaHhi9e++9p/97u+xGCyJdFrEr1Z5FJQUHGsPy9DWe6rOwW
         /kZp4J4ciRcJNsgHzu9Em+ScwAWeOCfYJuCpj1QpxJCNjhrexcc9I0hGh5R8hqSYoXQM
         OSUQ==
X-Gm-Message-State: AJIora99ZBPYh6+oPgyDVLTfJpq/jr5bbXmMxiWkGc3ek1UJWoJZ/utd
        xGDu/rHr2xHiSLvOEFfNgT2QgVKc0+s=
X-Google-Smtp-Source: AGRyM1t+oZQKZWkvgaHxxViZbREemnZ19pw1SSqJLI2/KozaiIEq5UOz6pFg4fh36fPb1JIxiB+q3g==
X-Received: by 2002:a17:902:dc81:b0:16c:7132:cc57 with SMTP id n1-20020a170902dc8100b0016c7132cc57mr43404184pld.87.1658394422992;
        Thu, 21 Jul 2022 02:07:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.182.19])
        by smtp.gmail.com with ESMTPSA id y184-20020a62cec1000000b0052ab912b0fasm1188344pfg.2.2022.07.21.02.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 02:07:02 -0700 (PDT)
Message-ID: <62d91736.1c69fb81.06ce.23cc@mx.google.com>
Date:   Thu, 21 Jul 2022 02:07:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7217178794236141617=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michal.lowas-rzechonek@silvair.com
Subject: RE: [BlueZ] mesh: Set global bus earlier
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220721080331.790277-1-michal.lowas-rzechonek@silvair.com>
References: <20220721080331.790277-1-michal.lowas-rzechonek@silvair.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7217178794236141617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661746

---Test result---

Test Summary:
CheckPatch                    FAIL      0.76 seconds
GitLint                       PASS      0.53 seconds
Prep - Setup ELL              PASS      31.33 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      10.05 seconds
Build - Make                  PASS      772.96 seconds
Make Check                    PASS      11.92 seconds
Make Check w/Valgrind         PASS      295.51 seconds
Make Distcheck                PASS      251.78 seconds
Build w/ext ELL - Configure   PASS      9.79 seconds
Build w/ext ELL - Make        PASS      87.49 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      507.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] mesh: Set global bus earlier
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#98: FILE: mesh/dbus.c:24:
+static struct l_dbus *dbus = NULL;

/github/workspace/src/12924841.patch total: 1 errors, 0 warnings, 43 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12924841.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7217178794236141617==--
