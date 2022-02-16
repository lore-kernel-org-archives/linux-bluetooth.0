Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F57C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 21:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiBPVJN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 16:09:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiBPVJM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 16:09:12 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6F4222DCD
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 13:08:58 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e140so8772218ybh.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 13:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQkktYkowWqztEZVw0Iit/xW1OskO9P/L8TSqkkcI1c=;
        b=BomnxOKi6hfwOMkMGWmww5guMJCXQpv/ZggaC3pEQKYojyxmRVMJriq0kSE1iRv50s
         3kNRO5RP0ZjGipA/0/Hass2UIi/CM+j+8Q2H8jUOLOIEY5wIR7G6SQQmSzgATt7xckLX
         6oRQHYWhlvYXTXDdRoBBHgpMd61UiJUvBrqjRhI/dKO8X43n+Cxeo3zmCqIHr6XiBPJp
         dZYgZ/5JbyOybvUVICzZ4R/hCjgAppHjiRKPhHWmHETK3uV6gn5ekzn+trTHYBfQnBlh
         civgIQNJualsn+ioVAmp57ha5UWNVp6/D89MsYcf/82HnoyMdab/EfiIwsKYVtPP793q
         JV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQkktYkowWqztEZVw0Iit/xW1OskO9P/L8TSqkkcI1c=;
        b=TB0b4Fj5zfBuDuh9hXZKVuU0MPTawxQemNE+x3VYWta2gDLcgvlMqWLy8mO6um/LPo
         pNNhzaI4ancWEXbyQEFi3/U9olU9deCXFE0iKgWam9XOLBF/CjIteA0v1QqoQwN7FuFT
         8kvXdoaTh9hNU88Ch+POMGUcKWpBozxyQAkP5p37BOyz8FQ9szPCquvCVkwuwBzSMleP
         Nzf+pzt9xNRQsWHtfjadPZOi9QZoH+C2cG8Rm8JEGu+HHTsxXVcph06pClUcE/PgZapY
         Py3NyjbTf1lUAp9qCAzBhtjBnV/oi18Zk/V81JRqyJsunWX64xbPuyXBWXi4bhppe/w5
         /EEg==
X-Gm-Message-State: AOAM532sFt/yNRi+jGf7xz40/doBNsrMzX8Bl+0qnkiLLEIlc+byFgVV
        X8gX4haX+0xA3cNZQjoVc1AlakHjEMBD4BuN2tE=
X-Google-Smtp-Source: ABdhPJwLZeYihfMoGduN/qcZAwsgYXNCMUWjOlgEKRUF+LiHuD8kniU3kxDG0dlOJeoc5MlcwwexQ7QhBtW5EbSaQAw=
X-Received: by 2002:a25:add5:0:b0:61d:c906:f4b7 with SMTP id
 d21-20020a25add5000000b0061dc906f4b7mr3844655ybe.284.1645045737716; Wed, 16
 Feb 2022 13:08:57 -0800 (PST)
MIME-Version: 1.0
References: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
 <CABBYNZLA6bRCxd=Tse_XbUT8ReBo4QjvstSassfQAcTX+Fk9_g@mail.gmail.com>
 <b50b9b75-96ea-0d93-3687-3a79cdec5419@gmail.com> <CABBYNZKAUMOZ8vhk2ATPOaVHbcqCTg-DMD2vypkx_CTOjeVg2g@mail.gmail.com>
 <6bec2be7-a411-c5bf-6e5d-b3efee33b834@gmail.com>
In-Reply-To: <6bec2be7-a411-c5bf-6e5d-b3efee33b834@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Feb 2022 13:08:46 -0800
Message-ID: <CABBYNZLAZGoB1JKW63SNJuFB-4raDvHjjEk4w8y0K1MLwe4b7A@mail.gmail.com>
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
To:     Andrey Butirsky <butirsky@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Wed, Feb 16, 2022 at 12:32 PM Andrey Butirsky <butirsky@gmail.com> wrote:
>
> On 16.02.2022 23:26, Luiz Augusto von Dentz wrote:
> > So we are receiving the reports:
> >> ACL Data RX: Handle 3585 flags 0x02 dlen 14
> >        ATT: Handle Value Notification (0x1b) len 9
> >          Handle: 0x002c
> >            Data: 01000000020000
> >
> > So I suspect there is something in the HID/uHID not working then, what
> > version of BlueZ are you using?
> >
> It's BlueZ Version: 5.60-0ubuntu2.2, Ubuntu 21.10

I try upgrading or better yet use the head since we have some fixes like:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/profiles/input/hog-lib.c?id=0516d2527ea83c8fa209d52c564ce99408a00fbe

-- 
Luiz Augusto von Dentz
