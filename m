Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA6C47256
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 16:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D651720CC7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 16:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJn9RFT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgEFQow (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 12:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730088AbgEFQov (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 12:44:51 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA4EC061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 09:44:51 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c3so1896220otp.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l5ABB6HXdl4YnzQdkjQ1bvC7//77Zg5tnh+Hhr5dEHk=;
        b=TJn9RFT5f6Cll+89ffNEGHzFDJ+FYy+GygHp+stf8s9XrsfXAiOyOHiJlQPEy8LTn1
         YakUrRb85zuBzb27uxC//sAvPF5bvh4rOo/UCP7S582/aDLliuJwcT9EueslgiWQ2Yql
         Vr497uinWRQ50ToNCvk8nWSBaxeyoMGONqDzXvoUSV2gti1yMvU6i4ZfW23y2Sw+WpvR
         9p8k9o4YUe6vgQyhjFJYZJEKk2P9wGGJQ/fIiTa79ysQxwUjqmAIvtjJnuy61GfQmN/r
         fCsCbvZtwUJdI2xCoMN2VdanEwp0WaqJ1FFjZJdxhGCNgQyiGMXm2lKRp4sPW6dzC8Fv
         yjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l5ABB6HXdl4YnzQdkjQ1bvC7//77Zg5tnh+Hhr5dEHk=;
        b=BBq03yDdJ75t4SbQ814LID9SY/H4N8x//3wovPtQY68DolI6Od77zPcNP42riF12JT
         1DEr1WSyGmSihyVkoBWbIKr3n7PNfTSQL2HLe3WAsMfb08Nd6xD2ofoGaBLimT4PcD9l
         AQ3IGU1hNV9zipX3L9y1ZSPgicdLAEZPEafHwhGfVq4i+SgMxayk5exROs8w0eJqqpPr
         zUTzcGt0FkAAnmhF/AZe1iqTqiIroahZyLlXXTJ8tCZIhqnh5H2nEd8pZdw59nVjSqZ3
         Xg8Uksi3fT8IExf+9zk46MUtx+ME1LM528En3XFtyEyxPxZ1WkOnNFNahKv+ovczVQPu
         YsbQ==
X-Gm-Message-State: AGi0PuYQoSWS1ShkWnoLt55gHXUF+N/O0WsIm9mG2tdAR3jD0/lA1x/f
        7wUfQz+IC77MA6T1kEgcOs15btBXbthGg8TyvwKvgapv
X-Google-Smtp-Source: APiQypIyDdjMLlLi4AauGm6LO+RpJH/dCm6bSnxdKELkX0VAht4sRa/SbrsalS0S4BszTLV5fR5XMSt1r4XaDbBHCLc=
X-Received: by 2002:a9d:57cb:: with SMTP id q11mr7301959oti.11.1588783490765;
 Wed, 06 May 2020 09:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200501215352.23858-1-sonnysasaka@chromium.org>
 <4A9E7F0B-4AB8-4330-BB2B-1A0EAA4EFDE8@holtmann.org> <a4650a5e465c23915d951b296ca86de9f2d91b44.camel@hadess.net>
 <CABBYNZK2SwcOO0jdpvtcdyjHFzw=WNocRU-a37hRsK3=yJ+d3Q@mail.gmail.com>
In-Reply-To: <CABBYNZK2SwcOO0jdpvtcdyjHFzw=WNocRU-a37hRsK3=yJ+d3Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 May 2020 09:44:38 -0700
Message-ID: <CABBYNZJu7Jg2fjZaJpR8S7iN6JSy4FYKjKZ2FN5mtKvLwSJywQ@mail.gmail.com>
Subject: Re: [PATCH] build: Add option to disable battery profile
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Wed, May 6, 2020 at 9:35 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marcel, Bastien,
>
> On Wed, May 6, 2020 at 7:14 AM Bastien Nocera <hadess@hadess.net> wrote:
> >
> > On Wed, 2020-05-06 at 13:24 +0200, Marcel Holtmann wrote:
> > > I have a little bit concern splitting this since battery service and
> > > HoG are kinda connected. Wouldn=E2=80=99t it be better we have a clea=
ner
> > > interface. Maybe we should actually integrate cleanly with
> > > /dev/upower or similar.
> >
> > Wat?
>
> I guess Marcel was refering to something like uhid though Im not sure
> that exists, or does it? That said one alternative would make uhid
> integrate the battery status, but I guess devices can also expose this
> over hid directly so I wonder if we can translate the Battery Service
> status to hid power strength that way we don't need any communication
> over D-Bus.

Btw, Im fine with the option to disable building the battery plugin
since platforms may not have a use for it, so except if there are some
strong reason against it I will apply the patch.

--=20
Luiz Augusto von Dentz
