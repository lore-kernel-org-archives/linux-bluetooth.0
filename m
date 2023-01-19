Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0529DC677F1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 02:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjASCoU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Jan 2023 21:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjASCoR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Jan 2023 21:44:17 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EF06D68A
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jan 2023 18:44:15 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1433ef3b61fso1091263fac.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jan 2023 18:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5aWvWMMr5mJBRgmUAyLe5Dyn6w74gnkUeVPCdGCFfMU=;
        b=NzZity7O3ex8Av6UfOvrD+wqfc8CVzZTbGV/b5TEAPQRTEO9k2E7pac7IMYhvWhW2C
         5HhUa8gCOW75TtyH9/WrOWCXw1NSJqmeV5RS3QzGR/DpZCZU0G4ZYLaTjVi24XRgsIhN
         vBtowhgsvLhAb4nTVJeQrML3a2GlG0SO5DF6Q6zfXXkbtaNv7Qw72XxvGHXYtQg+UsVr
         ODti+2jmpZE8umcDgyn/i4aMeSa4Lry58u4yYvrnY8fdx8fN6lO9q2Fi99b8o1gA0uiB
         olgVW/wpVTsVOoY4Jbqrv4igmyrqU4smtig5GskK8ej2gkmrEeVaDBRQPy35A68gUJw6
         +QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aWvWMMr5mJBRgmUAyLe5Dyn6w74gnkUeVPCdGCFfMU=;
        b=pbYns5UCjzHmNGad7j1SSXaPcrYulo63p4wBZj/j/SFBot115hDkWthprAGJIxvUjt
         MDcJocwN0Hw0XBM2nCAKuPu6DKJciz5wXAOFXTpX2dqwydRi+23X2ceYHqoMMB2oF17z
         HxvxVnGesCLRw4vVlpbmGBwxiuWPK58NVyuDgXPqcq54Udo4N/RLqUsnTsrtDFMRiGLq
         hM7AH5DOZHpSsh/eyg9RlP3FiGOgnmYQsZFaf2DEu8HoES3kxuNv1iJFB68m+3mjRbr6
         iahlB+nmTUC3s0SRlvJueoV9WpaV1lObnwEPUS47kpsziOT6GjbyuslTv1gbe2n9KUd5
         keug==
X-Gm-Message-State: AFqh2kpttexHWNo5oH0C62Ej8Nd9kOLckf9xNS97cqIYIjgU8mAR7Hqf
        +UPQO7KYlbqPvDiFHDNe7y75qpUJ6R4=
X-Google-Smtp-Source: AMrXdXvjArPft+vXPywHutupJQHCN6eOpgVDwT/iso+HUrWRQC5HmshnSQN2CITspXPHJUHh9TrfmA==
X-Received: by 2002:a05:6870:5386:b0:15e:efc5:35fc with SMTP id h6-20020a056870538600b0015eefc535fcmr5861820oan.30.1674096255000;
        Wed, 18 Jan 2023 18:44:15 -0800 (PST)
Received: from [172.17.0.2] ([52.171.137.242])
        by smtp.gmail.com with ESMTPSA id s18-20020a056870611200b0014c7958c55bsm19437537oae.42.2023.01.18.18.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:44:14 -0800 (PST)
Message-ID: <63c8ae7e.050a0220.1969.ec73@mx.google.com>
Date:   Wed, 18 Jan 2023 18:44:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6328152759138672670=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: L2CAP: Fix null-ptr-deref in l2cap_sock_set_shutdown_cb
In-Reply-To: <20230119013405.3870506-1-iam@sung-woo.kim>
References: <20230119013405.3870506-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6328152759138672670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=713481

---Test result---

Test Summary:
CheckPatch                    PASS      1.94 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 FAIL      0.53 seconds
BuildKernel                   PASS      38.21 seconds
CheckAllWarning               PASS      41.62 seconds
CheckSparse                   PASS      46.12 seconds
CheckSmatch                   PASS      124.89 seconds
BuildKernel32                 PASS      36.50 seconds
TestRunnerSetup               PASS      513.51 seconds
TestRunner_l2cap-tester       PASS      18.77 seconds
TestRunner_iso-tester         PASS      19.40 seconds
TestRunner_bnep-tester        PASS      6.99 seconds
TestRunner_mgmt-tester        PASS      123.49 seconds
TestRunner_rfcomm-tester      PASS      10.74 seconds
TestRunner_sco-tester         PASS      9.58 seconds
TestRunner_ioctl-tester       PASS      10.96 seconds
TestRunner_mesh-tester        PASS      8.25 seconds
TestRunner_smp-tester         PASS      9.34 seconds
TestRunner_userchan-tester    PASS      6.94 seconds
IncrementalBuild              PASS      34.93 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============6328152759138672670==--
