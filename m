Return-Path: <SRS0=VvJN=D3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB28C4363A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Oct 2020 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17682225C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Oct 2020 19:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJoI2FaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391720AbgJTTUO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391532AbgJTTUO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Oct 2020 15:20:14 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF39C0613CE
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2020 12:20:12 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a28so3246523ljn.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2020 12:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7GU1H0h9UBubdWAWqWMxlmAZQoK+Olw+C+P1XGiZZQE=;
        b=rJoI2FaQ3pkxI7xH6L3mHmcjOwBSF2V4W3WJJaeCNiY4P/QOtOKIVCS5KWKWD9Tvsk
         m6PWSWFQLaVnFRg/eYnR2YA/IvoMtZQ96boy6GcZcY0kFQ3ukrDAycpbf8jzetR7krtK
         Ok2RgfBUcxOyjl4dFhT9zccT/1Uh/j/JH+9G8p/k/4oZXa/BET0BMpvfilAQK6Hn9McX
         QMXeWLzSadm/ieuGytCak30Q1FellkT4y7p8YHiMTehGejxKHbGvRTyz4DRC+vebuRhP
         RPAW3Eo16i06mAhFA4CXwSH3DWveZknPTKPY9prZKtLWEPcixQADHeYVIu4JwtTmPVY6
         XlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7GU1H0h9UBubdWAWqWMxlmAZQoK+Olw+C+P1XGiZZQE=;
        b=Eoyp2+ve8N188Fd1SknDSJCpFqHFS+WbFlm8VFnOnjso7tKbQrwQ4kKD42sUSf098h
         0JXUVPxCqWyEIden2TTd8Kn7RGnwbAQc0S7VOXyghUfxDkhgcT9w5QP4czdBtuSFBxkU
         GhlnOQCA/HsJrzX/3Tac/pOBmNqRr07Vw2IITLh7HASKfJYO7H7euyccnVRbm7IcRPGX
         1QojWHbMVoINTPkrBTxzbrL0CQRTTKIlCk68wFtNXYgP2IGDkk8Ec0BdcS2YHacjF00s
         2OuTw5ZZ64H2zzZ89VioiLKkBc5H0JSndArPFQh7O129L9+IuAjmTrqfAvfls705/NwA
         hGBg==
X-Gm-Message-State: AOAM533ox25t++736UUMHPHccyWuAVQ41lSL8Fp532uXi5rpDIovDYhf
        laO9p5kCErEm3JCloL6jVGcZDT8SIXgtQzjDYa8y9edoBXM=
X-Google-Smtp-Source: ABdhPJxgdEqkIXGQy3IogWIvWlUp0vYEJHgbHUyKgUy8UNqVJVyv18woifb4GRFTZVJxVz+eFxRUKU13EzJXXdiHJPI=
X-Received: by 2002:a2e:b528:: with SMTP id z8mr1803374ljm.205.1603221611161;
 Tue, 20 Oct 2020 12:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <CABLzjm8S1J5MRhrwFu1pbX9fub7X5nXmYRWmtRsmVRObeJOCbw@mail.gmail.com>
 <B67F1317-2644-4803-8A16-2A2E7CC425F3@holtmann.org>
In-Reply-To: <B67F1317-2644-4803-8A16-2A2E7CC425F3@holtmann.org>
From:   Alexandre Augusto <alexandre.a.giron@gmail.com>
Date:   Tue, 20 Oct 2020 16:19:59 -0300
Message-ID: <CABLzjm-8-=73XQFxsqoGaqXYS=1E7jA5m_bqsGKmRj8gdt+e+g@mail.gmail.com>
Subject: Re: Entropy source based on the RSSI
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sorry, I think I misunderstood your email Marcel, apologies for that.
But yes, I have a sketch for this as a kernel driver (but still non
functional).
Nevertheless, in my repo there is a proof-of-concept version that I
used in the experiments presented in the video.

Thanks for the feedback.

Em ter., 20 de out. de 2020 =C3=A0s 15:38, Marcel Holtmann
<marcel@holtmann.org> escreveu:
>
> Hi Alexandre,
>
> > based on the motivation that IoT devices do not have many entropy
> > sources available, and also on the fact that trusting in a single
> > source may be risky, I have researched some additional ways to collect
> > randomness for the device, using bluetooth technology for that
> > purpose.
> >
> > For those who are interested in:
> >
> > Github: https://github.com/AAGiron/Bluerandom
> > Presentation: https://www.youtube.com/watch?v=3DiAKaKAmqCFo
> >
> > I also want to say thanks in advance to Emil Lenngren for his valuable
> > comments, here in this mailing list (back in 2019), and also to the
> > Bluez community.
>
> I would integrate as kernel driver. The Bluetooth stack could just use it=
s
> own LE random generator and an initial passive scan to gather RSSI values=
.
> No need to push this into user space.
>
> Regards
>
> Marcel
>


--=20
Alexandre Augusto Giron
Professor da UTFPR
Doutorando em Ci=C3=AAncia da Computa=C3=A7=C3=A3o (UFSC)
