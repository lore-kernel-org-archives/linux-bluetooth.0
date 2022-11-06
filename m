Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5805C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Nov 2022 23:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKFXZJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Nov 2022 18:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKFXZH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Nov 2022 18:25:07 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC317A47E
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Nov 2022 15:25:05 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso11006373fac.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Nov 2022 15:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QG/CjKSvFZQaCoWr7ypQoCkxCBty+FpzO0Qi0VrwzRs=;
        b=iRdfPsrvF+v5ExFdlaCQIx4OL1DauA7BjJ16lfYfi8OsstkYtKmTwFRymon6hD5mGs
         3XX7fjmsM1AGS31I/7dOZK3EeqLXf1gtqYmFQuRzfOLY5Sw9pY7BBnbL42/RF/1ke0Sf
         fFDSWemjJ3N6Qotq/eIPCvtvY9cQa13ieouQTXPNsCnxcwned6CiDy6BZTyYA3QT7EJm
         JWJC4CQaElVvPgTHCBwG1XfbQw6wCTF43RnYMwvC5vOv1zqxkdtas7VIph80VmW9uuPy
         Krmwfo2T7SxRU9c8X7xbwlJS3UaBnScrOQe7UsM3gdS84d+QtQEFyzaumH7q3W8DMoXr
         /Erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QG/CjKSvFZQaCoWr7ypQoCkxCBty+FpzO0Qi0VrwzRs=;
        b=Ef3cqKX395l2H/+gFEPqcPdFw3vv/SNDPdLMVW52FBflhCMUnR+Vg/RNI6Tpw52x2Y
         tnD789z9on4veXjgjegbel1IqWFjsEv40Um3tmWYfryv7rKWEDzH+LvGiC0fV+owRyB9
         ePwSV870WwDzVPhqU7FvP8W8yb+vZ8VKsqdpSkXOEk/wWH13jDI3G/ZGEkhmgcd1lUpV
         /aPh9KN2sTjWJj0UzJ1YKAfiqIQ4nQ9BsWKVDe8dpdNcD7VjA9UOGMRB5p+hA2HrMg5J
         rB0bMEMjIqGajzbyXxsDtJ/t4WzlJyubezazrWjHwr3U6zZPE3VnU0bOVt4RFMUWTYKV
         wfeQ==
X-Gm-Message-State: ACrzQf06uQ8/fTvxwsXzPBsuP4zi0X0NTdRc8cHa7aeNUT+afWioyfGE
        vJRYP+XAt3QEpThTsaZrO7LN/RN6Q4hl8Rr3pnN0XQ==
X-Google-Smtp-Source: AMsMyM6RBiAxPrS70jGeErOWqI6T+eSQAVfp1vPQBXJAAh/J4/m3YkRq/wIHtvcBhfQxhEE6uC2O+LIDYuOLo8YddHM=
X-Received: by 2002:a05:6870:b6a3:b0:13b:f4f1:7dec with SMTP id
 cy35-20020a056870b6a300b0013bf4f17decmr28328780oab.282.1667777105032; Sun, 06
 Nov 2022 15:25:05 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000bab2c05e95a81a3@google.com> <000000000000946f3005eca8cafe@google.com>
In-Reply-To: <000000000000946f3005eca8cafe@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 6 Nov 2022 15:24:53 -0800
Message-ID: <CACT4Y+bX40TE_rx0SFnixoQVd_vHuGih9mtJA4TB7-dDOeguew@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in hci_conn_add_sysfs
To:     syzbot <syzbot+b30ccad4684cce846cef@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, edumazet@google.com,
        gregkh@linuxfoundation.org, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, pabeni@redhat.com, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 4 Nov 2022 at 10:56, syzbot
<syzbot+b30ccad4684cce846cef@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 448a496f760664d3e2e79466aa1787e6abc922b5
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Mon Sep 19 17:56:59 2022 +0000
>
>     Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1052f8fe880000
> start commit:   dc164f4fb00a Merge tag 'for-linus-6.0-rc7' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
> dashboard link: https://syzkaller.appspot.com/bug?extid=b30ccad4684cce846cef
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1110db8c880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e58aef080000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Looks reasonable based on subsystem and the patch:

#syz fix: Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
