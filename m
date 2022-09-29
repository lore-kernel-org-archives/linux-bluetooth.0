Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67989C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 23:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiI2X7y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 19:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiI2X7t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 19:59:49 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803FE1A225
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 16:59:45 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id s9so1901609qkg.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 16:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=fEJZ2BcjnqNukgVielhzYJN98KbquaN4NTCINnDpwVQ=;
        b=nwgWXOy73zcwf+eEVsmypTm6lzykWQaHqRJRG7vTyx8TEzSQ/lYn8sCxx+KfI8K7Cw
         8B24rQnSKRcBtw4yiF1/iGHb1+gwhtyrRPZHKN/EK40nu8zZ+HdShuAPcSG5y1zXrHX0
         uhEZrUldiEABoE+tVStvyHyuZHIrEk/qiOu0shgTh9ZcAJojgqF52Oy6E7Bb2SJpPlR0
         bmRlOmKuB9AIyTtkmrWrQO1bB+N0YH5ZbIvsJOlhDG1AXtXMaW2vBruzfMZvo5Ksn3Tk
         keFCG8IibnRori8y6KO27KRXwWhIjb6XY+/ykPPCBkKC5z57YZcWIZ1BdFEXiP3FhCyU
         RdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=fEJZ2BcjnqNukgVielhzYJN98KbquaN4NTCINnDpwVQ=;
        b=cibg3uyw8xALoyFcHm7xTT2cHcXjR2Z9oVYnJ9OvCssNdK/YGUJjK/hHWOKJuQtbc6
         VS6a4+7EYCCPVUmg00cLkski1Qkod/qT0zzHNjd5+wtWH1+4a4C4+rP4tcFEjLUmbZGy
         XADh8J2K7D537h/NcSspwT7lFpdIgi0b93ORHcDqVJRUhWpFNlPU1Ns0deLhrJt8qQk+
         pqMzkd7bvTOHxOQB21xeGFNp0Uel05c7q9uKa5tTkDkIxaELgn37zF5wNtDALCvYDv8x
         MHiNawyet28HLP0XmFKfr7g2SFUfquAkoO39VSTBs+l7pgkH2/jJv87gxP5QwqNPlnZk
         gClQ==
X-Gm-Message-State: ACrzQf1eBEO+snPDS4VPLl0zUHrt0NmcCj8D28PDGbaHjgen92MJgBfZ
        8vxtp7R56oUvBMzLAv9xLNimTPKTjYRLVQ==
X-Google-Smtp-Source: AMsMyM7ljZd0xGioKO3pkbvrreEVhS06nc22F8Un+VYtz0Zooc4lGYTOgV8K+OpFSnGOU/Fs4B/YYQ==
X-Received: by 2002:a05:620a:271b:b0:6cd:fd1f:7472 with SMTP id b27-20020a05620a271b00b006cdfd1f7472mr4235899qkp.142.1664495984634;
        Thu, 29 Sep 2022 16:59:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.1.206.241])
        by smtp.gmail.com with ESMTPSA id de20-20020a05620a371400b006bbb07ebd83sm1167347qkb.108.2022.09.29.16.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:59:44 -0700 (PDT)
Message-ID: <63363170.050a0220.9a402.35c1@mx.google.com>
Date:   Thu, 29 Sep 2022 16:59:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8094829426470034938=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8094829426470034938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8094829426470034938==--
