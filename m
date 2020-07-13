Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB62C43459
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 23:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7123D21582
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 23:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jzuvwvt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGMXtP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgGMXst (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 19:48:49 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855BDC061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 16:48:49 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 18so11128919otv.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 16:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3FnEyMXCyMjWIZc011broRSH16kPZ5lCcUamQmS3Xk=;
        b=jzuvwvt+xmjT2+N8izRgmG1JKSDrHN/k/n5DWA7b9VDulN/HMSXfRdwRtMG7s/tqZl
         8MPk4PRcNIlyb/H2eHVJOF5P32g+uBI0+GKDgZMlh4Hlppcv/4IKV/09rkcI5kdOfhZc
         qQJN/xPDJq3HDn/Mdi6dv8xYz76TFPUl58gMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3FnEyMXCyMjWIZc011broRSH16kPZ5lCcUamQmS3Xk=;
        b=pfUPIyAg2fqom6t6ImnEegalXiJRujws4ABZ+W1JcEpFhO3r6eXUIGHXbVyaPX+ncO
         4U/KQrPt6xQU4zZcWHjt8eaX9CJXKHiEucOEXShN07AnVM3fu0uunDUt46ee0xU4PI6E
         MNsmqXJ3hLien00fSz2Trsvwh22lTW9wANhzUaG9uhpkCMEFLugyDmmqg0mhCnH5BO6v
         aBklYWOEPz17ul0qnMXwetlhDlIQKhc2sqaYfJHE+CrFtVEz8zRsaSWaGmzVOAIebLQ2
         1VNDKAEGbaQKHmk9eVXpjRuBs5Ht/5VcdWpO/3cLGTq9cf+P2Eok8djUvJeEOFWNtb/K
         wrFQ==
X-Gm-Message-State: AOAM533/Awau9jCHXCFcc0Lg97saLjVjeTzjS9DUsrydTr2Piz7yjtGk
        cs/iTaTuV8ZxtW/E0C6oWV+T3BTdp0aKgl3IEn9STbKH0GM=
X-Google-Smtp-Source: ABdhPJyveyuIEQxaAUFvWpCIWLlqsiLTx2bcWpUkVi016ZLpUPKlCp1nSl+bUwSeRMYv+HW0a33p6b9WLabNmhAKihA=
X-Received: by 2002:a9d:554d:: with SMTP id h13mr1660215oti.329.1594684128701;
 Mon, 13 Jul 2020 16:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200713201441.235959-1-sonnysasaka@chromium.org>
 <CABBYNZJ+7SFRra4S890bv+_oCbUXHPexVmxvGS2pAzdnHyhJXw@mail.gmail.com>
 <CAOxioNkHgmycT=xoJp01GHQxL-0enVhWh9NsiQxqbDUCZ1Gj8g@mail.gmail.com> <CABBYNZ+FyGLMGJUNJLR=quBn0R=bzsYRBHwbe1xnhR4BsR6k_w@mail.gmail.com>
In-Reply-To: <CABBYNZ+FyGLMGJUNJLR=quBn0R=bzsYRBHwbe1xnhR4BsR6k_w@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 13 Jul 2020 16:48:36 -0700
Message-ID: <CAOxioNnN23PkSdqYpS5MgaSjp2=BDpc--qUiCPYMF0KP0qAqQA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Per-device option to enable/disable internal profiles
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, Jul 13, 2020 at 3:59 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Mon, Jul 13, 2020 at 3:04 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > I considered having such an approach that gives exception to some
> > profile to not claim exclusive access. However, I think that this
> > approach has a drawback that it can only be guaranteed to work
> > correctly for profiles that contain only read-only attributes. Any
> > profile that contains writable attributes, naturally, cannot be
> > guaranteed to always work correctly (as is the case with the Battery
> > profile). Therefore, the usefulness of that feature will be very
> > limited.
> >
> > I also considered the benefits of the AllowInternalProfiles approach:
> > * Applications can also have control over any profile, not just
> > Battery profile. For example, if in the future BlueZ has more internal
> > profiles, like (Blood Pressure Profile or any other profile that may
> > contain writable attributes), we can guarantee that applications can
> > still opt to have access to that profile, without relying on a profile
> > being "safe" to be shared by both BlueZ's internal and external
> > handlers.
> > * This has an added security benefit: applications which operate on a
> > specific GATT profile will not unintentionally activate internal
> > profiles such as HOG (which is able to hijack input control of the
> > host). This is the correct and expected behavior of Android apps that
> > connect over GATT and get access to a GATT profile.
>
> Not sure I follow these arguments, it seems AllowInternalProfiles may
> actually enable hijacking the profiles so I wonder if you got this
> backwards as we can't let things like HoG be controlled by
> applications directly it would be too easy to implement something like
> a keylogger, or perhaps you are suggesting that there is another layer
> for implementing the profiles? Note that it is intended that plugins
> shall be used for profiles that need to be integrated system wide,
> D-Bus interface shall be restricted to only application specific
> profiles.

I think you misunderstood my point about HOG hijacking. Consider the
following case:
1. A legit application (not System UI) on a host computer scans and
connects to a nearby peer. It makes a guess about the peer device
based on its advertising data. It intends to operate on a specific
GATT profile (not necessarily Battery).
2. The peer device turns out to be malicious. It runs HOG GATT server
and triggers the host's HOG profile to be active.
3. The malicious peer device's HOG GATT server can now maliciously
make mouse movements or enter keystrokes to the host.

In this case the user is considered being attacked, because he/she
doesn't consciously interact with the System UI to connect to a nearby
mouse/keyboard.
My example doesn't have to be HOG. It just happens to be a profile
which is attackable at the moment. My point is that, for applications
it's always safest to turn off all internal profiles to avoid such
incident. There is no use case where applications want to trigger
internal profiles.

Note 1: By "applications", I mean things like Android apps or
JavaScript apps which are not considered System's Bluetooth UI.

>
> Note that we do allow external profiles to be registered with use of:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt
>
> And for GATT:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n366
>
> We could perhaps make the assumption that once an application
> registers itself as supporting a given profile we check if against a
> blacklist of profiles that may have security implications, which
> perhaps could be defined via main.conf or some other file, if that is
> not the case the internal profile can be disabled and the D-Bus object
> would be accessible over D-Bus. Also note that we do offer clients the
> ability to have exclusive access with AcquireWrite and AcquireNotify.
>
> > Therefore I think that this approach, although more complex, has
> > longer lasting benefits. Let me know if you have any objection to
> > having such a feature.
> >
> >
> > On Mon, Jul 13, 2020 at 1:35 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sonny,
> > >
> > > On Mon, Jul 13, 2020 at 1:18 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > >
> > > > This patch series adds a mechanism for clients to choose whether to
> > > > enable BlueZ internal profiles (e.g. A2DP, Battery) for specific
> > > > devices.
> > > >
> > > > The motivation behind this feature is that some applications (e.g. Web
> > > > Bluetooth or Android apps) need to have control over all remove GATT
> > > > services, like Battery service. With "battery" plugin being enabled on
> > > > BlueZ, it becomes not possible for those apps to work properly because
> > > > BlueZ "hides" the Battery-related attributes from its GATT Client API.
> > > > Disabling the "battery" plugin won't solve the problem either, since we
> > > > do also need to enable the plugin so that we can use org.bluez.Battery1
> > > > API.
> > > >
> > > > The solution that we propose is that clients can choose whether to
> > > > enable internal profiles for each device. Clients know when to enable
> > > > internal profiles (such as when a user chooses to pair/connect via a UI)
> > > > and when to disable internal profiles (such as when the connection is
> > > > initiated by a generic application).
> > >
> > > I wonder if it is not better to just have a flag indicating if the
> > > profile shall claim exclusive access (such as GAP and GATT services),
> > > so profiles that don't set that will have the services exposed so for
> > > battery we can probably just have it exposed by default since it
> > > doesn't appear to would be any conflicts on having it exposed.
> > >
> > > > Sonny Sasaka (3):
> > > >   doc: Add "AllowInternalProfiles" property to org.bluez.Device1
> > > >   device: Add "AllowInternalProfiles" property to org.bluez.Device1
> > > >   client: Add set-allow-internal-profiles command
> > > >
> > > >  client/main.c      | 38 ++++++++++++++++++
> > > >  doc/device-api.txt | 13 +++++++
> > > >  src/device.c       | 96 ++++++++++++++++++++++++++++++++++++++++++++++
> > > >  src/hcid.h         |  2 +
> > > >  src/main.c         | 10 +++++
> > > >  src/main.conf      |  4 ++
> > > >  6 files changed, 163 insertions(+)
> > > >
> > > > --
> > > > 2.26.2
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
