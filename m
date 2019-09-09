Return-Path: <SRS0=76SB=XE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B176FC4740C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Sep 2019 14:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D77218DE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Sep 2019 14:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkTtLZ/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405090AbfIIOHx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:07:53 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:41409 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405094AbfIIOHx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Sep 2019 10:07:53 -0400
Received: by mail-yb1-f174.google.com with SMTP id x4so986625ybo.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Sep 2019 07:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m+KwRik4gBy1au0sPkyf3szvTSQct26/R0UizV9BM78=;
        b=PkTtLZ/giPH+bPOdQ51srxUQa9uSudYVBt/tMQmf3VqIILGLSmt+3sksFth5aW9ujp
         fL+8LMi/MUgiPhcSoDBdnySgoNx2ryV6Ey610TzhUsxMz1ATxVSmcAnJueQ4TltFo4yg
         AH5GDo+6y3j7L+J97ljxfMPbgJ3T+W4+YrppPA4bdJHiWXxG1SKzeR0IeHsphosQycFG
         OCBb8UHKuf3L93GVn9LWyEWobDnZ+cM1t7Arh//md+IBeTYZr1gZzPoqCGkUwPHGCRnS
         7EwH36/JMN/pWxIHK+Ldfj1IqSEQUHo24HpMLJe1uMR4jfXB0gimctdENnUmAS3Ztnhi
         V/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m+KwRik4gBy1au0sPkyf3szvTSQct26/R0UizV9BM78=;
        b=uGSScKyW5//ZcvLp8RIzz5XzWwQ7kcOV55HHEPnioY/0pZl9AC9fv1BU6tESNO1ark
         T9O8Tm5SMnMz4c8xRk8tGFtktd4t96OFd10QHuKbe3S2++K5DjjN2LWfozq0QX9A4IbQ
         Ifgoh4kOis3Mdtn+AHJ5FPDtiaKcddncjM3CI4Cfxxj4nQH7D2l+bbWCw470rbzIUTBA
         1Uj3UMqEPlxKbOxBAy9Glh7Y2zi3C7d/AdMMEpAXn+/oozWFtuNrQV79ldFPuJyh7T5P
         Z7PfE/ngFY5C3HldgYpMLSU8RiiqHBAuzbLZieg5Gi4gfBbZ0P1u1D/T4BXlhtfRDoI+
         mHag==
X-Gm-Message-State: APjAAAXWQGbsgyJ4TChK+cZvpWbAK1IciYscu2LwwVNcN2pUxDr/tNuN
        IOEY0/77yiRtY9/C9ZvZ6l9SwXfu1gS1Zuw77/CWdKw4tHU=
X-Google-Smtp-Source: APXvYqzbmb/e4bBH4UKHfzSitwnMZQQ8Ovdu/xuhQkKENqHEsSO9FQnHvEmMaD30VmBQFpFkd4upyJcIGe+LgDDayHw=
X-Received: by 2002:a25:9706:: with SMTP id d6mr12182741ybo.150.1568038072655;
 Mon, 09 Sep 2019 07:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOT_U5bDZwYLYsny9OpWs3HjQFLqYK2j3o3g2koKX_CwGUtMbw@mail.gmail.com>
 <CAOT_U5a-qBMnS0uaGx=O7Av_a0uVDWUaPxZb5HFbLijd+OQ6pA@mail.gmail.com>
 <CAOT_U5azR21Fu5a9OQ5grRW=ztmT273iba4+nHO03hoZyq-rew@mail.gmail.com>
 <CAOT_U5bzKdQRZJrRf7MbKMtkas6jfR2UHN0i50unoeUJXs_wWw@mail.gmail.com> <CAOT_U5aHJxPDZe5Pb6B-YuKV7nrKCWTh8+JZs9hJuDQrsaw=yQ@mail.gmail.com>
In-Reply-To: <CAOT_U5aHJxPDZe5Pb6B-YuKV7nrKCWTh8+JZs9hJuDQrsaw=yQ@mail.gmail.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Mon, 9 Sep 2019 15:07:41 +0100
Message-ID: <CAAu3APYu5rV109AnwNzLXOPLtNQkY8W9wMv_Yrev8g4b8o__5g@mail.gmail.com>
Subject: Re: Locating /org/bluez/example/service from example-gatt-server
To:     Alan Martinovic <alan.martinovic@senic.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alan,

If a do a "busctl list" before and after starting the
"example-gatt-server" I can see that there is a new service started.
The way the example is coded it doesn't get given a nice service name
but I can see it is called (in my case) ":1.20"

I can now see the tree of services created.

$ busctl tree ":1.20"
=E2=94=94=E2=94=80/org
  =E2=94=94=E2=94=80/org/bluez
    =E2=94=94=E2=94=80/org/bluez/example
      =E2=94=9C=E2=94=80/org/bluez/example/service0
      =E2=94=82 =E2=94=9C=E2=94=80/org/bluez/example/service0/char0
      =E2=94=82 =E2=94=9C=E2=94=80/org/bluez/example/service0/char1
      =E2=94=82 =E2=94=94=E2=94=80/org/bluez/example/service0/char2
      =E2=94=9C=E2=94=80/org/bluez/example/service1
      =E2=94=82 =E2=94=94=E2=94=80/org/bluez/example/service1/char0
      =E2=94=94=E2=94=80/org/bluez/example/service2
        =E2=94=9C=E2=94=80/org/bluez/example/service2/char0
        =E2=94=82 =E2=94=9C=E2=94=80/org/bluez/example/service2/char0/desc0
        =E2=94=82 =E2=94=94=E2=94=80/org/bluez/example/service2/char0/desc1
        =E2=94=9C=E2=94=80/org/bluez/example/service2/char1
        =E2=94=82 =E2=94=9C=E2=94=80/org/bluez/example/service2/char1/desc2
        =E2=94=82 =E2=94=94=E2=94=80/org/bluez/example/service2/char1/desc3
        =E2=94=94=E2=94=80/org/bluez/example/service2/char2
          =E2=94=9C=E2=94=80/org/bluez/example/service2/char2/desc2
          =E2=94=94=E2=94=80/org/bluez/example/service2/char2/desc3

While the object path is the same as "org.bluez", they are stored
under a different service. So if I do "org.bluez" I can see they are
not there:
$ busctl tree "org.bluez"
=E2=94=94=E2=94=80/org
  =E2=94=94=E2=94=80/org/bluez
    =E2=94=9C=E2=94=80/org/bluez/hci0
    =E2=94=82 =E2=94=94=E2=94=80/org/bluez/hci0/dev_E3_AC_D2_F8_EB_B9
    =E2=94=94=E2=94=80/org/bluez/test

Hope that helps.

Regards,
Barry



On Mon, 9 Sep 2019 at 14:09, Alan Martinovic <alan.martinovic@senic.com> wr=
ote:
>
> Hey,
> looks like no activity here on my question,
> so in case someone is more into StackOverflow,
> I have a bounty on this question
> https://unix.stackexchange.com/questions/538107/locating-the-object-path-=
for-a-gatt-server-in-bluez
>
> Be Well,
> Alan
>
>
> On Thu, Aug 29, 2019 at 6:37 PM Alan Martinovic
> <alan.martinovic@senic.com> wrote:
> >
> > Hi,
> > in the example-gatt-server which is provided in the
> > sources there is a reference to the dbus object
> > `/org/bluez/example/service`.
> >
> > When that example gets run successfully under what
> >  "unique connection name" does that object end up living?
> >
> > It doesn't exist under org.bluez
> >
> > ~$ busctl --list tree org.bluez
> > /
> > /org
> > /org/bluez
> > /org/bluez/hci0
> >
> > Be Well,
> > Alan
