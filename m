Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C3EC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Feb 2023 10:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjBVKed (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Feb 2023 05:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBVKec (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Feb 2023 05:34:32 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EE1360A9
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Feb 2023 02:34:30 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id w42so7024538qtc.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Feb 2023 02:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jSd7TZmgBS9GECZDGzVZbczFpoJd7pPVaarSHn0tNgg=;
        b=LP69Yr3jkRkkf1V4Bete4APt2K6XTPv69v+b+xPezzrmAYxeHNbJsB1Ak9iiqLAMJJ
         Co/k89RZ+Ik6oe4izH7S+/QToWKvNoeUF8e+HIAuyazjUkA4cIxXcNXUNkAwWqdzs1EX
         Pf8VFVNBF3nLhFjAsyALESOueG5taBVpfYz9Fkkai4J2lxCCKLXgcJu3VN9zjMPlBAUI
         76w/qhllDGmc/c01Dq6mVU3V+u0RF8lsMLPqGdLVD76YIGG8cQ2LqEd4cGWRh8NhwPgT
         DBIb0WV0aKbN1nKfKT5p/CIEmSTOeeJsxu1sUCRfSxNRrOT6h0RziIvcDnOEgI+ob4Ut
         71hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSd7TZmgBS9GECZDGzVZbczFpoJd7pPVaarSHn0tNgg=;
        b=1SrSo5sgaTpH2TWJl7ntHBx9dUOtwByMk1vUQejfecmJ19nxzx7jRj9QnGcvbTEULS
         vntnxpIc+g480EA7jsmq8Uz4r3iN8fyg8jmte/IQRhapotVuyvuyfS4aHrNBMk++Zni1
         WsAhstC/FmdcNv9MnkewgVvMyneSCh7jew2URK9Xd73tNqYn1CSV78DHsunFtfyPgL2S
         hnyLRTkmRAeLQBbAgJqpy8EV95vbaQF692nEydJOYphrGhjpx3MfQTubd/f6R9GS2fNX
         0AQ4/SIWNVFYNKK/yjdKWgFfnKcXcJHMP0JZhALOLJi51+dpvZUs2dDX+A3CQDoouWW+
         aVgA==
X-Gm-Message-State: AO0yUKVhBsNgXp7iiy4LZhXD+wREp0zneB1RzvOckucO2QeT8A/yvyGl
        vZJkaFLjWhB40nKZ/iFKUXNnUxF9gq4=
X-Google-Smtp-Source: AK7set8u7Uno8Tb9Vbv25M2JGHoxIU31hH7N8w1dmxsHqOoXo/FtgLPnzlM0PZes/DaMOcygEWKV4Q==
X-Received: by 2002:ac8:5dcb:0:b0:3b6:3038:d4df with SMTP id e11-20020ac85dcb000000b003b63038d4dfmr14929685qtx.34.1677062069690;
        Wed, 22 Feb 2023 02:34:29 -0800 (PST)
Received: from [172.17.0.2] ([172.177.154.98])
        by smtp.gmail.com with ESMTPSA id 84-20020a370457000000b0073b692623c5sm673417qke.129.2023.02.22.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 02:34:29 -0800 (PST)
Message-ID: <63f5efb5.370a0220.5e6c0.14f2@mx.google.com>
Date:   Wed, 22 Feb 2023 02:34:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0917070537765980117=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, victor@allwinnertech.com
Subject: RE: [RESEND,v2] Bluetooth: btrtl: Add support for RTL8852BS
In-Reply-To: <20230222094720.67185-1-victor@allwinnertech.com>
References: <20230222094720.67185-1-victor@allwinnertech.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0917070537765980117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=724009

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.77 seconds
CheckAllWarning               PASS      33.88 seconds
CheckSparse                   WARNING   38.30 seconds
CheckSmatch                   WARNING   106.57 seconds
BuildKernel32                 PASS      29.82 seconds
TestRunnerSetup               PASS      429.32 seconds
TestRunner_l2cap-tester       PASS      15.83 seconds
TestRunner_iso-tester         PASS      16.17 seconds
TestRunner_bnep-tester        PASS      5.37 seconds
TestRunner_mgmt-tester        PASS      106.26 seconds
TestRunner_rfcomm-tester      PASS      8.55 seconds
TestRunner_sco-tester         PASS      7.87 seconds
TestRunner_ioctl-tester       PASS      9.10 seconds
TestRunner_mesh-tester        PASS      6.71 seconds
TestRunner_smp-tester         PASS      7.76 seconds
TestRunner_userchan-tester    PASS      5.56 seconds
IncrementalBuild              PASS      28.02 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============0917070537765980117==--
