Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B98ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 14:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiH3OIy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiH3OIx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 10:08:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E084D6B66E;
        Tue, 30 Aug 2022 07:08:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so6215782wms.5;
        Tue, 30 Aug 2022 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=y8NRn56TTNghGF267n9YhDLoRC0D+RKLzmBK9wVjOtc=;
        b=pOMRqM6He7s3vzVohn3MDfxZtYu5fFgYKqU8WsUBlLAf3iKoSSYLgdxCSVMrmFmB/N
         +5dmTERwu3gvxPimjo/k0tbCqbMWExLd5u+VnDZlekNWwVoHRRq8+M1EME22j4ozynWs
         sEENdBsF4+N/81AUBeKGBZ4PnhjrxTk6cfv3a1gumm50YrRKDho9Pae1pFtY4BYdicRW
         MdXXH4cJIghykeL2O19r33cLB4nEddpFB5T5hoRICTyQoRJad2Iaqf/crWEL9SG9YqUq
         ZNRGvvO3YBtZGEwuWt72pGTysUC4oUPwA7bsDYuE+Pi0k2dSeooxH8Bi9wPmHumGclPD
         FCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=y8NRn56TTNghGF267n9YhDLoRC0D+RKLzmBK9wVjOtc=;
        b=JT9NHZ6/XG3unWUnHPQGYnrvhKZFBrwtOv4wMH3zB5Uyf194nj8PwTYm5o19K9koNN
         NoSaUE9odT9F8ZH61ttWXjhOG6j20t9LMlxI+ewuJkItkJNo/wQafCe7cb676rchdmvv
         yc6IuKk/0H6fEIWUuYV9SeVyfT3HvcKm40XUhWKHC+BGYOSa/FXM1IgtXnPwcIVbYHj7
         97hM/WZdVW7RdmCKDoGio19gGSn5RWVX0rGAfcr3WS98otV6AVRDb/TTae0RDBh6jeT4
         PEyLRBCBp5507yt0NM7SVVPlzTy8mPAmqGx77mmn/RhMbgJtkIxTb1EaSt6N23yOiZZX
         o5zA==
X-Gm-Message-State: ACgBeo2KiXo3M4Q3h48ZDzJN6tcF1EUwLhe3h1w+uqGC/658sQ1DlNuy
        shZIKh2qkJ0ZeDbt8ohLT7vEkLhA4+GSQsscluk=
X-Google-Smtp-Source: AA6agR5nsFK6ujOw2YPzLMclmkfXMZvvDGTRj+t3d9VLtjZXsOQ4PTDb8eJ9Ht0wuApnxWtm91zGhRRS2Q4ACxeoScg=
X-Received: by 2002:a05:600c:3488:b0:3a8:52f7:b869 with SMTP id
 a8-20020a05600c348800b003a852f7b869mr1524842wmq.36.1661868530379; Tue, 30 Aug
 2022 07:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016512d05e76bd837@google.com>
In-Reply-To: <00000000000016512d05e76bd837@google.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 30 Aug 2022 22:08:38 +0800
Message-ID: <CAJhGHyDPN0CWZD8PxFHoB66f6QBNFGx8Lwz9EG-kSB8Q2yriQw@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: WARNING in __queue_work
To:     syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Tejun Heo <tj@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

CC: BLUETOOTH SUBSYSTEM

It seems that hci_cmd_timeout() queues a work to a destroyed workqueue.
