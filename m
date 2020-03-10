Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9258C10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884D721D56
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 17:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGYq5V+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgCJRM3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:12:29 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34494 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJRM3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 13:12:29 -0400
Received: by mail-oi1-f196.google.com with SMTP id g6so14669646oiy.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNTMuhLCvkDG+9h02ML+SwAIQ60m2wuHbvBXRAYffIs=;
        b=mGYq5V+wF2Poqrw/Xv0dsQ82xtrZp2zyNvLh0Pd4vXouoeClLjWIGhlWJH9rrmXosa
         oKrZHLwNGaGzXxWjITDkUJAKV/1YRuWoTrYwgeKncn87YkfH2H9KXl6M7MMwW+F9diwW
         Nlt13EOck/XTYcseG6VXL01yYJ41X9TEZDNgZ54erRlOCg9a77dbgmu37MTrmvF0kCqc
         doKHjStL0e6eZZfBgMrFUk7dNUFmoHYj8hB7LvVU54cPY2kMfC/23+QABwxwi+Eu+U3Y
         8Oyh1EiX3YBJuyYjWfNNf6N9BGS00ADQ8apBpIfnQSteZv5gZL8zl1QVkRBmhRihUiyA
         43IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNTMuhLCvkDG+9h02ML+SwAIQ60m2wuHbvBXRAYffIs=;
        b=ZmFw8Q716Xuu3CieNyHtLUAYIWL9s8cRxqwwsii8a2EZwc7G8k8GtpJ8MtLNZ85GeE
         xrkcb5Ng0xz6JiXFEooGYnbVhKiq6NU9BxKCMLv8hm33VYgQw/YVJB/Bb1RQYYxyyJ6X
         rOiRB7AV32ccJLFBYyJTzCizwN1UDlYzW0ABiaQN0acKKlRqaJgdh6GvpLDoVzW8fLZl
         YHMpeztA+8lgcmVeECwDjcsXc8pI+NsdjVT93R2m/tdMK/KJHDcq1e0GXVd3+YFQ11Bl
         tVjWXz+D/oG/tgHTKDJnsggauUCtXi9tOM8Nacl3SkY73EoEhN6K0NaOPhxIah83Jc7/
         L3+A==
X-Gm-Message-State: ANhLgQ1zmeFW0Xh9bPkeZjZx3d6QtUpkFONefAOsB42AJXJm8KYyiFIQ
        H7/C4At1i5Ilgf4kA35XFgyXuh4pTkBwv5RHOvBE5ne2
X-Google-Smtp-Source: ADFU+vvsFg7GWfOMqnXarkKUtiokYIzdo3lGBCGcwL+w9GO1I3lydKSD3PdzlJxPRCmnALHoaVWsFucflj2MD2AOITA=
X-Received: by 2002:a05:6808:10b:: with SMTP id b11mr1939724oie.110.1583860347761;
 Tue, 10 Mar 2020 10:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200310023516.209146-1-alainm@chromium.org> <87A4E633-63CF-4C71-9BF6-916894790EED@holtmann.org>
 <CABBYNZKbc71WvOA34cFcKXVRcG-hYedJBT5LeTK9c3+H5Trjwg@mail.gmail.com> <CALWDO_VNPFJm+je4N1u1bW=+n8WTCoe+xwzrOo=UZi4ymuwdsg@mail.gmail.com>
In-Reply-To: <CALWDO_VNPFJm+je4N1u1bW=+n8WTCoe+xwzrOo=UZi4ymuwdsg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 Mar 2020 10:12:15 -0700
Message-ID: <CABBYNZLCShMEVT0o0f89HK_8HhfnBaqEWt=Q82NNGWhPT9j5bQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH 0/2] HID and HOGP connections from non-bonded devices.
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Tue, Mar 10, 2020 at 5:30 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> Hi Luiz,
>
> On Tue, Mar 10, 2020 at 2:27 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Marcel,
> >
> > On Mon, Mar 9, 2020 at 10:26 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > >
> > > Hi Alain,
> > >
> > > > It was discovered that BlueZ's HID and HOGP profiles implementations
> > > > don't specifically require bonding between the device and the host.
> > > >
> > > > This creates an opportunity for an malicious device to connect to a
> > > > target host to either impersonate an existing HID device without
> > > > security or to cause an SDP or GATT service discovery to take place
> > > > which would allow HID reports to be injected to the input subsystem from
> > > > a non-bonded source.
> > > >
> > > > This patch series addresses the issue by ensuring that only connections
> > > > from devices that are bonded are accepted by the HID and HOGP profile
> > > > implementation.
> > > >
> > > > More information about the vulnerability is available here:
> > > > https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00352.html
> > > >
> > > > Alain Michaud (2):
> > > >  HOGP must only accept data from bonded devices.
> > > >  HID accepts bonded device connections only.
> > > >
> > > > profiles/input/device.c   | 23 ++++++++++++++++++++++-
> > > > profiles/input/device.h   |  1 +
> > > > profiles/input/hog.c      |  4 ++++
> > > > profiles/input/input.conf |  8 ++++++++
> > > > profiles/input/manager.c  | 13 ++++++++++++-
> > > > 5 files changed, 47 insertions(+), 2 deletions(-)
> > >
> > > both patches have been applied.
> > >
> > > However I changed BrBondedOnly configuration name into ClassicBondedOnly since that name seemed more obvious to me. The prefix Br has never been used and the Bluetooth SIG started calling it Classic a while back.
> >
> > Looks like you were quicker than me, anyway I do fill like we should
> > attempt to bump to security instead of just refuse to connection in
> > case of HoG since we are the central and the peripheral is not
> > mandated to started it either it may be just the client application is
> > attempting to connect to trigger pairing on demand, that would usually
> > kick latter when reading the characteristics but with this changes it
> > doesn't even get to that point if the devices was not bonded already.
> The specification for HoG is that the device is bonded.  If client or
> server attempts to access the service before it is bonded, it would
> violate the specification.  For this reason, I believe it is both
> safer and simpler to just reject any attempts to access the service
> without first being bonded.

Ive sent a patch for it, we would not be accessing anything while the
security is being bump as the kernel would block that, so in practice
this would just initiate the pairing procedure if the device is not
bonded .


-- 
Luiz Augusto von Dentz
