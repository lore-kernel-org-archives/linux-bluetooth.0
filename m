Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCC1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 21:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbiBJVaW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 16:30:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiBJVaW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 16:30:22 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4C7AF
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 13:30:22 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g14so19336676ybs.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 13:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVwxEECkeZqV/eQtZJeAUfb8gUHhW4uYh9hvRYEyOd4=;
        b=lih9joxgHpLxKGOpi74urpWswTn9hmWDV5ACes2BusD43fiaL/dE648aUU92RfvKJM
         4KuJzVsjA8rb+LVyR8yrp/5g3DWb4zDG8wijW2JlRGsQXjTUFDdkmxNJq8YYO0/0O7JZ
         FTikBDIR1eH91TWNrh6ZNVUahUyR9vs/oV84sPu8kUiIUj5rnW1DqUN2kVJHGU99arDW
         UBCVFENhaj4jnoVq4bjBuRQ/7xiG/yTqn6GwOf7Gsds4kwt7C/Sduh29eAJG71SRQsLa
         BFGCZlOdwvYyFVwjdWUDloi5HXexwf/NGIhWKTaBzk5e3f4JfffYeptmSwSO58HCFF+r
         6U0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVwxEECkeZqV/eQtZJeAUfb8gUHhW4uYh9hvRYEyOd4=;
        b=dtZSo2ZRQqFP8wPYe9zxxrKvPS/KC6/v6UMyZF8V5OtKTpTqmQN9cQvcmKUWArO+Eo
         bb3dZamMOLPxHBY/ukna8tRMHlbPcYpY1zcqsw1l/zCX44fFfnYCqzPN740BPkA9tSm+
         SSa4dU3s/3LNK9WvxdNhZ/SA291vIky30OcX1MUHqFeiUvHIUczOZmL7llCb+HtvGE0G
         KEkLqllyR8KwtmpgjmeollhZSRhDsidsbW4zmBH42OQhmN4usbHeK/v9CywSV3D8mbA7
         gd6zo/V6sJ2VHke87jKaNHyD5v79GURsR9+wGf//pBEkgteMIo7s2UhuuSUUI8jKSmfO
         Yh8w==
X-Gm-Message-State: AOAM532nhpGQpPtGxmD7mkOFZYx7tyHM6kOCE9829u6m/5siOmW8iosD
        tp5V0me3MpjsWST/zgod3l8vTAT4sen1Jazj/A1ass8rwds=
X-Google-Smtp-Source: ABdhPJxuLrnxUxfLeMT4CeZg7YUFM1dygJ7sR9YPnM+Ax7OhMz8VOQFo9s03CvyrpYi8mO4wwDNf/tos0ES0h4O+pd0=
X-Received: by 2002:a25:3857:: with SMTP id f84mr8734803yba.733.1644528621666;
 Thu, 10 Feb 2022 13:30:21 -0800 (PST)
MIME-Version: 1.0
References: <CAO271mmuMDoqNdXUUuPpyz3VyuLWrZUr1K=Jry+H9mGEtz-Z4Q@mail.gmail.com>
 <CAO271m=vQsGwRvpe2tUUMuqB7r2z2cAut27U1LY6bQ_sHAk3NA@mail.gmail.com>
In-Reply-To: <CAO271m=vQsGwRvpe2tUUMuqB7r2z2cAut27U1LY6bQ_sHAk3NA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Feb 2022 13:30:10 -0800
Message-ID: <CABBYNZKs-JH_g2iUxStL5bRu-1z1TVzrS5pk2RyXUK8hiWYb7Q@mail.gmail.com>
Subject: Re: Question about Trusted property
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Feb 10, 2022 at 11:23 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Dear maintainers,
>
> Friendly ping on this question. Does adding "Bonded" property to
> org.bluez.Device1 make sense?
>
> On Fri, Feb 4, 2022 at 4:02 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Luiz/BlueZ maintainers,
> >
> > What is the purpose of the Trusted property on org.bluez.Device1
> > interface? Does it mean whether the device is bonded? My experiment
> > with BlueZ shows that sometimes a device with "Trusted" property set
> > is not bonded (does not have pairing key stored) and also vice versa,
> > so I am assuming that the Trusted property means something else. What
> > is an example use case of the Trusted property?
> >
> > Eventually, what I am trying to achieve is for BlueZ clients to find
> > out whether a device is Bonded or not. Using the Paired property is
> > not very accurate because it is set to true during connection although
> > the device is not bonded (pairing key does not persist after
> > disconnection). For this purpose, I am about to propose adding
> > "Bonded" property to org.bluez.Device1. Some use cases include when
> > there is a temporary pairing with a peer device we don't want UI to
> > show that the device is in the Bonded device list. What do you think
> > about exposing the Bonded state via D-Bus? I will do the
> > implementation if this idea makes sense.
> >
> > Thanks!

Trusted primary use is to bypass agent authorization, so when set the
agent will not have to authorize profile connections, and yes you can
set a device to be Trusted even without having it paired since the
bonding procedure refers to authentication rather than authorization
which is what Trusted controls.


-- 
Luiz Augusto von Dentz
