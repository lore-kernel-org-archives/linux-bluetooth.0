Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C830C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 22:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18AF42137B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 22:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc/0mwbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGMW7Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgGMW7Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 18:59:25 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBBBC061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 15:59:25 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j11so12379740oiw.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uWX86usec4UElqr/Gt1rS+RH2x17bKUqzxnoEy9810=;
        b=Uc/0mwbxKFJRKqDQKKzlT18vH/QkmehQ0aq1GPPd/2y+X8uA5MHA9tOTdNhgR5EXkO
         QhljYqOfKnHospjJ1stgLGo9McDr7I0jUMK/blPmwhgWUVYB/Bw9zW5UOSs0lOiCYVbs
         Kv8eTncXVOwHSkvsCfx9YDdrdXrX7wq5AaiDhtDNmBXrZNMjMMltpTn8mUQhstwdIlXs
         +vE8ciLTfi8R7qIZ6Uww4cjjZCwkWqigzIGXi27ZL8Mf1qTF/FSBvC7Kfyl7c/go1AVo
         e3aS5iwsVpdiVGfklQNTzbcaCsF2RHtx1CB1URvfJzpgs18isKJbCq5O6zHkZ0IopTTH
         2arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uWX86usec4UElqr/Gt1rS+RH2x17bKUqzxnoEy9810=;
        b=AdJkX+o5lfu148T8Wotu1Ak1aiX55Jydjk3gbc1yk1HTzh8qJ+JQ73OUC/XST52DcZ
         Ik7l6lOSFN0aQ1zzu3YXdRspzQEBdLDqUfqpQ8rpqgfQ2V1zpbfnvNrM9ajtBgvjsLMx
         /iQQvEXn067E8MCxadxePECWGAWDwRBRXuy8JfHaWRliwc6Gvg6UUN7OGCLPVu+8wilZ
         UY68k3fVAVTsKM/AfmTAFXO8PNLEwrAGPW75mqDLSAt5VF6FNN8vf50pNnSfaPM1g78L
         PKzyPG5K95q4zE6k8f4uF/KfT555+83HlL+LjJKU3FQzFWsg+HL7nwpHqyesWIKLM4Gs
         M5Mg==
X-Gm-Message-State: AOAM532hS2rq+406e9QDUSAhv4gkhxu3oanZ26Yd2hdB2KI9AxLraJ7i
        A1azRohpfWNg9BG0on+3MI4aqiTxXGPsXouMMcS46F8LuoY=
X-Google-Smtp-Source: ABdhPJwU7z3rVj+MOtGXJXfC0cY81H2H92eRzFjLauVHiiuiq8w4Le104CdUhXV4vGXudNWue7CgN8Kxbk1q/lzr5Xk=
X-Received: by 2002:aca:cf81:: with SMTP id f123mr1472803oig.137.1594681163923;
 Mon, 13 Jul 2020 15:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200713201441.235959-1-sonnysasaka@chromium.org>
 <CABBYNZJ+7SFRra4S890bv+_oCbUXHPexVmxvGS2pAzdnHyhJXw@mail.gmail.com> <CAOxioNkHgmycT=xoJp01GHQxL-0enVhWh9NsiQxqbDUCZ1Gj8g@mail.gmail.com>
In-Reply-To: <CAOxioNkHgmycT=xoJp01GHQxL-0enVhWh9NsiQxqbDUCZ1Gj8g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Jul 2020 15:59:12 -0700
Message-ID: <CABBYNZ+FyGLMGJUNJLR=quBn0R=bzsYRBHwbe1xnhR4BsR6k_w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Per-device option to enable/disable internal profiles
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Mon, Jul 13, 2020 at 3:04 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
> I considered having such an approach that gives exception to some
> profile to not claim exclusive access. However, I think that this
> approach has a drawback that it can only be guaranteed to work
> correctly for profiles that contain only read-only attributes. Any
> profile that contains writable attributes, naturally, cannot be
> guaranteed to always work correctly (as is the case with the Battery
> profile). Therefore, the usefulness of that feature will be very
> limited.
>
> I also considered the benefits of the AllowInternalProfiles approach:
> * Applications can also have control over any profile, not just
> Battery profile. For example, if in the future BlueZ has more internal
> profiles, like (Blood Pressure Profile or any other profile that may
> contain writable attributes), we can guarantee that applications can
> still opt to have access to that profile, without relying on a profile
> being "safe" to be shared by both BlueZ's internal and external
> handlers.
> * This has an added security benefit: applications which operate on a
> specific GATT profile will not unintentionally activate internal
> profiles such as HOG (which is able to hijack input control of the
> host). This is the correct and expected behavior of Android apps that
> connect over GATT and get access to a GATT profile.

Not sure I follow these arguments, it seems AllowInternalProfiles may
actually enable hijacking the profiles so I wonder if you got this
backwards as we can't let things like HoG be controlled by
applications directly it would be too easy to implement something like
a keylogger, or perhaps you are suggesting that there is another layer
for implementing the profiles? Note that it is intended that plugins
shall be used for profiles that need to be integrated system wide,
D-Bus interface shall be restricted to only application specific
profiles.

Note that we do allow external profiles to be registered with use of:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt

And for GATT:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n366

We could perhaps make the assumption that once an application
registers itself as supporting a given profile we check if against a
blacklist of profiles that may have security implications, which
perhaps could be defined via main.conf or some other file, if that is
not the case the internal profile can be disabled and the D-Bus object
would be accessible over D-Bus. Also note that we do offer clients the
ability to have exclusive access with AcquireWrite and AcquireNotify.

> Therefore I think that this approach, although more complex, has
> longer lasting benefits. Let me know if you have any objection to
> having such a feature.
>
>
> On Mon, Jul 13, 2020 at 1:35 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Mon, Jul 13, 2020 at 1:18 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > This patch series adds a mechanism for clients to choose whether to
> > > enable BlueZ internal profiles (e.g. A2DP, Battery) for specific
> > > devices.
> > >
> > > The motivation behind this feature is that some applications (e.g. Web
> > > Bluetooth or Android apps) need to have control over all remove GATT
> > > services, like Battery service. With "battery" plugin being enabled on
> > > BlueZ, it becomes not possible for those apps to work properly because
> > > BlueZ "hides" the Battery-related attributes from its GATT Client API.
> > > Disabling the "battery" plugin won't solve the problem either, since we
> > > do also need to enable the plugin so that we can use org.bluez.Battery1
> > > API.
> > >
> > > The solution that we propose is that clients can choose whether to
> > > enable internal profiles for each device. Clients know when to enable
> > > internal profiles (such as when a user chooses to pair/connect via a UI)
> > > and when to disable internal profiles (such as when the connection is
> > > initiated by a generic application).
> >
> > I wonder if it is not better to just have a flag indicating if the
> > profile shall claim exclusive access (such as GAP and GATT services),
> > so profiles that don't set that will have the services exposed so for
> > battery we can probably just have it exposed by default since it
> > doesn't appear to would be any conflicts on having it exposed.
> >
> > > Sonny Sasaka (3):
> > >   doc: Add "AllowInternalProfiles" property to org.bluez.Device1
> > >   device: Add "AllowInternalProfiles" property to org.bluez.Device1
> > >   client: Add set-allow-internal-profiles command
> > >
> > >  client/main.c      | 38 ++++++++++++++++++
> > >  doc/device-api.txt | 13 +++++++
> > >  src/device.c       | 96 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  src/hcid.h         |  2 +
> > >  src/main.c         | 10 +++++
> > >  src/main.conf      |  4 ++
> > >  6 files changed, 163 insertions(+)
> > >
> > > --
> > > 2.26.2
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
