Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D720AC001DE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 20:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjHIUPG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjHIUPE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 16:15:04 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3AF10D4
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 13:15:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40fda409ca7so783991cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 13:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691612103; x=1692216903;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M2iCrVC22yJ+rihQbd2rk4MI6c4+Wsy2+JdcFujwxYk=;
        b=UFrOqyidXMa3QsG6FciAEJB+IFrK7v86pJU9uaieFqMSKo7iMVF9JY+KXLnH3xmYcv
         22S4jhm/+58rXlXlMuw733w2vhDA6FcF9e/sVHjUYF+rURstV/7PXxMTS5lhVBKLuNw5
         N1+iLR/vjqZm3C4XrCaP7Dfx1gCDLPthP3ZfXl+75lowK4TkPZGF2xhbl1jZoOFoUN+p
         /7z0vie7c+ngs2IG3FP6zFQpqy33Sd1IHe5I+6wDLYWzwbGPKdDguivS/t4to+nAhM5H
         HWAfYJyXelnBmzeiUbXhpl/yV8laN+aBnvO1WPcPCnIeAolPCc5r10AZJNrSGBoiMWN+
         Y6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691612103; x=1692216903;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2iCrVC22yJ+rihQbd2rk4MI6c4+Wsy2+JdcFujwxYk=;
        b=T6nRwszlMIRj5QVXlo66tYeNO1tskujZ2yb7gkbNppfGlUXPD5lxNvQrmmA58VqcIa
         ljFN52/+TWn8mVDZqJSXxoZI6UWWUyRQbUtvpeDvrm100sDihxOqFZWgWVYGCu081RC1
         jKyrAodBWliMRWflbl6YJjYP8Xwtr/rBPuO9zFhtqkSYn6PU40Ax2KmlN3kpqgMiG9Hk
         22wKPuHlA2jhjAprqWEXijoWEUSX8bj7wnYZbwJINseEYmePH2rqvK1J5cTgmOXBWA8k
         QxXc5BCO1uHwj13Lnpy8hWU4sOZimY0jqqD37Ftkx+Wcm+nTBiEj3G63nAn0ptKaqCSI
         x9gg==
X-Gm-Message-State: AOJu0Yx7bgrNX50D8n+QH8syWyItRVYMpR1G2nxarFNZbyKkke/J0t7Q
        6jwJzXJyEpGALWBLlq/6LVzWQKE+sq0=
X-Google-Smtp-Source: AGHT+IGy31rfsg30NGE6t6BCtWVxKcK9LZZfAJtYib6CJu5bVfz7CSMe2cjCgJMgF1v7gJcVjDBrBg==
X-Received: by 2002:ac8:5a54:0:b0:40f:1c71:d4f7 with SMTP id o20-20020ac85a54000000b0040f1c71d4f7mr506034qta.40.1691612103019;
        Wed, 09 Aug 2023 13:15:03 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.51])
        by smtp.gmail.com with ESMTPSA id f26-20020a05620a12fa00b0076cce1e9a1csm4212348qkl.31.2023.08.09.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:15:02 -0700 (PDT)
Message-ID: <64d3f3c6.050a0220.eb916.2ab6@mx.google.com>
Date:   Wed, 09 Aug 2023 13:15:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2126443649078351959=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] adapter: wait for kernel exp features in adapter initialization
In-Reply-To: <429cbc5a4fcdb150c62cf368c928e1174016eefb.1691606987.git.pav@iki.fi>
References: <429cbc5a4fcdb150c62cf368c928e1174016eefb.1691606987.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2126443649078351959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774659

---Test result---

Test Summary:
CheckPatch                    FAIL      0.88 seconds
GitLint                       FAIL      0.64 seconds
BuildEll                      PASS      27.25 seconds
BluezMake                     PASS      971.50 seconds
MakeCheck                     PASS      12.61 seconds
MakeDistcheck                 PASS      172.52 seconds
CheckValgrind                 PASS      257.26 seconds
CheckSmatch                   PASS      343.22 seconds
bluezmakeextell               PASS      103.97 seconds
IncrementalBuild              PASS      835.52 seconds
ScanBuild                     PASS      1057.65 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] adapter: wait for kernel exp features in adapter initialization
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#90: 
bluetoothd[981]: src/adapter.c:read_exp_features_complete() 6fbaf188-05e0-496a-9885-d6ddfdb4e03e flags 0 action 1

/github/workspace/src/src/13348341.patch total: 0 errors, 1 warnings, 176 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13348341.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] adapter: wait for kernel exp features in adapter initialization

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B1 Line exceeds max length (113>80): "bluetoothd[981]: src/adapter.c:read_exp_features_complete() 6fbaf188-05e0-496a-9885-d6ddfdb4e03e flags 0 action 1"
14: B1 Line exceeds max length (94>80): "bluetoothd[981]: profiles/audio/bap.c:bap_probe() BAP requires ISO Socket which is not enabled"


---
Regards,
Linux Bluetooth


--===============2126443649078351959==--
