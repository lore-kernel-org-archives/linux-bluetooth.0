Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCDBC7EE25
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 20:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjFGUjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 16:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjFGUil (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 16:38:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA86270C
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 13:38:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b246dd3390so15463655ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jun 2023 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686170300; x=1688762300;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jrg7k/2dsASF6qPEANUUCkggcmyUVakPk0P6yWa15KQ=;
        b=DdMTAAVjhEjKIZDE7N57ILVjuUHrqyJHk6JoycX5lCuulnDmE+gTcZJ9ZKMTuhUdW8
         0DoIh9F66Pdfgp9g3bHJGFf0qWFpgs6BJIxu7pF7SUppJsAOsxYfxL2R5nJNdfpdrTvl
         Jx9MTQMHb7n1gxWvJh+sKJXWmahPcesm/k7/EqLEQRoM7Hnl7pT0Ub4EajzZjdwJ56ay
         ziPiut0N1+LWwPgL3R26rZ6ylap0SbQ2NQ2cFNa4/d3NMxvwXhUBJrFYtZKgJ2EtF1qJ
         fYRE0mLMMa1oH8LNfIhOjlVc2AYGmjj9eHcD67GL3k/Ml5HT0xr8NQ/xwUHzDrnwcb+V
         K6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170300; x=1688762300;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrg7k/2dsASF6qPEANUUCkggcmyUVakPk0P6yWa15KQ=;
        b=Cdqat2aLY1MhCq8NVMWiLwqcnAHHR35wtxQiYm19eQvN5qREf7arRiMrUqXwB1B9ie
         GuEyNxc02nv6QFzmQKdU0eLgNbYGN2Swq+2y4SJCN0P8MFntGc94eWYyDXiAic/rDFc8
         sVzRUeTcJPM5DY0Qeu/5LBg+PkJV6NwaqRqwC6M9bXQbPApGw7z8F0YMUMy6LFSByJxX
         jsfES6aaCwXhIAnz71pZaAjxSlZbAl0mJxaIEu7hbXaeIQs+UxKFGSfLxGvdxl05BEHI
         JFxbZRlT4KZoq7EbSUpQGpUCQk4Rf2AcNKl3w+304nTt092CHGt3qCGDi347vh51hez1
         xwsQ==
X-Gm-Message-State: AC+VfDxxFUDqGanVwUiYV8iPHSBiK6Rir7z+8vxVOZa1QmKQzwar54Rx
        L2t893v0URkwUpYKS8N0c+76qs8sJng=
X-Google-Smtp-Source: ACHHUZ5chbq+tOXBsMSXYvg8E/QjBdQ/NEYfdLbNagB55gkVwPPttgoXcpKRqAbWlrzyKgl0FJqeRA==
X-Received: by 2002:a17:902:f1cd:b0:1ad:edbe:57a8 with SMTP id e13-20020a170902f1cd00b001adedbe57a8mr5437612plc.50.1686170300249;
        Wed, 07 Jun 2023 13:38:20 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.244.147])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902778d00b001b024ee5f6esm10822402pll.81.2023.06.07.13.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:38:19 -0700 (PDT)
Message-ID: <6480eabb.170a0220.fc604.5a93@mx.google.com>
Date:   Wed, 07 Jun 2023 13:38:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5543265499615895323=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable
In-Reply-To: <20230607194518.2901376-1-luiz.dentz@gmail.com>
References: <20230607194518.2901376-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5543265499615895323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=755036

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       FAIL      0.67 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      43.40 seconds
CheckAllWarning               PASS      46.08 seconds
CheckSparse                   WARNING   51.88 seconds
CheckSmatch                   WARNING   142.87 seconds
BuildKernel32                 PASS      42.15 seconds
TestRunnerSetup               PASS      592.76 seconds
TestRunner_l2cap-tester       PASS      20.87 seconds
TestRunner_iso-tester         PASS      30.92 seconds
TestRunner_bnep-tester        PASS      7.51 seconds
TestRunner_mgmt-tester        PASS      146.19 seconds
TestRunner_rfcomm-tester      PASS      11.75 seconds
TestRunner_sco-tester         PASS      10.98 seconds
TestRunner_ioctl-tester       PASS      13.07 seconds
TestRunner_mesh-tester        PASS      9.55 seconds
TestRunner_smp-tester         PASS      10.71 seconds
TestRunner_userchan-tester    PASS      7.93 seconds
IncrementalBuild              PASS      39.33 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (113>80): "Link: https://lore.kernel.org/linux-bluetooth/CABBYNZ+CYMsDSPTxBn09Js3BcdC-x7vZFfyLJ3ppZGGwJKmUTw@mail.gmail.com/"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============5543265499615895323==--
