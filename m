Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463EFC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 01:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0570B21925
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 01:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZLq6fdut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKLBQu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:16:50 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]:44063 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKLBQu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Nov 2019 20:16:50 -0500
Received: by mail-qv1-f54.google.com with SMTP id d3so4135230qvs.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2019 17:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4iYnfWVj5ZEQygUTstm7B+MVGllqXR0MArXT4ervwGA=;
        b=ZLq6fdutQ8Hku/OtJ6X+lSgSE7F2nugdNItsUdgH6Pzbr5OB16RTWf+X0oLivzpHib
         TJnaEV1z6nJPY9GSgRtXzEdEn6UlhATuu9zYjzylHEy4ne9szecuzXvZWIa/YhXSuTPh
         Rd/3Drds476xwMztoQ4hdGzecuVOcOu/oxMis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4iYnfWVj5ZEQygUTstm7B+MVGllqXR0MArXT4ervwGA=;
        b=X3/oZioGoTotTQNWwGMx7t5+G5wf0dvZL2rH3IwMckrziAirD8pYLHBiTbfBIz+stZ
         DmXwrpIkx5M0gpmFfoeXO5J5bIV9Jdvou15sF8/O+psASkOW/5DzDn3C9LJNZTJCtZcn
         CBL9tR7pu/6481V55vz15z5mxAqlDPL2C2UDq6bl8MKYuvqOyklP8EVLugczxBkdMLtD
         5jTBPOgP9Kle8FQ1HagUFHxf1Wrnz3ArISIwDvXco/Coj1cVWD5qYreLWRD3RmPG0XA2
         dSeopj22o51/3+Fmv1TeUdQv6PNfBzTi8PzGUlQRTscsoDa2iSlk8nha4TViURgnK2q+
         5oiA==
X-Gm-Message-State: APjAAAXhKlGOJ+KWb/o+WdC9wmSCIMglMpwHvv4Mr8Razjjbktur164j
        qRu5aWhYh9ohyZ1ChSQvIYaomMto2GBa3jVvXLbtMg==
X-Google-Smtp-Source: APXvYqy7+u6oa3JLSdQO1c25j4X+Rc68H0054rZ7EUvVIskSIY55U5ReWaksoWstGpbYVZOvSkGGxKyp8jirCTMfkUE=
X-Received: by 2002:a0c:936e:: with SMTP id e43mr26363557qve.73.1573521408727;
 Mon, 11 Nov 2019 17:16:48 -0800 (PST)
MIME-Version: 1.0
References: <CANFp7mVOh5KPYPPnbGO_YnV-mBGTV3gYgWcPNSMq+=aBzBM00Q@mail.gmail.com>
 <12B499CA-FAC4-459D-B75C-1CEE801406BA@holtmann.org>
In-Reply-To: <12B499CA-FAC4-459D-B75C-1CEE801406BA@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 11 Nov 2019 17:16:37 -0800
Message-ID: <CANFp7mXFp-5PooVVLwbBqFSzMXomf4y+5jgwPUW9b+Br1jyDmg@mail.gmail.com>
Subject: Re: RFC: Managing devices around system suspend in bluez
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Yoni Shavit <yshavit@chromium.org>, alainmichaud@google.com,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Nov 8, 2019 at 6:24 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > On ChromeOS, we are currently trying to design how bluez should behave
> > during system suspend. This is motivated by the fact that bluetooth
> > can be a noisy source of wakeups on a system and historically has been
> > noisy on ChromeOS.
> >
> > Here are some problems we've seen:
> > - If the system suspends while discovery is active, advertisements
> > will continue arriving on the host and will wake the system
>
> it is indeed a bad idea to run an active scan without whitelist when we a=
re going to suspend.
>
> > - Pairing a LE keyboard/mouse and disconnecting it (via link loss)
> > results in a passive scan of all advertisements (and these will wake
> > the host)
>
> This one I do not get, the passive scan should always be using the whitel=
ist.

This one is related to IRK resolution. In the existing kernel code
when configuring the le passive scan, if there are any addresses in
the whitelist which also have an IRK stored, the whitelist filter
policy is 0.

>
> > To resolve this, we propose adding a SuspendImminent and SuspendDone
> > dbus api to inform bluez that suspend is about to occur and the system
> > has resumed.
> > (These names are based off the ChromeOS Power Manager's existing
> > design: https://chromium.googlesource.com/chromiumos/platform2/+/master=
/power_manager/docs/suspend_resume.md)
>
> An interesting question is really if we need this around the corner path =
or if it would be done better directly from the kernel to bluetoothd via mg=
mt socket. So lets explore if we can make this work in a totally generic wa=
y that benefits all Linux distros.

Yes, we could let the kernel inform bluetooth that suspend is about to
occur (maybe via PM_SUSPEND_PREPARE) and wait for bluez to finish the
suspend tasks before continuing. We could probably do this via event
pairs of SUSPEND_PREPARE/SUSPEND_PREPARE_DONE and
RESUME_PREPARE/RESUME_PREPARE_DONE.

>
> > In the suspend imminent handler, we would do the following in order:
> > * Pause any discovery
> > * Set an event filter for all paired devices capable of waking the
> > system (anything that creates uhid or uinput virtual devices)
> > * Disconnect all connected devices (with a soft disconnect)
> > * Enable background scan with whitelist of devices that should be able
> > to wake the system (** see below for comments about IRK resolution)
>
> I agree that when a system is going to suspend, we should disable any act=
ive scanning without whitelist. If we want to differentiate between device =
allowed to wake us up and device that don=E2=80=99t, then we need to create=
 that list first. Right now we don=E2=80=99t really do that. And I think we=
 don=E2=80=99t have an easy way to tell the kernel via mgmt what this list =
will be.

We will want to introduce a new mgmt op or update an existing op to
set a wake capable bit for the device. MGMT_OP_SET_CONN_PARAMS might
be a good candidate to update with this info.
As for how bluez holds this information, I think we mark all devices
that create uhid or uinput as wake capable and then disable them if we
don't want them to wake us up. Maybe a "WakeSource" property in the
device properties?

>
> > In the suspend done handler, we would do the following in order:
> > * Clear the event filter
> > * Enable background scan with non-suspend logic (** see below for
> > comments about IRK resolution)
> > * Unpause discovery (if it was running before suspend)
>
> We need to define what discovery is. My understand is that discovery is a=
lways user triggered way of actively finding a specific device around you. =
In most cases because you want to pair with it. The way how mgmt works is t=
hat we discovery only for a period of time. And bluetoothd turns it into a =
continuous discovery as long as a specific UI portion is open and requestin=
g it. Unless discovery has a different meaning, then a simple restart is en=
ough.

The use-case I'm thinking of is the user has the scanning window open
and then closes the lid of their laptop. Right before suspend, they
were Discovering but in order to suspend, we need to stop. I think
maybe pause and unpause are ambiguous; it is actually just stop
discovery and start discovery.

>
> > We expect this will result in the following:
> > * Classic: A paired device can wake the host if it's in the event filte=
r
> > * LE: A paired device can wake the host if it's in the whitelist and
> > it sends an advertisement (undirected if in the whitelist, directed if
> > targeting our host; i.e. filter_policy =3D 0x1 or 0x3)
>
> Do we need this for classic? I agree that we should abort the inquiry pro=
cedure if one is active, but do we really want to deal with the event filte=
r? It is one of these old Bluetooth 1.0b concepts in HCI that are not as we=
ll defined as others since you have no idea what the controllers supports a=
nd how many devices they support.

Yes, I think we do. While we could initially leave this out, if we
wanted policy based wakeup control, we would need this.

>
> > Do you think the actions taken in the suspend handlers are sufficient?
> > Any concerns or things to look out for?
>
> I would try to handle this inside the kernel and only add some extra noti=
fications to mgmt so that bluetoothd can be told that we are suspended righ=
t now.

I think when we upstream this, we would want to do it this way
(especially because I don't think there's a userspace power manager
that's common across distros). I will look into using the PM notifiers
further.

>
> > Thanks
> > Abhishek
> >
> > IRK Resolution:
> > With this design, we have some problems with IRK resolution on BT
> > version < 4.2. Devices supporting BT Privacy 1.2 may start using
> > resolvable private addresses for both initiator and destination.
> > Without address resolution in the controller, we have to set the
> > filter policy to 0 (allow all) so that we can do address resolution on
> > the host.
> > Implementing these privacy features are outside the scope of this RFC
> > so we will disallow wake up from suspend for these devices (set filter
> > policy to accept only whitelist and directed). Once bluez supports
> > Privacy 1.2, wakeup from these devices will work on controllers with
> > BT version >=3D 4.2.
>
> It is either support for controller side IRK resolution or forwarding of =
unresolved directed advertising with RPA. The latter will cause wakeups, bu=
t it is limited to directed advertising and will be fine.
>
> Regards
>
> Marcel
>
