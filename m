Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82641C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533FA2074B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ14j/Z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgGPXvz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgGPXvz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 19:51:55 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBD9C061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 16:51:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id w27so6370052qtb.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 16:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/MJnLkbJLE9mXLEnJaHh67UU5knjI7/nh0C4gIyYoGw=;
        b=aJ14j/Z/hhqRNNs+3t+uuqhJ3OUSRCEAmlJ2LKrSbbzaaZtLEt7byKINP8g5Z5ltsR
         iqzX1g7XTpgHGXshYKILzLbcQRYC9c5WTYVegjs8LZr5feNJ/Se5sT1D2TSeOnuVgvzq
         u9JSpdj9pRvsb/VxagHLXUyVB32q8FsrtTbUcbBff7aer2qPAwbImPq/2mpzqajE/fx4
         SnTGvVUpXeXdFwgDjVPqs5UH/oNZo8rSjuzl2W/J3GHtWrmZCaALjU3YC9cwFe/Tu+2i
         CNbJX8E9LVD4ErAR/yWdXXMAFif9BhdAUeyru/UncQ7HDfjcpRDJgJPYrBTDVKRVX6iM
         KL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/MJnLkbJLE9mXLEnJaHh67UU5knjI7/nh0C4gIyYoGw=;
        b=F/8CxK0VMxG27p+OAiM78FXAL2XNJ5KVzJCzwYFRCRyDdsg8n4Gokc4qdFPM0t5Ams
         0+7IP2zI99MgPOMtecwYP8TqLqFdXug2SQWTLEiBYjs4P3I0tv7AoYVDrleCC0BAw1SM
         H7dErL7KD/uxLWvgqqwntUSSZP+iPlwdTcFErdF/DRVgCy1esrHr/K38MBzD9Rvy7hJf
         zSv26PCXt19OtZmM/1OT0jBkfE2P50vWXlSOPhjUJZv1Qt54a+GHS8qI5N0iNxYlRdzf
         M4XXTCNXEqx+AtP5jQXPC/fu5GMKUNrXxHuMfJ0/HV3f39P1HrT9rV1syxKEf1YQkC3S
         w2LQ==
X-Gm-Message-State: AOAM530C5lHZxEWe1UKHSHintBL+XaN2eqalgvu+74Srh8EERi509u5M
        UCaVQC1ImA+Dq9BoQoZoV8/R1sD6LJk=
X-Google-Smtp-Source: ABdhPJyRqL2sGMMrHFTpS/2Lj/D76nVSB66KprlwG4Af7nlFDlr9envABBafj9+9sRUiF+7XxhIfIQ==
X-Received: by 2002:ac8:108d:: with SMTP id a13mr7738078qtj.42.1594943514121;
        Thu, 16 Jul 2020 16:51:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.161.145])
        by smtp.gmail.com with ESMTPSA id v10sm9566238qtk.14.2020.07.16.16.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 16:51:53 -0700 (PDT)
Message-ID: <5f10e819.1c69fb81.2d00b.1b14@mx.google.com>
Date:   Thu, 16 Jul 2020 16:51:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3665026671272091068=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/att: Fix possible crash on disconnect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200716231857.934396-1-luiz.dentz@gmail.com>
References: <20200716231857.934396-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3665026671272091068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
makecheck Failed

Outputs:
./test-driver: line 107: 14798 Bus error               (core dumped) "$@" > $log_file 2>&1
make[3]: *** [Makefile:9726: test-suite.log] Error 1
make[2]: *** [Makefile:9834: check-TESTS] Error 2
make[1]: *** [Makefile:10228: check-am] Error 2
make: *** [Makefile:10230: check] Error 2



---
Regards,
Linux Bluetooth

--===============3665026671272091068==--
