Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6475DCDB47E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Oct 2023 20:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJMUqa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Oct 2023 16:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMUq3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Oct 2023 16:46:29 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAFAB7
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 13:46:28 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77acb04309dso96655839f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697229987; x=1697834787; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sBw308EVwLwLnSwyTsv/f2lMHofPugvRBWj3PEakwSU=;
        b=bcTEypbmHlVo4IsRVxdy0ihLKoQQdF139EaLuH3CJpNyrOYWOhn2QjLcjJf07U2xQU
         FeCk6nG/F8zFuOLudfDXQS8ZztikIuaSiXpUMiPPb3s9XRr+mtCPLto2t0Rd51343muk
         OwYycicTg6fzjbGjthj3XczWGjNJwWsRnSx3KzNsEVQEK2C/UrLyNA3Nsf1vt8afBOdZ
         9AX29mOMfi5wfS+xciyZU8cMju7SQKAeQSvtxrxkKcxSeVzF44+YJ/6g7F8oyBY263Wx
         wnaZ4nq4/PzNuUjwkBTwgtq1uiFeKgpgfG1PSfCaa3wOuniKvwo8tsm7UZV2paDFah7F
         BGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697229987; x=1697834787;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBw308EVwLwLnSwyTsv/f2lMHofPugvRBWj3PEakwSU=;
        b=Vif2hvVGBB+OMSLcrutCoskst34GxCXFZTem9eZpVASO8ve5bZMK60yZxGuPH2bHyJ
         BPmv6Jobf6je5nMkCel9NHaUHOfKDm5exYFG7/UxshidkNeKKrQersdnAmYzfy6gataS
         /I5Mq0350qx4H/JAqhKgKpJKtFakvBw4JBVaQIZ7/5vH5cDoTqBXA61ytnnCNKjkEiLh
         NHZbK2/PBKS/To4Xb6pFn7qJc/BqMcTv+oWoXmPglrMlZ4YN9vLrh2afnON9HwP//TaH
         GOzcCSRPd+LFZbWrrwj6Okrtx2hY8bq/QVkI/6Th43tWU8KbSyTvI4TxReotQBKB3Gxy
         +j/g==
X-Gm-Message-State: AOJu0Yw7u+iiU0odUy06kffmK2Uuzu0QaOaM6cZc0g9il8AxYwWligq6
        PrnzJRe1LK5hZLT4PS8QbrFb2njl+zs=
X-Google-Smtp-Source: AGHT+IE9D6i25upgmwoxHrtT5S9ewBYf6U5/qpZmEOVjG1zk+1NfqwIVz5Wk2PDqRXXuL2VV26mmvw==
X-Received: by 2002:a5d:9602:0:b0:79f:e481:fe31 with SMTP id w2-20020a5d9602000000b0079fe481fe31mr32803505iol.3.1697229987224;
        Fri, 13 Oct 2023 13:46:27 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.66.37])
        by smtp.gmail.com with ESMTPSA id b9-20020a05663801a900b0043a2736987fsm4807669jaq.11.2023.10.13.13.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 13:46:27 -0700 (PDT)
Message-ID: <6529aca3.050a0220.97f0.70b7@mx.google.com>
Date:   Fri, 13 Oct 2023 13:46:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2154533761895487936=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [kernel,v3] Bluetooth: btmtksdio: enable bluetooth wakeup in system suspend
In-Reply-To: <20231013124707.kernel.v3.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
References: <20231013124707.kernel.v3.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2154533761895487936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=793127

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      47.77 seconds
CheckAllWarning               PASS      52.05 seconds
CheckSparse                   PASS      59.67 seconds
CheckSmatch                   PASS      158.06 seconds
BuildKernel32                 PASS      45.80 seconds
TestRunnerSetup               PASS      711.93 seconds
TestRunner_l2cap-tester       PASS      41.15 seconds
TestRunner_iso-tester         PASS      85.08 seconds
TestRunner_bnep-tester        PASS      13.14 seconds
TestRunner_mgmt-tester        PASS      274.82 seconds
TestRunner_rfcomm-tester      PASS      22.48 seconds
TestRunner_sco-tester         PASS      26.06 seconds
TestRunner_ioctl-tester       PASS      25.54 seconds
TestRunner_mesh-tester        PASS      18.81 seconds
TestRunner_smp-tester         PASS      19.46 seconds
TestRunner_userchan-tester    PASS      15.54 seconds
IncrementalBuild              PASS      42.75 seconds



---
Regards,
Linux Bluetooth


--===============2154533761895487936==--
