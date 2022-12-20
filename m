Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8989C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Dec 2022 01:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLTBRT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 20:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLTBRS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 20:17:18 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053EC2B6
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 17:17:18 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id a9so10737460pld.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 17:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9dXBFLZUVfPO3OY8D1NlO4Wo1AqAwNDpt1c8coNZFM=;
        b=FQYirILutGau/0CpO0/HYmC8kchu5CXPzB+Ubi2elgnYOVKJx1T4I0MhFbGCVe1zJ9
         EQ63rZPqm87Vd3afsaSA5nqABXBhATM1+Nd9lFp1CeEzePN9QYuL71/kvwBkB7QHtlLL
         37QT5vNdImK03x88OVBhWQgumHaC67wV+rQXfLYg/t0WbEu2XD5UB9pU1s1LYikMBskJ
         MjM0oJUKAz8F6COArbZx9qMfNwlLOhGhjVTh7AFQWGmJ/IRjxkKCSehWAGQSwp9ODlWK
         3NoTBF8BUdC4rPWQqtKcjpqb7wFrjcDyDyCn3xAiTUpGg6BXUmHn9zhb5gYxhLtV62l+
         EigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9dXBFLZUVfPO3OY8D1NlO4Wo1AqAwNDpt1c8coNZFM=;
        b=GQio8pGKgy4xdJBud7/K2hbbZphbnZfy2CRBWCYUhArJbEcquI9ILgF2JwjB0edwf9
         QR8Mg9smE9tUBxfreyptBzD7wle0IiFWJbkBGKP/ht68BN1qJsfke0hjrfmNGCYNtyGP
         v+Annin1pFU151mvF4zk9gDUYhwBltztSzcL/FEA2ypk5VWzcofSWnFAk7MFzqa7m+4i
         evv7Tl3ITdMosAyFayqJT3jbZKHc678TnjhumAeoNLi15/mgavIH2dwWIUbARGLYW4E/
         4qiTkYg0ZJbhL8w+OTbD0OAgr9a8ioFLFaMM/SqN8DwDuB2p8JH9FMyKOZjJYSkp2vhB
         1Nlw==
X-Gm-Message-State: AFqh2krUP04zmsCEjQtNO3n/92xs0xxnLo/y5opIJR38XWU+yOw12g4t
        TbMWEyeg4wUJj0fbqt9C3WPs+XbFPRk=
X-Google-Smtp-Source: AMrXdXvdPBOEI/MuhC8zk5k69oAcBnp8Irxu/5JYIyVJh15OcSbP2CUqC/z+ZLfdqwgXSADtY3a9nw==
X-Received: by 2002:a17:902:ead5:b0:190:f25a:2549 with SMTP id p21-20020a170902ead500b00190f25a2549mr21599547pld.14.1671499037228;
        Mon, 19 Dec 2022 17:17:17 -0800 (PST)
Received: from [172.17.0.2] ([13.64.11.208])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c1d400b001891ea4d133sm7826001plc.12.2022.12.19.17.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 17:17:16 -0800 (PST)
Message-ID: <63a10d1c.170a0220.469e8.db1b@mx.google.com>
Date:   Mon, 19 Dec 2022 17:17:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0770923692169326330=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix use HCI_OP_LE_READ_BUFFER_SIZE_V2
In-Reply-To: <20221219234945.3733741-1-luiz.dentz@gmail.com>
References: <20221219234945.3733741-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0770923692169326330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=705763

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      41.88 seconds
CheckAllWarning               PASS      44.97 seconds
CheckSparse                   PASS      51.03 seconds
BuildKernel32                 PASS      40.74 seconds
TestRunnerSetup               PASS      580.88 seconds
TestRunner_l2cap-tester       PASS      20.21 seconds
TestRunner_iso-tester         PASS      22.14 seconds
TestRunner_bnep-tester        PASS      7.14 seconds
TestRunner_mgmt-tester        PASS      133.77 seconds
TestRunner_rfcomm-tester      PASS      11.21 seconds
TestRunner_sco-tester         PASS      10.35 seconds
TestRunner_ioctl-tester       PASS      12.25 seconds
TestRunner_mesh-tester        PASS      9.23 seconds
TestRunner_smp-tester         PASS      10.31 seconds
TestRunner_userchan-tester    PASS      7.77 seconds
IncrementalBuild              PASS      37.78 seconds



---
Regards,
Linux Bluetooth


--===============0770923692169326330==--
