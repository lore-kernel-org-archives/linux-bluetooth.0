Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBBCC3F2CE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 18:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E42217F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 18:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBBYGOIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgCDSgf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:36:35 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:37507 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDSge (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 13:36:34 -0500
Received: by mail-oi1-f176.google.com with SMTP id q65so3139051oif.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2020 10:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6zjVCgIDBiUnV97pPvDbMIe94i/6uVThNGHFUuea4lY=;
        b=RBBYGOImBEVDGwfcGzOtEb6yDd7TpWWftBlDU2yhVt6Ybbb/tfwWUM54IhBNQF56QI
         PljIlst2+c/FS1f9wRt66FDVGUmNYc8pYHzPlvn9xGNsoaSMX7PxOcOOWuR44LaqvZdp
         XBA96kn/pQeNRglfsEwDusGTn13bc8ab/IImfJEDvlFAMAn44EpsJXvsLOHAqhb3jH3V
         +Bhe5C+R28IQRyjb40VbPy5iAZCibmPVkhhSNtc3BNTWE29RAQME4UIJKf2FI8qzLtxp
         FjTNjpGjgBafqAqFSRzWlr3f7D8fs/avN3upvnAYbV3Snm3Jd9sYKPi9vH/1TaSGZbA5
         VLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6zjVCgIDBiUnV97pPvDbMIe94i/6uVThNGHFUuea4lY=;
        b=r+t7XWP0YreakDlTDhGeQ80BFe7rafvFX8mQE79mJYpHMMGnvAmz5CkkNjQtG7QUvE
         XOEvhJSR2YbXa7zEdzuSBnZyCFNJG9CdxpIS1/O5OL232DtdmWRnJtspGkoMCIaITYIM
         OcmUEpe4y2Fr+++tczRzmd3878hLPda1kqw2uoxV+MR9Gw5uYAjvMMWIgPaMXpeA1YwU
         7G7tJpHiuMb8DjwwO0if6B9ttSI/yyJpxMH0vqeKbqJU2IrjN6S3ma2iJnA7vd+qy1DR
         IwofH3B9iCvEVCVv2jYflKmg4uuWjRJ0RMoFqmR8pEpz4hh3tsQdV7pX0gwwXvh3IMtO
         mfnQ==
X-Gm-Message-State: ANhLgQ2iG0286eF9sb2SQOVzGtGJ5Wrb8/9rVDKEiw5MexIseST37eCi
        ASgAOJj9CqUsEXzw5vMhUlWD3PGso259r/KaNVV40+LZyXw=
X-Google-Smtp-Source: ADFU+vuMnSpAcNYgSYMxKvE5JG3QQsXHRKYGPK8Qlj+FTKbEf1jMLasrvfLrJ4Nw0+k18VJxyTZL7DGYMCNH7P4j1sg=
X-Received: by 2002:aca:b1d5:: with SMTP id a204mr2710446oif.82.1583346993651;
 Wed, 04 Mar 2020 10:36:33 -0800 (PST)
MIME-Version: 1.0
References: <CAO1O6sdGJeAKTHBVyDSUa7-Hp_ULYmfOHJEbb6=-B6xuPHvffQ@mail.gmail.com>
 <CABBYNZKtxPmTUn2fw9-dy1V9M_Pb996O6VmHkg4NrAr-=t+-4A@mail.gmail.com>
 <CAO1O6sdke-2J=eYHS2SoG83v-hMJDBu-gasufJYDyHK+1R+w5g@mail.gmail.com>
 <CH2PR14MB3658759A2701FB52A2D6573BE6E50@CH2PR14MB3658.namprd14.prod.outlook.com>
 <CAO1O6sfwcEswTkuuntoBM_S5oFkQv7mCP1GH8Z0S0vgHk2Bp5A@mail.gmail.com>
In-Reply-To: <CAO1O6sfwcEswTkuuntoBM_S5oFkQv7mCP1GH8Z0S0vgHk2Bp5A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 Mar 2020 10:36:22 -0800
Message-ID: <CABBYNZ+2v5Z05dSD+TrzioGYVWugZJGpBnq+2M=MO-smuVgXbA@mail.gmail.com>
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

On Wed, Mar 4, 2020 at 7:56 AM Emil Lenngren <emil.lenngren@gmail.com> wrot=
e:
>
> Hi,
>
> Den ons 4 mars 2020 kl 11:55 skrev Jamie Mccrae <Jamie.Mccrae@lairdconnec=
t.com>:
> >
> > Hi,
> > > It should be fine also if the remote end sends an Exchange MTU reques=
t
> > > at the beginning of the connection since we can then immediately send
> > > a response and assign the MTU property without waiting for the
> > > Exchange MTU response (that corresponds to our request).
> > >
> > > Let me know if you think I've missed some edge case...
> >
> > In the core specification 5.2 volume 3 part A, there is a command, L2CA=
P_CREDIT_BASED_RECONFIGURE_REQ, which allows for the MTU to be changed afte=
r it has been established. This requires an enhanced ATT service however, b=
ut it means that the initial MTU is subject to change.
>
> I just read the L2CAP/ATT/GATT parts in the new spec. Is EATT
> implemented yet for the dbus-api, and will it affect the API? Anyway,
> for EATT it's a requirement that the MTU can only increase, never
> decrease, which shouldn't cause issues for apps. But change my "ATT
> MTU exchanged" property name proposal to "Initial ATT MTU exchanged"
> then, if waiting for the ServicesResolved wouldn't be enough, and set
> it true immediately if EATT is used and after an Exchange MTU
> procedure for unenhanced ATT. Then update the ATT MTU property when
> the MTU is increased.

It completely transparent to D-Bus, so if we do expose the MTU it
should probably be reporting the biggest MTU of all connected channel,
while it is possible to reconfigre the MTU with
L2CAP_CREDIT_BASED_RECONFIGURE_REQ I doubt we would be exposing this
sort of operation to applications, we have to keep in mind multiple
application can request a change for their own needs so like Exchange
MTU bluetoothd will be taking care of setting the MTU, that said with
EATT incoming and outgoing MTUs don't need to be symmetric like the
unenhanced bearer.

--=20
Luiz Augusto von Dentz
