Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6407BC07E9D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 23:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIZXOU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 19:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiIZXOL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 19:14:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19751B14DB
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 16:14:10 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id ay9so5136614qtb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 16:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=zWZ6Hz+ITBmL/N6iO2Ok2VxXab8+WOfWtYrRVhDDmdQ=;
        b=U70swgDD1dmORc2v/eqbaGrNDi1r07vYHd1bMS8mlI/WOTRcHQBRHXWIvDk6Jhj6Rx
         MvReuZfjJRSqdxeZGr2L4cnPCeifFHlY5fQXl9e21kZWdz3Oyv0TTSFepVUr1BPjs33w
         /Fl73WFOgwrh1+Zi5V26HYhxVE5dqUKXXIPpjgAKZs44DmRkjXNjT3Y5ZDvh2QG5KUBX
         +gjGO96CWZ0wY3VaodMoim1LUk1NyP2YMhkhgssJBRe5tlhixtS3PpkJbDixWpt/sz1h
         8tDbwEYbO5rKJjxHxdViFWnc2F34msKG2caZ4Y9Rw1yhve3sKyeNAFi4gI91Zd7SSN1W
         Gb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zWZ6Hz+ITBmL/N6iO2Ok2VxXab8+WOfWtYrRVhDDmdQ=;
        b=7o7Gz7Dzx/FcY4IdARb33tp+gmR9QwUaJmv8b6SObHgcJwswTkcNxMuXt7WGrzPNbI
         dx28DkCxa/jY02jjJkjqGJEggw72Y6EujC9EyMp9/mlwNKdNuvLsQ2DPJ96GvUNCfSRS
         NyQa+M6IH+t4dzQIDifKLLyja9HJpyGs50gQVBQ8WIfB+r06HyGcPUS3GIcoIjY2RFHQ
         etjOlM4Rm6AqP321jNzfdPMyHF9m4KpqbY3t5R5yINxd0Ecya4PC7hVX5Z1rP8UyjbeW
         VY7c6xDpAbBOqrD/Rsjw7iwsuyja/hSltasEqNbg+gVbMbyJfrMKkB+f0YvhzU6zup0e
         RTQg==
X-Gm-Message-State: ACrzQf0v2tA6S4mJYtk7Jr4H+/myQlq4RozRKoGzn7BCURhptui/F7qY
        IQD97+J0wcIskZhpL6cxVRP9u83l2lY=
X-Google-Smtp-Source: AMsMyM6rhFqApaBdCr9vVaN3ec25290qriIdTdJHyl3Ai7t8Kbr7hDW2zLxL4UZZYRbVcnUv20C4YA==
X-Received: by 2002:a05:622a:1a1a:b0:35c:b90e:7905 with SMTP id f26-20020a05622a1a1a00b0035cb90e7905mr19778712qtb.643.1664234049027;
        Mon, 26 Sep 2022 16:14:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.70.63])
        by smtp.gmail.com with ESMTPSA id cf14-20020a05622a400e00b0031f41ea94easm11492526qtb.28.2022.09.26.16.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:14:08 -0700 (PDT)
Message-ID: <63323240.050a0220.e716b.3556@mx.google.com>
Date:   Mon, 26 Sep 2022 16:14:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5422690622906330483=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_core: Fix not handling link timeouts propertly
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220926225107.3226470-1-luiz.dentz@gmail.com>
References: <20220926225107.3226470-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5422690622906330483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=680748

---Test result---

Test Summary:
CheckPatch                    PASS      1.76 seconds
GitLint                       PASS      1.07 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      46.19 seconds
BuildKernel32                 PASS      40.66 seconds
Incremental Build with patchesPASS      56.67 seconds
TestRunner: Setup             PASS      677.05 seconds
TestRunner: l2cap-tester      PASS      21.35 seconds
TestRunner: iso-tester        PASS      21.64 seconds
TestRunner: bnep-tester       PASS      8.50 seconds
TestRunner: mgmt-tester       PASS      130.54 seconds
TestRunner: rfcomm-tester     PASS      12.74 seconds
TestRunner: sco-tester        PASS      12.23 seconds
TestRunner: ioctl-tester      PASS      14.32 seconds
TestRunner: smp-tester        PASS      11.85 seconds
TestRunner: userchan-tester   PASS      8.89 seconds



---
Regards,
Linux Bluetooth


--===============5422690622906330483==--
