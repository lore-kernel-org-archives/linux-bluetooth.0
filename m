Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A223C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 22:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B3221739
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 22:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dYYFW0Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgA1WGz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:06:55 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42288 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgA1WGz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 17:06:55 -0500
Received: by mail-vs1-f67.google.com with SMTP id b79so9162598vsd.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2020 14:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xt3c1Dw8yio/KFCJDkLfGcy91s3+5OniZirpgiKi4No=;
        b=dYYFW0Te7qImBnAleaLBQdseLmEDcWRephqG4xXV4EfGGeXPhyqVhNu1GMmx0uYSLf
         AaGUnsXa6FY2Mim3p8ijenjHnfKpkkc3CXcjgtJnwlhWiNi6PTV00MuduY/2TApEUipK
         1l6f3qzVLVOjEPI8g27Bx1R4cDmQYe2HpLIUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xt3c1Dw8yio/KFCJDkLfGcy91s3+5OniZirpgiKi4No=;
        b=d7YFLVlQlsePZ85cn+YgxsjZBQC/kExxX0+vtLm01TD3pUR4JK6x9wNwzBtBww0xVT
         /E8WKEbC7IyCzDCOpPx7YvRr3Bh+qI1Cdw+LcAM3todUzX2QmX+wNMJ9gqIsQc+B/pVy
         k2a2EQ4aNJXwDheA1QEV8mQXvKu/s++Vhpnry2TgqSCFwTfqfoXpQ4vvOlzqteoVg0Hz
         +ldnatQ7lAMXa6NAVsVQIHh6fXN+Q0YJHltbDfv4y7tr8wFC1qkzPLmgUa2eeEDVg1I4
         O6YXq4ajcS4gWM6XhSF0wjnk8WTjC3yJS1CHQISPKG+w+1SmYzC86lvzkNYZXy+DUduE
         ZoJA==
X-Gm-Message-State: APjAAAVsXKtzsRtt5tdzEvU4ACdAa3EVkZDXUNksAeSL/k1zv6R4Zng/
        SwopBDXR5esPnXbUEXH9YEofPTIgh48JOHVs/1NNag==
X-Google-Smtp-Source: APXvYqzamTruy4Iaeq7HvNs0UDfEv81bfg5sX+n4HW3c5MtTeqt3/oMdDKusB5fxgCOKnBmu2njHjTzLbjvSnoGSUq4=
X-Received: by 2002:a67:fc8c:: with SMTP id x12mr14799022vsp.96.1580249213890;
 Tue, 28 Jan 2020 14:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20200128020505.239349-1-abhishekpandit@chromium.org> <CABBYNZ+fRVSBxbX-3D-WxK=Z4TxnkHbWMPusv+owrRAsKdEOkw@mail.gmail.com>
In-Reply-To: <CABBYNZ+fRVSBxbX-3D-WxK=Z4TxnkHbWMPusv+owrRAsKdEOkw@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 28 Jan 2020 14:06:43 -0800
Message-ID: <CANFp7mX6ixWpA5Oqgsg8+z0wx4MRr0+7ib_ez-cXv4BNJV9Lcg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 0/5] device: Allow devices to be marked as wake capable
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

It has not yet been merged in the kernel so please avoid merging for
the time being.

We also need to discuss what the management API for setting the wake
capable needs to be called as well (I think we want to create a
generic Set Device Params sort of management api).

Abhishek

On Tue, Jan 28, 2020 at 12:31 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Mon, Jan 27, 2020 at 6:05 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> >
> > Hi bluez maintainers,
> >
> > This change accompanies changes in the kernel to mark HID devices as
> > wake capable so they can wake the system from suspend. The
> > implementation depends on the Set Wake Capable management operation. It
> > is currently a separate management operation but it may be added as an
> > extension to an exiting operand like add_device (need some feedback
> > regarding this).
> >
> > Per request on the last patch, I've moved docs/mgmt-api.txt into its own
> > patch so we can continue discussions on it.
> >
> > This change was tested with appropriate kernel changes on v4.19
> > (verified that HID devices were being marked as wake capable in the
> > kernel).
> >
> > Thanks
> > Abhishek
> >
> > Changes in v3:
> > * Added profile_wake_support and made wake_capable dependent on it
> > * Added documentation for WakeCapable
> > * Mark HID device to support wake from suspend
> >
> > Changes in v2:
> > * Separated docs/mgmt-api.txt into its own patch
> > * Added dbus api "WakeCapable" to set value
> > * Update device_set_wake_capable to be called by
> >   adapter_set_wake_capable_complete so we can emit property changed
> > * Newly added to show whether device is wake capable
> > * Removed automatically setting wake capable for HID devices
> >
> > Abhishek Pandit-Subedi (5):
> >   mgmt: Add docs for Set Wake Capable
> >   device: Allow device to be marked as wake capable
> >   client: Display wake capable property with info
> >   doc/device-api: Add WakeCapable
> >   input: Make HID devices wake capable
> >
> >  client/main.c           |   1 +
> >  doc/device-api.txt      |   5 ++
> >  doc/mgmt-api.txt        |  19 +++++++
> >  lib/mgmt.h              |   9 ++++
> >  profiles/input/device.c |   1 +
> >  profiles/input/hog.c    |   1 +
> >  src/adapter.c           |  65 ++++++++++++++++++++++
> >  src/adapter.h           |   2 +
> >  src/device.c            | 116 ++++++++++++++++++++++++++++++++++++++++
> >  src/device.h            |   5 ++
> >  10 files changed, 224 insertions(+)
> >
> > --
> > 2.25.0.341.g760bfbb309-goog
>
> Other than the small comments I had this set is quite good, does the
> kernel support has already been merged?
>
> --
> Luiz Augusto von Dentz
