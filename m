Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B05C54EBC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 02:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjAKClY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 21:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjAKClV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 21:41:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC4B85D
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 18:41:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n12so14429638pjp.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 18:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vE3J2qVWOkZK9V5M8lJ4EoYtjZQ5XypqZzL+bDxdZwY=;
        b=L+0hnM1FW/b6RfhYzSMrI2Pp1la4DIXz30tW8TT2I5qwMMCREUDYkbZ7gshrRnY5lq
         Gee8fibabf5RP8VnAKuqf3OSJUFrUCAPgz4VGafWf9wwEVqfaIu3EUYSQZXyo0szbbMf
         s6IKRb+3bICBF7inQd6TPDl7Atzf/zW9+osKlM2r/K5lHeqjfUB+cudVTZEnzAHR5fAu
         xbcIj6A7ZliijIsoZAm6bXVhxtgXbQCN5nSlwCEP29LrtLI69kEKFtS7XFfO3WOVIXxm
         hpoCaTdw7tIUejeNeuTD1PB0oSkk9R/TxHSD9uWpU75gXfTc9aSauQzyag5HAQnjyEKq
         5SuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vE3J2qVWOkZK9V5M8lJ4EoYtjZQ5XypqZzL+bDxdZwY=;
        b=N7LnWH0VuVltX8w6tBqXmOuyO68PDdEb9GravcX2RYbpAOZewtHvq8FEG1jNRJ+IJp
         l7c4nnyjhGTJ10nzm2OLEwefWBQ5p7O2ywGA3zwQlqa0hCUoCLLMuO1GZ3ZRYZfv8zBH
         ugA/bcBWnWZTxOnetn0GpYr/i4xU11Sxi95e+adzMWDbYPP99xCennRuAkvJy3o73OsV
         KRX3YKGFYvrjLxKfCX4a/ZpCYgGrp5XDErVSsS4tOGFhoY3meiGYY7UOvShmwa7L4mbW
         6hy/pRvOwoTQTw4lSrJ7OOA0kp5ABuZgNafQ/DoaJYuBXBUONn488MnJsvcnqnQToB+l
         w3zg==
X-Gm-Message-State: AFqh2ko9kQWhSN3Sr8CS8rzGL3NgMiquoS3L2Rg63n82X7dml9RwM/js
        oXzXCAh3TY1MUvuHm1hqlsVeGHM7id0=
X-Google-Smtp-Source: AMrXdXvibA4zAC6WWrot21UuvchRUUqBveXnHumDKuVp7Z/Bk8yTPUQNph5Oaa3UpiT8S8uOVsADQA==
X-Received: by 2002:a05:6a20:669b:b0:b5:dc64:b79d with SMTP id o27-20020a056a20669b00b000b5dc64b79dmr7204252pzh.6.1673404877268;
        Tue, 10 Jan 2023 18:41:17 -0800 (PST)
Received: from [172.17.0.2] ([13.64.213.130])
        by smtp.gmail.com with ESMTPSA id q7-20020aa78427000000b00580978caca7sm2529566pfn.45.2023.01.10.18.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 18:41:17 -0800 (PST)
Message-ID: <63be21cd.a70a0220.36efd.4ea3@mx.google.com>
Date:   Tue, 10 Jan 2023 18:41:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3074836908005971371=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_event: Fix Invalid wait context
In-Reply-To: <20230111012254.3724082-1-luiz.dentz@gmail.com>
References: <20230111012254.3724082-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3074836908005971371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=710751

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      38.57 seconds
CheckAllWarning               PASS      43.05 seconds
CheckSparse                   WARNING   48.98 seconds
CheckSmatch                   WARNING   128.74 seconds
BuildKernel32                 PASS      37.90 seconds
TestRunnerSetup               PASS      540.85 seconds
TestRunner_l2cap-tester       PASS      18.79 seconds
TestRunner_iso-tester         PASS      20.54 seconds
TestRunner_bnep-tester        PASS      6.58 seconds
TestRunner_mgmt-tester        PASS      128.52 seconds
TestRunner_rfcomm-tester      PASS      10.52 seconds
TestRunner_sco-tester         PASS      10.03 seconds
TestRunner_ioctl-tester       PASS      12.19 seconds
TestRunner_mesh-tester        PASS      8.28 seconds
TestRunner_smp-tester         PASS      9.58 seconds
TestRunner_userchan-tester    PASS      7.12 seconds
IncrementalBuild              PASS      35.88 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============3074836908005971371==--
