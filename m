Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5C1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Nov 2022 17:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiKKRZU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Nov 2022 12:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiKKRZT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Nov 2022 12:25:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48300FCFD
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Nov 2022 09:25:18 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p21so4728018plr.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Nov 2022 09:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AAdnEZ6ygK81AuOqfgVMBD00aDFC6JxHBKfAtkA9KP4=;
        b=DV4rTNqjJ5fXupXkZKXLHyohFNU7FTmwTJaTWE8cIAB/Mvf1eFzfk3IJAyckrQhhcG
         Z4LNnYQIhJjyDW0qfR+4w0P08X/CfNPGgBGKmw6ihxL12+48hX/wjvVHmPPJumG11dHs
         W5FnrrwOTii5AhlNSKPh5vYOHOBsS2+ZwsuUo8ngT+UuQpoXiLfjB6IWDaUTsMwziwTi
         SAnXxyNJev6PMAOr3eo/FkUyjVixG4cBiHNKYp9ksNRp/VMcvtqZzVuKGFGY61kxZh1v
         j3rwjNbAX0rKrYBsyNk5ZpEdgRTeVwNn1B7XvBnOARMNtPY3RlzJpPyR5cgcfr6gtL8B
         5khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAdnEZ6ygK81AuOqfgVMBD00aDFC6JxHBKfAtkA9KP4=;
        b=GIGiK4LSKtQGrJF/6ufjv6mh6mU7A97NkESwFMuHXTm+xP+HKY/23N3xn/sVeOjStW
         20BzHBroP3AETP62NY+UneX2gEhMTMVZsF+ZzZpS+/5+jPZH6pZGqoTCQ/Uy/LQsXm47
         wTX96He79G4zKOOnQAPqxmtZznwgAp4TCasYWlmykyzeZBzU6h+yNI+nDyOmktx3j9wy
         pSjfiJe5KebO8ImJ2eowKs0pxUswA/j52nBGB8rXr+s55CQrY/ZMKZC5UtAvRR/6Nyb6
         /gTIGT1rVFdPHp0X5QHTsAi4+wtI+L7pTev3ezo8ccm7MNnkJGWznQhv5eDc2eZFsENc
         X5vw==
X-Gm-Message-State: ANoB5pk93E1cb6qqlGxum8iz+Wvc60dERMuNldpt/A3sJcYkYP83GqFg
        ybb02H7YzGwQ1Vmk4Ibm8OkO5bzYfZE=
X-Google-Smtp-Source: AA0mqf7RZybzXn/4EDdcoI0fBNT0itodjCu1eR7WcJQYnAdd5JAdQR/3cb+yoXXmCpFHbpRDCOAviA==
X-Received: by 2002:a17:902:9b8a:b0:187:4920:3a7e with SMTP id y10-20020a1709029b8a00b0018749203a7emr3420442plp.171.1668187516133;
        Fri, 11 Nov 2022 09:25:16 -0800 (PST)
Received: from [172.17.0.2] ([40.78.25.78])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902ed5200b0018668bee7cdsm1985225plb.77.2022.11.11.09.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 09:25:15 -0800 (PST)
Message-ID: <636e857b.170a0220.e16d5.326a@mx.google.com>
Date:   Fri, 11 Nov 2022 09:25:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1475663186679618056=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, drv@mailo.com
Subject: RE: Bluetooth: hci_conn: Use kzalloc for kmalloc+memset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <Y253EjjM0yvRGl+M@qemulion>
References: <Y253EjjM0yvRGl+M@qemulion>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1475663186679618056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=694573

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      48.47 seconds
BuildKernel32                 PASS      42.93 seconds
Incremental Build with patchesPASS      67.14 seconds
TestRunner: Setup             PASS      695.23 seconds
TestRunner: l2cap-tester      PASS      21.64 seconds
TestRunner: iso-tester        PASS      22.88 seconds
TestRunner: bnep-tester       PASS      8.53 seconds
TestRunner: mgmt-tester       PASS      139.53 seconds
TestRunner: rfcomm-tester     PASS      13.29 seconds
TestRunner: sco-tester        PASS      12.53 seconds
TestRunner: ioctl-tester      PASS      14.65 seconds
TestRunner: mesh-tester       PASS      10.41 seconds
TestRunner: smp-tester        PASS      12.32 seconds
TestRunner: userchan-tester   PASS      8.81 seconds



---
Regards,
Linux Bluetooth


--===============1475663186679618056==--
