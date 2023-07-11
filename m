Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB3FEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 19:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGKTFK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jul 2023 15:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjGKTFK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jul 2023 15:05:10 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56DD1710
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 12:05:08 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-635decc135eso33780676d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689102308; x=1691694308;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pcxfDD5WZY1RRkNvb80fVTsOpcZ1wCB4IQeh3DDrN5U=;
        b=EM0RPHrXBhDTKQNsfT2Bf8A4dawD3wfbkXBy4ELczBh4aLt2y22syRiKCOQpRjGzfR
         7/Dz/X+oHADwaV0IGsabiCHJPDS1ObLbffry9COlx1ApJgOVNfOgTht8TLXgb8MkxhYK
         rIgP6B8y2oReloPbzQltymC8YMfByX53KZqYrDraIPTM9DIqEXMUj8aGnrV0wLFKPm0h
         ecjGHU92N2W44rt9D2PtR7rUT3yyLfgBPJ8VPgZXdDR2UbQsFU9ujDkxLw8UjR0I8Ht1
         Y4w3qsq/ebVau59jOrIY+vgOFB+uhOp65NliGm5z7FP5+y1qQ7m4Fsmos4g5Jqi5zfTJ
         UXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689102308; x=1691694308;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcxfDD5WZY1RRkNvb80fVTsOpcZ1wCB4IQeh3DDrN5U=;
        b=Ww14INvCalA7xHvDZDYMTz1CwC0Rw5ncZlqXbP+OV/3Di40TYnrMZtt8EDF2vL6JSJ
         X6rDSGGGo1crEQsuzFUOjztW8B46bm2rzOrzYs/sH+izs4d+lJxDy7CcfOTuCh31pb+/
         AKxZqQoV/d/aWoCVAvys/PTol92NYs7oNcVBHB7AfEHVE2vejV/R4SfOLhRYBJwWqCRX
         Aq/e/sfiKWkVjdJXxWGZZjs3G7ong3Up8CPQpJNsp0yq9Fk9p/1OpLO0nNV04gOFhSgv
         djQTCvdNGPnLSKud0Ryl36GCuZqp3CowqBY1XbPbf/xByJIetMUVqZYdbmbJezLLPcAC
         X3Ow==
X-Gm-Message-State: ABy/qLYp5rp2ZGZpdtFIHnRSi8/OEXhxfIYO/g2D6VR0l9aqkmCbUKD3
        aFOL5zPaildv9qN8G74naqbu/ifYshl34g==
X-Google-Smtp-Source: APBJJlESZJYhpytggolG9HUa2eLhDv4ks7eSs3fUW5Y2tnU2mrWUb2knJNU0fcMe+ucobLMo4uHrJg==
X-Received: by 2002:a05:6214:d05:b0:631:f590:69bd with SMTP id 5-20020a0562140d0500b00631f59069bdmr21765890qvh.25.1689102307821;
        Tue, 11 Jul 2023 12:05:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.14.54])
        by smtp.gmail.com with ESMTPSA id d25-20020a0cb2d9000000b006166d870243sm1404609qvf.43.2023.07.11.12.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 12:05:07 -0700 (PDT)
Message-ID: <64ada7e3.0c0a0220.c05e9.4af9@mx.google.com>
Date:   Tue, 11 Jul 2023 12:05:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7530365940575496733=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rgammans@gammascience.co.uk
Subject: RE: Bluetooth: btusb: Add support for another MediaTek 7922 VID/PID
In-Reply-To: <20230711175743.20606-1-rgammans@gammascience.co.uk>
References: <20230711175743.20606-1-rgammans@gammascience.co.uk>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7530365940575496733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764543

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      33.53 seconds
CheckAllWarning               PASS      36.66 seconds
CheckSparse                   PASS      42.19 seconds
CheckSmatch                   PASS      113.29 seconds
BuildKernel32                 PASS      32.36 seconds
TestRunnerSetup               PASS      494.07 seconds
TestRunner_l2cap-tester       PASS      23.55 seconds
TestRunner_iso-tester         PASS      42.13 seconds
TestRunner_bnep-tester        PASS      10.85 seconds
TestRunner_mgmt-tester        PASS      223.90 seconds
TestRunner_rfcomm-tester      PASS      16.23 seconds
TestRunner_sco-tester         PASS      17.11 seconds
TestRunner_ioctl-tester       PASS      18.39 seconds
TestRunner_mesh-tester        PASS      13.72 seconds
TestRunner_smp-tester         PASS      14.58 seconds
TestRunner_userchan-tester    PASS      11.58 seconds
IncrementalBuild              PASS      30.78 seconds



---
Regards,
Linux Bluetooth


--===============7530365940575496733==--
