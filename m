Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4060CC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 06:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB0E2464B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 06:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAHVLs2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgCJG12 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:27:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43275 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgCJG12 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 02:27:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id a6so4203017otb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2020 23:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MymHMIPjwA8vlfgP3l2VtEZj5oz3aMUkf3EFgYY7H0=;
        b=NAHVLs2fpOAhrOmaF2NqxxZpHCrSI6UPv8nm/FNFr2qvbO6RAp7LRiD+3hpQYduLcj
         siKlMb2dwcKCWLeFcvwYkWQq00QcftKDWD4Rmz1dsu72Pd5JPuflM7lkATIN3BBlLK/z
         77CxZM4Gk88VcrQldbGuF0otjR3VXMkMjlKFhMz2lXACKOHHgnkTCinANfVBPFKO4yj9
         PpFrLUkU6NYqD01mgc9u9++6A0o7E2bdiJqoe9Vyy++NAPx7nbdL7E08e0GlxPXseqD1
         pyID+n99ZiCGRgKaD+B9E3v3s7BeZ22volQh434a7c+pmajJhPSfEEdWae0A2i5J8taa
         NCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MymHMIPjwA8vlfgP3l2VtEZj5oz3aMUkf3EFgYY7H0=;
        b=e+YV9vBXZ0mCaBXgeovt/1KVf1N2LHtOtPlwLNv8os1QUMkFcedaIGeZ1PGYESP88f
         OgTTLAj3HYOm4SzFLrhuZ/OYRWXwKz0YcS0pH6vIc36DUL12vqxzHC7riw48PXRNTh2K
         fxMPkS/Ldu3rVg7h0rSWxVnYDu+BylrFRAvu37cZ1iAnSGDOAl91S++hwm+BqliyH5BT
         0Z/YJ8GXDw5U6qAn8VFfSurFezzMCUECjlRyopb+yamBkQF3ggM3pFH/cYqEBarx17lh
         us+HagimdLAz1ZMyBt08WCBBBxz2VwXp40GNKc0IJUXaE5wQ6eZPh6vsgsVBibnjOMqc
         fGGA==
X-Gm-Message-State: ANhLgQ2ndGclcnaMd+YMb0XuW09NhniQCOHeNeE6MCWOgn2Upttj5rKw
        MAinutKENxxjBxiqGciEXRM/q6dcaRLtIjQycgf15NXu
X-Google-Smtp-Source: ADFU+vvDP2IXtnvatr1Nyn67Y6WbaNxDMKR49aIVtQ15uLaDnpUTQnxGaPwYF0gMrh/vjDFV9+5gWsyQiMwESL+ipYU=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr11208129oth.11.1583821647433;
 Mon, 09 Mar 2020 23:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200310023516.209146-1-alainm@chromium.org> <87A4E633-63CF-4C71-9BF6-916894790EED@holtmann.org>
In-Reply-To: <87A4E633-63CF-4C71-9BF6-916894790EED@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 9 Mar 2020 23:27:15 -0700
Message-ID: <CABBYNZKbc71WvOA34cFcKXVRcG-hYedJBT5LeTK9c3+H5Trjwg@mail.gmail.com>
Subject: Re: [BlueZ PATCH 0/2] HID and HOGP connections from non-bonded devices.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Mar 9, 2020 at 10:26 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > It was discovered that BlueZ's HID and HOGP profiles implementations
> > don't specifically require bonding between the device and the host.
> >
> > This creates an opportunity for an malicious device to connect to a
> > target host to either impersonate an existing HID device without
> > security or to cause an SDP or GATT service discovery to take place
> > which would allow HID reports to be injected to the input subsystem from
> > a non-bonded source.
> >
> > This patch series addresses the issue by ensuring that only connections
> > from devices that are bonded are accepted by the HID and HOGP profile
> > implementation.
> >
> > More information about the vulnerability is available here:
> > https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00352.html
> >
> > Alain Michaud (2):
> >  HOGP must only accept data from bonded devices.
> >  HID accepts bonded device connections only.
> >
> > profiles/input/device.c   | 23 ++++++++++++++++++++++-
> > profiles/input/device.h   |  1 +
> > profiles/input/hog.c      |  4 ++++
> > profiles/input/input.conf |  8 ++++++++
> > profiles/input/manager.c  | 13 ++++++++++++-
> > 5 files changed, 47 insertions(+), 2 deletions(-)
>
> both patches have been applied.
>
> However I changed BrBondedOnly configuration name into ClassicBondedOnly since that name seemed more obvious to me. The prefix Br has never been used and the Bluetooth SIG started calling it Classic a while back.

Looks like you were quicker than me, anyway I do fill like we should
attempt to bump to security instead of just refuse to connection in
case of HoG since we are the central and the peripheral is not
mandated to started it either it may be just the client application is
attempting to connect to trigger pairing on demand, that would usually
kick latter when reading the characteristics but with this changes it
doesn't even get to that point if the devices was not bonded already.

-- 
Luiz Augusto von Dentz
