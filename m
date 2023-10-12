Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B477CDB46E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Oct 2023 12:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378662AbjJLMBR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Oct 2023 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjJLMAy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Oct 2023 08:00:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22BF19A
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 05:00:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2773f776f49so646477a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697112043; x=1697716843; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uQg5NFejB36ARMTIEaFFf8ctRv0Upollbx9hy65E0fE=;
        b=RNpDWclyNPnc7y2CTu92j6JyM8698jl8QtTzL1WrWJexa12rlSLTQDnVJmNob3lUtD
         YWOjnPbbryYxkhoj8WF2GDTibMJJ6mv1jy3CSNO5P8xPNFveIXrn4pvGta6OzZT/mDdU
         81iGXS+4lPpNYIGF5JpzNfNr6rkcOIQ6ibEjc+fmpKb5Zu4IDum2vmI1Ql7C1P4Pg0J3
         pHIGWFd3Mj2AXi/hK6LR33h0lWr+9L+kREk+gj/9SPux6g9R8V1Gxuf42uf6Wuqq4i08
         EOSERRePnUWKuImpodPM339KuDOMCswor02kwpBNrnU69yD6rtG2zxiswqGUdfHIuRtX
         HE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697112043; x=1697716843;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQg5NFejB36ARMTIEaFFf8ctRv0Upollbx9hy65E0fE=;
        b=AdirRYxVc9VjPjLm2rpBQ40Jxl/b45rv/tqNIuP5Lc9IqCcczvSK0cLvY95mQPdjEc
         GRf5A9fyh5JOZDtqpd9251FCCRzH1bu36nZ1b2guy5a4EGxVRZMel1Jrzkr6hlAX5xdQ
         QczPUR/ajnI7zdlThvusQEOkkBbNVvy5F9lhV4MVDYe3UwnZuSsvz1VdHrqtGtaW1aY+
         ixEAG2Ni5d4oUxJeI2Iau6sT4fSZQn3BjFKqbBlNJf0HmNE3Qwj5OhJYxe/nOJw2E9kb
         /Rwur8fO2ZqTcBo4f3b6YcDLFHJgjsfTwMc5xszP8u0iTP233zkAGHvdJ0EURfbd2aDJ
         9uBg==
X-Gm-Message-State: AOJu0Yz+aImeFp5KLNjy/8mG03twguFLG4JkGQhdhG2Rc+pmGISIRBVL
        5DQio6FkNfuy/MZc9SerXRxUOZMDsS0=
X-Google-Smtp-Source: AGHT+IHFC8TWJWApBLsj3pVv903kGfHcRTKIsze0a5FpPTbO4aODFb+hzU0qCDydfS3jcrpFnVVaXA==
X-Received: by 2002:a17:90b:1bc4:b0:274:dd15:87bf with SMTP id oa4-20020a17090b1bc400b00274dd1587bfmr30293560pjb.20.1697112042995;
        Thu, 12 Oct 2023 05:00:42 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.0.230])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090ac58e00b00263cca08d95sm1659049pjt.55.2023.10.12.05.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 05:00:42 -0700 (PDT)
Message-ID: <6527dfea.170a0220.7e840.4f5a@mx.google.com>
Date:   Thu, 12 Oct 2023 05:00:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6688776822249080777=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, guanwentao@uniontech.com
Subject: RE: Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE
In-Reply-To: <20231012112118.11431-1-guanwentao@uniontech.com>
References: <20231012112118.11431-1-guanwentao@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6688776822249080777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=792565

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       FAIL      0.73 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      32.96 seconds
CheckAllWarning               PASS      36.09 seconds
CheckSparse                   PASS      41.61 seconds
CheckSmatch                   PASS      114.90 seconds
BuildKernel32                 PASS      32.27 seconds
TestRunnerSetup               PASS      501.00 seconds
TestRunner_l2cap-tester       PASS      29.43 seconds
TestRunner_iso-tester         PASS      53.55 seconds
TestRunner_bnep-tester        PASS      9.74 seconds
TestRunner_mgmt-tester        PASS      212.36 seconds
TestRunner_rfcomm-tester      PASS      14.96 seconds
TestRunner_sco-tester         PASS      18.38 seconds
TestRunner_ioctl-tester       PASS      16.84 seconds
TestRunner_mesh-tester        PASS      14.01 seconds
TestRunner_smp-tester         PASS      13.38 seconds
TestRunner_userchan-tester    PASS      10.16 seconds
IncrementalBuild              PASS      30.20 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
40: B1 Line exceeds max length (84>80): "Link: https://lore.kernel.org/all/20220420052402.19049-1-tangmeng@uniontech.com/ [1]"


---
Regards,
Linux Bluetooth


--===============6688776822249080777==--
