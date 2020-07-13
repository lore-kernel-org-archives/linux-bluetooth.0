Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 22:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC4420C56
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 22:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P9jIHHWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGMWEy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgGMWEy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 18:04:54 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552DFC061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 15:04:54 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w17so12307934oie.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5oJFjl1usC9P8/dSSr34ahD/dcsG5PpeYskUUSdD9h0=;
        b=P9jIHHWQ3vUydM5wqFS7vJq3aTdZZdngSLodIE/tVCgzN6Ozroj8QUrwv62Bi9VmOa
         JaYT2G2HiOTtDZuZfDNZm3jVgDN2OHmeGlAnDTJft7gl8aPpuUzY2e5lTeXaPAJHtBMs
         ZgzsEcTALdaDDh/4FvReUR+zCdGPYWZnk4RFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5oJFjl1usC9P8/dSSr34ahD/dcsG5PpeYskUUSdD9h0=;
        b=qQ7iGUas23Ew36GTVE7CSiBihCphnQthGrPhOBHfy3z2YrWgyk82o3U4tT9bCPFOKa
         /S5NxH7YIMYn98WFf9bTRpLB6VkJsAb4odl5SD9FyBK/DklxDl4hc1ZxMSxfiQOr0DFW
         HIQbK+7Cb58fzpZw+MWjaBGSZtgHKcLgX2r4Hg4Jtb1OXpgIMQmQgwQc0XTFU/WS4+ss
         8iA0WjCY16YdrfbZnRK3bUVR4zN5gBCQjxqscS2An1DhwkzHOGuMVw5CHkph9kMIyNpn
         9Gg8BhAMdI1JFWUns53H33pJ+ezrqqZlhKA0i3veWaAS5/wIHJGLNsDgqK9rSqepm1hx
         1Meg==
X-Gm-Message-State: AOAM530IwNXue3quCC5rtq7VgERf1zpRTllQ5n9kWcuzYZgYdOi73TDc
        YmqluPngjp4Sh6+6THPnbMDiB/x8/cnfLnIE4tjFtA==
X-Google-Smtp-Source: ABdhPJzWS5tpHg22wJ+rmEqoqeyw5CerJrE59FWAl4xPvFNI6XxP5gInnQ6KdGb626qKL461UWmRuGEbh3RweEP7ReU=
X-Received: by 2002:aca:c157:: with SMTP id r84mr1321069oif.136.1594677893693;
 Mon, 13 Jul 2020 15:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200713201441.235959-1-sonnysasaka@chromium.org> <CABBYNZJ+7SFRra4S890bv+_oCbUXHPexVmxvGS2pAzdnHyhJXw@mail.gmail.com>
In-Reply-To: <CABBYNZJ+7SFRra4S890bv+_oCbUXHPexVmxvGS2pAzdnHyhJXw@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 13 Jul 2020 15:04:41 -0700
Message-ID: <CAOxioNkHgmycT=xoJp01GHQxL-0enVhWh9NsiQxqbDUCZ1Gj8g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Per-device option to enable/disable internal profiles
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I considered having such an approach that gives exception to some
profile to not claim exclusive access. However, I think that this
approach has a drawback that it can only be guaranteed to work
correctly for profiles that contain only read-only attributes. Any
profile that contains writable attributes, naturally, cannot be
guaranteed to always work correctly (as is the case with the Battery
profile). Therefore, the usefulness of that feature will be very
limited.

I also considered the benefits of the AllowInternalProfiles approach:
* Applications can also have control over any profile, not just
Battery profile. For example, if in the future BlueZ has more internal
profiles, like (Blood Pressure Profile or any other profile that may
contain writable attributes), we can guarantee that applications can
still opt to have access to that profile, without relying on a profile
being "safe" to be shared by both BlueZ's internal and external
handlers.
* This has an added security benefit: applications which operate on a
specific GATT profile will not unintentionally activate internal
profiles such as HOG (which is able to hijack input control of the
host). This is the correct and expected behavior of Android apps that
connect over GATT and get access to a GATT profile.

Therefore I think that this approach, although more complex, has
longer lasting benefits. Let me know if you have any objection to
having such a feature.


On Mon, Jul 13, 2020 at 1:35 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Mon, Jul 13, 2020 at 1:18 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > This patch series adds a mechanism for clients to choose whether to
> > enable BlueZ internal profiles (e.g. A2DP, Battery) for specific
> > devices.
> >
> > The motivation behind this feature is that some applications (e.g. Web
> > Bluetooth or Android apps) need to have control over all remove GATT
> > services, like Battery service. With "battery" plugin being enabled on
> > BlueZ, it becomes not possible for those apps to work properly because
> > BlueZ "hides" the Battery-related attributes from its GATT Client API.
> > Disabling the "battery" plugin won't solve the problem either, since we
> > do also need to enable the plugin so that we can use org.bluez.Battery1
> > API.
> >
> > The solution that we propose is that clients can choose whether to
> > enable internal profiles for each device. Clients know when to enable
> > internal profiles (such as when a user chooses to pair/connect via a UI)
> > and when to disable internal profiles (such as when the connection is
> > initiated by a generic application).
>
> I wonder if it is not better to just have a flag indicating if the
> profile shall claim exclusive access (such as GAP and GATT services),
> so profiles that don't set that will have the services exposed so for
> battery we can probably just have it exposed by default since it
> doesn't appear to would be any conflicts on having it exposed.
>
> > Sonny Sasaka (3):
> >   doc: Add "AllowInternalProfiles" property to org.bluez.Device1
> >   device: Add "AllowInternalProfiles" property to org.bluez.Device1
> >   client: Add set-allow-internal-profiles command
> >
> >  client/main.c      | 38 ++++++++++++++++++
> >  doc/device-api.txt | 13 +++++++
> >  src/device.c       | 96 ++++++++++++++++++++++++++++++++++++++++++++++
> >  src/hcid.h         |  2 +
> >  src/main.c         | 10 +++++
> >  src/main.conf      |  4 ++
> >  6 files changed, 163 insertions(+)
> >
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz
