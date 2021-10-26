Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C405AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 08:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF46B60F90
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 08:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhJZIgU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 04:36:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56624 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhJZIgT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 04:36:19 -0400
Received: from smtpclient.apple (p5b3d2be1.dip0.t-ipconnect.de [91.61.43.225])
        by mail.holtmann.org (Postfix) with ESMTPSA id 497D7CED2C;
        Tue, 26 Oct 2021 10:33:54 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [BlueZ PATCH v4 1/3] doc: Introduce the Adv Monitor Device
 Found/Lost events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGPPCLBNN+Eg92=GnmbMBfngLEb=BL6sSkx7O19rYOydAkO8HA@mail.gmail.com>
Date:   Tue, 26 Oct 2021 10:33:53 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BACB0D21-AB8E-47F2-8CAC-B5E574B8A85C@holtmann.org>
References: <20211025191811.3575708-1-mmandlik@google.com>
 <20211025121343.BlueZ.v4.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
 <577458A3-49B9-416B-A35B-58F174CC88F8@holtmann.org>
 <CAGPPCLBNN+Eg92=GnmbMBfngLEb=BL6sSkx7O19rYOydAkO8HA@mail.gmail.com>
To:     Manish Mandlik <mmandlik@google.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

> > 
> > Example
> > @@ -4910,3 +4911,50 @@ Controller Resume Event
> >       Address_Type. Otherwise, Address and Address_Type will both be zero.
> > 
> >       This event will be sent to all management sockets.
> > +
> > +
> > +Advertisement Monitor Device Found Event
> > +========================================
> > +
> > +     Event code:             0x002f
> > +     Controller Index:       <controller_id>
> > +     Event Parameters:       Monitor_Handle (2 Octets)
> > +                             Address (6 Octets)
> > +                             Address_Type (1 Octet)
> > +
> > +     This event indicates that the controller has started tracking a device
> > +     matching an Advertisement Monitor with handle Monitor_Handle.
> > +
> > +     The address of the device being tracked will be shared in Address and
> > +     Address_Type.
> > +
> > +     Possible values for the Address_Type parameter:
> > +             0       Reserved (not in use)
> > +             1       LE Public
> > +             2       LE Random
> > +
> > +     This event will be sent to all management sockets.
> 
> My initial thought was actually to include all the fields from Device Found Event here as well. So that in case we are using advertising monitor, we just need to worry about this event only. Thoughts?
> The controller sends advertising reports in addition to the MSFT_Monitor_Device event. This event is reported only twice per bt-device (at start and at end of the monitoring); and it includes only the device addr and addr type [1]. To include other fields from the Device Found event, we need to buffer MSFT_Monitor_Device in the kernel and wait for the subsequent advertising report before we can send it to the bluetoothd. I feel this will unnecessarily complicate the logic in the kernel.
> 
> This event will be used to invoke DeviceFound/Lost on the interface only when we are completely offloading monitoring to the controller (i.e. when the Sampling_Period is set to 0xFF). When the Sampling_Period is set to 0xFF, the controller sends only one advertisement report per monitoring period [2]. So, we need to rely on the MSFT_Monitor_Device controller event for RSSI and timeouts tracking. In other cases, as the bluetoothd receives more than one advertisement report, it can perform RSSI and timeouts tracking.
> 
> So, I think it is better to pass on this event as it is to the bluetoothd and let the advertisement monitoring in the bluetoothd handle it. Let me know what you think about this?

the kernel has to buffer events related to advertising reports and inquiry results already anyway. That is just the cost of business and it is the job of the kernel to do exactly that.

I do not want to dumb down the kernel into a vendor extension passthrough since that is always going to come back and bite you. My current thinking is actually that unless Start Discovery triggers a discovery procedure, device that are monitored, should get its own report out path via mgmt.

So the kernel would send Advertising Monitor Device Found Event (most likely with a flag for tracking started) and subsequence events of the same type whenever it gets updated. I mean, the kernel should track the state when a device is tracked anyway. It has to keep track of these things. In case of power down or reset or anything, the kernel needs to generate the Device Lost event to keeps this all in sync. Otherwise userspace is left to figure out what happens. We can not have that. This is similar to when a process dies, the kernel cleans up all open file descriptors. That is the basic paradigm that we have enforced with mgmt. If bluetoothd dies or restarts, we can get back to a state where we now all the details without having to hard reset hardware.

One way to lock at this is always from the point of something that is not bluetoothd. Any other user of mgmt API needs to be sound and have a good API contract as well. Kernel APIs that are only designed with one daemon in mind are awful and cause major problems along the road.

That all said, we can do this as above, but I would explore the option of doing it with my proposal and really focus on completely offload of the monitoring the controller.

Regards

Marcel

