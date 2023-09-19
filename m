Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47878CE79A9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 20:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjISUeg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 16:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjISUef (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 16:34:35 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E9993
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 13:34:29 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34fdadf3f7aso9521255ab.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695155668; x=1695760468; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gI0JtyXjDGc3kfUvj93eh2Dze4hFKzgVAN5ODvM3XwI=;
        b=DZ7iofsifyYCKJKhaJ8oy1d3QxnF7P3oXUrQS00Z1dd7RkMOIwejQ06i2rHomrld3v
         wsVLfhKPyG+m8CUxVONZQX9h3YWstpM24n3FIBqLmwkDd7NX4sfQ6GtyGWjC/6wM4YaB
         KnKuT6XwCWFZbqZoIwGfiXweT9EPhHqkRHudwQO94sI+sk2IR7B3S9IpS0uucqNLuS1r
         UBR+Ju8ssl8N+DNCg2CC9H+ecG5mzzYUZoL3k/PVdCgIqLtpVZJt9Lxtmf1tfq4SuHX2
         6l4jkEczmKzuZGHBtWd0oZ9yueY4dMgdeR4Yiij10pWyrtGSbCVw1HrnQj2ck4ySNNKm
         18Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695155668; x=1695760468;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gI0JtyXjDGc3kfUvj93eh2Dze4hFKzgVAN5ODvM3XwI=;
        b=rae/3zYZ90bMRvqcm/eFfl5oh5Ov3JPYPFbcPH3SYFyLAYONwHR2vY5WPrxN+/YtJ9
         3dTID6zymbyB1TWG1vG/yEDEk1+GfRrm6dNhObeLWTMOZw/BZKdAfN5R1/LS/Zd/YEbG
         SYz+XSnkjjqJFtYimU4NvdOoC+luoz6BnHKhqTZ1QLeyDjfKxTiZVzcqh/g9+wNucw3y
         jfbf8dj5WM43m8CovYC/S9STRcK1pdN2JmA26OwlWMxv3/BUaWlC8v0KQ+wnExGbZfjb
         aanWerNFy+vJ0X8n0NbX/DRJYx5JIZwgzIKg48hNv/KyyqVjZZxiRQO6IEwRODfyVpLb
         qyMg==
X-Gm-Message-State: AOJu0Yw8CkdvkXbSmIi+y/dYLBD0SdLhIy44auP98j14NeVrS9PgLNlv
        oZ0JtA26SPkF+RDfDDkNdhidGl+mF2o=
X-Google-Smtp-Source: AGHT+IEzQxeZehQf4Q+UYktKSBSxvjTp0QsSsHuWl5nBNVOziCzBKxPEiLo6Gd51JqP16JlgKFf75w==
X-Received: by 2002:a05:6e02:1c89:b0:34c:ceaf:b627 with SMTP id w9-20020a056e021c8900b0034cceafb627mr933614ill.29.1695155668631;
        Tue, 19 Sep 2023 13:34:28 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.143.104])
        by smtp.gmail.com with ESMTPSA id j14-20020a02cc6e000000b0042b16c005e9sm3742673jaq.124.2023.09.19.13.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 13:34:28 -0700 (PDT)
Message-ID: <650a05d4.020a0220.5b15b.4b5b@mx.google.com>
Date:   Tue, 19 Sep 2023 13:34:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2080573002386608243=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] pbap: Fix not checking Primary/Secundary Counter length
In-Reply-To: <20230919191401.311236-1-luiz.dentz@gmail.com>
References: <20230919191401.311236-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2080573002386608243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=785720

---Test result---

Test Summary:
CheckPatch                    FAIL      0.64 seconds
GitLint                       FAIL      4.97 seconds
BuildEll                      PASS      27.65 seconds
BluezMake                     PASS      783.26 seconds
MakeCheck                     PASS      11.51 seconds
MakeDistcheck                 PASS      157.96 seconds
CheckValgrind                 PASS      253.66 seconds
CheckSmatch                   PASS      348.02 seconds
bluezmakeextell               PASS      105.39 seconds
IncrementalBuild              PASS      669.97 seconds
ScanBuild                     PASS      1040.56 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] pbap: Fix not checking Primary/Secundary Counter length
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#91: 
     #0 0x7f95a1575637 in MemcmpInterceptorCommon(void*, int (*)(void const*, void const*, unsigned long), void const*, void const*, unsigned long) ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:860

/github/workspace/src/src/13391785.patch total: 0 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13391785.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] pbap: Fix not checking Primary/Secundary Counter length

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B1 Line exceeds max length (231>80): "     #0 0x7f95a1575637 in MemcmpInterceptorCommon(void*, int (*)(void const*, void const*, unsigned long), void const*, void const*, unsigned long) ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:860"
15: B1 Line exceeds max length (130>80): "     #1 0x7f95a1575ba6 in __interceptor_memcmp ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:892"
16: B1 Line exceeds max length (130>80): "     #2 0x7f95a1575ba6 in __interceptor_memcmp ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:887"
24: B1 Line exceeds max length (99>80): "     #10 0x7f95a12fdc43 in g_main_context_dispatch (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)"
26: B1 Line exceeds max length (91>80): "     #12 0x7f95a12fd2b2 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)"
28: B1 Line exceeds max length (91>80): "     #14 0x7f95a10a7d8f in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58"
31: B1 Line exceeds max length (97>80): " 0x607000001878 is located 0 bytes to the right of 72-byte region [0x607000001830,0x607000001878)"
34: B1 Line exceeds max length (106>80): "     #0 0x7f95a1595a37 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154"


---
Regards,
Linux Bluetooth


--===============2080573002386608243==--
