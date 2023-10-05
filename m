Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BD7E92FC8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 21:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjJEVrl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJEVrk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 17:47:40 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED3E95
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 14:47:38 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso871572fac.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Oct 2023 14:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696542458; x=1697147258; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yosm2N69TMNRU1Y0GJiPDKeI/ejZAxKskmdsG9F+BeM=;
        b=FBx5TOywIpYsp/QMOSl3N5ZYqrjSnBACemkmRDc6h5Sjv04TPF5vFeezrBnt2UpLai
         yQa1o08xC5UQZNx4iw/xsAgy8lstESjusedEd5Su6xiviO2LElpdZNumDkc4Z7u3gscO
         T9V+uefNmLdPps7jeyp3/WY5FWFHd5P1bWi/vU4ex8+6Nsr38F45N+H1DCL6un462hqj
         ajTQQPY3IiVgcDaKZwPR/2wRWIrYLNwTToq99gniWg77o3XWGiPWjhBHDufb/lIcH3UQ
         WF3dyPX9TFvUbhndDgl/hwq33pelGEJ3vl1BaGpwEnWW9XUCMjS51/zsyGNqSRD+pqhz
         9f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696542458; x=1697147258;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yosm2N69TMNRU1Y0GJiPDKeI/ejZAxKskmdsG9F+BeM=;
        b=pD7CL57jd+2pPzDvYPJAG1o3CmvAglq/9zCWhA6wwpyhPnr4jeh5ZwtWJqQvmDiBN2
         mErLZhWZ2xrW32Y8BrCt1CLtQbymafc62OWcohcolFqSDknmhsDKVbsw3paRAs0nN1UZ
         GaoUzxry9zV8CpjbkOiYxFd6FmVln3tcjLaPO3T30s+CxyzAMY9DIb8/Meqzr1E41Ahh
         LJ8vsh/jXfUTLIl2+pzXL4/kQ9lVOU7IPL6cfh2JzfzcLGJREwA3/j7MW1jBtiWpQ97D
         79D0Sbh0NRPYlwvG0rm7GF7KapXNoqdi3WXaW2wP8iU1M0zILriDK2yhcp76EK19iThM
         DHAw==
X-Gm-Message-State: AOJu0Yx/ERbzQNQRGts9UPZBoAu+QRmHzIiqD+iWjOl/KhMBcKrcSwsm
        95vsWNyRJOkRWb30yXQA+OZYCfP2gn8=
X-Google-Smtp-Source: AGHT+IGnQUHOjnfrJmxDX01iB1xQZKSd6LDXN8rU5kNhH5DCmx/xVosMWymPFWlybIUVN7OkU/lhRQ==
X-Received: by 2002:a05:6870:638b:b0:1d6:5561:ea7a with SMTP id t11-20020a056870638b00b001d65561ea7amr7379945oap.18.1696542457696;
        Thu, 05 Oct 2023 14:47:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.12.255])
        by smtp.gmail.com with ESMTPSA id r6-20020a0c8d06000000b0065655bb349csm825463qvb.141.2023.10.05.14.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 14:47:37 -0700 (PDT)
Message-ID: <651f2ef9.0c0a0220.3f734.4ea5@mx.google.com>
Date:   Thu, 05 Oct 2023 14:47:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6208144417738072632=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: hci_event: Fix using memcmp when comparing keys
In-Reply-To: <20231005212322.3886919-1-luiz.dentz@gmail.com>
References: <20231005212322.3886919-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6208144417738072632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=790428

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       FAIL      0.98 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      35.31 seconds
CheckAllWarning               PASS      37.84 seconds
CheckSparse                   WARNING   43.53 seconds
CheckSmatch                   WARNING   116.97 seconds
BuildKernel32                 PASS      33.67 seconds
TestRunnerSetup               FAIL      41.23 seconds
TestRunner_l2cap-tester       FAIL      0.14 seconds
TestRunner_iso-tester         FAIL      0.14 seconds
TestRunner_bnep-tester        FAIL      0.14 seconds
TestRunner_mgmt-tester        FAIL      0.14 seconds
TestRunner_rfcomm-tester      FAIL      0.14 seconds
TestRunner_sco-tester         FAIL      0.13 seconds
TestRunner_ioctl-tester       FAIL      0.13 seconds
TestRunner_mesh-tester        FAIL      0.14 seconds
TestRunner_smp-tester         FAIL      0.13 seconds
TestRunner_userchan-tester    FAIL      0.14 seconds
IncrementalBuild              PASS      44.86 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[2/2] Bluetooth: hci_event: Fix coding style

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B3 Line contains hard tab characters (\t): "+	if (!bacmp(&hdev->bdaddr, &ev->bdaddr))"
9: B3 Line contains hard tab characters (\t): "+	{"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunnerSetup - FAIL
Desc: Setup kernel and bluez for test-runner
Output:
Bluez: 
make[1]: *** No rule to make target 'unit/test-micp.c', needed by 'unit/test-micp.o'.  Stop.
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:4582: all] Error 2
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No tester found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No tester found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No tester found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No tester found
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:
No tester found
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
No tester found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
No tester found
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
No tester found
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
No tester found
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No tester found


---
Regards,
Linux Bluetooth


--===============6208144417738072632==--
