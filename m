Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C53FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 07:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiKRHdu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbiKRHds (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 02:33:48 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E0C6CA0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:33:47 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y10so2668964plp.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DtnyNFvJsaUwlrJQG5web/Iyd0BcJgFHEwWKQqRbZ34=;
        b=Tvs0+pjPdMqHKnD009PBGDm9YFLwA/XVCKmYweO3UT5ofHbqbznloNcb7WF78k9JQ6
         BEJXfUy/MoFcaG3gJqIN54X2xOV2f9o8OpSJyF0PO7ygdWh5YNnqxSXd89G+8y3S+leP
         NjNR8kVPXhYJ/o0YAi3SWGzb/YfoWmcH0ZVbG2z76L8bhhg/HW5iXcLZ12+SjQTL+5ve
         nd0XUT/yu9nrDkULZHbtQLbOP5xDn5qSBcA+/jAz6pXMwSzJSApS+ylYSBI7lL14xoyI
         b0+foZAqGG1RJbvQPNiQM7SD7ojVxADsr4WFTY4WB82d5T6gnuvgdcmbLlJ4x3ToflWi
         lLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtnyNFvJsaUwlrJQG5web/Iyd0BcJgFHEwWKQqRbZ34=;
        b=mZjYW+5mg4yIGgyE0Ezimj6OYG2qwTbsWEVRPYX7BS+HbgIjsXn9aVqrOYC8yGk3gR
         F+d3KTBeNS9c0pt5ZAksXvzc8jtnRDSFI4vzrGAQa/jdG1SbRW3wQV830uMW9JG664mf
         tqo2ZE3mRO2uyF9tHzUNZDtau2MmnnpimTg44eG9p7wGwSTIi0BeMcRMzbcKTNpd8ap0
         D7uxXqAgBmAp/zLBEXBRoMSRfeiGzat3JNUe6wCaj9NtQs4xYgDTJnbpF1GZA7a5vgcR
         zJxDK19UljRJ4R9jxOYBEBPZDAQfeOi3agVPLZAJzkeI02Jq7BzklA15oFhKZJmSWqGO
         WWmA==
X-Gm-Message-State: ANoB5pnQx2tKRYVeUY5rMZkKwvx4KHhM39zXr4yhgussOBkXuvLroZ8T
        rrmwK6NU2L++D0rXqe+85zIED1kzwc4=
X-Google-Smtp-Source: AA0mqf43CTqgVQyipMNQ/wAVYiJuF03JSS0+M9WIZOkkqeq13wQhYJBjE9/bdHEul0qrlvc0X/A4Ow==
X-Received: by 2002:a17:902:7686:b0:186:9c25:7ef0 with SMTP id m6-20020a170902768600b001869c257ef0mr6205947pll.164.1668756827077;
        Thu, 17 Nov 2022 23:33:47 -0800 (PST)
Received: from [172.17.0.2] ([40.112.250.245])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7940f000000b0056bfd4a2702sm2438054pfo.45.2022.11.17.23.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:33:46 -0800 (PST)
Message-ID: <6377355a.a70a0220.e6cf7.40d1@mx.google.com>
Date:   Thu, 17 Nov 2022 23:33:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6748958978318991400=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] bluetooth: Remove codec id field in vendor codec definition
In-Reply-To: <20221104071810.22720-1-kiran.k@intel.com>
References: <20221104071810.22720-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6748958978318991400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691972

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
GitLint                       PASS      0.48 seconds
SubjectPrefix                 FAIL      0.53 seconds
BuildKernel                   PASS      43.60 seconds
BuildKernel32                 PASS      39.06 seconds
TestRunnerSetup               PASS      543.72 seconds
TestRunner_l2cap-tester       PASS      18.47 seconds
TestRunner_iso-tester         PASS      20.19 seconds
TestRunner_bnep-tester        PASS      6.84 seconds
TestRunner_mgmt-tester        PASS      130.27 seconds
TestRunner_rfcomm-tester      PASS      11.56 seconds
TestRunner_sco-tester         PASS      10.69 seconds
TestRunner_ioctl-tester       PASS      12.47 seconds
TestRunner_mesh-tester        PASS      8.95 seconds
TestRunner_smp-tester         PASS      10.31 seconds
TestRunner_userchan-tester    PASS      7.17 seconds
IncrementalBuild              PASS      48.29 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============6748958978318991400==--
