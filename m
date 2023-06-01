Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E56C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 03:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjFAD6B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 May 2023 23:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjFAD55 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 May 2023 23:57:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC793
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 20:57:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af278ca45eso4861971fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 20:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685591874; x=1688183874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Oi7PWcjBkUW0YlbN/exknEFUJgU8vT115+fDNuws1w=;
        b=A2G8/HMrnBcP0jqWUqpf/F8Fq+d+bPO1diVviVhejop+paZkFKnjzLrisVG/nmWYGo
         JCS33vhXTwvfdFhzGjVuAKbg3hVueSQ+ZAq7kZiWlDoJpPhU5IvFsEbJ286hYShxji2M
         WAYUZ9cABr3QcOiXGnosNnqTm42r43ZzOpMeDZ1jIzlwRomkmlbFu+1uRcIm+Cci9Z1T
         jn2NoDKVE6efxB9C+LQu0/BvnUAJA8PUx0YjirRpmkvJbK3kYULglhlGiqf/hM7svV9u
         UcFRMlqqUuDegMWaWNP44q71kUJjHq2zZyAXkGrZR2UoUkqD6XuGyuRWn18KFlXWQD6w
         aSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685591874; x=1688183874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Oi7PWcjBkUW0YlbN/exknEFUJgU8vT115+fDNuws1w=;
        b=RdQIIAMPlZbrBcFxt1VqroxEGY9eyjXxxOeFhPlHHebKg+hWQBeOewKxCZcsLQ3Amv
         I3YJKISWdVtvIHmjGuNKa+07pP/NLO+oMw6YxtdziX4qUO7p+XlOEqlVwd8Kt9IS2FbZ
         l3R8IUfpxskcUsxCnBv3m4vDZISZpebqbUO03y5gjU3B7dwonb2VFtdSxXZ4I/hnkVs6
         oQwqtCHb+IsIsxeBZt/l2+lyqJKEueTFbQRmDqu/PyqTLCHRu+KA0gygJZIcZus1zysl
         cBemUdnAE34IvF5qrgo8GfM56nWq8WF8BOp2yPuo7KsdPvL54DtvWccbBt7CqCT1kd8L
         ga2g==
X-Gm-Message-State: AC+VfDyoHn2H5qFzJ642Sr4OjIat6uRZ/2WlwnSbKFcWzXzoSR0jxUnL
        5AaylltVykuSu+3/IsvsgseR1qJo+0NBCujgTYwrZzdIQS8=
X-Google-Smtp-Source: ACHHUZ4sq6vEMqnVXpIk7gER08ByqhjLK/N7+hXq9pJG2MjHutjPG0VxfLRPMs+0NmwhCujEAiWU1nCP75AcyrZjGb0=
X-Received: by 2002:a2e:360e:0:b0:2b0:3343:1c0a with SMTP id
 d14-20020a2e360e000000b002b033431c0amr3713625lja.31.1685591873429; Wed, 31
 May 2023 20:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230601023835.1117866-1-yinghsu@chromium.org> <64780a7d.d40a0220.ea23f.cabd@mx.google.com>
In-Reply-To: <64780a7d.d40a0220.ea23f.cabd@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 31 May 2023 20:57:41 -0700
Message-ID: <CABBYNZ+wmNX0seeh+XeCbnL7=DozCULoRg7s+_WnM3XCnmQoTg@mail.gmail.com>
Subject: Re: [v6] Bluetooth: Fix l2cap_disconnect_req deadlock
To:     linux-bluetooth@vger.kernel.org
Cc:     yinghsu@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ying,

On Wed, May 31, 2023 at 8:08=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be appli=
ed to the current HEAD of the repository.
>
> ----- Output -----
>
> error: patch failed: net/bluetooth/l2cap_core.c:4634
> error: net/bluetooth/l2cap_core.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>
> Please resolve the issue and submit the patches again.
>
>
> ---
> Regards,
> Linux Bluetooth

It has been pushed already:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D0e31289b2827062975194a68c0ae4d854cd87a81


--=20
Luiz Augusto von Dentz
