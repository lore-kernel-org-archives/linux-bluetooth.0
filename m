Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9C1C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 09:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJSJzH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 05:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJSJye (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 05:54:34 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86D3E086
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 02:30:26 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id o67so10957859qvo.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=grjrcKjU6N2Gb9erSctIxguxWJU0m78quBx41ReARGU=;
        b=QvyUSSTHZMJulUtdJsKNfP36i6HJsiQjF6UtZNLoCvoOdDOuA2aZEHEYsZyC4Y7Kha
         C9fWvTGHjEGjALETomIoyKwYKbcavTGV4P46mLv3UbJI4MNon5bKi0R8gbGWgf7xsJ6G
         IQ/6pn7NmGJGCh8goy6TL1ApZ1KtbncVWyqpeV4TSSi1yL/Qt0sacQVQDOCnTi96Dx1C
         dYFgKGYVk0EUvdXCgFiVfhBXWTyi/cjBiva2cdDV75d3cu494c2uFGKm/tEws04iogn1
         NX5HuR2out6of8rs4CbxgwiGtLrYRqOHQU5Xt9/KG1wIq8MzTXcf6R3lp/TtlS5ZCUM3
         x1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grjrcKjU6N2Gb9erSctIxguxWJU0m78quBx41ReARGU=;
        b=gUI/4IBaYxgdRnFDw1JS1qgE7UvHzlacaP6zl+PpEypwpUJbLMY5k+Xu+Pgwojqix5
         SAygTZhO3BBeY/JPaE7VoOIDMsCS8g29chQxXfJMTQtl36ivBG5Goz+yvs9C6qgGa+4o
         7RUmkA+E5vdzgcPLZXffNJrCx8NMRbjkYSOwpe//XJl4NUKoUVNm3V209ttzkCMMPrzT
         S0fppAwj7Nz9a9Da3T72DT9DmPCvvxwmh8dBkpMYKw5L8LPmWzVZJY2CAJ8cDSE/+z9S
         dY1w69tiqN8Dh/WRLkc5FcJ68Og7umJGobTeBbnA4IrfOngrX33dSy1n+MVyHrQnL49H
         N2vA==
X-Gm-Message-State: ACrzQf1UWjpTgjoDseBxfyw2OIZUgFMtNlg1FgFvbnWlqcMyet51t/iE
        MtDllQ+rVJUODCdC3C6904gA8OPGIPoG2A==
X-Google-Smtp-Source: AMsMyM5gIsFA8StPUbyK8M3shHa3w11DCeAUysL24yjfZVhcn1rHHX8Zob40hLSPwHeM8kkijFguxw==
X-Received: by 2002:a05:6214:27ec:b0:4b2:1337:a442 with SMTP id jt12-20020a05621427ec00b004b21337a442mr5741578qvb.20.1666171653259;
        Wed, 19 Oct 2022 02:27:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.217.51])
        by smtp.gmail.com with ESMTPSA id f20-20020a05620a281400b006ee79bb1f8asm4385602qkp.68.2022.10.19.02.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 02:27:32 -0700 (PDT)
Message-ID: <634fc304.050a0220.a6264.c8b4@mx.google.com>
Date:   Wed, 19 Oct 2022 02:27:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7867871517160293748=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yangyingliang@huawei.com
Subject: RE: [v2] Bluetooth: hci_core: fix error handling in hci_register_dev()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221019080652.836484-1-yangyingliang@huawei.com>
References: <20221019080652.836484-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7867871517160293748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686590

---Test result---

Test Summary:
CheckPatch                    PASS      1.73 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 PASS      0.84 seconds
BuildKernel                   PASS      33.97 seconds
BuildKernel32                 PASS      29.79 seconds
Incremental Build with patchesPASS      43.47 seconds
TestRunner: Setup             PASS      502.40 seconds
TestRunner: l2cap-tester      PASS      17.18 seconds
TestRunner: iso-tester        PASS      15.97 seconds
TestRunner: bnep-tester       PASS      6.35 seconds
TestRunner: mgmt-tester       PASS      102.59 seconds
TestRunner: rfcomm-tester     PASS      10.10 seconds
TestRunner: sco-tester        PASS      9.52 seconds
TestRunner: ioctl-tester      PASS      10.69 seconds
TestRunner: mesh-tester       PASS      7.66 seconds
TestRunner: smp-tester        PASS      9.45 seconds
TestRunner: userchan-tester   PASS      6.48 seconds



---
Regards,
Linux Bluetooth


--===============7867871517160293748==--
