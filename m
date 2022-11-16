Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E716DC43217
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 04:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKPEe6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Nov 2022 23:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiKPEe5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Nov 2022 23:34:57 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E4A2E68F
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 20:34:55 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 63so12370151iov.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 20:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HKBKwO1ltmXYYde7OwdUTEKRAIPJRM2AlGflITls8Rk=;
        b=lxP/kjbsjozVo4g15NNK5lfY6OFyGDhy9cypd3hubqkGfKAqqgCf8EizWYYe1Glmn8
         mDwRmgOiup0wyC1TFxZJaT2o8idcuCvq8rT4aEsavf4MBVx2NIwEI9bKdjZ4j31X/2JW
         Op6gNyl7cd3KkaoI5td6fqINa9cm8/QTgQ3ogn+KAMZQRbWi3fJh/uuH7CYOHbjsO6Fp
         dnp+u1E5CLdEmg2DZh8WuZT2GiVaUBCHNo0XeZbCXHa6R2FcqKuEWKoOFakNBYmDgPC4
         HAKmDtSRByC/CwEkT1hESfWoQsyV8J4FVyT9fSM0kftc5nFcDVHH6DZfU5SzKh5gsqB4
         BR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKBKwO1ltmXYYde7OwdUTEKRAIPJRM2AlGflITls8Rk=;
        b=pqAw5EcD4jbrYYlf/fNujcgirImLozhNFEwnXKW4/CNbrT6WcNISKSpNlAnXLRmPhR
         RZrx7h0nRmIg+XqpoE0gqAfISMbhXHb385nj8biCz7FC+HQb9qpEKakd12/L5DHJJu5y
         3ZkrD5VTWvQeuA/x7Ux1vmWAWmClE9QMtNTRHXJ6WBaHgfqGAnJTJaZxEbID7BEAQST+
         EgvlmiT0AQ5zqSYwKAtCSsYnDOEECwRTNhEZNPrE4VxmCf9/n7vS2NgW7eS66qfCaor0
         SL6xv6+ZZVn+5+riAAUIitvRHhI/1QtW3jUKcQVwUb2jS1chi1PBzXgc3y37WtEzRqkU
         wDPQ==
X-Gm-Message-State: ANoB5pmzV6zJOwDUH4SJyiqwNvm9DWfUKeL1vM7DFp1dN4a6pHf0Q1/e
        W9T8NvE/vWSOWXMyr77aRIjx9O2GbZk=
X-Google-Smtp-Source: AA0mqf4oTnWOM+OyROppC5ii06dgWQIbk9K7fW6jaKTPLhDxRgOLiG7+fZNJJ+z2AlKkXIv/kxMLvw==
X-Received: by 2002:a05:6602:4188:b0:6d2:da5f:304c with SMTP id bx8-20020a056602418800b006d2da5f304cmr9269448iob.17.1668573294902;
        Tue, 15 Nov 2022 20:34:54 -0800 (PST)
Received: from [172.17.0.2] ([20.12.192.208])
        by smtp.gmail.com with ESMTPSA id a59-20020a029441000000b003712c881d67sm5467177jai.164.2022.11.15.20.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 20:34:54 -0800 (PST)
Message-ID: <6374686e.020a0220.35759.7d5e@mx.google.com>
Date:   Tue, 15 Nov 2022 20:34:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2343988273446501269=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lifangpi@hotmail.com
Subject: RE: [-next] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <SI2PR02MB4603DDABFC0EC1CC323BAF4ADD079@SI2PR02MB4603.apcprd02.prod.outlook.com>
References: <SI2PR02MB4603DDABFC0EC1CC323BAF4ADD079@SI2PR02MB4603.apcprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2343988273446501269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695778

---Test result---

Test Summary:
CheckPatch                    PASS      1.41 seconds
GitLint                       PASS      0.87 seconds
SubjectPrefix                 PASS      0.66 seconds
BuildKernel                   PASS      42.27 seconds
BuildKernel32                 PASS      37.06 seconds
Incremental Build with patchesPASS      59.56 seconds
TestRunner: Setup             PASS      609.40 seconds
TestRunner: l2cap-tester      PASS      19.90 seconds
TestRunner: iso-tester        PASS      19.40 seconds
TestRunner: bnep-tester       PASS      7.72 seconds
TestRunner: mgmt-tester       PASS      121.81 seconds
TestRunner: rfcomm-tester     PASS      11.99 seconds
TestRunner: sco-tester        PASS      11.40 seconds
TestRunner: ioctl-tester      PASS      12.78 seconds
TestRunner: mesh-tester       PASS      9.26 seconds
TestRunner: smp-tester        PASS      11.24 seconds
TestRunner: userchan-tester   PASS      8.09 seconds



---
Regards,
Linux Bluetooth


--===============2343988273446501269==--
