Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478CCC46467
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Jan 2023 14:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjAROEZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Jan 2023 09:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjARODs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Jan 2023 09:03:48 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B010823C79
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jan 2023 05:39:58 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id u8so17033071ilg.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jan 2023 05:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ktHpKKRwt02c5GM1eNMxxkzVXQO/hlKlwIWAAgPH4P8=;
        b=hp42EIeqq9vKYkcyvFURyHzQLZ0cbTZUhxjTdJPSj9Q5zULqsMp6Fk2OYjbn8AH4Kd
         AgcTPUx3dL9S3Ed+7FcVSvcud9d+IPpyha2nK4l+Cpz3eMrIg941y5MQhUEyVITz6Qlk
         N3+1jJjlcDx0sp0RpUgefw/ToAivongglFDYC4VJyAtBf5ooFC97armJIPhJIhE8qxSA
         J9NlDZPflXsxtt23XdZ2QlZ6XX0iTvG0xqJxTbeyFRK2NWgfqgnTnypXmKL40UsrX6mY
         sViUW5/BNo3JF2BFxl86F+CBQXPEPEgz/A6/w3wQ0VXiQ5Ypx7XmRsvEJmo4DXWXB2cY
         TN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktHpKKRwt02c5GM1eNMxxkzVXQO/hlKlwIWAAgPH4P8=;
        b=gJOx8yR9b/tr3N+MWqx8MJzmQHdbS9GXpB7VqdfKEJ/giULWbS+FOHRosczWnlXMav
         MJfNXhi7fjaQpOLfnKmoj6pkbRi3bPRuLk6tK2Li6htUFiSrS4s+SGuJpnKvKeznwt2W
         jvzlxbTnXNmsdZwaDuQyq3Wbz2T1J98Nu7T97N+AfXdCcQVAx+Kri0gwUEEz4rMp4aig
         bDTAv+krVku8e2QiZSAhBenhcLtm10QIKf/8x8hXIjibemVUMFRPwe3LMEIe2A2zyfqk
         IDizJxmzmFXkv5xEy8Vn3Fvf/jaFwHaDSFR7S4PD+aOQaIxgsWvo7MdyAQhcTJ3M6+hA
         xeWQ==
X-Gm-Message-State: AFqh2kpDNrWQ1PsSmPAspbZTxxg7vk041v/paLcuX+G/YYYjY6CpAvmD
        VvEdp8iKMKTJChWWQFfgYbEEyYODMcA=
X-Google-Smtp-Source: AMrXdXtxCFUGRWrzjCD0SATOXumXMKy83k8+yiXItWo9btUwWZ/tvoWqw9JkUD7Ex2VKSrKZSrmZdQ==
X-Received: by 2002:a05:6e02:5ab:b0:304:c709:b876 with SMTP id k11-20020a056e0205ab00b00304c709b876mr21356173ils.23.1674049197918;
        Wed, 18 Jan 2023 05:39:57 -0800 (PST)
Received: from [172.17.0.2] ([40.122.243.82])
        by smtp.gmail.com with ESMTPSA id k8-20020a056e02134800b0030dc530050dsm5899003ilr.85.2023.01.18.05.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 05:39:57 -0800 (PST)
Message-ID: <63c7f6ad.050a0220.a074f.c28a@mx.google.com>
Date:   Wed, 18 Jan 2023 05:39:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1760951501073745881=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, francesco@dolcini.it
Subject: RE: Bluetooth: hci_mrvl: Add serdev support for 88W8997
In-Reply-To: <20230118122817.42466-2-francesco@dolcini.it>
References: <20230118122817.42466-2-francesco@dolcini.it>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1760951501073745881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=713265

---Test result---

Test Summary:
CheckPatch                    PASS      2.50 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 FAIL      0.65 seconds
BuildKernel                   PASS      31.25 seconds
CheckAllWarning               PASS      34.68 seconds
CheckSparse                   WARNING   39.13 seconds
CheckSmatch                   PASS      107.68 seconds
BuildKernel32                 PASS      30.24 seconds
TestRunnerSetup               PASS      433.10 seconds
TestRunner_l2cap-tester       PASS      15.97 seconds
TestRunner_iso-tester         PASS      16.17 seconds
TestRunner_bnep-tester        PASS      5.47 seconds
TestRunner_mgmt-tester        PASS      105.86 seconds
TestRunner_rfcomm-tester      PASS      8.68 seconds
TestRunner_sco-tester         PASS      7.96 seconds
TestRunner_ioctl-tester       PASS      9.21 seconds
TestRunner_mesh-tester        PASS      6.86 seconds
TestRunner_smp-tester         PASS      7.89 seconds
TestRunner_userchan-tester    PASS      5.75 seconds
IncrementalBuild              PASS      41.39 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/hci_mrvl.c:170:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:203:23: warning: restricted __le16 degrades to integer


---
Regards,
Linux Bluetooth


--===============1760951501073745881==--
