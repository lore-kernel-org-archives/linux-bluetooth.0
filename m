Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51F0E95A8E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 14:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjJIOha (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjJIOh3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 10:37:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F01A3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 07:37:27 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77574c076e4so318722485a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696862246; x=1697467046; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2M3jvHbcF5ihqceYDl1yL2+TtCjKuJNK3DePERymuyA=;
        b=D+YinLk9VcYRTGDqOP4WiDf7972Kvd8lQgsDcxlHR802MCK93B/owXTQSclIUZ1DVS
         OW7P21N/4TQCP3Ax2XL2ExyRWgFzQGWOgKGq+PQzgaDwFyvdQY50KNvyrPmqfOgTPn2A
         lv2B15Hn3CSh+yA/2A7Cc7YAFBrKdhvA0lHbFsOMwJ03eDPK47g/ET4iYYUiHM4QCf0N
         wNmb9l2fzYFTO3/ltaK0pE1Z3DCwqSit6RNWyDklxb4K7NQfBsNOm/WsYWuACO+KKDlZ
         fNP4o6oVxjCMy8gVoSx0d3TZGm3Ffj1eEw/FevQDydrRcjuq1SOvHuQhcRbVcF3TQstC
         ibDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696862246; x=1697467046;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2M3jvHbcF5ihqceYDl1yL2+TtCjKuJNK3DePERymuyA=;
        b=GqdF+luAyh07PHZ85vrBx7VLb52lGsNaBu0IWubNFp67tSCRpDQU4yZqg43M/OVCgZ
         7lGkmzle0mj17I8LQbBZriVU7Alai49Sj226PSsKHeh20mHI5ekE9lZIUV11YC7RRE1Q
         DunthdKicx9s4M1mNLlfSTIyr/0dH6UGwR6szzQURX72xQf1lnhnERcJsNMFGjYjuyIY
         m0qnkiYOuUlixMHX3WZGLqhCg/mOCfSnSSbLhjMo0mYAh6EqJpACqLcroXmbKd8DOx0w
         5FkUo/mQIKcukEa1U1xUphc7S9EaLIp/cc9ZM/Edw5AgBT2Xucnwa9vQUretJ7jMzEyo
         1dYA==
X-Gm-Message-State: AOJu0YzJ8ZwnWzXuTYWa82WHqAUGP9wDRr3zP1EfcAMjrxou3dA94ZU3
        wLUbgO452lL8j8UNoajOvz3ONIQedVE=
X-Google-Smtp-Source: AGHT+IHkYI5sQSAu7asXCDBYHsQVU+b5iVMqx/YdJGguFnF65pRIAfkqHslatEgJEt2BEdibjgPebA==
X-Received: by 2002:a0c:cc04:0:b0:66a:c297:c239 with SMTP id r4-20020a0ccc04000000b0066ac297c239mr15128313qvk.20.1696862245925;
        Mon, 09 Oct 2023 07:37:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.59])
        by smtp.gmail.com with ESMTPSA id j5-20020a0c9cc5000000b0065d89f4d537sm3936589qvf.45.2023.10.09.07.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 07:37:25 -0700 (PDT)
Message-ID: <65241025.0c0a0220.8281b.f0b0@mx.google.com>
Date:   Mon, 09 Oct 2023 07:37:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8050887692566306311=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: Bluetooth: mark bacmp() and bacpy() as __always_inline
In-Reply-To: <20231009134826.1063869-1-arnd@kernel.org>
References: <20231009134826.1063869-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8050887692566306311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=791315

---Test result---

Test Summary:
CheckPatch                    FAIL      1.10 seconds
GitLint                       FAIL      0.62 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      34.83 seconds
CheckAllWarning               PASS      38.35 seconds
CheckSparse                   PASS      44.57 seconds
CheckSmatch                   PASS      117.20 seconds
BuildKernel32                 PASS      33.68 seconds
TestRunnerSetup               PASS      513.96 seconds
TestRunner_l2cap-tester       PASS      31.42 seconds
TestRunner_iso-tester         PASS      52.83 seconds
TestRunner_bnep-tester        PASS      10.68 seconds
TestRunner_mgmt-tester        PASS      221.69 seconds
TestRunner_rfcomm-tester      PASS      16.26 seconds
TestRunner_sco-tester         PASS      19.74 seconds
TestRunner_ioctl-tester       PASS      18.41 seconds
TestRunner_mesh-tester        PASS      13.55 seconds
TestRunner_smp-tester         PASS      14.56 seconds
TestRunner_userchan-tester    PASS      11.22 seconds
IncrementalBuild              PASS      31.91 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: mark bacmp() and bacpy() as __always_inline
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#71: 
    inlined from 'hci_conn_request_evt' at net/bluetooth/hci_event.c:3276:7:

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("Bluetooth: Reject connection with the device which has same BD_ADDR")'
#82: 
Fixes: d70e44fef8621 ("Bluetooth: Reject connection with the device which has same BD_ADDR")

total: 0 errors, 2 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13413766.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Use of uninitialized value $cid in concatenation (.) or string at /github/workspace/src/src/scripts/checkpatch.pl line 3228.
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: mark bacmp() and bacpy() as __always_inline

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (125>80): "include/net/bluetooth/bluetooth.h:364:16: error: 'memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]"


---
Regards,
Linux Bluetooth


--===============8050887692566306311==--
