Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA92C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 03:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiKRDsG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 22:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKRDsF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 22:48:05 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EAB8F3E9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:48:04 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id h7so2011638qvs.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=evnZuKl1YpWxdySE3eyTwoCpqGtGPn8Kps6E20JddnU=;
        b=lvxcvWVPuL5zxHjbL9P70kl+BAOfhYjRgQIYQ294Xikp0110kZpGRGiv18bO8FtXts
         lTSnOEtJX+rlcPHvrsti6NlDbSXGwtps0Xtc9ycyZalrReYpRGL7N2EjP8MlC2j6/pj9
         ybiEte38wCMxAazaterFX+Mg+SRjH+XzB9rt3PTRbLgx7X8jc7sAl53QEHGYCsore5SV
         gl3LhDm8GHrs4PykmTAjy5AcsBNf296MNdbiQjZ7PJS663dEZA84bi7d7Tfax9JwXb6o
         2zJSrRXNMD6yEyRILiIe/008zAodZpmf1Fcq1WmN/UP8kM+UcWLNPqo9y2fWVUmEfCl6
         L4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evnZuKl1YpWxdySE3eyTwoCpqGtGPn8Kps6E20JddnU=;
        b=nucVMxoG2p8ryQjNRhvl9WwBILQhKsv7EwNxc9mK+y9lBlk1Wvg1EZtY5j4UvlZ5m2
         MdqwmESq6K+9U2qV7CijA69p18JT8r0tuZeBp+NkxQlzufKSolgdPIe6q2HsGRQQZYLN
         kxTz4u7Q7N0ZH2GSQcxg/1DDnlwUy0M4pr/yHagfhnfD7/2nIepxLHngQeHqIg6/HfX9
         J8sG92j1cY3+LqI66DQiDAIbtuvDeIizdWrNXGAQrwTGELthTh1XjA5laT+jYfATuOCa
         t37PH06IfbGyYLG2a4Z1FSJgGHl3tEcdJ7n/X0esHiJdUY3sHUYD3afD/0+k83jPk9uW
         I+xA==
X-Gm-Message-State: ANoB5plSYRLVJ/ugGjqBTuHujbXoZ9EDhsojGzVk0O9s4E6hW9SS1Gwl
        1s3te/hoMRVQgFqvYLDGzYFSkWg1KkDu8A==
X-Google-Smtp-Source: AA0mqf6i4v8n8VmEwfLQor/8A8GmfSNQZGaIziacDs4SU0dG7Px3h1pzNFo7G8lB6CFylwADY/9OPw==
X-Received: by 2002:a05:6214:5504:b0:4c6:9399:9335 with SMTP id mb4-20020a056214550400b004c693999335mr1100972qvb.12.1668743283457;
        Thu, 17 Nov 2022 19:48:03 -0800 (PST)
Received: from [172.17.0.2] ([20.1.150.230])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006fab68c7e87sm1769819qkp.70.2022.11.17.19.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:48:03 -0800 (PST)
Message-ID: <63770073.050a0220.ddc61.8ec3@mx.google.com>
Date:   Thu, 17 Nov 2022 19:48:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3749455180936171503=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Fix MSFT filter enable
In-Reply-To: <20221102175927.401091-2-brian.gix@intel.com>
References: <20221102175927.401091-2-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3749455180936171503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691340

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.67 seconds
BuildKernel32                 PASS      29.93 seconds
TestRunnerSetup               PASS      419.51 seconds
TestRunner_l2cap-tester       PASS      15.73 seconds
TestRunner_iso-tester         PASS      14.87 seconds
TestRunner_bnep-tester        PASS      5.45 seconds
TestRunner_mgmt-tester        PASS      104.00 seconds
TestRunner_rfcomm-tester      PASS      9.12 seconds
TestRunner_sco-tester         PASS      8.51 seconds
TestRunner_ioctl-tester       PASS      9.66 seconds
TestRunner_mesh-tester        PASS      6.84 seconds
TestRunner_smp-tester         PASS      8.40 seconds
TestRunner_userchan-tester    PASS      5.59 seconds
IncrementalBuild              PASS      30.91 seconds



---
Regards,
Linux Bluetooth


--===============3749455180936171503==--
