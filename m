Return-Path: <SRS0=QJP1=RU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CCAC43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2991D21738
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt62jiOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfCQIdZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Mar 2019 04:33:25 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:41642 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQIdZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Mar 2019 04:33:25 -0400
Received: by mail-oi1-f177.google.com with SMTP id v7so900494oie.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2019 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+Ut6xvob+R5+oY57314iaIT+ILVd4SXhssbD77ND6E=;
        b=Mt62jiOl0tlZTMtDt9+zLf416tMLea0gi6FWYyXN185KkzEFKEcWKjHBcHaylApc+y
         OeFMZHn0Sdc91z4zRovhEF/v+OuAwf+I9m2mq6MwU8xdqnDK9JROoozfx6HpjG9z1Mwo
         ImytjwDhL4jdPG2iBMqry9umMwcoxIsObrw09wqh6A7h54+/J71o6ky8Q4lKtSDysfKx
         vfgt75moj/0n9ef7vO7H2biG78sq1CVWa3cSloTxr8Fq/g9nrF1VgUHCDxZZZpDkeNa4
         eCskadRvIGQK7kZkcSb7ONwi8oEy5gtSQDM+7cHo/xbb5LtCd4APV1grFOsou6qzHVQm
         HC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+Ut6xvob+R5+oY57314iaIT+ILVd4SXhssbD77ND6E=;
        b=dz3Pj6vKvL1MElYv76GilN6KgkbNe1NxlxX20yaTu8mqYkiLNWQede96P1RTZkWjsc
         okTN6lgia7xLVm1M/KzC4dEI7NgGaC2mkxyq9FwtCYdayRoLIuWSyNLpz0ruaGyHHtH5
         /rBoQALHWerQ8FML2WogKWTs1Vkkl+6vRS1IORIwn073tm6eMUea2uNtr8Js6nM/Ob6H
         fv0sOjzVqwdvJndMqpWcAro5flGyXvUJx1Bu96o/egvYwHtWF3Tr5zOJC6wUf1pj3Y2v
         o29z4p8DWbolQI+YvoKqO2XH2b3aLhLur0Wqc0kVCwkLNH5KPD+8gljnB0LOOaGOpYTD
         jB1A==
X-Gm-Message-State: APjAAAUIoOmGIiUSNxwY7vnzVQqz745+sR9DfIrr4nkgolvfw+F7LAns
        29KiYOkWQwtKFD2crKM3n72YX8VCCs+/6ozGBPY=
X-Google-Smtp-Source: APXvYqzA2jl4gGMI5OfkciF9o3dPVLYvNjhA4+b4A3YrDXPXUA5b6AcRJYwPWp860Q+QIXrGtKg/oi2KmJT2BsGt/5c=
X-Received: by 2002:a05:6808:699:: with SMTP id k25mr6850266oig.110.1552811604525;
 Sun, 17 Mar 2019 01:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAB+bgRZZxQBrX6-7a=atdN51UUqRdrVM-0Vfd5PbSEQHuCf_dQ@mail.gmail.com>
In-Reply-To: <CAB+bgRZZxQBrX6-7a=atdN51UUqRdrVM-0Vfd5PbSEQHuCf_dQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 17 Mar 2019 10:33:14 +0200
Message-ID: <CABBYNZJVk-bK4mREXbqOP1-Lg42TbJbDwc+yeWOEE9=-ZeKBEw@mail.gmail.com>
Subject: Re: supporting both btgatt-client and btgatt-server in application
To:     Ordit Gross <ordit.gross@orcam.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ordit,
On Sun, Mar 17, 2019 at 9:54 AM Ordit Gross <ordit.gross@orcam.com> wrote:
>
> hi all,
> We have an application that should support both btgatt-client and
> btgatt-server (connecting to different devices for different
> workflows), using bluez.
>
> 1. Should I create a single mainloop that will be used by both or
> should I create two different mainloop_run? (thought of have porting
> the mainloop code to c++ and change it to be class element)
>
> 2. Regarding the btgatt-client, how can I initiate a disconnect? (I
> looked in the btgatt-client.c test application and did not see an
> initiation of disconnect).
>
> thanks in advance! (hope I sent the message to right mailing list.. )

Take a look at bluetoothctl, it can actually act as both Client and
Server at the same time with just a single mainloop, you can check how
to disconnect using disconnect command.


-- 
Luiz Augusto von Dentz
