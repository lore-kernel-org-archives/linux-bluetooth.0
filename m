Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE0DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 02:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiLBCAJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 21:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLBCAI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 21:00:08 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4483B7F8B6
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 18:00:07 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id fz10so3431983qtb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 18:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GDzDVSv552xue3m9ML6UC0i71CHfPefJDvw03KuU/RA=;
        b=WDZaT1XAnCrgLsoi55rjS3a28uEnywvAs8RXH1GdNNeQ+J6YZj21mwJVOmaYFFFkjP
         DQPFHMU65BQ73tZxKVoa15Jqv3Ze7iL5LcmBaGFJ5sVj8X7Dj5Foy26Kpy1NjrdLeg/f
         sO2jOrj3RxbqQ0inpVUEGlkv6v9b9n9KlM7Aqs7WB0C6/CoGQavDtXFRwaersdqrlu3N
         GV6BC2Y1JVcnOTpsnDqVE1wuC1wamf1c2JsGVggjdEcRfdwr1qPkhQ2pqveRSEZlGH2c
         ttYnLhsYtJu8oBsBpssMsp+oBOf8sVVG1pwbgd2TX041MaxH4bXkGph9lHnheYTCd1cW
         R9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDzDVSv552xue3m9ML6UC0i71CHfPefJDvw03KuU/RA=;
        b=r3OXqMFatvzdtwQQ3cRyP3FkYJSc7DRg/cu9g0GCz5UnmIkFZq6IFnaskaQqFg5fJN
         WVzkdeIHCg9YByzxItXtFr4d4Ft/FZD6oI5iVzDKR3HWt+p4sX8B0I06NRr08B0UQSw/
         /A6IIFJm4PbRJpL0kcbwoS4PA5hNT+a7tAwc7wfpI4NpHURS/xPKispdGcXTsO1ry74a
         dPvKPIV6PaAQZR628pc0WQkOKtyeKKnQRqHSWOXWpahwRwtofEtp+BrE5D8CiBhLuSWf
         TbSpFM304IgX32KYyJgvi29V0xoPvlSL8mYLPqBvwXxZjexROl2jh4nK0bzuU25jc0O9
         Xs4A==
X-Gm-Message-State: ANoB5pll5A/fBGqjzf6iRJrk6GDq6Ged1bBQn69huzjZc7z8suSEvibc
        NEw6H4neNJqDwrktbS6Rg8oVVAz1reBCrQ==
X-Google-Smtp-Source: AA0mqf4d+bZMDp3Jp4KFV96r/xtodCcKk6aIOZOxB2yB4IPFhyim0qkX1tZPY8D6LFAVUlkz8ojrfA==
X-Received: by 2002:a05:622a:1f12:b0:399:36a9:7d9d with SMTP id ca18-20020a05622a1f1200b0039936a97d9dmr46934594qtb.49.1669946406283;
        Thu, 01 Dec 2022 18:00:06 -0800 (PST)
Received: from [172.17.0.2] ([20.119.180.158])
        by smtp.gmail.com with ESMTPSA id w18-20020a05620a425200b006cfc9846594sm4601318qko.93.2022.12.01.18.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 18:00:05 -0800 (PST)
Message-ID: <63895c25.050a0220.95a14.14b2@mx.google.com>
Date:   Thu, 01 Dec 2022 18:00:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4391744915369769038=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/gatt-client: Fix not checking valid ranges
In-Reply-To: <20221202003237.2371302-1-luiz.dentz@gmail.com>
References: <20221202003237.2371302-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4391744915369769038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=701025

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      27.30 seconds
BluezMake                     PASS      867.15 seconds
MakeCheck                     PASS      11.62 seconds
MakeDistcheck                 PASS      145.87 seconds
CheckValgrind                 PASS      241.01 seconds
bluezmakeextell               PASS      94.09 seconds
IncrementalBuild              PASS      699.42 seconds
ScanBuild                     WARNING   991.88 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/gatt-client.c:387:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:600:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:900:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1009:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1201:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1266:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1537:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1542:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2044:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2052:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3135:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3157:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============4391744915369769038==--
