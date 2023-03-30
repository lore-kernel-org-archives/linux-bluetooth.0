Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9B7C761AF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 22:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjC3Wc0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjC3WcY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 18:32:24 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64FA1FE2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:32:23 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h14so9259547ilj.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680215543;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=00bsa0r49DgCIT/+0ubVz+DWYGrxbpQAG5zM33RJn/4=;
        b=GQCvmO/T9e/DHSfC3kSp5wX99ySErPjJXooizPkw2FeZP8FZgsAi2X5i2ufpeN7iss
         5HBCoJDI0n5S+hzxDToc6BhQdVgiqLopRoBbkafRTQVs7kywE7Olp5RQkrVAh8yyJOJW
         xGQIydU6WW5LQn0ObQX6IDQfk4Lgz1GaU5Wh1/sinnHEYAqf5+VMYUY5te69dvjbUxhi
         FhsgutqEZg/5SxeQmgzfyUNS2NpEzMsDSF2uGK7QfyxUXq+6U5OHICHtAUnP3TKGLT67
         KMi4ls02SYb52wODmcOF4HRJZXU+gJ/CHi1tqZ0GUdaBM3cbEM4/qgJ6Dko6DE4e+WVi
         /GKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680215543;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00bsa0r49DgCIT/+0ubVz+DWYGrxbpQAG5zM33RJn/4=;
        b=jtzgfpRQPxsLK57qywowAjg+cQxaDLPXR+CeMBjGY85mhW5Lc1QMaqxBBv+hJH9k6P
         hPSxtEePe4bCyL+HJz8NkiXFA/aTT0+0WbzaQiVnS1Nb+Tei8nOgybT779f/wMxRkHMQ
         J/f2ubkso+ht5RToZCbFPCMDmi9lgy0Om7cvmZASI0i0gHVBsku/iQXqUVRHUgrD8sIR
         dBnfjo4EcQFFnFSurZNQwnMRq5ihm3FsifFm2plJXLFzoXkHRaF4XelGjd0roMiQ3L6P
         mBQJRVdjL9rR5Hi1hRqo0AHSKSZwKeRXChcX5yIiit4LDXMFUP8YrmYCbJJ/z7JA7VE2
         Fpbg==
X-Gm-Message-State: AAQBX9e5aN6f1lFnY03gz9sd6rUkEjF9jE4EDU39gX217+IqGUu7VAtl
        to9HGYwpcIKKWp2mr6LCN4QKjRbhZso=
X-Google-Smtp-Source: AKy350Z/5i7dhnbygkNxK9PctWlnz5/Q+n7dljPcfv7IizTODwe17PUDhMp4TqjwFtTv17IH5f873A==
X-Received: by 2002:a05:6e02:4d0:b0:323:f2:920b with SMTP id f16-20020a056e0204d000b0032300f2920bmr9958552ils.31.1680215543122;
        Thu, 30 Mar 2023 15:32:23 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.244.99])
        by smtp.gmail.com with ESMTPSA id b21-20020a026f55000000b004061d6abcd2sm204376jae.146.2023.03.30.15.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:32:22 -0700 (PDT)
Message-ID: <64260df6.020a0220.97f0.05bb@mx.google.com>
Date:   Thu, 30 Mar 2023 15:32:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4948436627167167686=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Fix double free in hci_conn_cleanup
In-Reply-To: <20230330220235.1035456-1-luiz.dentz@gmail.com>
References: <20230330220235.1035456-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4948436627167167686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735596

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      31.29 seconds
CheckAllWarning               PASS      34.91 seconds
CheckSparse                   PASS      39.07 seconds
CheckSmatch                   PASS      108.89 seconds
BuildKernel32                 PASS      30.34 seconds
TestRunnerSetup               PASS      435.71 seconds
TestRunner_l2cap-tester       PASS      16.15 seconds
TestRunner_iso-tester         PASS      15.63 seconds
TestRunner_bnep-tester        PASS      5.10 seconds
TestRunner_mgmt-tester        PASS      106.90 seconds
TestRunner_rfcomm-tester      PASS      8.21 seconds
TestRunner_sco-tester         PASS      7.51 seconds
TestRunner_ioctl-tester       PASS      8.72 seconds
TestRunner_mesh-tester        PASS      6.37 seconds
TestRunner_smp-tester         PASS      7.38 seconds
TestRunner_userchan-tester    PASS      5.29 seconds
IncrementalBuild              PASS      28.65 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix double free in hci_conn_cleanup

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
34: B1 Line exceeds max length (87>80): "Link: https://syzkaller.appspot.com/bug?id=1bb51491ca5df96a5f724899d1dbb87afda61419 [1]"


---
Regards,
Linux Bluetooth


--===============4948436627167167686==--
