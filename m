Return-Path: <SRS0=TRpe=UV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC402C43613
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 17:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C186E20675
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 17:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRSM3boD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfFVRBZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:01:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35301 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfFVRBZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jun 2019 13:01:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so9442309otq.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jun 2019 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7dvF9l9D/90n4FIs3GxFXRzqjm3pvT0oW/Ojzpf4ymc=;
        b=cRSM3boDZTH0RY/zRidGdw8f8tnjeMCD/Sw6Rvenf6/l2JO3ZCyc8HkXUpC44pYWYs
         /fbq5jKCROjtCisLJq/QWLgMzTrNPylY20MZn1XTzwf6cmDJzTke3x3jwVDhI9nrXeEv
         jg1TKCzew30sM+Y/jV5ALRlbPoaHb9qOOqWgkZTe+vHMN6vHZCEScK9GfKyZXt0iLTnk
         fostsOwkLZzv2eiLlRHTjmxPGFeOX96GbWxJkGXIQV7QUSEx0YlAGPzjs5oHCUo9GKOY
         vXdwhv9BbEfhMo4XrFRC8YcVdt3U++mcM3rFVeFANCGEffjIsqtVI1j+xeprJRee0W3g
         +pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7dvF9l9D/90n4FIs3GxFXRzqjm3pvT0oW/Ojzpf4ymc=;
        b=DdvY2egksGaDRteYlbOXfQEZHt9ClK1e0ooKhzH9ZBkAov00vlXO8Hu3hkfUyG3x45
         k2tUVEwExcDFGDfisgumfEQGRidAuem+HU9JUvHXLXq64JYkf0YNelWY+T1VxqgnplUf
         leNv+oM9hmeKeU+XmrpZke90rTHyrEe6iwutu1WC2QA6r1tIPRUhuP1ki9863EdWpFF6
         rN/NsOdYZyk6sV/JlOqnZazsgMZCdZpk0Xq46DeA30px9tw2u4bSGEPi6IkM7gfSxnN/
         4zUR6rZxgZPSa68vDpzM0RbquwY+5K5GSh7fhB8oM399nrKgv+fS1J8Zf491DUWmZVun
         v0Tg==
X-Gm-Message-State: APjAAAWncQorut3yJb6vvp4Jr+Kco2RJJGhwbqhtExhncigEIwMZVdow
        Jh1vms8oZ5Fz2wY2z786U+qld8d4q6roYKOlHJM=
X-Google-Smtp-Source: APXvYqyT063nX5AJuPcdy0fZeBnJezHzJcDmUo3N8zp9G+KtT2zCKcKpzOhNCE5yYlVcuIbsccC4SdGye40ZBCUENxQ=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr9677381otf.146.1561222884447;
 Sat, 22 Jun 2019 10:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190513170550.bsbr2mh7w36hj7io@pali> <20190607125800.trsx2o3njaiaitu2@pali>
 <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com>
 <20190607153715.w5exsodd25qxc6xv@pali> <CABBYNZ+gPRkAgFAeeoSqZ7tp5fYimGdju9JSuSpn_kL+f9hJhQ@mail.gmail.com>
 <20190608105924.qmauvrwyz7nofx74@pali> <20190608111553.65s6yoyhmusmr3pc@pali> <20190622161837.37mjlsirpoql2plj@pali>
In-Reply-To: <20190622161837.37mjlsirpoql2plj@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 22 Jun 2019 20:01:15 +0300
Message-ID: <CABBYNZK-L0NfuR9Qq8Vj9Q7nxmgurzkimayJHSKV+kTJ7D_tUA@mail.gmail.com>
Subject: Re: bluez - check for new a2dp features
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sat, Jun 22, 2019 at 7:18 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Saturday 08 June 2019 13:15:53 Pali Roh=C3=A1r wrote:
> > On Saturday 08 June 2019 12:59:24 Pali Roh=C3=A1r wrote:
> > > Ok. So is there any way how to check if bluez supports profile switch=
ing
> > > or not? And if not, could be introduced some flag/property on DBus so
> > > applications would not this information?
> >
> > Because older versions of bluez does not support profile switching and
> > does not support properly remembering last used SEP, I need to know thi=
s
> > information in pulseaudio. To prevent any breakage e.g. that high
> > bandwidth codec would be chosen by old version of bluez in unsuitable
> > environment. Because of these problems I do not think that pulseaudio
> > should register these high quality codec with fixed high bandwidth. And
> > currently there is no way (or at last I do not know) how to check if
> > bluez support these features. And I need to know it at time when
> > pulseaudio is registering to DBus so it would correctly decide if SBC
> > UHQ codec should be registered via DBus to bluez or not.
> >
> > Currently I know one way how to detect it -- look if there are availabl=
e
> > SEP paths at dbus. But this works only after A2DP connection is active.
> > So I cannot use this "heuristic".
> >
> > Therefore I'm asking for some DBus property or flag or whatever which
> > would tell me, prior to registering A2DP codecs via DBus to bluez, if
> > bluez supports profile switching or not.
> >
> > Without this information, pulseaudio could enter into state when it is
> > unable to transmit any audio via bluetooth because old bluez chosen
> > unsuitable codec. And because old bluez version does not support profil=
e
> > switching, nobody (pulseaudio or user) is able to fix this problem.
>
> Would be possible to provide this runtime dbus information? As explained
> in previous email, I really need it for pulseaudio for additional A2DP
> codec support.
>
> If not, then I would be forced to use compile time check (probably via
> bluez.pc) and based on this decide if support for additional codecs and
> profile switching would be compiled into pulseaudio or not... But this
> would work only in case whole profile switching would not be hidden
> under --experimental command line flag. So another configure flag for
> pulseaudio would be needed.

I think a better idea would be that we introduce something specific to
that, such as the SEID being returned so the next time around you may
restore a SEID, this may actually make more sense perhaps if we reuse
the RegisterApplication semantics:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n4=
64

That means it is no longer required to call RegisterEndpoint as many
times as there are endpoints since that is time-consuming due to the
D-Bus round trips, instead, the endpoint are discovered with the use
of ObjectManager, if the method doesn't exist then you just fall back
to the old mechanism since it might be an old daemon.

--=20
Luiz Augusto von Dentz
