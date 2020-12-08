Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224AAC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 09:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C979E23A9B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 09:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgLHJqs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 04:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbgLHJqr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 04:46:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701EAC061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 01:46:07 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m19so2316878lfb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FRYH9Hyx/aZNKicgnri3k65K8p4xSP9nQJX2DWGaBIc=;
        b=hGhwAV3hjlRozJu4S6YLClAGidnzJYoi0OtgKZtCt9S1CNSaSC3emH9K9gLEr8auEv
         x76pmpex4lbt2fmfQpcnKa/xfksiiQ4rM7mb2YuNqnwksMuxYIFnaQH7O/vPVn1TZAWp
         C1es74lTV78w2+ewVudj5Ao5Ot90npW2jIWYnVDgUm82bLyUzoXuU5FokDdau/O6nWGI
         guoxq67yDhSUOs1N6hiBi5KbdSQMBzYXoe/BS9T6HF1ESF4BLLym3D2XkTb2VqIcXYfZ
         baTbNcVQtmG4xMrxNBUlhu1/NuMYtpNllP9t8s31TUbWt4+Lptt3WEInpV/0xBT6ATbM
         5nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FRYH9Hyx/aZNKicgnri3k65K8p4xSP9nQJX2DWGaBIc=;
        b=LhLVQPHIZ2ieF953dtiMcfO2cOEk8HHOMcTt8eQt3ACND3FQOKp+mEYMLLSTbg3Obn
         1GQ8BeQ8Fog4ElQTxvXO1Jm8s+93VjeQEzEiiZG+1FUxqpC1SWyIgrA82BAtMbJB1Qc/
         KjBi7fz4OPznrQ+ozIyLyhJ2lNJJpq9Y9d2cOujUpmJDA8qURm2NbS+l1MlL6ImxCMP6
         M31/hYlyyT0UjN8cbSZcF9rU6SX82Uyp78gF6fJSYKh/Km7IzmToz39x2GZDnBlAYNE/
         CHJrrmUQG0+bt+Lf1dJOZu8aMIkaUAeX0QOZNTQz7HFSVfqeDUvwehfPqefK6XoDHDFq
         LXdw==
X-Gm-Message-State: AOAM531OjIlSDQijbTsXyJbieuZTzZvQwIxPxlEJoT+DiRLTm+ifIE6I
        /GDMNZXBCKJqcWlzWKYhYQEbz2Xkl12b6qG807hd5p2is7M=
X-Google-Smtp-Source: ABdhPJwJrRMCpPJ85LL9+ZlmwjXdMzLI8sgf2sTokYiFu0aFyRp1t78ac+X5ZUQVyg0JeO7iLgbzIbzY08IZfgFr64A=
X-Received: by 2002:a19:ee13:: with SMTP id g19mr39896lfb.637.1607420765991;
 Tue, 08 Dec 2020 01:46:05 -0800 (PST)
MIME-Version: 1.0
References: <CAMxp894ThdL9qxNz49561WrDj3XhWxpFMf+9afMD9WqMbSPBbw@mail.gmail.com>
 <2fb922ffced103ba09571567366968d5462f9267.camel@hadess.net>
In-Reply-To: <2fb922ffced103ba09571567366968d5462f9267.camel@hadess.net>
From:   Lionel Jeanson <lionel.jeanson@gmail.com>
Date:   Tue, 8 Dec 2020 10:45:54 +0100
Message-ID: <CAMxp8948=LGwO6NE_oij2WgXxzXCY7nByj_XmmhPZFMiookseA@mail.gmail.com>
Subject: Re: sixaxis patch proposal
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi;

yes, I've seen your commit, and actually I don't get it, since it was
integrated, and bluez updated, sixaxis pads are not working as well as
they used to, I need to repair the device again and again.

I tried to do it with the pairing agent using bluetoothctl but
couldn't get it to work as expected, any hint? I can't find anything
on google or anywhere else.

Merci;
Lionel


Le mar. 8 d=C3=A9c. 2020 =C3=A0 10:01, Bastien Nocera <hadess@hadess.net> a=
 =C3=A9crit :
>
> On Mon, 2020-12-07 at 18:04 +0100, Lionel Jeanson wrote:
> > Hi;
> >
> > I'd like to propose the following patch to fix the following issue :
> >
> >  - if an already paired PS3 DualShock is plugged to USB, while it is
> > turned off (PS button wasn't pushed or no more battery for instance),
> > then it's connection will be reset and it will have to be paired
> > again
> >
> >  - to fix this, I removed the device connection check
> >
> >  - tested on Ubuntu 20.x (bluez-5.53 and bluez-5.55) and works fine
> > in
> > all cases.
>
> It doesn't have to be paired again if the pairing agent doesn't accept
> the pairing.
>
> Also, see 7bb73f092a.
>
