Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ED0C54EBC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Jan 2023 16:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbjAJQjI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 11:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbjAJQjD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 11:39:03 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F43D3FCAD
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 08:39:02 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id b81so5875874vkf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 08:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Jt9N/C7klIe867ZBsPCOwbXqA2BPaacAn4Hv6YmaJc=;
        b=CPi7F5nheKNVqos7ar7+oIG76KWKEO001ibgR23sZLOjeK7lfyX1sYn+1IpOrCth0v
         wYsgvLHoPt6myMqgxb7lZwcTw9+2lrmcRnEBoIVFQn8X/3ZVq/CvA/aYvGb4aWWZOJR3
         n6b54Zw8HpN2izbM8HN0hfXQ6WNNDQ1LU9cPKvYyZtvRj5ihivR2adf7EL7y81PlDM3D
         tECE+x1A1kDdCgwgQAYuSviFIQDBYoFXk+zMo9NUjaniYwBVao7HGe4rJ/GFXoeemxaC
         wluDR0FSbwMrtynZov1y1zOTdULzA+Q1wr/veIFwb50XqebI/Efy0rOsedG2w0BnG7LL
         wp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Jt9N/C7klIe867ZBsPCOwbXqA2BPaacAn4Hv6YmaJc=;
        b=ixeylCixcq4O4X0fZ0isoOxjugOZVCfVzfjr5yVHZAmLYKTGR3qOgbscWxjED8REYF
         hgKGXu38jRKPt26iJZ4bBNq0B05UbEGDoEZhwOOV7DlCgYqTJcQU5iGKNVcumbTbJqNv
         x2vhzhA/j3I6SWjDBGTKKHSBUQeIjiyRaQYELXVCAxTp5FusnCngRAyUX/49AtL8UZz3
         mhvAmLTAHPaL1SkkRXP5de9U0TjhViuQACbqF7Pdk79EX9PxulPy9V8o7tAu5BnoagRO
         olmIFs2jT9mdD+WIvjx3RIB+gkVcFnyKz1w5V0A8rPom9uNHcSBu7RxW/TsBO7m1nYVG
         1lYA==
X-Gm-Message-State: AFqh2krFDyP3pdWEYuvcNTMywnMth1v5Qpuc8Y3tz+xAfJF2cJBFAZtR
        TvYuDjR5G0cSH8nE7M0B8vVuw6SW8u9JGQ==
X-Google-Smtp-Source: AMrXdXtads5aj3dLgKlxnLuYfGFno+tj3yemVkhiCJFNMPxvdJlKJZ2886Bwol6HFtbBIEBANVEMQQ==
X-Received: by 2002:a1f:f808:0:b0:3da:de07:66a1 with SMTP id w8-20020a1ff808000000b003dade0766a1mr2439518vkh.14.1673368741225;
        Tue, 10 Jan 2023 08:39:01 -0800 (PST)
Received: from [172.17.0.2] ([172.176.188.83])
        by smtp.gmail.com with ESMTPSA id c15-20020ae9ed0f000000b006fafc111b12sm7360464qkg.83.2023.01.10.08.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:39:01 -0800 (PST)
Message-ID: <63bd94a5.e90a0220.f4937.7273@mx.google.com>
Date:   Tue, 10 Jan 2023 08:39:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7324271556850117736=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] btintel: Add recovery when secure verification of firmware fails
In-Reply-To: <20230110155905.18203-1-kiran.k@intel.com>
References: <20230110155905.18203-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7324271556850117736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=710575

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      32.29 seconds
CheckAllWarning               PASS      35.00 seconds
CheckSparse                   PASS      39.88 seconds
CheckSmatch                   PASS      107.37 seconds
BuildKernel32                 PASS      30.46 seconds
TestRunnerSetup               PASS      441.80 seconds
TestRunner_l2cap-tester       PASS      16.27 seconds
TestRunner_iso-tester         PASS      17.18 seconds
TestRunner_bnep-tester        PASS      5.80 seconds
TestRunner_mgmt-tester        PASS      110.21 seconds
TestRunner_rfcomm-tester      PASS      9.07 seconds
TestRunner_sco-tester         PASS      8.33 seconds
TestRunner_ioctl-tester       PASS      9.87 seconds
TestRunner_mesh-tester        PASS      7.24 seconds
TestRunner_smp-tester         PASS      8.26 seconds
TestRunner_userchan-tester    PASS      6.08 seconds
IncrementalBuild              PASS      28.91 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============7324271556850117736==--
