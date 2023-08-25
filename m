Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7A5C71133
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Aug 2023 19:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHYTex (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Aug 2023 15:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjHYTeo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Aug 2023 15:34:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA6A2685
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 12:34:40 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a850f07fadso911158b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692992079; x=1693596879;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DuwtHHJM3pjXr909Artr9LHZi/Cmv2yjGYJDcKD0hUg=;
        b=El0F7idOXhKzOwcNK4PZUBF/LG3vcZ2Fy/D+r+WvML3IpsKCdAoUXQL//EYfcCBeG/
         2OwDMJIuP7in2AIxeJBF8HT3ZT6RnnEpGz0L+mbhkYXAtiyTXaP16q3P7vwM9sV5MZWt
         m0YuRyJl5lGp7L3248W0X2XGxsKw2ziR9OtOhQQl14LzOqOZOIiDK9+6HwtGdMzfL035
         llc/cXHXoL46kQgP7RMeHZECsnMXcjKYFDZnBYIrYB9PeF15NWyCJEteOVBa/uqZXUpr
         APZU00Tb5WvtkHMUvbPkgv5PGEbBbd2RJeeAKS9J5g+FQE73xa5KFR1eyGm1Tkh+hkRd
         OJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692992079; x=1693596879;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuwtHHJM3pjXr909Artr9LHZi/Cmv2yjGYJDcKD0hUg=;
        b=Qc6Z2jgfa3kAt5a5crVpVNyC5JlRPvvJXUNSegbk8x5vRHuk00A7dHP5KdyXycnco4
         r0ivD1eyfs4mhIHi7UBZ8YstMv0LNZ+5O+kFRmNXX68my6jNFUGCftfHy1lBYLdX3VR/
         LwunnXIBdti9N7pzedr8wnalBhE6NoyJy2DFGfZMjS6357OAMzK9To8fxbSwCD5fEYfT
         iVksXUK2WZXsO/tzJxybBtaoGgsqjK2YZBE2EPsy5WWHEhg/MK7x0yKy6oHCL5xk12RE
         2PdJ3gZ5C06OqgYGDknIJKU/sCtsMgTrV0LUM66fLRddC6dWdDkFFxp05REUL9eFMFd+
         sYvA==
X-Gm-Message-State: AOJu0YyjAkholG7QicsDKzw6G/QftEMkkiu2ZgDokrnVyTP56q6Lzfyx
        an8muvt+gmHW6jmPX2IAZUyEtBcTrds=
X-Google-Smtp-Source: AGHT+IF5I9wSFld0EZw93ofi2m2Frhcaupb6ew9t3h2Xw/UpWUPX3jZSbZYrB7Gin1LbZbSi7cK3aw==
X-Received: by 2002:a05:6358:2608:b0:135:515c:38ee with SMTP id l8-20020a056358260800b00135515c38eemr19011905rwc.25.1692992079159;
        Fri, 25 Aug 2023 12:34:39 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.246.226])
        by smtp.gmail.com with ESMTPSA id jr16-20020a05622a801000b00407906a4c6fsm706712qtb.71.2023.08.25.12.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 12:34:39 -0700 (PDT)
Message-ID: <64e9024f.050a0220.b7012.3609@mx.google.com>
Date:   Fri, 25 Aug 2023 12:34:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5244204196800173366=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_conn: verify connection is to be aborted before doing it
In-Reply-To: <8d413750f5749773c033245a593394933b77372e.1692986355.git.pav@iki.fi>
References: <8d413750f5749773c033245a593394933b77372e.1692986355.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5244204196800173366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=779464

---Test result---

Test Summary:
CheckPatch                    PASS      0.89 seconds
GitLint                       FAIL      0.59 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.03 seconds
CheckAllWarning               PASS      35.29 seconds
CheckSparse                   PASS      40.36 seconds
CheckSmatch                   PASS      113.12 seconds
BuildKernel32                 PASS      31.07 seconds
TestRunnerSetup               PASS      475.05 seconds
TestRunner_l2cap-tester       PASS      27.01 seconds
TestRunner_iso-tester         PASS      47.85 seconds
TestRunner_bnep-tester        PASS      10.34 seconds
TestRunner_mgmt-tester        PASS      217.79 seconds
TestRunner_rfcomm-tester      PASS      15.84 seconds
TestRunner_sco-tester         PASS      19.02 seconds
TestRunner_ioctl-tester       PASS      17.82 seconds
TestRunner_mesh-tester        PASS      12.97 seconds
TestRunner_smp-tester         PASS      14.03 seconds
TestRunner_userchan-tester    PASS      10.94 seconds
IncrementalBuild              PASS      29.67 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_conn: verify connection is to be aborted before doing it

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B1 Line exceeds max length (88>80): "Closes: https://lore.kernel.org/linux-bluetooth/0000000000005ab984060371583e@google.com/"
26: B3 Line contains hard tab characters (\t): "        2874	conn = hci_conn_hash_lookup_handle(hdev, handle);"
27: B3 Line contains hard tab characters (\t): "        2875	if (!conn || WARN_ON(!conn->abort_reason))"
28: B3 Line contains hard tab characters (\t): "        2876		return 0;"


---
Regards,
Linux Bluetooth


--===============5244204196800173366==--
