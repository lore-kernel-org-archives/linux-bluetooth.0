Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02222C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 May 2022 23:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiEKXDm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 19:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiEKXDk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 19:03:40 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46C106344
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 16:03:39 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id hf18so3192561qtb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ebTYnOsAZqGnqrpgx74IEo6jC9vQALRYJmAUtpdG2qY=;
        b=F7i1npY7NdZWTdJ9iu26nkmh45w53LzM62rtm7dV1vcMdatDpqXYvt28o7yMRc2I9z
         ODHx3Ju72HcxL/x1Xn1TiuTb+1PwxxMkqZZMGhpFgy6ymoZ2yfeOPPRdOxGL/xYFdRdw
         nXRnft6w7Ts2jTyOdaZ7ObcoEz5r0zPqmcJauCaBxklQSiRvuOoJDQP/4eHBGnFXSRoL
         I6H1f1xDp9VIBflzLmz5vKY28LX76v5uDTnS2YSlr3lRod0dAV8YyPoCnQpt0HIWlqlP
         ntzqTBzX2bQls/L7Asen9rFiRWJVcSZ8rXPs3kBa0JT/rcUr1EnoibjPBLBxeNe5FsBh
         C1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ebTYnOsAZqGnqrpgx74IEo6jC9vQALRYJmAUtpdG2qY=;
        b=aw/E0YbeYGTbAW3pjcXzESjz4HR6jMqV14kB0FjywMsZSSAu8MxTnQURSnIK4XwWCa
         pSz/GDB31Csfykpn14JQfXeZ1POwivpWqgbTmqUnjPxDEjxlOr863DxJJYXGjFb6yIYZ
         L/MK0sSjFxqII9dTNNhHSDgUQzDwaFJZeLwJU4JOE1boxjCLoOA4cTwaImhW7TJc5xR8
         3RK3hstbPDepNAsfvgWfZWfVjnzZfSzoz4G7rV4wUxrCpz1z8B3F2+KZPnwVVZVccTWF
         hu+t8PDbU6cggiu0/TRnbM3EeFQ+GKT/jMUIwdljow3VVYmjxYzMZ5YvtZHixJrqNhwy
         6dWg==
X-Gm-Message-State: AOAM5337iC28Wu30lvj6DRdIideSwuqfYkv0lsvY4NKGkRZCjmWZpZBV
        JoyGkIAfiKXcaJY9/a+1F3+FMbvhNAYIfg==
X-Google-Smtp-Source: ABdhPJwSR1jBj3imqSt5WZ4EUIqZdonXyQO8X0LsNRcAdAB4PILRKeTcIGlX6LX3CV/rcfj9NcnJPA==
X-Received: by 2002:a05:622a:1015:b0:2f3:b8d1:3cd9 with SMTP id d21-20020a05622a101500b002f3b8d13cd9mr26512700qte.674.1652310218802;
        Wed, 11 May 2022 16:03:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.74.220])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a281200b0069fc13ce222sm2270692qkp.83.2022.05.11.16.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:03:38 -0700 (PDT)
Message-ID: <627c40ca.1c69fb81.1baab.b9c8@mx.google.com>
Date:   Wed, 11 May 2022 16:03:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8657170495179000260=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v2] Bluetooth: btmtksdio: fix use-after-free at btmtksdio_recv_event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <f8bf12f9682a01de8905d4c0d7a0a1ff0502ba5f.1652307131.git.objelf@gmail.com>
References: <f8bf12f9682a01de8905d4c0d7a0a1ff0502ba5f.1652307131.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8657170495179000260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=640728

---Test result---

Test Summary:
CheckPatch                    PASS      1.63 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      32.04 seconds
BuildKernel32                 PASS      28.78 seconds
Incremental Build with patchesPASS      38.19 seconds
TestRunner: Setup             PASS      474.64 seconds
TestRunner: l2cap-tester      PASS      17.45 seconds
TestRunner: bnep-tester       PASS      6.08 seconds
TestRunner: mgmt-tester       PASS      102.23 seconds
TestRunner: rfcomm-tester     PASS      9.63 seconds
TestRunner: sco-tester        PASS      9.50 seconds
TestRunner: smp-tester        PASS      9.51 seconds
TestRunner: userchan-tester   PASS      6.40 seconds



---
Regards,
Linux Bluetooth


--===============8657170495179000260==--
