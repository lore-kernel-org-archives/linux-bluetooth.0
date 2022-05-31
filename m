Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 19:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbiEaTMD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 15:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346344AbiEaTMB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 15:12:01 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE35D2F3A9
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 12:12:00 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id v1so2244952qtx.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Pf0X/OCwQPr8Hf5P6vIwaw1lU0n9t9UueU0GoHBxrdw=;
        b=CljqRMT601uQN75gybyeQqruHycOt2DFBukPgL3/bUZM6qJqnMBKIzU434PN/rMj6X
         Z3ORzwyOSGZ9CcKrgcAwCN2pfG1B8whJ6ScLbhNFanzYyx42bTsMmjFuEQJBFWGaXgcY
         HBdqY/EW0E4JeHYUQgeMwT/CnvE4GABsFYrMve8S+gUO2AHfz8YutYLaq5OEsdym+O38
         t3VFO2zWzDZaqlmkzQqhs4euN94i/Epp7VlirgxfcRoEVzCGBagRmKKW5nKd/q/9sZFk
         oj3KFKGguuDb0JkNHkX5Nqavh7RjdTNb6b6BzdAhzGksMOSKlxBRqt155/zL/RS6T8Qt
         Z/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Pf0X/OCwQPr8Hf5P6vIwaw1lU0n9t9UueU0GoHBxrdw=;
        b=o6Sl3fTv+/sN6acrocLShC5j/rFGStLy78r7XkNjfy0XXAP5xWJ8V8XORJygiegpGM
         Le+3qDqjW1U2SNhh3McT7MMCNOCHp7iN6vswAyCFZOGtR/XAy1FnE8u9SNDORa/6CD9K
         8g0kclMu0pFT0Mb3tKWuLxXvkclhBh2fU5zq5U7NTHGAAA9p2OZ3PPuUjrdAXZd/FA4d
         aM+xRwjKQKa+w6BGDOwTDNRO5IDrGAfXOQTMmjhzFy/I37rMeVNaVUxNDE0YuQFAPKBN
         7r6+vfEpfT3tOUt4uShileJpaYHfKmvhQUwM9h0UuEmM00OwtafP70H2fUIDTSpigGFW
         JwxQ==
X-Gm-Message-State: AOAM533x0kcYUnkZoy+LcP5PB8/JzOaQCpbNBNaWXtjzcEV7b6Z6ni12
        TELJqtRIfZHMRbnZhSTiSdvYBLXeY7gw7w==
X-Google-Smtp-Source: ABdhPJxj9E24uA3muABrlel9GzjV5Up6ZnOxhnXJBeqpuBQOqkSArsr8Gi78ja0iYCto9sVip4ZdJQ==
X-Received: by 2002:ac8:5e53:0:b0:2f3:ccc3:3328 with SMTP id i19-20020ac85e53000000b002f3ccc33328mr49010478qtx.274.1654024318515;
        Tue, 31 May 2022 12:11:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.120.19.112])
        by smtp.gmail.com with ESMTPSA id j3-20020a05620a000300b006a37c908d33sm9978979qki.28.2022.05.31.12.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 12:11:58 -0700 (PDT)
Message-ID: <6296687e.1c69fb81.b9736.0cf2@mx.google.com>
Date:   Tue, 31 May 2022 12:11:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6956683265830557807=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, schspa@gmail.com
Subject: RE: Bluetooth: When HCI work queue is drained, only queue chained work.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220531184124.20577-1-schspa@gmail.com>
References: <20220531184124.20577-1-schspa@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6956683265830557807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646337

---Test result---

Test Summary:
CheckPatch                    PASS      2.03 seconds
GitLint                       FAIL      1.10 seconds
SubjectPrefix                 PASS      0.83 seconds
BuildKernel                   PASS      32.53 seconds
BuildKernel32                 PASS      27.94 seconds
Incremental Build with patchesPASS      39.13 seconds
TestRunner: Setup             PASS      481.36 seconds
TestRunner: l2cap-tester      PASS      17.23 seconds
TestRunner: bnep-tester       PASS      6.08 seconds
TestRunner: mgmt-tester       PASS      101.04 seconds
TestRunner: rfcomm-tester     PASS      9.63 seconds
TestRunner: sco-tester        PASS      9.45 seconds
TestRunner: smp-tester        PASS      9.44 seconds
TestRunner: userchan-tester   PASS      6.33 seconds

Details
##############################
Test: GitLint - FAIL - 1.10 seconds
Run gitlint with rule in .gitlint
Bluetooth: When HCI work queue is drained, only queue chained work.
1: T3 Title has trailing punctuation (.): "Bluetooth: When HCI work queue is drained, only queue chained work."
13: B1 Line exceeds max length (85>80): "CPU: 1 PID: 18374 Comm: kworker/1:9 Not tainted 5.18.0-rc6-next-20220516-syzkaller #0"




---
Regards,
Linux Bluetooth


--===============6956683265830557807==--
