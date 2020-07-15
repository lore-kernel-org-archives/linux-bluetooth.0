Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9E0C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 16:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914B02065E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 16:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2T9EN1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgGOQZu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgGOQZt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 12:25:49 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220B1C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 09:25:49 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t198so2653362oie.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yogsD9dOjvPh9IGQrxuVaesSOGnFu9UMXcOKMPJF33s=;
        b=V2T9EN1sa+lQpvuDcofGOFsxapQoYrJMZMGN/XcRDMc3Of2k7qkNoKLjaWLuhrxtvf
         V/nUfGEOgZjBnIFu5hIgFL/bgkQ16p3mK3m6DrlhKbStSBgfne5Mq/buMdmOb0xvRbYo
         rDnP9nnO81qXp+P//tCFYIaqtxVVi/h2vCjfSyR848BLm+R2aymo/yHMw6xFqufePjZL
         gOnD40tUuOBEdeR5b51mrTRh65WZZxJJmHIPcZYx9JxlIymzvtzVfzSCX2MONnT2HLuJ
         lmjJO+bLwxxxF0aYgCaJQli4SSRJoXZNkdB+zE2LgayV6CKEqABNQU8zE1ewPWOOgaKr
         wAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yogsD9dOjvPh9IGQrxuVaesSOGnFu9UMXcOKMPJF33s=;
        b=ll6tF+y0nK37Vq8b9tperR5PrlBeOKc+IVvydNPk09B0KAfBSPTNcLrNKmPBsrvqi9
         7MnCn4mxTE6iJD1wVZXFDdvOThCAplkakz5caETZLgV1WXLp0SAIbcMU+N1lX+o9rzU2
         Q27ZAS5z28WohjF4VSSm6gNLnppji0mOylnQJs2asg+8Pj/0uD3pEI76qIOQ0MnoKBrQ
         5F5Uj3+gCQfcPGDcd7NeaEyLDQCp59m/25xGXeMa757R+CrYfFAdod/pNyytze3PDGrE
         pYMJKQWfDXq0HdaZBnAv2gMcuYDkht+l4mjjvVYZce/9j56YIZrwdslC1Kvp7w1GwtjZ
         Ja0A==
X-Gm-Message-State: AOAM532wo/B6HaHuyu2NEShQvdbEwYVzaFEs7Mxv0MMdwlgNIsPy4kH+
        HNA+wsN8JVXzqteKv5Q02JuAqfh8IuV+HRMnWU4=
X-Google-Smtp-Source: ABdhPJx6jFqi5nMHPd7WthOMfEUiob5q5ZYQ6YXBuXAUIj4BisqdY6QkQ14RYo4Y7nwx4/wUXBfAMGjOmcjLCceT5aM=
X-Received: by 2002:aca:4a04:: with SMTP id x4mr421917oia.152.1594830348298;
 Wed, 15 Jul 2020 09:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200713201441.235959-1-sonnysasaka@chromium.org>
 <CABBYNZJ+7SFRra4S890bv+_oCbUXHPexVmxvGS2pAzdnHyhJXw@mail.gmail.com>
 <CAOxioNkHgmycT=xoJp01GHQxL-0enVhWh9NsiQxqbDUCZ1Gj8g@mail.gmail.com>
 <CABBYNZ+FyGLMGJUNJLR=quBn0R=bzsYRBHwbe1xnhR4BsR6k_w@mail.gmail.com>
 <CAOxioNnN23PkSdqYpS5MgaSjp2=BDpc--qUiCPYMF0KP0qAqQA@mail.gmail.com>
 <CABBYNZLd-NYoqtreM-0BNwJGM1JLCw9TbXJwusKMUGJPpvjNAw@mail.gmail.com> <CAOxioNmjL4a8aZpn3Lok5P=c9agCJYt8MaaqH=rz7HEbknwHOg@mail.gmail.com>
In-Reply-To: <CAOxioNmjL4a8aZpn3Lok5P=c9agCJYt8MaaqH=rz7HEbknwHOg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Jul 2020 09:25:36 -0700
Message-ID: <CABBYNZLinkpfhcfKhFTM+ui-r5RFYGoS=rbLtXQ7kQZv-Zcg9Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Per-device option to enable/disable internal profiles
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Tue, Jul 14, 2020 at 1:55 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
> On Mon, Jul 13, 2020 at 10:28 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Mon, Jul 13, 2020 at 4:48 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Mon, Jul 13, 2020 at 3:59 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Sonny,
> > > >
> > > > On Mon, Jul 13, 2020 at 3:04 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > I considered having such an approach that gives exception to some
> > > > > profile to not claim exclusive access. However, I think that this
> > > > > approach has a drawback that it can only be guaranteed to work
> > > > > correctly for profiles that contain only read-only attributes. Any
> > > > > profile that contains writable attributes, naturally, cannot be
> > > > > guaranteed to always work correctly (as is the case with the Battery
> > > > > profile). Therefore, the usefulness of that feature will be very
> > > > > limited.
> > > > >
> > > > > I also considered the benefits of the AllowInternalProfiles approach:
> > > > > * Applications can also have control over any profile, not just
> > > > > Battery profile. For example, if in the future BlueZ has more internal
> > > > > profiles, like (Blood Pressure Profile or any other profile that may
> > > > > contain writable attributes), we can guarantee that applications can
> > > > > still opt to have access to that profile, without relying on a profile
> > > > > being "safe" to be shared by both BlueZ's internal and external
> > > > > handlers.
> > > > > * This has an added security benefit: applications which operate on a
> > > > > specific GATT profile will not unintentionally activate internal
> > > > > profiles such as HOG (which is able to hijack input control of the
> > > > > host). This is the correct and expected behavior of Android apps that
> > > > > connect over GATT and get access to a GATT profile.
> > > >
> > > > Not sure I follow these arguments, it seems AllowInternalProfiles may
> > > > actually enable hijacking the profiles so I wonder if you got this
> > > > backwards as we can't let things like HoG be controlled by
> > > > applications directly it would be too easy to implement something like
> > > > a keylogger, or perhaps you are suggesting that there is another layer
> > > > for implementing the profiles? Note that it is intended that plugins
> > > > shall be used for profiles that need to be integrated system wide,
> > > > D-Bus interface shall be restricted to only application specific
> > > > profiles.
> > >
> > > I think you misunderstood my point about HOG hijacking. Consider the
> > > following case:
> > > 1. A legit application (not System UI) on a host computer scans and
> > > connects to a nearby peer. It makes a guess about the peer device
> > > based on its advertising data. It intends to operate on a specific
> > > GATT profile (not necessarily Battery).
> > > 2. The peer device turns out to be malicious. It runs HOG GATT server
> > > and triggers the host's HOG profile to be active.
> > > 3. The malicious peer device's HOG GATT server can now maliciously
> > > make mouse movements or enter keystrokes to the host.
> >
> > I'm not sure how you would like to prevent that, we could in theory
> > attempt to authorize every single profile before connecting, just like
> > it is done for legacy, but Im sure system would not be asking the user
> > what profiles to connect so they just end up trusting the device,
> > alternatively we could make ConnectProfile to work also for LE so you
> > can provide a UUID and nothing else would be exposed, but note that
> > this guess on the AD may actually be wrong and the device may end up
> > malfunctioning.
> >
> > > In this case the user is considered being attacked, because he/she
> > > doesn't consciously interact with the System UI to connect to a nearby
> > > mouse/keyboard.
> > > My example doesn't have to be HOG. It just happens to be a profile
> > > which is attackable at the moment. My point is that, for applications
> > > it's always safest to turn off all internal profiles to avoid such
> > > incident. There is no use case where applications want to trigger
> > > internal profiles.
> > >
> > > Note 1: By "applications", I mean things like Android apps or
> > > JavaScript apps which are not considered System's Bluetooth UI.
> >
> > Well that doesn't make my point moot, let's say we do enable
> > connecting by UUID and the application try to connect HoG, it could be
> > a malicious application trying to eavesdrop what the user is typing,
> > so this problem of malicious goes both ways Im afraid, besides the
> > performance penalty that one would have if we need to transport HID
> > over D-Bus.
> If an application handles HOG, there will be nothing to eavesdrop
> because that application shouldn't have an access to UHID in the first
> place. If that malicious application had UHID access, that is already
> a problem to begin with regardless of whether there is Bluetooth or
> not. The security of this is handled above the Bluetooth layer. The
> operating system that uses this feature is responsible for higher
> layer security. For operating systems that don't need it I am okay
> with adding an option to disable this feature altogether. But I can
> see that there are systems that need it and I am not convinced that a
> general purpose Bluetooth stack should not support it.

All a malicious application has to do is to subscribe to notification
of HoG characteristic, then any input generate by the device would be
notified back to the application and that doesn't matter if uHID is
accessible or not the application may not even forward the events to
the system, now perhaps you are imagining that applications don't have
direct access to the attribute objects but that would be system
specific which is rather tricky to define.

> >
> > More applications could be involved and then this all becomes a mess
> > if they have to fight over AllowInternalProfiles, so instead of using
> > a theoretical example we better find real apps and devices where
> > conflicts happens and work out case by case, adding ConnectProfile
> > should actually fix most of them if there is a single profile involved
> > by we could also thing about an alternative to connect multiples.
> > There is also the possibility of exposing the btd_service as objects,
> > I've actually had this implemented for the car industry, that way
> > AutoConnect property could actually be controlled on a per service
> > basis instead of having just one switch for everything.
> To be clear, applications do not have direct access to
> AllowInternalProfiles. The higher layer operating system controls it.
> This is just the same case as the org.bluez.Adapter1.Powered property
> and many other examples where applications are not expected to have
> direct control of. Therefore there should be no problem of many things
> fighting over it if used correctly, just like many other properties.
> Again, I am okay with adding an option to disable this for operating
> systems that do not want it.

I see, though you didn't comment on the idea of controlling this on a
per-service basis, not just have everything disabled with
AllowInternalProfiles, note though that there are some profiles we
can't really disable like GAP and GATT as that involves things that
bt_gatt_client itself does need to access in order to work properly.

You can find the service_api commits in here:

https://github.com/Vudentz/BlueZ/commits/service_api

It does allow to control both the auto_connect logic as well a block:

https://github.com/Vudentz/BlueZ/commit/9bd6dce59fe9978b3bf415fe74f89d72254b8075
https://github.com/Vudentz/BlueZ/commit/42a7e479d5beb641a3d94f724a2df60db0f8221c

> Note: I have been using the term "operating system" to refer to high
> level components rather than the kernel.
>
>
> >
> > > >
> > > > Note that we do allow external profiles to be registered with use of:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt
> > > >
> > > > And for GATT:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n366
> > > >
> > > > We could perhaps make the assumption that once an application
> > > > registers itself as supporting a given profile we check if against a
> > > > blacklist of profiles that may have security implications, which
> > > > perhaps could be defined via main.conf or some other file, if that is
> > > > not the case the internal profile can be disabled and the D-Bus object
> > > > would be accessible over D-Bus. Also note that we do offer clients the
> > > > ability to have exclusive access with AcquireWrite and AcquireNotify.
> > > >
> > > > > Therefore I think that this approach, although more complex, has
> > > > > longer lasting benefits. Let me know if you have any objection to
> > > > > having such a feature.
> > > > >
> > > > >
> > > > > On Mon, Jul 13, 2020 at 1:35 PM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Sonny,
> > > > > >
> > > > > > On Mon, Jul 13, 2020 at 1:18 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > > > > >
> > > > > > > This patch series adds a mechanism for clients to choose whether to
> > > > > > > enable BlueZ internal profiles (e.g. A2DP, Battery) for specific
> > > > > > > devices.
> > > > > > >
> > > > > > > The motivation behind this feature is that some applications (e.g. Web
> > > > > > > Bluetooth or Android apps) need to have control over all remove GATT
> > > > > > > services, like Battery service. With "battery" plugin being enabled on
> > > > > > > BlueZ, it becomes not possible for those apps to work properly because
> > > > > > > BlueZ "hides" the Battery-related attributes from its GATT Client API.
> > > > > > > Disabling the "battery" plugin won't solve the problem either, since we
> > > > > > > do also need to enable the plugin so that we can use org.bluez.Battery1
> > > > > > > API.
> > > > > > >
> > > > > > > The solution that we propose is that clients can choose whether to
> > > > > > > enable internal profiles for each device. Clients know when to enable
> > > > > > > internal profiles (such as when a user chooses to pair/connect via a UI)
> > > > > > > and when to disable internal profiles (such as when the connection is
> > > > > > > initiated by a generic application).
> > > > > >
> > > > > > I wonder if it is not better to just have a flag indicating if the
> > > > > > profile shall claim exclusive access (such as GAP and GATT services),
> > > > > > so profiles that don't set that will have the services exposed so for
> > > > > > battery we can probably just have it exposed by default since it
> > > > > > doesn't appear to would be any conflicts on having it exposed.
> > > > > >
> > > > > > > Sonny Sasaka (3):
> > > > > > >   doc: Add "AllowInternalProfiles" property to org.bluez.Device1
> > > > > > >   device: Add "AllowInternalProfiles" property to org.bluez.Device1
> > > > > > >   client: Add set-allow-internal-profiles command
> > > > > > >
> > > > > > >  client/main.c      | 38 ++++++++++++++++++
> > > > > > >  doc/device-api.txt | 13 +++++++
> > > > > > >  src/device.c       | 96 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  src/hcid.h         |  2 +
> > > > > > >  src/main.c         | 10 +++++
> > > > > > >  src/main.conf      |  4 ++
> > > > > > >  6 files changed, 163 insertions(+)
> > > > > > >
> > > > > > > --
> > > > > > > 2.26.2
> > > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
> > > >
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
