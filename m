Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0DCC636D4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 23:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBOXw0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Feb 2023 18:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOXwY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Feb 2023 18:52:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D532E80D
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 15:52:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w14-20020a17090a5e0e00b00233d3b9650eso4027523pjf.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 15:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fpwKA5jMLFJitYZaZL+U1JipDw6Arb0g9hfUF8TD/JA=;
        b=E47/xHc2QrvDfoRDswwf7w7VWoJYBkZNvsFTsoMR/q5z7SBH7YSnDtM5tV6GVtI22n
         kgjAEp/ywtJTYyH3kaIy96yBoRkw8DNM5dPivvNysTlge/aC3FiKFTvsDeB8D9HU9DLo
         QfJ2PKesErWCYgPN207BUzaidIu63OZ5waDJVvFHwLWyjMstyyJhFEId4UNdq9mOGxKV
         c7hn5TWq7fs8cRfWwN5Ln6TE2r48WhYCBWEAJe/jcu1CfEmA/30PMNVFr6mEOQmA34PT
         PY5u7Zhp/Lmr4wAuROS7sQzV9rBEoqnqbB1Srf+87kIt3B08Mty+He8gresGR1naDnMx
         MhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpwKA5jMLFJitYZaZL+U1JipDw6Arb0g9hfUF8TD/JA=;
        b=b8IJsfeq0bUwm9ais0rJ1JjmTHJs1XrNiGs0l5evPBUcJpTO40ssKeZTqLsrxeLWeH
         WAYJXqXBHwKgu5se/VBCuTM7lfvOvbtgbmz0RNbfF1kyXlP1pP8zobeBrnvTkog9o0uI
         u2uBkalmT9hftvJvHMylk2jmfHpKr6eCMH+E7jJntzEUVkUC7XZ9jNRJAS4+w/3bVOQK
         0hdSHADv4BQw0TjNpo0IX8wrxm0850I6Qt5pBJm3Jh9dirGm9M9QMFr/mKbIIglOTs93
         CPEuQlzwzxVQCBVir6ZOFvnfI5YuBsRZxy60osJKMBxHkO4W3frcGE0BLKNYD3ST0U0n
         yCjg==
X-Gm-Message-State: AO0yUKWPabeHGbtLKjSXjLruositUG8/1v8bUge8zWJD2C0dV7tNzLOs
        E+S78+EhsseQVz8GPD9FnEzIRZBCtCk=
X-Google-Smtp-Source: AK7set8IN6/rexboekU6kPRZhPanL0ZgrS3qtilUJHYcUx0cpDUJZe1NJFGbG8j1x3TNGEARh7NGwg==
X-Received: by 2002:a17:902:d4cd:b0:19a:a6c4:6403 with SMTP id o13-20020a170902d4cd00b0019aa6c46403mr5238038plg.1.1676505142362;
        Wed, 15 Feb 2023 15:52:22 -0800 (PST)
Received: from [172.17.0.2] ([20.171.63.114])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902e8c500b0019a8283f272sm8983859plg.81.2023.02.15.15.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 15:52:21 -0800 (PST)
Message-ID: <63ed7035.170a0220.bffb.077d@mx.google.com>
Date:   Wed, 15 Feb 2023 15:52:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1712339924702688298=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/3] audio/transport: add media_transport_get_stream method for transports
In-Reply-To: <f973ae1e4b2c07902f98a6e7776b44bef25670be.1676499415.git.pav@iki.fi>
References: <f973ae1e4b2c07902f98a6e7776b44bef25670be.1676499415.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1712339924702688298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=722269

---Test result---

Test Summary:
CheckPatch                    FAIL      1.41 seconds
GitLint                       FAIL      0.98 seconds
BuildEll                      PASS      26.48 seconds
BluezMake                     PASS      754.93 seconds
MakeCheck                     PASS      11.39 seconds
MakeDistcheck                 PASS      147.58 seconds
CheckValgrind                 PASS      241.93 seconds
CheckSmatch                   PASS      318.98 seconds
bluezmakeextell               PASS      96.52 seconds
IncrementalBuild              PASS      1841.66 seconds
ScanBuild                     PASS      962.98 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,2/3] media: look up BAP transports by their associated stream
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#80: 
    #0 0x7f16708b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)

/github/workspace/src/src/13142251.patch total: 0 errors, 1 warnings, 78 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13142251.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,3/3] media: fix ASAN crash in pac_config_cb
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#67: 
    #0 0x7eff644b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)

/github/workspace/src/src/13142252.patch total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13142252.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/3] audio/transport: add media_transport_get_stream method for transports

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[BlueZ,v2,1/3] audio/transport: add media_transport_get_stream method for transports"
[BlueZ,v2,2/3] media: look up BAP transports by their associated stream

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
48: B2 Line has trailing whitespace: "    "
53: B2 Line has trailing whitespace: "    "
[BlueZ,v2,3/3] media: fix ASAN crash in pac_config_cb

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
34: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============1712339924702688298==--
