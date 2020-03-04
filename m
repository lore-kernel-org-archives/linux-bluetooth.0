Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1B6C3F2CE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 20:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3A520870
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 20:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgXJ2QsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCDUSZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:18:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44168 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDUSZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 15:18:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id a10so3468139ljp.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2020 12:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJXrs3w8JO8ditzAAzBc2CkmebwXQhk9UOKlej90UCY=;
        b=HgXJ2QsJICJ8V48CQN7yNfOoZxC6/9HLEQfNen+KwUV1tcrVzO5vCTJlo1B20kxUeE
         sR5CIKiTULV3k7VWyR9SqrPcAComKFx3/+i0WAR2F6BrHXSn04a9QevI3JS1H6seaAJd
         XdWPMp3h6lEXM4ah5j8hqULqsNeSXYtoiEd2v7vh/cGWVzOj/NjmytSdhIwtTWKxPhbl
         nXCop3gaGRDV0G+lY4PpUJKST4EQN0RlKd++GiSgLbY75UNhwB4H311anROsz2mUDhSX
         73pgeWUEo8yoF4aReyYw7Eujd4OxsK4Ynq6D7Fw1nQLS5bPsgxDUxwcvDlbAmF7rnJ3X
         GT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJXrs3w8JO8ditzAAzBc2CkmebwXQhk9UOKlej90UCY=;
        b=UqWCr7G+A0tlbjsWGlzmyHJLbN18BeDQZF0wcJJb3GJEuKebiC91ghFHaZJKOfNZY6
         tYsMjN4Z7wBPZukYcmzcSFDFJkCjE9X2rjjJE1R4XzkVJu80HOjGzxrdL32gdncOsnpV
         vFBFuT0dPRmrHXltc3QmCnoeqPVrJixBqiipiNsNLoHnH757zau5JOmxKnmHf4jSg3gz
         7gJzNIQ1yhdS8YLfsalFiepxGIWlcpgjAaJZ5z6r/wCGX384dAvY4F2E7lxFvDd52N6H
         ETnJb8N3VRcLYvqELGYkAPqJ9MZyC8yIGsaPgnRSkjc6QFz78pK2aiyZPDkbKt73pVBh
         KDww==
X-Gm-Message-State: ANhLgQ15oFvZT8/aDJufNp2yfNhGaD1vR3fbYfYzBoP3Htri9QhoIZkA
        HOBiTfFeQSh7t0tFD5zfhyMc51ATaPmcqfKb9dFFFJyw
X-Google-Smtp-Source: ADFU+vs+/M9ehgRvJUwr1hkAe9gPB5qrB6EeSX587p+S95NG9rSgU9tBdDv0z2zCcldXb3VojhCuzn3eL9rPTIPLQew=
X-Received: by 2002:a2e:890b:: with SMTP id d11mr3151304lji.79.1583353102578;
 Wed, 04 Mar 2020 12:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20200304173249.66324-1-alainm@chromium.org> <1990C7E4-CB11-48A5-B07D-A06A94FB73EC@holtmann.org>
In-Reply-To: <1990C7E4-CB11-48A5-B07D-A06A94FB73EC@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 4 Mar 2020 15:18:11 -0500
Message-ID: <CALWDO_XDw9TPWiW3K8F6_e8u2P4Hv_94-mKq+d82HQaLuqA+dA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] Adding definitions for Wide Band Speech configuration
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

Thanks, I will rebase and send a v2 with just the header changes.

Thanks,
Alain

On Wed, Mar 4, 2020 at 1:37 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > This change adds the corresponding user space definition for wide band
> > speech.
> >
> > ---
> >
> > doc/mgmt-api.txt | 30 ++++++++++++++++++++++++++++++
> > lib/mgmt.h       |  5 ++++-
> > 2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 5c23268a1..ecdfd9b95 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3052,6 +3052,36 @@ Load Blocked Keys Command
> >       Possible errors:        Invalid Parameters
> >                               Invalid Index
> >
> > +Set Wide Band Speech Command
> > +======================
> > +
> > +     Command Code:           0x0047
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     wide_band_speech_enabled (1 Octet)
> > +     Return Parameters:      Current_Settings (4 Octets)
> > +
> > +     This command is used to enable/disable Wide Band Speech support for a
> > +     controller. The allowed values of the wide_band_speech_enabled command
> > +     parameter are 0x00 and 0x01. All other values will return
> > +     Invalid Parameters.
> > +
> > +     This command is only available for Wide Band Speech capable controllers and
> > +     will yield in a Not Supported error otherwise.
> > +
> > +     This command can be used when the controller is not powered and
> > +     all settings will be programmed once powered.
> > +
> > +     In case the kernel subsystem does not support Wide Band Speech or the
> > +     controller does not either, the command will fail regardless.
> > +
> > +     This command generates a Command Complete event on success or
> > +     a Command Status event on failure.
> > +
> > +     Possible errors:        Busy
> > +                             Not Supported
> > +                             Invalid Parameters
> > +                             Invalid Index
> > +
>
> I already committed the mgmt-api.txt change since I was fixing a few things in the document.
>
> Regards
>
> Marcel
>
