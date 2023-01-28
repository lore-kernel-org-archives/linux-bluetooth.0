Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF54C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Jan 2023 01:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjA1BPa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 20:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjA1BP3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 20:15:29 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07358222D4
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 17:15:27 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h24so5581808qta.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 17:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Firqyz1n+2qQbJHI4kD1QUdyNuPl2JdNqyqQmLW0wQ=;
        b=BWfy72jcCOH0RJPe1rzK+GSNLdQTfpHeMyT7cPayJok8bysTxFUa/zd5Fy1lU4VfD/
         a/M0uCWoqbYhildbDCkPu/ih/spSbMkk+ilt9I0TFEd0ouB0GHb/6OUfVRBUeLnHGwuU
         MHM2rnFJHJQSPOz7wCM9Czw5kIk5m1sxpEtjJ1uAnlVsYWGX83t/4d5+uWVnnUmeVe0B
         6aQeSXZj1JSp+E9b+tkdLAm4G7l6Zh0VPVL01dtvFxAOKvVtVOZEZ+qx4pviZzUpa5qP
         SDbuSVa2mKWdWjHQyS7I6qRpRZgamOz+Sl0OzEn16us7XP0Gm5HEsrvFTq8troQpLNyx
         2I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Firqyz1n+2qQbJHI4kD1QUdyNuPl2JdNqyqQmLW0wQ=;
        b=G23oRlrcemXjcykHJbwEDDky6HhJawUdc8FT+hOxYB5K6bd0t3tweI3OHcOtlWasJ9
         uU1bK8HARWETVqEf61kOPEwqBACbISUs+ovSUMW0Gudac3JPKpAOPTAu1/rEsLbdlQ0m
         6GQvUMSYpbK2vZKC4+hin+rd6SDdGiJebtwls8ZvWtwieoIM9pb5sWawKM/EPcT0pth0
         Y1Ilkhh+pMhDaZ5vo0MV5uTo7ai+/3qyNhImT23g0QppiObSctenwT41UO+9+tkorCzV
         EC71EUGgCyt0dmtBEujfjOD30KVdhdtXCJ+JltTPj/ojvV1GMX4QLV0PUiqkaO7qLGhe
         9caQ==
X-Gm-Message-State: AO0yUKXe1e3OzlVH9dr6o4sNfKaGyDyDZIB6eAWT6FzmManQ2I/J6DSh
        OezNtQA59l9FiifZfLfLs6esh5XLb18+Og==
X-Google-Smtp-Source: AK7set8ydobvWNwJe3ef9Te9+d+9eBZ7UZHePEeP4aGsr9iHEne8EqszNTlYw+3z9xqmThykeaO4/A==
X-Received: by 2002:a05:622a:1884:b0:3b4:d5be:a2e0 with SMTP id v4-20020a05622a188400b003b4d5bea2e0mr1701762qtc.20.1674868525897;
        Fri, 27 Jan 2023 17:15:25 -0800 (PST)
Received: from [172.17.0.2] ([20.42.13.16])
        by smtp.gmail.com with ESMTPSA id x1-20020ac80181000000b003a527d29a41sm3695408qtf.75.2023.01.27.17.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 17:15:25 -0800 (PST)
Message-ID: <63d4772d.c80a0220.37331.ce8c@mx.google.com>
Date:   Fri, 27 Jan 2023 17:15:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7854795504131870001=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, keescook@chromium.org
Subject: RE: Bluetooth: hci_conn: Refactor hci_bind_bis() since it always succeeds
In-Reply-To: <20230128005150.never.909-kees@kernel.org>
References: <20230128005150.never.909-kees@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7854795504131870001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=716493

---Test result---

Test Summary:
CheckPatch                    FAIL      1.23 seconds
GitLint                       FAIL      0.61 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.60 seconds
CheckAllWarning               PASS      34.13 seconds
CheckSparse                   PASS      38.76 seconds
CheckSmatch                   PASS      105.61 seconds
BuildKernel32                 PASS      30.23 seconds
TestRunnerSetup               PASS      435.80 seconds
TestRunner_l2cap-tester       PASS      16.61 seconds
TestRunner_iso-tester         PASS      17.48 seconds
TestRunner_bnep-tester        PASS      5.76 seconds
TestRunner_mgmt-tester        PASS      115.04 seconds
TestRunner_rfcomm-tester      PASS      9.17 seconds
TestRunner_sco-tester         PASS      8.47 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        PASS      7.27 seconds
TestRunner_smp-tester         PASS      8.40 seconds
TestRunner_userchan-tester    PASS      6.03 seconds
IncrementalBuild              PASS      28.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_conn: Refactor hci_bind_bis() since it always succeeds
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#105: 
    inlined from 'atomic_dec_and_test' at ../include/linux/atomic/atomic-instrumented.h:576:9,

total: 0 errors, 1 warnings, 0 checks, 30 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13119595.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_conn: Refactor hci_bind_bis() since it always succeeds

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (94>80): "    inlined from 'atomic_dec_and_test' at ../include/linux/atomic/atomic-instrumented.h:576:9,"
11: B1 Line exceeds max length (123>80): "../arch/x86/include/asm/rmwcc.h:37:9: warning: array subscript 0 is outside array bounds of 'atomic_t[0]' [-Warray-bounds=]"


---
Regards,
Linux Bluetooth


--===============7854795504131870001==--
