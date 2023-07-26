Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CBDC0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 14:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjGZOAm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjGZOAk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 10:00:40 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8EB268F
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 07:00:39 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b9d562f776so5271389a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690380039; x=1690984839;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1JaCLp8Kl6VNKRixdBKYp7Cjyoj29VmaxPvP++3Zefc=;
        b=pgYPHk6IqjSvkzx4NzH6+IvH+InQ3gzkREXv5tN8lPUiVCd/8HTcAc84wKNKIFGEFw
         eyfgGnfrRvQHdLUHUxGjzhpHP0W3UnsBmfEAHPYDemfB7/sI+w+6RK8bDtwRCGYVx44N
         GLAcwP4YXRulqVGBQqQDMQQ0AieUh/NiBRGw3FbjuxZDAl/64fDCPitDZcs9UY4LxO0m
         bLzV5OUE6ByifC+wKbkczUUh7ZqQHEdj+5KDCE/b54pYp8MDiiuvgvyBDgO8Nlaa5RkU
         f9aJklC5oIVyVMEId2zqtLJpHnQCt+aCY0SaPVCNqPdhLxLZP5hBuufYHap7rf2yIPni
         GHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380039; x=1690984839;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JaCLp8Kl6VNKRixdBKYp7Cjyoj29VmaxPvP++3Zefc=;
        b=CX1FeJpP+B9bLCrcvDXtBmOBF2XISJhWtgT+ipVHDy4O7wKxgceinYEbLfFeP0tm31
         hwSbJIfXgt0E4UNWNOt6Jelr442qzdpIv24XCLiqXaXCPhNQtDQhAe5n2AElXQ/xYwF4
         S4ELcDeO07OjPQgbk5Jrjh3Sa+ljrVP5r1ony2bPeOK5hTFvPQrg38kr/HWaGGkm1j6n
         F4FZFKoHGRyzQm29mN1OsbJaNJLMhnTC11/tKqGUDvKrp1SRllzWoCEdJA+KFSRs85p0
         m0Gdj+Kh5rsF+jezy8yQa2QvgIhdYhOsg2GzN2R0CIB93xceXVk3DprcKHcc7NGitAOt
         tT2g==
X-Gm-Message-State: ABy/qLbaaCMIW0pZAETmBOOkHIpcm5+0iRQqZ6NLSK8/eTtUjtueeTTG
        povDjeufJ4+MlTUqq1XQMNj1LrYRmjg=
X-Google-Smtp-Source: APBJJlG2Fdh9SXPDqvWvszaSiXPUzmg1+1uBzXbuDqIBN6/zsq77gi6kCwwFItyjzdLTd+oeLoJWsw==
X-Received: by 2002:a9d:6a51:0:b0:6b8:79e6:a2bd with SMTP id h17-20020a9d6a51000000b006b879e6a2bdmr2023556otn.37.1690380038988;
        Wed, 26 Jul 2023 07:00:38 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.79.0])
        by smtp.gmail.com with ESMTPSA id c1-20020a9d75c1000000b006b884bbb4f3sm4823958otl.26.2023.07.26.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:00:38 -0700 (PDT)
Message-ID: <64c12706.9d0a0220.fe2be.c471@mx.google.com>
Date:   Wed, 26 Jul 2023 07:00:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5653406254938172510=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ruc_gongyuanjun@163.com
Subject: RE: [1/1] bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()
In-Reply-To: <20230726133000.20417-1-ruc_gongyuanjun@163.com>
References: <20230726133000.20417-1-ruc_gongyuanjun@163.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5653406254938172510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=769710

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 FAIL      0.34 seconds
BuildKernel                   PASS      33.79 seconds
CheckAllWarning               PASS      36.59 seconds
CheckSparse                   WARNING   42.15 seconds
CheckSmatch                   PASS      112.52 seconds
BuildKernel32                 PASS      32.22 seconds
TestRunnerSetup               PASS      491.97 seconds
TestRunner_l2cap-tester       PASS      23.62 seconds
TestRunner_iso-tester         PASS      42.91 seconds
TestRunner_bnep-tester        PASS      10.72 seconds
TestRunner_mgmt-tester        PASS      217.72 seconds
TestRunner_rfcomm-tester      PASS      15.99 seconds
TestRunner_sco-tester         PASS      16.95 seconds
TestRunner_ioctl-tester       PASS      18.24 seconds
TestRunner_mesh-tester        PASS      13.47 seconds
TestRunner_smp-tester         PASS      14.40 seconds
TestRunner_userchan-tester    PASS      11.31 seconds
IncrementalBuild              PASS      30.25 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/hci_nokia.c:284:23: warning: incorrect type in assignment (different base types)drivers/bluetooth/hci_nokia.c:284:23:    expected unsigned short [usertype] bauddrivers/bluetooth/hci_nokia.c:284:23:    got restricted __le16 [usertype]drivers/bluetooth/hci_nokia.c:287:26: warning: incorrect type in assignment (different base types)drivers/bluetooth/hci_nokia.c:287:26:    expected unsigned short [usertype] sys_clkdrivers/bluetooth/hci_nokia.c:287:26:    got restricted __le16 [usertype]


---
Regards,
Linux Bluetooth


--===============5653406254938172510==--
