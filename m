Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8716EC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 18:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCPSgY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCPSgX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 14:36:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A588AAFBA1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 11:36:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i5so2758625pla.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678991782;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p8hVVCbpl+MhQUe0P4IWqjtdM7bJ/rtk8BXU6oKRlX4=;
        b=Cx7fSJ5+AM8mGTlW/7556STdsCa54dE37YYroghjE1JvRqe79dRB9ao6bgAqp1NP1z
         9pSx8BNh3w4wxzz38ZC8uDuIoV/8LWA7meuaY3z0FWWvcp227kWjDQgZpUjSoYSFlZX0
         j4PqUigMP/LzOcWGSv6wnCDApzIbmwx95SX9IwkgUthRChSbeQfRccDN5tvA5SQUGsMZ
         VebCOX1ih0uKQYOIIASSuc3DJF7Hp9DJO6mR6ABFCZFee98W2doimLEfEnA3qdaypRVr
         FGLFQGadxWB7CJsQkbce9E/c04LuWGZgxDPkBCLLjjLJENVPIB1KFr+wF49ipDHOKxz+
         sLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678991782;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8hVVCbpl+MhQUe0P4IWqjtdM7bJ/rtk8BXU6oKRlX4=;
        b=w1juKzAaURO1QJCQbkvSthT0HW3TncdkAVigN5lr6WkuqhP+JCsHowvYUyEQ9Yf6E2
         jYZJyNnT0RXYYVLBqOaTPg1SsRBfdDEfENpfkvY7yp/h65ohCmxaVnjSGrUbTc0KMehR
         SGWQXfjSIvZi4aW+3gjsonu8rhseAWq9PKgeUH3yIQEJK7j8mbI516TbxP7klkYRO6wE
         tmBATbjsqKwJ+nJwLj5vAbttsJTqfzDGHfP+Da+BEepU3vZ3HN5W0vxnY0g4P068bvWZ
         /SJT3pMgGZvZxPtRK3VPb692th43Js01grQ9YCqhE6bMdVBA9CnWa7vLOkbNR/TFaM08
         ZQvw==
X-Gm-Message-State: AO0yUKX4caI6x+7mIml3d/2vV/QGxjlV4t23JPXPoT9yFigan2wDm0p2
        0OljMU2uT/BJF8XZj8cBIc6rBYt4V+w=
X-Google-Smtp-Source: AK7set9L6odw1eeuwFMAc+us27oOkgg4hGdy7SvOk8f3sDrZit3RC9UMC1yWeQ5L/Z9JufBPI23Xfg==
X-Received: by 2002:a17:902:c711:b0:1a1:85d4:a773 with SMTP id p17-20020a170902c71100b001a185d4a773mr2972826plp.69.1678991781900;
        Thu, 16 Mar 2023 11:36:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.19.52])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902b28400b001a19d4592e1sm9188plr.282.2023.03.16.11.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:36:21 -0700 (PDT)
Message-ID: <641361a5.170a0220.596d0.0079@mx.google.com>
Date:   Thu, 16 Mar 2023 11:36:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8099517483561396776=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230316172214.3899786-2-neeraj.sanjaykale@nxp.com>
References: <20230316172214.3899786-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8099517483561396776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730917

---Test result---

Test Summary:
CheckPatch                    PASS      4.76 seconds
GitLint                       FAIL      1.37 seconds
SubjectPrefix                 FAIL      0.69 seconds
BuildKernel                   PASS      32.32 seconds
CheckAllWarning               PASS      34.53 seconds
CheckSparse                   PASS      38.93 seconds
CheckSmatch                   PASS      108.72 seconds
BuildKernel32                 PASS      30.64 seconds
TestRunnerSetup               PASS      435.92 seconds
TestRunner_l2cap-tester       PASS      16.51 seconds
TestRunner_iso-tester         PASS      16.51 seconds
TestRunner_bnep-tester        PASS      5.41 seconds
TestRunner_mgmt-tester        PASS      107.20 seconds
TestRunner_rfcomm-tester      PASS      8.60 seconds
TestRunner_sco-tester         PASS      7.85 seconds
TestRunner_ioctl-tester       PASS      9.17 seconds
TestRunner_mesh-tester        PASS      6.77 seconds
TestRunner_smp-tester         PASS      7.76 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      43.53 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v13,3/4] dt-bindings: net: bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
20: B1 Line exceeds max length (87>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============8099517483561396776==--
