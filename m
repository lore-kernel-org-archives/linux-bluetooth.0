Return-Path: <SRS0=CJlv=4S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D46C3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Mar 2020 19:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5E5246BA
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Mar 2020 19:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlBuD5no"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCATQQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Mar 2020 14:16:16 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:33680 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgCATQQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Mar 2020 14:16:16 -0500
Received: by mail-ot1-f52.google.com with SMTP id w6so7593294otk.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Mar 2020 11:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7BtwWmGqlMfLRFx10LsAlrYvxOig9qCTrlkBwPALNEY=;
        b=dlBuD5norKFYCrB+04LYP78AFoST6eVnBdxrdKubyUVyVbOhXVuDe6PEejoyZwvFiC
         Gx+nPF5vRlUF8EEQmlhK7L4l/YhYuW682brNWDcDeyDfkhYP6g5526o+ygBjpM9oyI3N
         8yEpGdVIduQW9MEIRUVjHgSfR9MwR+4Zge1Xbax3gG3nDcapkRzmVP4ZaXT9tesnqB+O
         BQlOMOziaRCwHRYCBNehYpJNbR2qhjtNXJwM+Y2Tjz/6MMifV1G/u19p9ZiOo1wG3Itk
         LjoHaY/Cc4gEeia2aoYjF/fK+751kNH1mwObiJ3dfW70hohT/xXWG3ABfyWwpxv7Z3Qf
         EhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7BtwWmGqlMfLRFx10LsAlrYvxOig9qCTrlkBwPALNEY=;
        b=r26Convy7T+nc8jdF/IKNrkkP56z0iyzwg3ABpCNPhHuQ0LbPAZucfus1SFZBHNo73
         ncP4BYAx3k8bfKcUU6EFckUNuoH2q6kMrdrtzV6N8VImt9SyxdSFPLrILgC7H+KSu9lk
         JlcHBPTidVHqj/TC8ZwqTuDKep9zQd/Os9VN5FDFZpDO5avOrfWcL2if+pbiry7Q0jzv
         xQtfB9qWbcfN9DyyBVBF6b4aVVN3lYiD7clgmd7iWfOpHaa0DoWfx/hJYmjOmKtEAYJ0
         F1JtCJqLTsVQlWk9GzDJRMp5GTEUHHgrGD6G0OYa2ZTBRQlsJ/YHxd/Ndvsh3xxwRdUY
         /bxA==
X-Gm-Message-State: APjAAAWhr+nJIz9Al17NG16Q7U2cv1/49y4DRDsdrKIEytHviVWskPbb
        SvPcu6FHCKkIHL+Aty03OmPejArC+p1mbpYW8qVegJ08
X-Google-Smtp-Source: APXvYqxMZX01lkkg8z16TJ4qXCumUXrtGBhaZkju1Bq+sPRp0SexGmtJJYjEdfJ32rdSAmOn0rGE7P5pBIRodDwWyTc=
X-Received: by 2002:a9d:6c01:: with SMTP id f1mr10289689otq.133.1583090175538;
 Sun, 01 Mar 2020 11:16:15 -0800 (PST)
MIME-Version: 1.0
References: <CAO1O6sdGJeAKTHBVyDSUa7-Hp_ULYmfOHJEbb6=-B6xuPHvffQ@mail.gmail.com>
 <CABBYNZKtxPmTUn2fw9-dy1V9M_Pb996O6VmHkg4NrAr-=t+-4A@mail.gmail.com>
In-Reply-To: <CABBYNZKtxPmTUn2fw9-dy1V9M_Pb996O6VmHkg4NrAr-=t+-4A@mail.gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Sun, 1 Mar 2020 20:16:04 +0100
Message-ID: <CAO1O6sdke-2J=eYHS2SoG83v-hMJDBu-gasufJYDyHK+1R+w5g@mail.gmail.com>
Subject: Re: Get negotiated ATT MTU?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Den s=C3=B6n 1 mars 2020 kl 07:46 skrev Luiz Augusto von Dentz
<luiz.dentz@gmail.com>:
>
> Hi Emil,
>
> On Sat, Feb 29, 2020 at 2:13 AM Emil Lenngren <emil.lenngren@gmail.com> w=
rote:
> >
> > Hi. I have a feature request that the negotiated ATT MTU should be
> > exposed as a property in the org.bluez.Device1 interface.
> >
> > For some applications it's good to know or required how much data that
> > can be written / read / notified in each packet, and it's not always
> > desired or possible to use AcquireNotify / AcquireWrite.
>
> We already negotiate a fairly big MTU maximum by default, and you can
> just use AcquireWrite/AcquireNotify just to discover it and the close
> the fd immediately, so I suppose we cover much of what the feature is,

I was considering having a solution implementable by for example
Web-Bluetooth. This "workaround" wouldn't always work since it's not
guaranteed to exist a characteristic with the 'write-without-response'
or 'notify' property. I think there could also be a "race condition"
here if two apps do the same thing (although the time window is pretty
small): one app might get that the acquire operation returned "busy".
And is it even possible to use AcquireNotify/AcquiceWrite if the d-bus
runs over tcp or the programming language doesn't support d-bus file
descriptors? An ATT MTU property would be so much simpler and
straight-forward.

> except perhaps if the application requires something bellow the
> default MTU bluetoothd but that can be a problem if other application
> would start requiring their own MTU as well, so even if we introduce a
> Property that would have to be read-only

Yes! The idea was to have it read-only. It's sane to let the BT stack
negotiate (a big value on non-embedded systems like Linux/BlueZ)
immediately after the connection has been established. There should be
no reason for an application using BlueZ to negotiate a smaller MTU
than a "big" one, which BlueZ already selects.

> but there may be races if the
> application start writing/reading too fast or the remote end do
> trigger its own exchange for some reason.

It's already not possible to write anything after "Connected" has
become true but before "ServicesResolved" becomes true (I get
"org.bluez.Error.Failed: Not connected" in that case). I assume MTU is
guaranteed to have been exchanged at this point, so there shouldn't be
any problem for this case. Another possibility would also be to add a
boolean "ATT MTU exchanged" property which is set to true when the MTU
property becomes valid, if waiting for "ServicesResolved" wouldn't be
enough.

It should be fine also if the remote end sends an Exchange MTU request
at the beginning of the connection since we can then immediately send
a response and assign the MTU property without waiting for the
Exchange MTU response (that corresponds to our request).

In the case when the remote end sends a notification before it
receives our Exchange MTU request, then the MTU property would
correctly be 23 since the MTU Exchange hasn't finished yet.

The list of five rules in Bluetooth Core specification Vol 3 Part F
3.4.2.2 (ATT_EXCHANGE_MTU_RSP) should also prevent most "race
conditions".

Let me know if you think I've missed some edge case...

/Emil
