Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6B5C001B0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 07:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGGHGR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 03:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjGGHGQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 03:06:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11061FDD
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jul 2023 00:06:13 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-783549ef058so54820039f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jul 2023 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688713573; x=1691305573;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/9Rg2wrcQ8DT9aFzHRHv6JOnPAbIFQScZXGYaxP0mfk=;
        b=aZO8pw1jwjyApjZ6G9iP/9Y7l9herQa4kZcQloq2b3fBFMM+v77O+nnJnFTmF1QHXJ
         j9fGykhTvKCXlxbLtQoxtsgd5Yyo13la4vOQv1aJwGzyriefC4sSVfcZgAQLEpEuRL5J
         2joWsf4pARYos/uWilnZFLgntNAGSRmM+JdRSvz5NLlgw92h4D6gTp5PO6YnEMFo7qx9
         lDOH0Ih2octpxL63xgFlVW8B2ti5DVgdyLyhMybcVg4mVfjp52qUa3PF2exGcC7ZJNQn
         KDKGGlqDGwYXm+C+ytttCtLWLFYYIdipkLsUa/dI2PBb16jmp2WprDRQ11jHEggKD2nl
         i1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688713573; x=1691305573;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9Rg2wrcQ8DT9aFzHRHv6JOnPAbIFQScZXGYaxP0mfk=;
        b=iXHEDrFs8iyhBFkBCqzy3vAD6LPNH3tFysyhQXIjg8GjVXrc66Jbgu2MIFWJe7upHk
         V35HDMUHUMlbxG0g9P1IPyJsmvOxCrqUZmr/Ktkqgf3zTGnlnDuzpd0aFb1kbWx+1UUF
         TvXKUHUibAGyg0gQUra0yXgr6jZNDVZljd+r8wJofuhoJHJvmCfvw5ggfmrzavm2P1G5
         noKvrtNQEUsSpYdbhYebS6jNRsSHvuM+LE8mVKZUOUcpaMsTGhNVMVMdBc6gmAtcu4gB
         4BhTcLypnP/0OEJ1+DvNZWAVKu0lR6j+Flw7NP7Mf+s7Fm8fL+gjMOC4QTdhzSBbqa0B
         FR9A==
X-Gm-Message-State: ABy/qLYgjUfwvGFGFwxzTYBF03dLwRjSAFrlvihVWDSz3DY/hVjUJn6S
        XYzAgpDSoCRhKNhoyv/g0YJ/vKSrjAY=
X-Google-Smtp-Source: APBJJlHUupS0eEAwqI3pJ4NULApWhQUJ9SwH2tN5vrMQ2cwvBt5RlHprnUnppzIAuW4Q6B5e0vV/wQ==
X-Received: by 2002:a5d:8252:0:b0:785:cb8d:f1c5 with SMTP id n18-20020a5d8252000000b00785cb8df1c5mr4112725ioo.12.1688713573233;
        Fri, 07 Jul 2023 00:06:13 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.52.242])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d8c86000000b007836a9ca101sm1074307ion.22.2023.07.07.00.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 00:06:13 -0700 (PDT)
Message-ID: <64a7b965.5d0a0220.42ee2.0ce0@mx.google.com>
Date:   Fri, 07 Jul 2023 00:06:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7138581693959386942=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v3,1/2] Bluetooth: btusb: Add new VID/PID 0489/e102 for MT7922
In-Reply-To: <20230707062959.30371-1-chris.lu@mediatek.com>
References: <20230707062959.30371-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7138581693959386942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=763319

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
GitLint                       PASS      0.53 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      32.22 seconds
CheckAllWarning               PASS      35.70 seconds
CheckSparse                   PASS      40.73 seconds
CheckSmatch                   PASS      112.46 seconds
BuildKernel32                 PASS      31.40 seconds
TestRunnerSetup               PASS      478.00 seconds
TestRunner_l2cap-tester       PASS      22.76 seconds
TestRunner_iso-tester         PASS      40.15 seconds
TestRunner_bnep-tester        PASS      10.16 seconds
TestRunner_mgmt-tester        PASS      212.81 seconds
TestRunner_rfcomm-tester      PASS      15.33 seconds
TestRunner_sco-tester         PASS      16.32 seconds
TestRunner_ioctl-tester       PASS      17.12 seconds
TestRunner_mesh-tester        PASS      12.64 seconds
TestRunner_smp-tester         PASS      13.61 seconds
TestRunner_userchan-tester    PASS      10.59 seconds
IncrementalBuild              PASS      34.79 seconds



---
Regards,
Linux Bluetooth


--===============7138581693959386942==--
