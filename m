Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A48C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jan 2022 07:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348718AbiA2HF5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348161AbiA2HFw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Jan 2022 02:05:52 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA8C061714
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jan 2022 23:05:51 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id h25so6217742qtm.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jan 2022 23:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kdbUoZPk4E+DXmfHqWHfwlZ3WZtJr1YKOGRfYiTTS+g=;
        b=NDRtL+EQsbKOgdd8+spkExnDQz3wfzNdNYEEStoFRa7PGCFWw/hszEQM83a+WYEEPj
         zIFxfgoux0sUDplx0M15NEHLY1FW4aCgLZGj3KfhafdUS2yTIhrXdotcX70XG7eI6Rpu
         S5dj3GrqBQ5oKPGByad+BYtgQY/0G0Oj43/LnQU/3UxBX64sDefik8oWQ3zqBfGkKnnI
         uOc9PvxTAAvA96sSXfHwLll27TkB9GlzFIzDXoi1l2KasSBshDOsE0o4FkZ1F0AZ5MiI
         iyAfnGJT5SK57AU2bxOyMuy4krlmirIEah5yAR2VmrlscNu71IWO++TOxMlWvch/Rbn3
         j3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kdbUoZPk4E+DXmfHqWHfwlZ3WZtJr1YKOGRfYiTTS+g=;
        b=l4JVTLwSeTA5l8+kSfnhyt5WdA7rKOHIOuGC7zE9sKioeQmNpcrjI4K9/ou8MDweis
         OaStDLOMNkcFiWpnoGHipRjJ/riV/HI41cmqjwkPuE91uVxU3cqw0qP2zWx7Hait/LAK
         cGzntshvfEtdSZG2zsSp+oFAoGMQHLkvu+FhygKCdFa6iyLiLjLKzU/z0DFzV8wRAR2h
         o1LAMZcll4lgL70+OWUKRVRjlMIQ8/qMV1cSZwelQnuLg5BaUg8eE1ejxY2RgTvE39sJ
         slffDATBH1pRCHYbtuA7i9XJSebhvudpRZN5J1BB4iCKEeaQhnmu0YPxkJ0E011Ebz76
         ZKzQ==
X-Gm-Message-State: AOAM532MhD3AOgQPtpJGhYG9fhJxwhFHDoE7Smb1H/Lox+ZRe/83DIbI
        j7rG0ffy76FRUNAWTtqG1XNgiKtk3y3LKQ==
X-Google-Smtp-Source: ABdhPJyoRePTLXTQ/Is0XaoD0sFoqJnYVYbZMvECZdWhH2lLbMl5oinJeghg/G+VEkiC/mO9A8CydQ==
X-Received: by 2002:a05:622a:1756:: with SMTP id l22mr8252771qtk.415.1643439950875;
        Fri, 28 Jan 2022 23:05:50 -0800 (PST)
Received: from [172.17.0.2] ([20.110.140.178])
        by smtp.gmail.com with ESMTPSA id w20sm5013496qkp.102.2022.01.28.23.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 23:05:50 -0800 (PST)
Message-ID: <61f4e74e.1c69fb81.1991.9645@mx.google.com>
Date:   Fri, 28 Jan 2022 23:05:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3739529542098867590=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [1/2] Bluetooth: mt7921s: support bluetooth reset mechanism
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <52ae30c33f2994efcdff180764801141d59e6e0c.1643435854.git.objelf@gmail.com>
References: <52ae30c33f2994efcdff180764801141d59e6e0c.1643435854.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3739529542098867590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=609706

---Test result---

Test Summary:
CheckPatch                    PASS      3.77 seconds
GitLint                       PASS      2.08 seconds
SubjectPrefix                 PASS      1.71 seconds
BuildKernel                   PASS      30.47 seconds
BuildKernel32                 PASS      26.94 seconds
Incremental Build with patchesPASS      42.88 seconds
TestRunner: Setup             PASS      472.91 seconds
TestRunner: l2cap-tester      PASS      13.67 seconds
TestRunner: bnep-tester       PASS      6.19 seconds
TestRunner: mgmt-tester       PASS      105.33 seconds
TestRunner: rfcomm-tester     PASS      7.59 seconds
TestRunner: sco-tester        PASS      7.75 seconds
TestRunner: smp-tester        PASS      7.58 seconds
TestRunner: userchan-tester   PASS      6.45 seconds



---
Regards,
Linux Bluetooth


--===============3739529542098867590==--
