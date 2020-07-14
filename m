Return-Path: <SRS0=5ENf=AZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8F3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 05:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4487121927
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 05:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJOpGcgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgGNF2R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jul 2020 01:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgGNF2R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jul 2020 01:28:17 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA48C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 22:28:17 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w17so13000891oie.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 22:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNck8jTr4IDyVc41d1w3ipAipUYDAOgWf+jO0QBQkwU=;
        b=YJOpGcguktLTUc5nhkqbnw1bO25L060bP3Q9xToBO3siA9y50Iq/s2a6XJHaVjqzih
         zV6UnW+hK4XQ/OUKWT6dNACeujAZj1asxmBBpmusoSj8smrv+VDbiJqG0kIeFhDNp67I
         J+Qv5pRhCiAK7VUn2vcXu/0FM2jPLGvTOR16X6lE9ou195kbnXaLFzrkkqfkH0oJVPCm
         8xWQageVgNxhIEoEUmLn+bBXatVyQ9bvlleiZC7956iy1eSgFxCQWZ1SE0FJwhUm1Cg2
         7K8Y0NuRH/qraaIrNtnL4ikcacz7poU271yKVOcqm/Tt/ekloMbRg4dbsut2ZP3otCHh
         +rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNck8jTr4IDyVc41d1w3ipAipUYDAOgWf+jO0QBQkwU=;
        b=GcziryELx4AzCAi4viOKzTmiluP1Vwv/ezCt3K7bMYY9dVW5wEcXkULnXsmZ7L8mUK
         wjBRBWONROlV5gOT50tdFKI7iKkNxM+xJU+X7KjT1AgycRv+Lt5WUFddE5MG+Kp9dPDr
         i/ghnigv8+jsp7452bay4rZmvrsr6UUViZ3+jTEUnhi3o2OQPBOzpZx919ArAiOKHfbl
         IP3QFY5oMKZJ5v6scPV6mCRm9ZfYNhupHZ8kj4vIoQv+ztXiUbmm3GyY+OSHwQ9xnwJU
         wFNSVlU5BVzDVAKXhhkm7RozYrdKLkrCsRV/mmeIVdHWOXU2ib/LEp9XDAxIdoVIhzZa
         YvrQ==
X-Gm-Message-State: AOAM531lJ23m5gj7arN/foy9PKoGpKA76b4M0FwYAgvqB/wSxZEPc8pm
        jgMjhYCA0NZM2yT6gata5zaH6jc65ya3AEhimGmsCwukaCg=
X-Google-Smtp-Source: ABdhPJy5y0s9o7YKMwll3xqMUS/ChpDyIKzhYmGHR0G5m4GxQHhVIVb0MmCMDGtmH+ByJMMFRadNnwq/vSo57Rm2fPI=
X-Received: by 2002:aca:cf81:: with SMTP id f123mr2434681oig.137.1594704496627;
 Mon, 13 Jul 2020 22:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200713201441.235959-1-sonnysasaka@chromium.org>
 <CABBYNZJ+7SFRra4S890bv+_oCbUXHPexVmxvGS2pAzdnHyhJXw@mail.gmail.com>
 <CAOxioNkHgmycT=xoJp01GHQxL-0enVhWh9NsiQxqbDUCZ1Gj8g@mail.gmail.com>
 <CABBYNZ+FyGLMGJUNJLR=quBn0R=bzsYRBHwbe1xnhR4BsR6k_w@mail.gmail.com> <CAOxioNnN23PkSdqYpS5MgaSjp2=BDpc--qUiCPYMF0KP0qAqQA@mail.gmail.com>
In-Reply-To: <CAOxioNnN23PkSdqYpS5MgaSjp2=BDpc--qUiCPYMF0KP0qAqQA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Jul 2020 22:28:05 -0700
Message-ID: <CABBYNZLd-NYoqtreM-0BNwJGM1JLCw9TbXJwusKMUGJPpvjNAw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Per-device option to enable/disable internal profiles
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Mon, Jul 13, 2020 at 4:48 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
> On Mon, Jul 13, 2020 at 3:59 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Mon, Jul 13, 2020 at 3:04 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > Hi Luiz,
> > >
> > > I considered having such an approach that gives exception to some
> > > profile to not claim exclusive access. However, I think that this
> > > approach has a drawback that it can only be guaranteed to work
> > > correctly for profiles that contain only read-only attributes. Any
> > > profile that contains writable attributes, naturally, cannot be
> > > guaranteed to always work correctly (as is the case with the Battery
> > > profile). Therefore, the usefulness of that feature will be very
> > > limited.
> > >
> > > I also considered the benefits of the AllowInternalProfiles approach:
> > > * Applications can also have control over any profile, not just
> > > Battery profile. For example, if in the future BlueZ has more internal
> > > profiles, like (Blood Pressure Profile or any other profile that may
> > > contain writable attributes), we can guarantee that applications can
> > > still opt to have access to that profile, without relying on a profile
> > > being "safe" to be shared by both BlueZ's internal and external
> > > handlers.
> > > * This has an added security benefit: applications which operate on a
> > > specific GATT profile will not unintentionally activate internal
> > > profiles such as HOG (which is able to hijack input control of the
> > > host). This is the correct and expected behavior of Android apps that
> > > connect over GATT and get access to a GATT profile.
> >
> > Not sure I follow these arguments, it seems AllowInternalProfiles may
> > actually enable hijacking the profiles so I wonder if you got this
> > backwards as we can't let things like HoG be controlled by
> > applications directly it would be too easy to implement something like
> > a keylogger, or perhaps you are suggesting that there is another layer
> > for implementing the profiles? Note that it is intended that plugins
> > shall be used for profiles that need to be integrated system wide,
> > D-Bus interface shall be restricted to only application specific
> > profiles.
>
> I think you misunderstood my point about HOG hijacking. Consider the
> following case:
> 1. A legit application (not System UI) on a host computer scans and
> connects to a nearby peer. It makes a guess about the peer device
> based on its advertising data. It intends to operate on a specific
> GATT profile (not necessarily Battery).
> 2. The peer device turns out to be malicious. It runs HOG GATT server
> and triggers the host's HOG profile to be active.
> 3. The malicious peer device's HOG GATT server can now maliciously
> make mouse movements or enter keystrokes to the host.

I'm not sure how you would like to prevent that, we could in theory
attempt to authorize every single profile before connecting, just like
it is done for legacy, but Im sure system would not be asking the user
what profiles to connect so they just end up trusting the device,
alternatively we could make ConnectProfile to work also for LE so you
can provide a UUID and nothing else would be exposed, but note that
this guess on the AD may actually be wrong and the device may end up
malfunctioning.

> In this case the user is considered being attacked, because he/she
> doesn't consciously interact with the System UI to connect to a nearby
> mouse/keyboard.
> My example doesn't have to be HOG. It just happens to be a profile
> which is attackable at the moment. My point is that, for applications
> it's always safest to turn off all internal profiles to avoid such
> incident. There is no use case where applications want to trigger
> internal profiles.
>
> Note 1: By "applications", I mean things like Android apps or
> JavaScript apps which are not considered System's Bluetooth UI.

Well that doesn't make my point moot, let's say we do enable
connecting by UUID and the application try to connect HoG, it could be
a malicious application trying to eavesdrop what the user is typing,
so this problem of malicious goes both ways Im afraid, besides the
performance penalty that one would have if we need to transport HID
over D-Bus.

More applications could be involved and then this all becomes a mess
if they have to fight over AllowInternalProfiles, so instead of using
a theoretical example we better find real apps and devices where
conflicts happens and work out case by case, adding ConnectProfile
should actually fix most of them if there is a single profile involved
by we could also thing about an alternative to connect multiples.
There is also the possibility of exposing the btd_service as objects,
I've actually had this implemented for the car industry, that way
AutoConnect property could actually be controlled on a per service
basis instead of having just one switch for everything.

> >
> > Note that we do allow external profiles to be registered with use of:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt
> >
> > And for GATT:
> >
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n366
> >
> > We could perhaps make the assumption that once an application
> > registers itself as supporting a given profile we check if against a
> > blacklist of profiles that may have security implications, which
> > perhaps could be defined via main.conf or some other file, if that is
> > not the case the internal profile can be disabled and the D-Bus object
> > would be accessible over D-Bus. Also note that we do offer clients the
> > ability to have exclusive access with AcquireWrite and AcquireNotify.
> >
> > > Therefore I think that this approach, although more complex, has
> > > longer lasting benefits. Let me know if you have any objection to
> > > having such a feature.
> > >
> > >
> > > On Mon, Jul 13, 2020 at 1:35 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Sonny,
> > > >
> > > > On Mon, Jul 13, 2020 at 1:18 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > > >
> > > > > This patch series adds a mechanism for clients to choose whether to
> > > > > enable BlueZ internal profiles (e.g. A2DP, Battery) for specific
> > > > > devices.
> > > > >
> > > > > The motivation behind this feature is that some applications (e.g. Web
> > > > > Bluetooth or Android apps) need to have control over all remove GATT
> > > > > services, like Battery service. With "battery" plugin being enabled on
> > > > > BlueZ, it becomes not possible for those apps to work properly because
> > > > > BlueZ "hides" the Battery-related attributes from its GATT Client API.
> > > > > Disabling the "battery" plugin won't solve the problem either, since we
> > > > > do also need to enable the plugin so that we can use org.bluez.Battery1
> > > > > API.
> > > > >
> > > > > The solution that we propose is that clients can choose whether to
> > > > > enable internal profiles for each device. Clients know when to enable
> > > > > internal profiles (such as when a user chooses to pair/connect via a UI)
> > > > > and when to disable internal profiles (such as when the connection is
> > > > > initiated by a generic application).
> > > >
> > > > I wonder if it is not better to just have a flag indicating if the
> > > > profile shall claim exclusive access (such as GAP and GATT services),
> > > > so profiles that don't set that will have the services exposed so for
> > > > battery we can probably just have it exposed by default since it
> > > > doesn't appear to would be any conflicts on having it exposed.
> > > >
> > > > > Sonny Sasaka (3):
> > > > >   doc: Add "AllowInternalProfiles" property to org.bluez.Device1
> > > > >   device: Add "AllowInternalProfiles" property to org.bluez.Device1
> > > > >   client: Add set-allow-internal-profiles command
> > > > >
> > > > >  client/main.c      | 38 ++++++++++++++++++
> > > > >  doc/device-api.txt | 13 +++++++
> > > > >  src/device.c       | 96 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  src/hcid.h         |  2 +
> > > > >  src/main.c         | 10 +++++
> > > > >  src/main.conf      |  4 ++
> > > > >  6 files changed, 163 insertions(+)
> > > > >
> > > > > --
> > > > > 2.26.2
> > > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
