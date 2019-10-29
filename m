Return-Path: <SRS0=CsyS=YW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EDCCA9EAE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 13:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD6720578
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 13:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRc92yvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbfJ2NXo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:23:44 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:42627 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388328AbfJ2NXo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Oct 2019 09:23:44 -0400
Received: by mail-oi1-f174.google.com with SMTP id i185so8879104oif.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2019 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YvoCgsmMDStvkEgYksBPpHKdqHlFbhAPsTW6KZbxXU=;
        b=DRc92yvoGCdllIJ0JS+46IjIdVD1KAT4uGgkCfASyH08tapI/vgb5Y1xxBo+wCL8Ou
         9zjzY2quyvyd+/iMLUpdjy08iKFKTU1dzgITFk4vN/90vQZ46yX4GB1ZC0ZWEd3yDOIy
         84PRWJzJdHwNPkiOQ3LpM7Ev6x/y8WRaMnMaNWO97AUxOPLyCr3BOnxyPqiZ8UEFP64o
         fUl2rekcntpQF/gLInMG/EPId2J/OZem5LxCqPqhxc8/UuV5nWPK8peOziSZJ4HFd5ar
         LQQPhcqoXVGvntVQ709yu4msSCmXM+geM2qEQ3mwjwELrNRPIqj+/z0Q8RE1lKfG4L1Z
         qWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YvoCgsmMDStvkEgYksBPpHKdqHlFbhAPsTW6KZbxXU=;
        b=IAmnR/icPLYL0ganw4GLiLIlOaWlyUQCDc48RAgqCs267ENgY2doELRajU4um7RnkY
         LUhPkSepeiTsNT+USqtsj19bOsfgNd9tXGCiBv253iOLtoD+3xLE+vhCTzoQK2rEiH83
         uKvUomS08V0DriAqMs9jLNH+WGsatM1uJwEGDSdEFUQKLi49GYw0DVdKiQiz+GKEcFlT
         s5vttXD3Aik98YFzgYwXmr86PTDqKLUxS4Nqqy2Ma2JbHdpOker1eEPaUNxYOJcfvOu+
         NRNAk32JyO3ArXi3uoih5MoVDGy/S1BoR80mkH6tW+1t81YkNs1F8LAcmcTU1yaXHeNw
         Se7Q==
X-Gm-Message-State: APjAAAWJQOUZAAENcBYgU3mwI1OGKtV4TpYcHXWUi0/gVPgJISN5c21t
        DBAldYKK6q3lwb7/DiPX0svOc9f4kl30vYDZqprGV70CVxo=
X-Google-Smtp-Source: APXvYqyDqhrcRgfrBxYZ57ffH+J1IDtn9R/tIyZDYvNPsvD73GZDStfHWGorY46d4E18tcaohwmbqYQSFAEbBpeBI9c=
X-Received: by 2002:aca:281a:: with SMTP id 26mr3935711oix.82.1572355423158;
 Tue, 29 Oct 2019 06:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <37e50a80d823b267508893db9573a1903c87d0c6.camel@rdmp.org>
In-Reply-To: <37e50a80d823b267508893db9573a1903c87d0c6.camel@rdmp.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 29 Oct 2019 15:23:30 +0200
Message-ID: <CABBYNZKzscuNsT6SY7KKiHMrJ2+zWCyxuWHk6UrAFDOu2zhpSw@mail.gmail.com>
Subject: Re: Audio out to phone
To:     Dale Mellor <bluez-2hxy5d@rdmp.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dale,

On Sun, Oct 27, 2019 at 11:07 PM Dale Mellor <bluez-2hxy5d@rdmp.org> wrote:
>
> Does anybody know of any tricks needed to get audio to go out through
> an ongoing phone call?  Everything in my setup looks good, with all the
> right devices and settings in bluetoothctl, pavucontrol (including
> correct headset/handsfree profiles) and I can hear the caller, but they
> are only getting silence from my end.  I am using the pulseaudio
> asynchronous API, which works well enough playing through speakers but
> I can't get sound through the telephone (an Android device, which works
> perfectly well with my car's headset).
>
> bluez5: 5.51
> ofono:  1.30
> pulseaudio: 13.0
> debian: 10 (stable)
> linux: 5.3.0
>
> I'm quite desperate to get this sorted, so if it is an unsolved problem
> perhaps some pointers to where the issue might be will help me to help
> you debug the situation?  As you see from the updatedness of the
> packages, I have built them all from source and can dig if necessary.

We will need quite a bit more information to help you, like btmon,
journal of the components involved (bluetoothd, pulseaudio and ofono).
If I got it right that is the audio path of your mic -> loopback ->
bluetooth-src -> sco socket -> hci -> usb iso endpoint that is not
working? There can be quite many things wrong actually, for the mic
being muted to the usb endpoint not working, the later is not uncommon
but you did hear the other side of the call so maybe that is not it.

> Thanks in advance for any help,
> Dale
>
>


-- 
Luiz Augusto von Dentz
