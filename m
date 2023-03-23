Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E21C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 11:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCWLsn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 07:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCWLsn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 07:48:43 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA2A25BAB
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 04:48:41 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o44so10995374qvo.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 04:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679572121;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kAEODpuNOi+aoNlvI8IECUiC5JKDJHmkacEK+/ryj+I=;
        b=dvdpMe/2mM1G3vZnGwemJ+H9Q1UxAkelYBwtIcyoXPAmLc2ul/apUNabgsjUxN3Kwz
         lOJeUXq7vZfkFaAJ916DKgFGtFFjK/aVUe/NuywW8ewRv7+HjxQxyQf9ERS1MMeeLz29
         d2PjG6/DJLr/XjRKnwMM+PiQgrVJlXNq61GTu+1Re3b89JanOYsPqzZ5S4O9hhFONoWn
         vlmC1p05mf6DkPNGBMWhu14j9QQ6LGbQNTqikuKUnxHJoXfwfwzvE3++VdNKRQV6Ty6T
         zQgKxTI4lmg1wljYGciaHv0jV2fKWnm5Bam1ikT3AuLPckOY4gkyO9C/BBIT3gvElR93
         cuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679572121;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAEODpuNOi+aoNlvI8IECUiC5JKDJHmkacEK+/ryj+I=;
        b=dff14KhpZTOnV0tWbdr2c/ydhHP/VrittON0FhKtTkupjJAC9z8cdhpS/hlWDriL/U
         jnYljGF0Dri993MPKlyJ8WglF1KEMccJzPujRVUh4YXnFo8EGNDweNACW5NMxaVG494f
         VWM9hEFxqfa/aYoBnibaEqGK2B2qw+09hDsIUxE5LPsCitjycML7gNACwVQo+Cn6YfZp
         gV/2SrEwj1txml+znQKZKmIYsOBLSlvH44vdf2A3nWzrIIOIoPbEbbS06k4+GL77R+Qn
         CJVhTFP0BPoMgsyivHJFlUjNfKF+W/9gvCdl3ngDaEsk9WkeunA/XNna3DY8AaVFPGxR
         O1HA==
X-Gm-Message-State: AO0yUKX1R75d5juiSKodSpXUsi90HJqGrjH9ECQK9ppYbPO5CuYHo6ly
        QUMSTY9SH8E2mgqB0EEmFBZp0LUwQXM=
X-Google-Smtp-Source: AK7set9QjhSsE2PnVfhUkqCrLJHkydT9t3QvAsFE/QSMy9mF4Hm202CYCJCEvR1IB6tze6M+m0ROXg==
X-Received: by 2002:a05:6214:19e5:b0:56a:d94d:6deb with SMTP id q5-20020a05621419e500b0056ad94d6debmr11109390qvc.25.1679572120839;
        Thu, 23 Mar 2023 04:48:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.18])
        by smtp.gmail.com with ESMTPSA id x17-20020a376311000000b00741a8e96f25sm2587620qkb.88.2023.03.23.04.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 04:48:40 -0700 (PDT)
Message-ID: <641c3c98.370a0220.20fbd.b103@mx.google.com>
Date:   Thu, 23 Mar 2023 04:48:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8518774798494164506=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: monitor
In-Reply-To: <20230323102858.566934-2-simon.mikuda@streamunlimited.com>
References: <20230323102858.566934-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8518774798494164506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=733108

---Test result---

Test Summary:
CheckPatch                    FAIL      1.28 seconds
GitLint                       FAIL      0.96 seconds
BuildEll                      PASS      27.11 seconds
BluezMake                     PASS      867.28 seconds
MakeCheck                     PASS      11.16 seconds
MakeDistcheck                 PASS      150.36 seconds
CheckValgrind                 PASS      245.68 seconds
CheckSmatch                   WARNING   328.41 seconds
bluezmakeextell               PASS      98.55 seconds
IncrementalBuild              PASS      1441.30 seconds
ScanBuild                     PASS      1013.20 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] monitor: Fix printing Signed Write Command
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#81: 
        Handle: 0x006f Type: Vendor specific (f7debc9a-7856-3412-7856-341278563412)

/github/workspace/src/src/13185462.patch total: 0 errors, 1 warnings, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13185462.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/2] monitor: Fix printing Signed Write Command

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B1 Line exceeds max length (83>80): "        Handle: 0x006f Type: Vendor specific (f7debc9a-7856-3412-7856-341278563412)"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8518774798494164506==--
