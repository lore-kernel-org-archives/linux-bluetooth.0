Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3ECC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 13:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B425D206C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 13:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwaN9jkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390300AbgE1NSM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 09:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390102AbgE1NSJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 09:18:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FBDC05BD1E
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 06:18:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so10855015ljn.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+T0laD8fwMrzvjRfzh0Qu+3vQImL3/pnRK93BRyZs14=;
        b=XwaN9jkBM1r+uEfW7d+JdfAERto2G1UKO+19oBk2hn2miGYRSdG3u7zf63WSxPED60
         +tFlGBBpON8yxsdMRHtfN4ybIhqAyLiODnPyzVJiIkrLSxOwCzbbHJnj/6gQhfjnAV6p
         kpp1yczuR65RkkI+a67U6TIY4OqU9J43tWypuz9odSbjD8anMOdBNus4aOpv2XdYYLqm
         Tpq+9lI4Cp61VJCK2uhsCN1smGGWWKr/YPrqJWPJVFJSqmUTIsWB+B79S1IO4GJvk5TO
         1u1ud5nHuPkJL+3hbprVGNJjQFrXNY/DQHfhnTNOz2ahYJknRfr8H8wbBtjgZNzZ4XHM
         /ezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+T0laD8fwMrzvjRfzh0Qu+3vQImL3/pnRK93BRyZs14=;
        b=dQpICyJ9D42LnYP13XfSZsg3wUmNKk0bsmIIDIMvdqI7CeP7pUxl4Ybvw2KNeSht6S
         YZWpiYapSOHdum+P0+kB+xZ7bGUY+C3GqlfNrB3UXhvc4JIZUT/afE8GcgOD/74ElPcx
         aF4PLGrXruKGz3JieAR+rpP82FUVArENS6WUsb/2HfIHhPepBebwmtYHjKVxW14IKLC7
         LgVvjMHZd1JBxof9MadQf6oc+4lPNFoYlBR9lkB+AnGxTmNYuh1TZz4maP1XHDhS6/Lg
         vV728EQ1GbrvCWvRyw/wnrWkiv6fqrpsqYxmnr2y8JFh9IEAm5MSEo0B1Bx2QCkpaZya
         sL4Q==
X-Gm-Message-State: AOAM533B3KBqQYBXL9LGbM6cXstb6fUVmRcfGm92a+9ZiWD4/6jLaIzc
        zMljHvALSN0Fg5lmlCGUiwS19sf47OtgjoH2faKyzw==
X-Google-Smtp-Source: ABdhPJxQr+bhwXHf16PbZjs04RZklpemYIbVgCm6E6U793c6ABUDdHbieK3L0GEqNhTPJ41P2WbsDBQLxva8SrXZnHo=
X-Received: by 2002:a2e:9c45:: with SMTP id t5mr1655762ljj.344.1590671887515;
 Thu, 28 May 2020 06:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200519202519.219335-1-luiz.dentz@gmail.com> <20200519202519.219335-2-luiz.dentz@gmail.com>
 <C478BA49-0BBF-4323-AC3A-30442F65D346@holtmann.org> <CALWDO_UEPaAGyLFG93JzT41P=yGePB-N2Pbh5hioLBOXdh2YBw@mail.gmail.com>
 <23C4DB2B-4C5E-45E7-A777-6F26A675EB92@holtmann.org> <CALWDO_XztiDRfQEtioALNmO9smLm-qTW56hxkw8-ZH-Aw2cH1g@mail.gmail.com>
 <6F17F57F-8AF4-4539-8564-C3F13BC6FBF5@holtmann.org>
In-Reply-To: <6F17F57F-8AF4-4539-8564-C3F13BC6FBF5@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 28 May 2020 09:17:56 -0400
Message-ID: <CALWDO_Umz9T9-_U3spSTO85V3sjw8AWku9iwwuF0J7SKQYiE6w@mail.gmail.com>
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

On Thu, May 28, 2020 at 4:22 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Alain,
>
> >>> Starting with the 2.1 specification, it is my interpretation that it
> >>> is not valid to support EIR but not SSP.  I understand that SSP may b=
e
> >>> disabled from BlueZ's point of view, but this doesn't seem to be a
> >>> legitimate/qualifiable configuration.  Should we instead fail the
> >>> legacy pairing if EIR was received as an invalid condition?
> >>
> >> I know that using EIR requires to also use SSP. However this is just a=
 precaution in case the other device is an attacked and tries to trick us.
> >>
> >> You might get an inquiry result and not extended inquiry result, but y=
ou are still talking to a SSP device. This has to do with the fact that the=
 reception of EIR is not guaranteed. In case of radio interference you migh=
t miss one and only get an ordinary inquiry result.
> >>
> >> If we indeed received an EIR and then get legacy pairing request, we c=
ould try to reject the pairing. However keep in mind that our inquiry cache=
 is time limited and we through outdated information away. This might cause=
 some race condition. So I rather read the remote host features to ensure w=
e know the actual host features of the remote device.
> >
> > You are correct, the EIR response is not a guaranteed thing.  For this
> > reason, the host should try to resolve the name of the device before
> > initiating bonding where a Remote Host Supported Feature Notification
> > Event is generated to signal the remote side's support of SSP.  As you
> > allude to, a remote spoofing a legitimate SSP device may always just
> > jam and downgrade to not SSP, but if you have any signals that SSP is
> > supported by the device, it may be a good defensive posture.
>
> trying to resolve the name before connected is a waste of time. Resolving=
 the name after connecting will not give you that event. You should just re=
ad the remote features.

I have a vague memory that there was an interoperability issue around
this that required the initiator to know ahead of time if SSP was
supported by the remote host before connecting which was the reason
why this was added in the first place.  However, I agree that this can
also be read after you are connected rather than just waiting for a
RNR page to complete just to page again.  The point here however is
about the signals that SSP should be supported and the conditions
where we let legacy pairing go through.  My assertion is that EIR
implies SSP, so legacy pairing shouldn't be allowed in that case.
It's not a definitive security measure, but IMO, every signals that we
can get will help close a door to downgrade attacks.

>
> > Receiving an EIR response or a Remote Host Supported Feature Event
> > with the SSP bit set is a good indication that the device supports SSP
> > and you should expect SSP to take place.  Again, it is not a valid
> > configuration to have EIR enabled but not SSP per my interpretation of
> > the 2.1 specification.
>
> If you have an idea on how to tighten this and fail, please send a patch.=
 It is just that our inquiry cache was never designed for that. It was just=
 to speed up the connection process.
Ack.  This definitely looks like an opportunity.  We can add it to the back=
log.

>
> Regards
>
> Marcel
>
