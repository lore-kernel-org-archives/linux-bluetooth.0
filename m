Return-Path: <SRS0=5fy2=7I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C6AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 14:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851062065F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 14:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muB9sQtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgEZOaj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 May 2020 10:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgEZOaj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 May 2020 10:30:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9744DC03E96D
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 07:30:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so24817042ljo.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LztMYlNxAp/YzMlFlAsB5KiKAsfpCCfOHvY1s1s4XCs=;
        b=muB9sQtYshmJG2HyGawj5kPZ3mQ9OtxQqO65WeL7XZZGucmQP3f/dpE5Lnsd45jxGK
         /olNwAccvNEDx0+UiRCswWlbzdsf5J/3DIyLeSmc+Fbi1SbIrOtxY067w7lfcMhSiESz
         rxNDv4kI+JaXZtq4s8ooU0VPtKBCK7oepo8l2zy4uVZj9vOWTcM0U9tzHcB4aM0TtvEy
         v/7zqfuXMpHACGXZ5R6S1J7UL9YyWYYr64p5TQbcZlFVDc4X/C+miUJGuRd055G5Wimn
         SB5MaGWxTnnEEGig4KWaK9mwpYPA4TMKu/VQ/D+yp9lBCKbfAx69kRuCX4HMOfO8u9h1
         Hyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LztMYlNxAp/YzMlFlAsB5KiKAsfpCCfOHvY1s1s4XCs=;
        b=da7Y3XnrOhTSpzlFeC5QrUIh1i7M9XafG15Uyw3YMmctxpLdirDPqwWvVV+jCCzN6K
         Ewcv4BakdrnXyqmrIeA+pzUem66leR8GEJ3JjT5JRFVhrrnSjDurM8K0AznxBfB66E7g
         pBjbnPqvjysaRaudRTVaN84uykeQANJOk81EDtKhiX555Udvl5j9KTlajb4CLWvSTPT4
         EwhUe422RNv+ONRBPvw2xYJj3iCrfkIIYO4y2zgLxDtvRpwb9xuGfNZccS62OJc6y0hu
         4BcQ0BZVyQ8uXhTWXE86EWI6o4ormzC4F88AZbF4gT5L33bZ1JuhqkSQCZJknPn6u8x3
         WbYw==
X-Gm-Message-State: AOAM533sw8K4h49bIwtdmSTkahs/zyd0v6ihG3ysAHYMxrMakNj0n21S
        zfIydb0fwJIbmW/fG94rSC7wRHwtbdbKDIiNvBezJA==
X-Google-Smtp-Source: ABdhPJwzEk5VNr/SL7nylGsx58wzNJxbHpP4LzE+YUTbmMFryHNavAgIPMVk8xcr5AMeuutQNFAY/UE+Aae6w0YNlUM=
X-Received: by 2002:a2e:9586:: with SMTP id w6mr719718ljh.274.1590503436858;
 Tue, 26 May 2020 07:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200519202519.219335-1-luiz.dentz@gmail.com> <20200519202519.219335-2-luiz.dentz@gmail.com>
 <C478BA49-0BBF-4323-AC3A-30442F65D346@holtmann.org> <CALWDO_UEPaAGyLFG93JzT41P=yGePB-N2Pbh5hioLBOXdh2YBw@mail.gmail.com>
 <23C4DB2B-4C5E-45E7-A777-6F26A675EB92@holtmann.org>
In-Reply-To: <23C4DB2B-4C5E-45E7-A777-6F26A675EB92@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 26 May 2020 10:30:25 -0400
Message-ID: <CALWDO_XztiDRfQEtioALNmO9smLm-qTW56hxkw8-ZH-Aw2cH1g@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: Fix assuming EIR flags can result in SSP authentication
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, May 26, 2020 at 10:17 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Alain,
>
> > Starting with the 2.1 specification, it is my interpretation that it
> > is not valid to support EIR but not SSP.  I understand that SSP may be
> > disabled from BlueZ's point of view, but this doesn't seem to be a
> > legitimate/qualifiable configuration.  Should we instead fail the
> > legacy pairing if EIR was received as an invalid condition?
>
> I know that using EIR requires to also use SSP. However this is just a pr=
ecaution in case the other device is an attacked and tries to trick us.
>
> You might get an inquiry result and not extended inquiry result, but you =
are still talking to a SSP device. This has to do with the fact that the re=
ception of EIR is not guaranteed. In case of radio interference you might m=
iss one and only get an ordinary inquiry result.
>
> If we indeed received an EIR and then get legacy pairing request, we coul=
d try to reject the pairing. However keep in mind that our inquiry cache is=
 time limited and we through outdated information away. This might cause so=
me race condition. So I rather read the remote host features to ensure we k=
now the actual host features of the remote device.

You are correct, the EIR response is not a guaranteed thing.  For this
reason, the host should try to resolve the name of the device before
initiating bonding where a Remote Host Supported Feature Notification
Event is generated to signal the remote side's support of SSP.  As you
allude to, a remote spoofing a legitimate SSP device may always just
jam and downgrade to not SSP, but if you have any signals that SSP is
supported by the device, it may be a good defensive posture.
Receiving an EIR response or a Remote Host Supported Feature Event
with the SSP bit set is a good indication that the device supports SSP
and you should expect SSP to take place.  Again, it is not a valid
configuration to have EIR enabled but not SSP per my interpretation of
the 2.1 specification.


>
> Regards
>
> Marcel
>
