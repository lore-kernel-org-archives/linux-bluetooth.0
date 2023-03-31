Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BFDC7619A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 02:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCaCAR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 22:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCaCAP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 22:00:15 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF89CBB95
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 19:00:07 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id jl13so15470726qvb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680228007;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5hYs5n1ITZnHkUWCSUWW48EOIg+U7lQfMmPpeHjgrU0=;
        b=I0yXqEdFdUxJtyp6P1PwKSEKl6MLjhRNGQIOg8aTMNoYpI6/AVv/bK/9K2Ghb7CoD/
         oNoePJ0fPseS0cTnJrv74uXRhER6lYArzUTLjuhN4o081zf5/fgorDFrZ2HcNjKLSagl
         bUKsG4Xotcwme+0eSfWXC/2giGHCwSzM60d9sWl70Ozu1HQO/sLTRULagsrHpNDCUfRS
         fA+1U5DoS6angFQAv9HRaNlLXuRj0WeA6fQXue2L5eVTNClXu8xDSnqMafsXu7dbFdtf
         dG8UsKUlSX1Qy64VRxQSOr7Gtt2vXHZSAq4I39Q0sWwNNVkq7NfG2+UbgHRckp/E4tYv
         xCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680228007;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hYs5n1ITZnHkUWCSUWW48EOIg+U7lQfMmPpeHjgrU0=;
        b=3JHMn22l5OJpi6rfdMVoihCaTRlILgFVkl3N63YWKsvcxWa6eaBwDC0GUtO+5HejXX
         qQr6/f/EVgImkok0IJZkNp5D2ez24lPzn//acvIRMSKlSjGElUCCuwMneacI5tRFW5+R
         yekepqgiPYlaTTjHdGLefDPexCqj9NyXdfrV5BW0td0Tw/JyO4NZwNm9s0/O/JvnyDDX
         5cYAqpYlI9V9UP8HadQPkB0xCcUfve3GbVhcf72acAvwZNjRGbbGjz9NwMl7qOm42ch4
         F8vtOzZW1lvfmY+y7ZOh+rjmOOf5w2ucf4sI0ROzIF3Nt/5R3mh9Hn4bPIjcdLKSeW5m
         PEUQ==
X-Gm-Message-State: AAQBX9f7SqM5ECN6HbQTIRtnTkh3ZZ3Y73Ds0voG5GDXROyfPng/4AdO
        61yN0ILMboHZbm7K9R3Ule8211+oZl4=
X-Google-Smtp-Source: AKy350ZMUFPLeuLbeaJPLk7NtCScPkl4KP0BSApyZZ8gYiXBvcKBtu7YNi/KLa93Qyx7L/dBPrj6Fg==
X-Received: by 2002:a05:6214:2487:b0:537:7d76:ea7c with SMTP id gi7-20020a056214248700b005377d76ea7cmr45054315qvb.25.1680228006573;
        Thu, 30 Mar 2023 19:00:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.254.80])
        by smtp.gmail.com with ESMTPSA id b10-20020a0cbf4a000000b005dd8b9345d6sm248645qvj.110.2023.03.30.19.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 19:00:06 -0700 (PDT)
Message-ID: <64263ea6.0c0a0220.5d1dc.167e@mx.google.com>
Date:   Thu, 30 Mar 2023 19:00:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5786605138094124636=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] avrcp: Fix crash while handling unsupported events
In-Reply-To: <20230330234425.1064422-1-luiz.dentz@gmail.com>
References: <20230330234425.1064422-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5786605138094124636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735621

---Test result---

Test Summary:
CheckPatch                    FAIL      0.74 seconds
GitLint                       FAIL      0.54 seconds
BuildEll                      PASS      26.44 seconds
BluezMake                     PASS      753.07 seconds
MakeCheck                     PASS      11.41 seconds
MakeDistcheck                 PASS      148.65 seconds
CheckValgrind                 PASS      240.95 seconds
CheckSmatch                   PASS      323.46 seconds
bluezmakeextell               PASS      96.96 seconds
IncrementalBuild              PASS      604.17 seconds
ScanBuild                     PASS      962.23 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] avrcp: Fix crash while handling unsupported events
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#90: 
     #3 0x7fbcb3e51c43 in g_main_context_dispatch (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)

/github/workspace/src/src/13195053.patch total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13195053.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] avrcp: Fix crash while handling unsupported events

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B1 Line exceeds max length (98>80): "     #3 0x7fbcb3e51c43 in g_main_context_dispatch (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)"
16: B1 Line exceeds max length (90>80): "     #5 0x7fbcb3e512b2 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)"
18: B1 Line exceeds max length (83>80): "     #7 0x559644755606 in mainloop_run_with_signal src/shared/mainloop-notify.c:188"
20: B1 Line exceeds max length (90>80): "     #9 0x7fbcb3bafd8f in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58"
22: B1 Line exceeds max length (83>80): "     #11 0x5596444e8224 in _start (/usr/local/libexec/bluetooth/bluetoothd+0xf0224)"


---
Regards,
Linux Bluetooth


--===============5786605138094124636==--
