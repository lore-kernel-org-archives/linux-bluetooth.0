Return-Path: <SRS0=54w9=ZB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B3DC17440
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Nov 2019 02:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68D4214DA
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Nov 2019 02:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfKICYv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Nov 2019 21:24:51 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45066 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfKICYv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Nov 2019 21:24:51 -0500
Received: from marcel-macbook.fritz.box (p4FD19401.dip0.t-ipconnect.de [79.209.148.1])
        by mail.holtmann.org (Postfix) with ESMTPSA id 01686CED20;
        Sat,  9 Nov 2019 03:33:53 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: RFC: Managing devices around system suspend in bluez
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mVOh5KPYPPnbGO_YnV-mBGTV3gYgWcPNSMq+=aBzBM00Q@mail.gmail.com>
Date:   Sat, 9 Nov 2019 03:24:49 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Yoni Shavit <yshavit@chromium.org>, alainmichaud@google.com,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <12B499CA-FAC4-459D-B75C-1CEE801406BA@holtmann.org>
References: <CANFp7mVOh5KPYPPnbGO_YnV-mBGTV3gYgWcPNSMq+=aBzBM00Q@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> On ChromeOS, we are currently trying to design how bluez should behave
> during system suspend. This is motivated by the fact that bluetooth
> can be a noisy source of wakeups on a system and historically has been
> noisy on ChromeOS.
> 
> Here are some problems we've seen:
> - If the system suspends while discovery is active, advertisements
> will continue arriving on the host and will wake the system

it is indeed a bad idea to run an active scan without whitelist when we are going to suspend.

> - Pairing a LE keyboard/mouse and disconnecting it (via link loss)
> results in a passive scan of all advertisements (and these will wake
> the host)

This one I do not get, the passive scan should always be using the whitelist.

> To resolve this, we propose adding a SuspendImminent and SuspendDone
> dbus api to inform bluez that suspend is about to occur and the system
> has resumed.
> (These names are based off the ChromeOS Power Manager's existing
> design: https://chromium.googlesource.com/chromiumos/platform2/+/master/power_manager/docs/suspend_resume.md)

An interesting question is really if we need this around the corner path or if it would be done better directly from the kernel to bluetoothd via mgmt socket. So lets explore if we can make this work in a totally generic way that benefits all Linux distros.

> In the suspend imminent handler, we would do the following in order:
> * Pause any discovery
> * Set an event filter for all paired devices capable of waking the
> system (anything that creates uhid or uinput virtual devices)
> * Disconnect all connected devices (with a soft disconnect)
> * Enable background scan with whitelist of devices that should be able
> to wake the system (** see below for comments about IRK resolution)

I agree that when a system is going to suspend, we should disable any active scanning without whitelist. If we want to differentiate between device allowed to wake us up and device that don’t, then we need to create that list first. Right now we don’t really do that. And I think we don’t have an easy way to tell the kernel via mgmt what this list will be.

> In the suspend done handler, we would do the following in order:
> * Clear the event filter
> * Enable background scan with non-suspend logic (** see below for
> comments about IRK resolution)
> * Unpause discovery (if it was running before suspend)

We need to define what discovery is. My understand is that discovery is always user triggered way of actively finding a specific device around you. In most cases because you want to pair with it. The way how mgmt works is that we discovery only for a period of time. And bluetoothd turns it into a continuous discovery as long as a specific UI portion is open and requesting it. Unless discovery has a different meaning, then a simple restart is enough.

> We expect this will result in the following:
> * Classic: A paired device can wake the host if it's in the event filter
> * LE: A paired device can wake the host if it's in the whitelist and
> it sends an advertisement (undirected if in the whitelist, directed if
> targeting our host; i.e. filter_policy = 0x1 or 0x3)

Do we need this for classic? I agree that we should abort the inquiry procedure if one is active, but do we really want to deal with the event filter? It is one of these old Bluetooth 1.0b concepts in HCI that are not as well defined as others since you have no idea what the controllers supports and how many devices they support.

> Do you think the actions taken in the suspend handlers are sufficient?
> Any concerns or things to look out for?

I would try to handle this inside the kernel and only add some extra notifications to mgmt so that bluetoothd can be told that we are suspended right now.

> Thanks
> Abhishek
> 
> IRK Resolution:
> With this design, we have some problems with IRK resolution on BT
> version < 4.2. Devices supporting BT Privacy 1.2 may start using
> resolvable private addresses for both initiator and destination.
> Without address resolution in the controller, we have to set the
> filter policy to 0 (allow all) so that we can do address resolution on
> the host.
> Implementing these privacy features are outside the scope of this RFC
> so we will disallow wake up from suspend for these devices (set filter
> policy to accept only whitelist and directed). Once bluez supports
> Privacy 1.2, wakeup from these devices will work on controllers with
> BT version >= 4.2.

It is either support for controller side IRK resolution or forwarding of unresolved directed advertising with RPA. The latter will cause wakeups, but it is limited to directed advertising and will be fine.

Regards

Marcel

