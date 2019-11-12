Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A5CC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 08:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B8021925
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 08:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfKLIOx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:14:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38485 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLIOx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 03:14:53 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id DC7BACECE9;
        Tue, 12 Nov 2019 09:23:56 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: RFC: Managing devices around system suspend in bluez
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mXFp-5PooVVLwbBqFSzMXomf4y+5jgwPUW9b+Br1jyDmg@mail.gmail.com>
Date:   Tue, 12 Nov 2019 09:14:51 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Yoni Shavit <yshavit@chromium.org>, alainmichaud@google.com,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CBD08E55-C103-49E2-85DF-87297216DAE8@holtmann.org>
References: <CANFp7mVOh5KPYPPnbGO_YnV-mBGTV3gYgWcPNSMq+=aBzBM00Q@mail.gmail.com>
 <12B499CA-FAC4-459D-B75C-1CEE801406BA@holtmann.org>
 <CANFp7mXFp-5PooVVLwbBqFSzMXomf4y+5jgwPUW9b+Br1jyDmg@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

>>> On ChromeOS, we are currently trying to design how bluez should behave
>>> during system suspend. This is motivated by the fact that bluetooth
>>> can be a noisy source of wakeups on a system and historically has been
>>> noisy on ChromeOS.
>>> 
>>> Here are some problems we've seen:
>>> - If the system suspends while discovery is active, advertisements
>>> will continue arriving on the host and will wake the system
>> 
>> it is indeed a bad idea to run an active scan without whitelist when we are going to suspend.
>> 
>>> - Pairing a LE keyboard/mouse and disconnecting it (via link loss)
>>> results in a passive scan of all advertisements (and these will wake
>>> the host)
>> 
>> This one I do not get, the passive scan should always be using the whitelist.
> 
> This one is related to IRK resolution. In the existing kernel code
> when configuring the le passive scan, if there are any addresses in
> the whitelist which also have an IRK stored, the whitelist filter
> policy is 0.

you might be right here since the patches for LL Privacy are taking a while to get into good shape to be merged.

I wonder now if the Add Device action 1 which meant incoming connections only is working correctly (or we use it correctly). For LE that meant Directed Advertising and for that there is a special mode to use the whitelist and only forward PRAs for resolution to the host. It needs a controller with support for that. But I need to go back and check that this is not accidentally broken.

>>> To resolve this, we propose adding a SuspendImminent and SuspendDone
>>> dbus api to inform bluez that suspend is about to occur and the system
>>> has resumed.
>>> (These names are based off the ChromeOS Power Manager's existing
>>> design: https://chromium.googlesource.com/chromiumos/platform2/+/master/power_manager/docs/suspend_resume.md)
>> 
>> An interesting question is really if we need this around the corner path or if it would be done better directly from the kernel to bluetoothd via mgmt socket. So lets explore if we can make this work in a totally generic way that benefits all Linux distros.
> 
> Yes, we could let the kernel inform bluetooth that suspend is about to
> occur (maybe via PM_SUSPEND_PREPARE) and wait for bluez to finish the
> suspend tasks before continuing. We could probably do this via event
> pairs of SUSPEND_PREPARE/SUSPEND_PREPARE_DONE and
> RESUME_PREPARE/RESUME_PREPARE_DONE.

Lets try to integrate PM_SUSPEND_PREPARE into the Bluetooth core. Then we see if we need to inform bluetoothd via mgmt at all about this change or if we can just handle things accordingly. We can then see what bluetoothd needs extra to handle resuming discovery gracefully.

>>> In the suspend imminent handler, we would do the following in order:
>>> * Pause any discovery
>>> * Set an event filter for all paired devices capable of waking the
>>> system (anything that creates uhid or uinput virtual devices)
>>> * Disconnect all connected devices (with a soft disconnect)
>>> * Enable background scan with whitelist of devices that should be able
>>> to wake the system (** see below for comments about IRK resolution)
>> 
>> I agree that when a system is going to suspend, we should disable any active scanning without whitelist. If we want to differentiate between device allowed to wake us up and device that don’t, then we need to create that list first. Right now we don’t really do that. And I think we don’t have an easy way to tell the kernel via mgmt what this list will be.
> 
> We will want to introduce a new mgmt op or update an existing op to
> set a wake capable bit for the device. MGMT_OP_SET_CONN_PARAMS might
> be a good candidate to update with this info.
> As for how bluez holds this information, I think we mark all devices
> that create uhid or uinput as wake capable and then disable them if we
> don't want them to wake us up. Maybe a "WakeSource" property in the
> device properties?

I was thinking to either add action 3 to Add Device which means the same as action 1, but allow wakeup. Or we are adding an Add Extended Device that we give a flags parameter for specifying a flag. I would not do that with the connection parameters command since the flow is a bit different there.

Initially I would just enable it for HID devices only and then see how that works. If we need to expose this via D-Bus, then we do that once we have the kernel bits working correctly and tested.

>>> In the suspend done handler, we would do the following in order:
>>> * Clear the event filter
>>> * Enable background scan with non-suspend logic (** see below for
>>> comments about IRK resolution)
>>> * Unpause discovery (if it was running before suspend)
>> 
>> We need to define what discovery is. My understand is that discovery is always user triggered way of actively finding a specific device around you. In most cases because you want to pair with it. The way how mgmt works is that we discovery only for a period of time. And bluetoothd turns it into a continuous discovery as long as a specific UI portion is open and requesting it. Unless discovery has a different meaning, then a simple restart is enough.
> 
> The use-case I'm thinking of is the user has the scanning window open
> and then closes the lid of their laptop. Right before suspend, they
> were Discovering but in order to suspend, we need to stop. I think
> maybe pause and unpause are ambiguous; it is actually just stop
> discovery and start discovery.

As mentioned above, lets figure this out when the core bits are working. We do have to abort an ongoing inquiry and active scan for sure.

>>> We expect this will result in the following:
>>> * Classic: A paired device can wake the host if it's in the event filter
>>> * LE: A paired device can wake the host if it's in the whitelist and
>>> it sends an advertisement (undirected if in the whitelist, directed if
>>> targeting our host; i.e. filter_policy = 0x1 or 0x3)
>> 
>> Do we need this for classic? I agree that we should abort the inquiry procedure if one is active, but do we really want to deal with the event filter? It is one of these old Bluetooth 1.0b concepts in HCI that are not as well defined as others since you have no idea what the controllers supports and how many devices they support.
> 
> Yes, I think we do. While we could initially leave this out, if we
> wanted policy based wakeup control, we would need this.

If you are using Add Device and leave connectable=false, then when adding a BR/EDR it will become connectable for you. So we change the API to allow the global connectable to stay off and if only a device is added via Add Device, we will enable connectable. Since for BR/EDR we use Add Device only for HID devices, the list of HID devices that you want as wakeup source are automatically in here.

That said, I have no objections with using the event filter for BR/EDR. I just have the feeling it is not as urgent as with LE.

>>> Do you think the actions taken in the suspend handlers are sufficient?
>>> Any concerns or things to look out for?
>> 
>> I would try to handle this inside the kernel and only add some extra notifications to mgmt so that bluetoothd can be told that we are suspended right now.
> 
> I think when we upstream this, we would want to do it this way
> (especially because I don't think there's a userspace power manager
> that's common across distros). I will look into using the PM notifiers
> further.

Awesome. Feel free to send RFC that we can give a spin.

Regards

Marcel

