Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04350C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 18:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D031661156
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 18:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhJNSIa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhJNSI3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Oct 2021 14:08:29 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6E0C061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 11:06:24 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id j12so3904345vka.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YYrmzxsmXxbeZZMwjIH11PW2jheVTBPCREdBrr3Pts=;
        b=SO5QGcI38At/NwY9P3m8xe2ibTahCcFBWsFctKlAaKh15hrtU4oXW5QSvTWfRQdhS2
         BUlAAdS2CiYstsKoPrpOCz5CMDBRt1S7xUzr66/31WzD83OM5PQcLQ6Rfn70s+cjlyiY
         kxeRZ17l8/JmoPukRb9FjxC+qy7Fhq6EvUhcdKXHkLCupTUfCKStgN3w2CD5RpeUjvbK
         yTh8dbjD88g6N19/GE8KLwA1B2D8Nb88BPqXaPqCD2ReseMeMQcHxyUvTpc/1XYyzXPY
         m8Xo8gackxmn5lAeBhhZ4zzrR8ST7ETMUXvcJIue2+F4c3dUUpy8D2ozD8GCyARamnr7
         iedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YYrmzxsmXxbeZZMwjIH11PW2jheVTBPCREdBrr3Pts=;
        b=DNxXUuTcRq/xqVhT/SG4ItkKshy/NWIdjMKAajkGA3f/fwBIVLqGHLILtJE0OzQSKm
         XmBYkXH4D+UG6IM1qgBu4eZ9vvXU3gJh2lzOLAC+GQEFNfLZzdMzC3ig0EAtjOfHj5bA
         GNR0Ij+wkRo9R8BWyfK5vOAIkeBE+lfUXO0126GX3KJwEe0905Ji9Ul+DuU/VwwHAKph
         PPtV61CJd4nxZqLOLrfkxKOXlGIpI4IarSMX++UgRFe2WH/VFTEdwYZ9ILBao0qkHaAK
         0tbHGxztrHdEamg3ZfK7tu9N2UCS6O99RBmO+/KrdJNLRL7hT/oq4lfyl9x5qLmrWM97
         8TGw==
X-Gm-Message-State: AOAM530zX0VQDfbh853MZ5lw6ZtQkqE23TMU00SK8oPPiSOQmMUaVTy4
        /+dzd1B5OFOxP/f7t6ZCRgCluQ2u9ktSqWeKmDw=
X-Google-Smtp-Source: ABdhPJwL6HbYhgR62fN4Yix4GqN0E6y7tk5NFv7BpsBK+XruEFmh259NjJ/NCOYiCgd1kHcsoAssoPZsHrIug+BgqJ4=
X-Received: by 2002:a1f:2cc2:: with SMTP id s185mr8080070vks.23.1634234783296;
 Thu, 14 Oct 2021 11:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211013124210.1454876-1-mmandlik@google.com> <20211013053935.BlueZ.v2.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
 <7414EB4C-0422-4BCF-869C-B4FA611DFCFC@holtmann.org>
In-Reply-To: <7414EB4C-0422-4BCF-869C-B4FA611DFCFC@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 14 Oct 2021 11:06:12 -0700
Message-ID: <CABBYNZKCVVLR8fHU=kyVtLwRgzUFqTh3rg5p4L5fewcL0=CrWA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 1/3] doc: Introduce the Adv Monitor Device Lost event
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Manish Mandlik <mmandlik@google.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Manish,

On Wed, Oct 13, 2021 at 6:15 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Manish,
>
> > Add a flag 'Device Tracked' to the existing 'Device Found' event to
> > indicate that the controller has started tracking the device matching
> > an Advertisement Monitor with handle 'Monitor_Handle'.
> >
> > Add a new event 'Adv Monitor Device Lost' to indicate that the
> > controller has stopped tracking that particular device.
> >
> > ---
> >
> > Changes in v2:
> > - Instead of creating a new 'Device Tracking' event, add a flag 'Device
> >  Tracked' in the existing 'Device Found' event and add a new 'Device
> >  Lost' event to indicate that the controller has stopped tracking that
> >  device.
> >
> > doc/mgmt-api.txt | 32 +++++++++++++++++++++++++++++++-
> > 1 file changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 5355fedb0..0fd884ed0 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -107,7 +107,8 @@ Configuration command, Default Runtime Configuration Changed event, Get
> > Device Flags command, Set Device Flags command, Device Flags Changed event,
> > Read Advertisement Monitor Features command, Add Advertisement Patterns
> > Monitor command, Remove Advertisement Monitor command, Advertisement Monitor
> > -Added event and Advertisement Monitor Removed event.
> > +Added event, Advertisement Monitor Removed event, Updated Device Found event
> > +and Added Advertisement Monitor Device Lost event.
> >
> >
> > Example
> > @@ -4247,6 +4248,7 @@ Device Found Event
> >                               Address_Type (1 Octet)
> >                               RSSI (1 Octet)
> >                               Flags (4 Octets)
> > +                             Monitor_Handle (2 Octets)
> >                               EIR_Data_Length (2 Octets)
> >                               EIR_Data (0-65535 Octets)
>
> you can not do this. This breaks ABI.

I was going to say that, we can't be adding parameters to existing
commands/events as that is not backward compatible (old bluetoothd
won't be able to parse them properly). That said, I wonder why it
needs the handle though? Wouldn't a flag be enough to indicate that
has been found via monitor filtering or do we need to know the exact
monitor rule that has triggered it?

Btw, afaik monitor handles as 1 octet not 2.

-- 
Luiz Augusto von Dentz
