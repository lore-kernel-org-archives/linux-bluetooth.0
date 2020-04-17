Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B2C2D0EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 18:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17CC22202
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 18:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD5NFrPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgDQSQ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730256AbgDQSQ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 14:16:57 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE51C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2020 11:16:56 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k9so2853039oia.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2020 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsjkOBpA8x9za7n64g4Jvl6euX8+/1EHNdmhGRQy1AI=;
        b=UD5NFrPq+fc/6PRdrThVCmvvstEjdRl8gvtSx5Bwep8UGdRahSKNNK1IRBRmompnIJ
         4gBIlKC5bgfGYKhhT2W5Wvy56hfafvDd2ewEFUghpQW3Z0kxgSGdF16J6TMIBc3kLUio
         9C6s/JAFQWo05WrEDT7eObjP68U6LSKiEUcL3mzdTwGXDKBHmctjWEbXD0FKOXddxnnh
         0rVfhj52Eoy4kNuRJlmVW++N49tLq1HtQu4FB7i2y+pF3TlDnpFUaAjW90nMh/AQ+tXt
         uEcN+hbkfIdAcN6AMKTkEYFW58HtI2bsuq1qKc7fUFnbZz+sgmSCxzXSYGJOF6FqUxCC
         aF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsjkOBpA8x9za7n64g4Jvl6euX8+/1EHNdmhGRQy1AI=;
        b=qNqKNYjT6wakl7HYi5CVcJjcTw7X9kaabMrfP/QEbQkfe9sZBiZSDGx3NAbhYRyvc0
         muNml0IyPAOiljjdr+xtQBD6E5oZPj1U/KCwAKeeFU0kXBPtkUU8ckvQRnYWsjMPbVCB
         bMv2zn4vvmTjyCqGZdoD8YqsdncClD9ckjafZsa1PQb7OW96TiETdPuWCgAydEfd3TzA
         0AKIbpUMaHsOeORfLbuUI29jLO2hmnVo0t1ba9WJIdsev0Gr7sj96YR2ppXHtOyAvdF3
         lBdDBya+q8Qw/LO0jrqXelOayemutJ0O1C3ijVrg6pxAdnF10qS9mJkCc5cSjsBOc9k0
         +qfA==
X-Gm-Message-State: AGi0Pua0fq0pq3ZghPieJEkzKfysZBzgiUk2eNGU7ohYZn+DU9QcT+5V
        Wz21vje3Bwtq43HCRN3IknPH8ahU7TQzXRiC5MY=
X-Google-Smtp-Source: APiQypKeCsgaWsnEG8cjabCtcQg1kOehapgxIBjQu/yxvTJUJPB4+rTk3hF2q9J7QzERiFjFuHGQ5dXbAYtsG3vzLl0=
X-Received: by 2002:aca:b602:: with SMTP id g2mr2978167oif.82.1587147415490;
 Fri, 17 Apr 2020 11:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200403153331.101846-1-alainm@chromium.org> <CALWDO_VvEBqSgJgKHMM7D9G3tTrDEC2u0NUTrPyOsNuOC_F5kQ@mail.gmail.com>
 <CABBYNZJ0SF-atqPx6B26P4Coz2YUXMvSFnW=QnXPUD6i98o-4g@mail.gmail.com> <CALWDO_Ubb9NTAqQwv+q9XCKKoC6q2YE2nxX+N5o24fqp3xbvCQ@mail.gmail.com>
In-Reply-To: <CALWDO_Ubb9NTAqQwv+q9XCKKoC6q2YE2nxX+N5o24fqp3xbvCQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Apr 2020 11:16:44 -0700
Message-ID: <CABBYNZLvxwtivQZ0Fwv_uZeJZBK6x85Nb8Kr+0orFPteeQcEhg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc:adding a WidebandSpeechEnabled Api
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Thu, Apr 16, 2020 at 5:34 PM Alain Michaud <alainmichaud@google.com> wrote:
>
> HI Luiz,
>
> On Thu, Apr 16, 2020 at 8:29 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi Alain,
>>
>> On Thu, Apr 16, 2020 at 1:32 PM Alain Michaud <alainmichaud@google.com> wrote:
>> >
>> > Friendly ping on this series.
>> >
>> >
>> > On Fri, Apr 3, 2020 at 11:33 AM Alain Michaud <alainm@chromium.org> wrote:
>> > >
>> > > This change adds an adapter Api to report the controller's
>> > > widebandspeech enabled state.
>>
>> I wonder if this shouldn't be queried over SCO socket, or simple fail
>> with BT_VOICE when using BT_VOICE_TRANSPARENT which is how what is
>> normally used when using mSBC.
>
> I think there is value in both.

Can you expand on that? I think this might generate confusion if the
property indicates support for it but HFP implementation don't support
it, since the later is usually implemented as a external profile so we
don't have the features it may support, or perhaps the intention here
is to actually indicate when it is in use?

>>
>>
>> > > ---
>> > >
>> > >  doc/adapter-api.txt | 8 ++++++++
>> > >  1 file changed, 8 insertions(+)
>> > >
>> > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
>> > > index acae032d9..d8865e795 100644
>> > > --- a/doc/adapter-api.txt
>> > > +++ b/doc/adapter-api.txt
>> > > @@ -326,3 +326,11 @@ Properties string Address [readonly]
>> > >
>> > >                         Local Device ID information in modalias format
>> > >                         used by the kernel and udev.
>> > > +
>> > > +               boolean WidebandSpeechEnabled [readonly]
>> > > +
>> > > +                       Returns true if the adapter's wideband speech feature is
>> > > +                       supported and enabled.
>>
>> There seems to be some extra empty lines here.
>
> ACK, will fix.
>>
>>
>> > > +
>> > > +
>> > > +
>> > > --
>> > > 2.26.0.292.g33ef6b2f38-goog
>> > >
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
