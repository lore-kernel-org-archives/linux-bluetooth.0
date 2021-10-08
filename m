Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715CFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 06:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C9061042
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 06:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhJHGoD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 02:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhJHGoC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 02:44:02 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0866C061570
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Oct 2021 23:42:07 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id k3so5749620qve.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Oct 2021 23:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=v2rdRIKeap3avYkAvV60zmywBti0IETPvx2nf1kpkVA=;
        b=dzN+yt9rgdkGyP6ssPavwKibYuGiKM7nfceisvIxSINnTJGditZIeqOB+R/3ezXL+7
         8vXlTLTgTxaWPH2RPowwBmGXwTXDSbduaOFJYFsUMsWAApiZD1ekZ1xXwZePvuEgo86s
         JPOTPMWcPK13VnJa3rl7KB2ZZZhjqToi5LDoyzYI6ip0ZBL2rxGJk7kXi4caD/Rwmxg5
         X8aI+4ZtBtzab0SXM++MkMpt8H0sv1+YgwGeqXpQawSgLqvJ+ctMGfWd4ZLR7yDwxA+W
         yN1JM+RndMGOjDPh7N9Ptu2blDAe83Jc34Ae/8dAu2QPi0bYL3LlbkQRkqU/tHUv0PUa
         cKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=v2rdRIKeap3avYkAvV60zmywBti0IETPvx2nf1kpkVA=;
        b=ndW98B/wOD/5LGhIrCGFgfByHJ+rPZn6Op7RolL1ochRBaua2VUsFD4MX8q3ivvsTl
         x7ixFqAS9wqh2W10J3EcDytVrc/l38MGuKh3mO5wT1SQE6+eNkJ+49p6DRanZ87csyIV
         oiY30Tb2QD8dMMkqobPkCVZc7uIjzXvOGfIxBs2wT4NIzByTWBuK+Wc4qBbEorP2ppRJ
         gbFVEbivJBOmYDiG/+z35WnTrhzJia5ucNqaEGNb1xzzWr/kjXg1Yi2i1fBYXhhUgIoP
         JWPq3rprVIxV18gMbnxQ/+SIuU+JHLfNvRJ5vvvWsF04t68M58xkX6ve52uaNSCsJJ7t
         /j3A==
X-Gm-Message-State: AOAM532nDyyH97BIUDZZPVCsYM9qgjQicnOajMEjIH9Ka7tMI8opG+GG
        j0PcCor1sFg8DMxIuz0pj2Xo0VA22gJ8jg==
X-Google-Smtp-Source: ABdhPJwe62zNkKdsckSD6DgZ3Q9gnobbmpDE+VOZHo5B0JayuXkodkquDmU8GUBur9I4T5FR8VofyA==
X-Received: by 2002:a05:6214:d8c:: with SMTP id e12mr1862345qve.14.1633675326954;
        Thu, 07 Oct 2021 23:42:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.163.104])
        by smtp.gmail.com with ESMTPSA id z14sm1413729qkb.91.2021.10.07.23.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 23:42:06 -0700 (PDT)
Message-ID: <615fe83e.1c69fb81.772b0.9372@mx.google.com>
Date:   Thu, 07 Oct 2021 23:42:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5395653326679262726=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2,1/3] doc/tester-config: Enable Runtime Debugging Feature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211008054300.27989-1-hj.tedd.an@gmail.com>
References: <20211008054300.27989-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5395653326679262726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=559685

---Test result---

Test Summary:
CheckPatch                    FAIL      4.59 seconds
GitLint                       PASS      2.76 seconds
Prep - Setup ELL              PASS      49.27 seconds
Build - Prep                  PASS      0.49 seconds
Build - Configure             PASS      9.19 seconds
Build - Make                  PASS      213.69 seconds
Make Check                    PASS      9.35 seconds
Make Distcheck                PASS      253.27 seconds
Build w/ext ELL - Configure   PASS      9.30 seconds
Build w/ext ELL - Make        PASS      203.23 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v2,3/3] tools/mgmt-tester: Add more suspend/resume test cases
WARNING:LONG_LINE_STRING: line length of 84 exceeds 80 columns
#273: FILE: tools/mgmt-tester.c:12642:
+	test_bredrle50_full("Suspend/Resume - Success 9 (Discovery/Suspend/Resume)",

WARNING:LONG_LINE_STRING: line length of 84 exceeds 80 columns
#283: FILE: tools/mgmt-tester.c:12652:
+	test_bredrle50_full("Suspend/Resume - Success 10 (Multiple Suspend/Resume)",

/github/workspace/src/12544411.patch total: 0 errors, 2 warnings, 187 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12544411.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5395653326679262726==--
