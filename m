Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C2AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427C12072D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 16:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/C8P1l0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgE2QKN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 12:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2QKM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 12:10:12 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A8BC03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 09:10:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id i68so2342050qtb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Fdb1emlw1OhiyIu18te6RJ/T0Hd/UZQKyNlOAqTGX9I=;
        b=q/C8P1l0G2ep0GS4UL3kkYpYNeUcOlXTYkktvz8PIYTos3+V23qcVtoiCwYYnVuzPA
         IBcwEwjRoNWRL0ABY8Xo12aEbNhX/DncsHGDAw/lLkhM65BG6erf9WKVK3QXDpSDx0UM
         onk3EB+6xNfRE38R5Evlp4/s7j2nvTmyVmqVXrpBIAU7Z6J4nL2o7mWPtiA/yN5aTaLI
         POYnvRRGzkOhNRQQx3cbKQzObglf2KxcTZ3XdOQ5u0l6UabcWPSmxqtJwgYqljYCuaUQ
         Pq9tsmmW2n0cdPbKai1IHhBBCsSX06ehQrxIQiRFHRHindDY/V7P45e1073QfnYRPEHl
         SbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Fdb1emlw1OhiyIu18te6RJ/T0Hd/UZQKyNlOAqTGX9I=;
        b=tNT4V5kfzElgBZobKvnpah7icb1Yl+zuYN4IAkbxd2DaQvi6gC7bUZJHz3S3xdJM1J
         VTFqO6Y4HW5yhBcN/6wC8CJY68rd6WOqeMdDmnSu8uezPtzxIFygsxRmSjf5EQE9GGtp
         ox9Paijqh3HmOf2wnPgA32KaWK1Z2gz7hLS4XlVVY0eq2Ym/Ko9qa9FMbibukzT9XYGP
         lcBGUqvssG1l2AwO5dFdnif/ivSvKvrwrdq/VzdosPDE1ZvxC0zGjjgyqihQP8P7t9O7
         0RO3q/AGmMGyGdwg4n9j+RZjg3iUkrHMTuScaPjBAFN8ejrnn8twYYL2RZykf308TzJP
         da3Q==
X-Gm-Message-State: AOAM532ZmBRetgffYYiepxu9xuq/2j8z6HrpvjYERh580HXDO/fiYXxK
        K+fCLHcIZwQ85WxfNYrbkcz0dqWusXQ=
X-Google-Smtp-Source: ABdhPJzWuG1rkD5Lx08T0DZXQVK4meTMTXgAViS1S+Z9AaKnk2idfECfGP4eO0mvIZVJJsoSjlvxxw==
X-Received: by 2002:ac8:465a:: with SMTP id f26mr9718207qto.324.1590768611314;
        Fri, 29 May 2020 09:10:11 -0700 (PDT)
Received: from [172.17.0.2] ([104.46.108.37])
        by smtp.gmail.com with ESMTPSA id 79sm7122489qkf.48.2020.05.29.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 09:10:10 -0700 (PDT)
Message-ID: <5ed133e2.1c69fb81.dcc97.9c5b@mx.google.com>
Date:   Fri, 29 May 2020 09:10:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4797334174026208810=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: [BlueZ,v3,3/4] main:read default system configuration from the conf file.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200529153814.213125-4-alainm@chromium.org>
References: <20200529153814.213125-4-alainm@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4797334174026208810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
1: T3 Title has trailing punctuation (.): "main:read default system configuration from the conf file."



---
Regards,
Linux Bluetooth

--===============4797334174026208810==--
