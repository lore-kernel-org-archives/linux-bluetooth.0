Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4505BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 20:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiKIUn2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 15:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiKIUnZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 15:43:25 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D31121
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 12:43:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r12so27832935lfp.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 12:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F5NA6pXyA1P//mfZ+G9mzWinmHy9uK4K2To7W6ZqWJg=;
        b=fp0IpseQoG1LDjLyOR4GOD2ZwJFWyxwoblRz20F13X4ew/JKmazVXR40vgKmjRVFns
         m2GKrgOTPtzBC5l46ckHCwyah2cuaSooZbowAX4YjgQ87ZnMNxEbaSg9ROiD0HpgsBEB
         4TM1SALQ5Y7jpetdJV1Pt88Y28GsujGoUUnMBdW0j+/QrU/riTSIFB+X8+LrWkMxyci0
         rx8MasZleA9a7RpnriG2McakfzrWmOF5ObN1vHzuBgVybXlGZmroqQbjM1WYY3FsGi/D
         FZdHBdXwRZ1NtpT8Xzg3V4N+xrwMxLFjJz+2WeS3H9zVNEO69qBQO9h05mWCV08triQS
         PFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5NA6pXyA1P//mfZ+G9mzWinmHy9uK4K2To7W6ZqWJg=;
        b=LO4TtdON2TZfsg2pAlOsbI6uANxhOdTv3qvJHqX6HuVQ5eQZEQQXuOh4Fj4d5FoHwN
         DaD0ura3I3h1DwaAgo+RzBTptn/PL3UmgE7DqGhnGk+MwUVK8olNmOuzOZWsozeclXo+
         1YhQJLkyv/KrVrWN66mqDmIqTpoW8qPAl2EC42KDxbQEKVySp2IB55b+5JhKsPXSFm7j
         q3CzVr8CDEYN/QHNOOAi0YrwAWTPvND395GzS/aokl3h7Aw/bGJ2H0byxTLQlPMsm/Ms
         QyshkR6UyTZOeClwlx3wfy3b9lHIRGBzCZAV7FnVAeCqNorJsHmtzvf41AaKPjAX7FMh
         n4fg==
X-Gm-Message-State: ACrzQf38LwqNuDMNfZCfk/uKOT+zbV7dWboOcWbVN8flQF1KHAHR9gRS
        ZOCmTh0b+t38r1PynUoWLhIhKk5hPviEIu4OG/c=
X-Google-Smtp-Source: AMsMyM6ibiS09ZnYMtVXM0TduImZauQ/SehhzidzLSVp9kFzAOIhAbdCO/Axot+wmD6gltaf82uo24vcBwkB1RRQZ4Q=
X-Received: by 2002:a05:6512:3f2a:b0:4ae:612b:f47b with SMTP id
 y42-20020a0565123f2a00b004ae612bf47bmr20140882lfa.106.1668026601673; Wed, 09
 Nov 2022 12:43:21 -0800 (PST)
MIME-Version: 1.0
References: <76cd4547-a68d-9d52-1d87-8299e29406ff@gmail.com> <LWPL3AC7.RRTERTU2.B5FO44IX@4YQH7VT3.DY2DZPQX.S6LIZ6VV>
In-Reply-To: <LWPL3AC7.RRTERTU2.B5FO44IX@4YQH7VT3.DY2DZPQX.S6LIZ6VV>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Nov 2022 12:43:10 -0800
Message-ID: <CABBYNZKDEjYOW+b1snUsvBgidW37+tPbsidq0pXaOqWKvRC8uQ@mail.gmail.com>
Subject: Re: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
To:     Jack <ostroffjh@users.sourceforge.net>
Cc:     linux-bluetooth@vger.kernel.org, Swyter <swyterzone@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Nov 9, 2022 at 11:40 AM Jack <ostroffjh@users.sourceforge.net> wrote:
>
> On 2022.11.09 14:12, Swyter wrote:
> > >> Correct hci_set_event_mask_page_2_sync() event mask
> > >> git bisect good 0feb8af0275d196a29e321bedc15319673923cb6
> > >> # bad: [1172c59f451f524a14bac5e7b047781883dfe441] Bluetooth: btusb:
> > >> Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA
> > >> git bisect bad 1172c59f451f524a14bac5e7b047781883dfe441
> > >> # bad: [766ae2422b4312a73510ebee9266bc23b466fbbb] Bluetooth:
> > hci_sync:
> > >> Check LMP feature bit instead of quirk
> > >> git bisect bad 766ae2422b4312a73510ebee9266bc23b466fbbb
> > >> # first bad commit: [766ae2422b4312a73510ebee9266bc23b466fbbb]
> > >> Bluetooth: hci_sync: Check LMP feature bit instead of quirk
> > >>
> > >> And 766ae2422b4312a73510ebee9266bc23b466fbbb does make sense as a
> > >> likely culprit.
> > >
> > > Looks like we will need to reintroduce the quirk then since it
> > appears
> > > the LMP feature bit is probably set in those controllers but the
> > > command doesn't work.
> >
> > It is. I already mentioned it in the Bugzilla thread and that's
> > what the patch series I submitted the other day fixes:
> >
> > > Bluetooth: btusb: Fix Chinese CSR dongles again by re-adding
> > ERR_DATA_REPORTING quirk
> > >
> > https://patchwork.kernel.org/project/bluetooth/patch/20221029202454.25651-1-swyterzone@gmail.com/
> >
> > Hans de Goede gave it a Reviewed-by, but it has been ignored even
> > since.
> >
> > Keep in mind that I'm an occasional contributor and I can barely use
> > a mailing list,
> > but this goes back to the patch that Zijun Hu sent back in July and I
> > was pinged.
> >
> >
> > I took a look back then, it looked suspect, but I imagined you guys
> > knew what you were
> > doing. Fast-forward three months and the code arrives at most
> > mainstream distros.
> >
> > Every single cheap Bluetooth dongle on Earth broke again. Just like
> > that.
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=60824#c242
> >
> > I just came across this thread archive by pure chance, this isn't
> > very user friendly.
> > Please CC me if you talk about this, I'm not subscribed to any list.
> >
> In case it helps any, I have applied Swyter's patch referenced at
> comment #243 of the bug referenced above, and it does restore function
> to my particular dongle (Gentoo linux, with gentoo-sources kernel
> 6.0.6.)  (I believe I provided the git bisect quoted at the top of this
> message.)

Ive applied the first 2 patches, the third one I'm not so sure I'd
like to introduce another module parameter.

> Jack



-- 
Luiz Augusto von Dentz
