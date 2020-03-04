Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DF4C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 20:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEBD207FD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 20:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC96RYk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgCDUoD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:44:03 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33908 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgCDUoC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 15:44:02 -0500
Received: by mail-oi1-f173.google.com with SMTP id g6so3564738oiy.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2020 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0OZQImmCMy5wMxnPq36M6NHrUziOzGvZ6Fk3jvk2RHg=;
        b=lC96RYk91X2RaFEc6ZHqDvBdaP5GXbY1sIrZjJOex3LRJQsoKqNpjl0lsoKoG9CNNC
         pCFSVO02jjdI7b01mUiWFXxBWTjSNhzXKYDmTqScFZZnEROkC/2NqXBcDqU265VbOq1n
         pzu/DPbOp3B3UemFX485n1q6ZNb9MOW9UO9D+5ajDAQUOTrORimd+qGJTm1IU/Ogh2n/
         7NlwR8XR3mZ/aJQjaTUJlx6/Q58ukH8+6d0qtjLsjjpwaa5XCrTJFGsBzON9XYjR4+uS
         /PfWppuSXqC6W1VGbONy1tX+ggFDDnVZgdXC7OpyoNa7E5PTvVgg/jlhX4HLGv3p4iw7
         uHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0OZQImmCMy5wMxnPq36M6NHrUziOzGvZ6Fk3jvk2RHg=;
        b=sf2JVtjxpAnsenOQegbLhPjQUJwwRK/+PIeQ5Ztv+kFlgzmvPoib0Q4V5aVI9XMg9g
         9qTEwOb6zpczYQR/8SbqfHjIPIMRImdkOOtmHy5JGsBe7G/lwrCy2Cwoa3K3j16+O3+J
         u4MXTfqt6+5NXxjGTYpPxvnTjeCn7DBiORXShjGjz4CQUrIsC5Rr/xOeei5QxfYuc2LI
         DtvBoLJgwrfRAuTK5rx1Cx1uOzl3GHSATxtNZKYn3v6PdB9SSHU9S4q4HzeqKdqxyvFF
         iLtJtp8+zNbXY4NkBYDyPiDHBjj0rO62VlVTsfpeLM+vu40cpguQodAxTsvG1QsPp9ns
         hIjw==
X-Gm-Message-State: ANhLgQ2Alg1E2jmaDMhq04Y34koFQBJR/ljOhkMLIhUItUYs2I5CwUlr
        F2xWxYlsrDi2ljf8TMXFedmd/1KCj9DmplldK5fyrIZD
X-Google-Smtp-Source: ADFU+vtJQMuyw70j9HHJCr3zMKijZfjdDQQcRC5+ib0EFuwqRpE3T5YFa3xz/wyFM99wC5suRNK3Os5zYjYI/CZ7WSI=
X-Received: by 2002:a05:6808:10b:: with SMTP id b11mr3140918oie.110.1583354641984;
 Wed, 04 Mar 2020 12:44:01 -0800 (PST)
MIME-Version: 1.0
References: <CAO1O6sdGJeAKTHBVyDSUa7-Hp_ULYmfOHJEbb6=-B6xuPHvffQ@mail.gmail.com>
 <CABBYNZKtxPmTUn2fw9-dy1V9M_Pb996O6VmHkg4NrAr-=t+-4A@mail.gmail.com>
 <CAO1O6sdke-2J=eYHS2SoG83v-hMJDBu-gasufJYDyHK+1R+w5g@mail.gmail.com>
 <CH2PR14MB3658759A2701FB52A2D6573BE6E50@CH2PR14MB3658.namprd14.prod.outlook.com>
 <CAO1O6sfwcEswTkuuntoBM_S5oFkQv7mCP1GH8Z0S0vgHk2Bp5A@mail.gmail.com>
 <CABBYNZ+2v5Z05dSD+TrzioGYVWugZJGpBnq+2M=MO-smuVgXbA@mail.gmail.com> <CAO1O6sfWgqnduM8_UuO_1W8KjnEvoetbk6bcaA_ATFUaXLtB0w@mail.gmail.com>
In-Reply-To: <CAO1O6sfWgqnduM8_UuO_1W8KjnEvoetbk6bcaA_ATFUaXLtB0w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 Mar 2020 12:43:50 -0800
Message-ID: <CABBYNZJrWBVEY7ZUxqFShfPne2b=6ahDOd3srJF6NAJwQLWQpQ@mail.gmail.com>
Subject: Re: Get negotiated ATT MTU?
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil,

On Wed, Mar 4, 2020 at 10:47 AM Emil Lenngren <emil.lenngren@gmail.com> wro=
te:
>
> Hi,
>
> Den ons 4 mars 2020 kl 18:36 skrev Luiz Augusto von Dentz
> <luiz.dentz@gmail.com>:
> >
> > Hi Emil,
> >
> > On Wed, Mar 4, 2020 at 7:56 AM Emil Lenngren <emil.lenngren@gmail.com> =
wrote:
> > >
> > > Hi,
> > >
> > > Den ons 4 mars 2020 kl 11:55 skrev Jamie Mccrae <Jamie.Mccrae@lairdco=
nnect.com>:
> > > >
> > > > Hi,
> > > > > It should be fine also if the remote end sends an Exchange MTU re=
quest
> > > > > at the beginning of the connection since we can then immediately =
send
> > > > > a response and assign the MTU property without waiting for the
> > > > > Exchange MTU response (that corresponds to our request).
> > > > >
> > > > > Let me know if you think I've missed some edge case...
> > > >
> > > > In the core specification 5.2 volume 3 part A, there is a command, =
L2CAP_CREDIT_BASED_RECONFIGURE_REQ, which allows for the MTU to be changed =
after it has been established. This requires an enhanced ATT service howeve=
r, but it means that the initial MTU is subject to change.
> > >
> > > I just read the L2CAP/ATT/GATT parts in the new spec. Is EATT
> > > implemented yet for the dbus-api, and will it affect the API? Anyway,
> > > for EATT it's a requirement that the MTU can only increase, never
> > > decrease, which shouldn't cause issues for apps. But change my "ATT
> > > MTU exchanged" property name proposal to "Initial ATT MTU exchanged"
> > > then, if waiting for the ServicesResolved wouldn't be enough, and set
> > > it true immediately if EATT is used and after an Exchange MTU
> > > procedure for unenhanced ATT. Then update the ATT MTU property when
> > > the MTU is increased.
> >
> > It completely transparent to D-Bus, so if we do expose the MTU it
> > should probably be reporting the biggest MTU of all connected channel,
>
> Is there ever any reason for one application to have more than one ATT
> bearer? I thought the idea of EATT was to allow one ATT bearer per
> application.

EATT is meant to allow multiple outstanding requests, it probably
would not escale if we would add an API to have a bearer per
application so we just use the extra bearers as a pool.

> > while it is possible to reconfigre the MTU with
> > L2CAP_CREDIT_BASED_RECONFIGURE_REQ I doubt we would be exposing this
> > sort of operation to applications, we have to keep in mind multiple
> > application can request a change for their own needs so like Exchange
> > MTU bluetoothd will be taking care of setting the MTU,
>
> I think it's fine that bluetoothd chooses the MTU. I don't see any
> reason that the application should choose MTU (assuming bluetoothd
> sets a big value).
>
> > that said with
> > EATT incoming and outgoing MTUs don't need to be symmetric like the
> > unenhanced bearer.
>
> While that is true on the L2CAP layer, it's not true on the GATT layer:
>
> Vol 3 Part G section 5.3.1:
> "The ATT_MTU for the Enhanced ATT bearer shall be set to the minimum of t=
he
> MTU field values of the two devices; these values come from the L2CAP_-
> CREDIT_BASED_CONNECTION_REQ and L2CAP_CREDIT_BASED_-
> CONNECTION_RSP signaling packets or the latest L2CAP_CREDIT_-
> BASED_RECONFIGURE_REQ packets."
>
> So if the peripheral sets its receive MTU to 48 and the central sets
> its receive MTU to 517, then 48 will be used in both directions.

This is kind of an artificial limitation that the author decided to
impose on the bearer, but if it was adopted like that so be it.


--=20
Luiz Augusto von Dentz
