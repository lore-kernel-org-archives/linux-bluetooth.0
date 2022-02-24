Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732EAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 20:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiBXU52 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiBXU51 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 15:57:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06756D3AD
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 12:56:51 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id ay5so96135plb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 12:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matician-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ua7RwfBUFGFrHt0GqPZjdl1EgU4M6MJALSN7vO8VXDw=;
        b=OmbCixYtk/da6/VEEnh8RrOLQG8h9T9yRj1NDOU9K+3GZohxl3eqlaDolJnyik95I5
         KolpljAJ1YlpUPiDWt1BloVzC7fIP/TF+7iShOVEyYV/Pps3rPcDdY4quDkIPdPa6QYB
         i7qHp84123VDRfeZtgITq3QVvJCM2CMuOTc58y/uqHbtJ2IiN9Y/T/UefUkWMG5qKorg
         ESaAXSK90l+x6Fqxmrzwx4cNkeA3Oa6/xVsA7nx3FVFDnZZSzDkCF/07qLjJqdMo0C89
         wZeNbUduw4Lyh4njRdGmFzxOUcGOn4Xtp1rXgdQYsF7O6ILLEtSvwa7bFlFW0uUm4KOn
         D97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ua7RwfBUFGFrHt0GqPZjdl1EgU4M6MJALSN7vO8VXDw=;
        b=yBrPBpaOeplZa4/0n+4h+3LHzIehDppW+SNkomwdtXae3MbMUa2B9HkCXp81jM+M/R
         DWmkgupS50wgSMpPe9bagB2UUx8QFRif5FIu34lAaY7Z/mLeJnjo0jT+a75E45Tj7qPo
         Ga33BCa7U8bnuzuQiJ8zOY96/bEs5AtWs3zPJJAy2LKCZnRg4PADEH7mi9l2nNkGDF/6
         JFCr7KXkTN4NJOyokZzNUfTc1z4ac//LJ08cwZIeAZLGsfkgwWpo6lPJDZp1AC8uFK5/
         mHHHXVTJ0465FcvgH8i5k/A2iyCXGoTkqkLVOzjA3vJlfbxHqTCx3gr0uo9xsWpx4whF
         J8JA==
X-Gm-Message-State: AOAM532ZrLuAq/aQi6rgd4DAebmhzEvOv5m/FAtVrHLK4ax3Elb6uh/U
        gcdd7AScnTP0EA6ahNu09akg4AKFi9D4hnZwWe15WMkyJoS80A==
X-Google-Smtp-Source: ABdhPJzlurTu2FEJPpIjH8/aMo568rkMIiLcPefVghdDlaweBwJEiCv0GsG+DyShHWVqPrcFF3zX0wPUXDjnM3brnVw=
X-Received: by 2002:a17:902:f782:b0:14b:63db:9bc1 with SMTP id
 q2-20020a170902f78200b0014b63db9bc1mr4222362pln.60.1645736211087; Thu, 24 Feb
 2022 12:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20220224100641.2449550-1-gavin@matician.com> <71D25C8F-67D1-4EC0-9160-5F61C832F0AF@holtmann.org>
In-Reply-To: <71D25C8F-67D1-4EC0-9160-5F61C832F0AF@holtmann.org>
From:   Gavin Li <gavin@matician.com>
Date:   Thu, 24 Feb 2022 12:56:39 -0800
Message-ID: <CACB127+s8mj2-Hkt4yZXRZ_cQ9CbAK0r3y709-8Cb3awpVJm9Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix incorrect nonblock bitmask in bt_sock_wait_ready()
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thanks for reviewing this quickly.

> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> > index ee319779781e6..69374321130e4 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -568,7 +568,7 @@ int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
> > EXPORT_SYMBOL(bt_sock_wait_state);
> >
> > /* This function expects the sk lock to be held when called */
> > -int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
> > +int bt_sock_wait_ready(struct sock *sk, unsigned int flags)
>
> can we then also do s/flags/msg_flags/ then.
I prefer keeping it as flags because all other net code also uses
flags, msg_flags only appears
in msg->msg_flags.

> > @@ -576,7 +576,7 @@ int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
> >
> >       BT_DBG("sk %p", sk);
> >
> > -     timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
> > +     timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
>
> Since sock_sndtimeo() is taking a bool. This might be better !!(flags & MSG_DONTWAIT).
It appears to be well-known in the net code that sock_sndtimeo takes a
bool, since no other
uses of it do the "!!" conversion.

Let me know what you think. I can make the changes if needed but I was
just trying my best
to match the currently existing convention.

Best,
Gavin
