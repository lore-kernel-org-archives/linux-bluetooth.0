Return-Path: <SRS0=3vvc=RY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE5BC43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 09:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7763218A2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 09:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="SoN5C+dX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfCUJYF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:24:05 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:24604 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfCUJYE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Mar 2019 05:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1553160237;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=omp4mnoWvSPTJqOxHxlRqglJq5RxWVCAt3GJLM7VnnQ=;
        b=SoN5C+dX9teZ21qAc0/GFQphAeYq/CmrH4s+WQ19+ucNqkjB9V3HnFMi1mzxgdpy01
        twORvfzudh4i8pPt4BPMn2VjeJJlCOLLVFlQyZJjbmcas9Q5V8LhzURPQwLK5d7YlYBE
        dWWp5FKA4dwO8GZIHZtM/tfQpfT0GfdeqtHtQMd0XyVBITBAzYMeQLoHr+UiXokZgPQb
        XzQnsJfTslJO8TZ93t0wBO7hKZ6YYrfvShlkefQO1RoYgXlPeYa2kkwYaheoeXTqqEOU
        q7iYeal50fUY8Po5JFyLol7OFdKUNKDBulLmhauEcWt9lsdKd8LzVlHltijN4+wXc7Bw
        XJvg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8f+IczEa4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.16 DYNA|AUTH)
        with ESMTPSA id k0bbe4v2L9NvVui
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Mar 2019 10:23:57 +0100 (CET)
Date:   Thu, 21 Mar 2019 10:23:47 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Ferry Toth <ftoth@exalondelft.nl>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/2] Bluetooth: btbcm: Add default address for BCM2076B1
Message-ID: <20190321092347.GA921@gerhold.net>
References: <20190305130901.56660-1-stephan@gerhold.net>
 <20190305130901.56660-2-stephan@gerhold.net>
 <7b48753f-f103-f522-68c5-38479feb4552@exalondelft.nl>
 <20190319140356.GA1076@gerhold.net>
 <0898b45c-b59a-0873-d8fc-1755e5c5e23b@exalondelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0898b45c-b59a-0873-d8fc-1755e5c5e23b@exalondelft.nl>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Mar 20, 2019 at 10:11:45PM +0100, Ferry Toth wrote:
> 
> Op 19-03-19 om 15:03 schreef Stephan Gerhold:
> > Hi,
> > 
> > Sorry for the late response. I've been quite busy lately...
> Thanks for responding anyway!
> > 
> > On Tue, Mar 05, 2019 at 07:26:14PM +0100, Ferry Toth wrote:
> > > Op 05-03-19 om 14:09 schreef Stephan Gerhold:
> > > > BCM2076B1 appears to use 20:76:A0:00:56:79 as default address.
> > > > This address is used by at least 5 devices with the AMPAK AP6476
> > > > module and is also suspicious because it starts with the chip name
> > > > 2076 (followed by a different revision A0 for some reason).
> > > With BCM43340 (Edison) it's the same principle. With the fake address I
> > > found everything (in user space) seems to work except PAN/NAP (bnep) and no
> > > decent error message anywhere making this quite hard to debug.
> > Not familiar with PAN/NAP, but the main reason to avoid default
> > addresses is that they will cause issues as soon as you have two of
> > those devices next to each other.
> 
> That might be the main issue with other services, but if you have only a
> single device you won't see this.
> 

Well, the other obvious thing is that it goes against the BT 
specification if you use an address that is not unique. :)

But you are right, I've also been using the default address for more 
than a year, simply because I wasn't aware that the BT controller does 
not have a proper BT device address. I did not run into any problems.

> With PAN/NAP I found bnep network device is created and immediately removed,
> which confuses connman and give no other message than 'I/O error'. Even with
> only one device.
> 
> > > > Add it to the list of default addresses and leave it up to the
> > > > user to configure a valid one.
> > > Which way is the user supposed to configure the valid one?
> > > 
> > It took me a while to figure this out - there is not much
> > documentation for this. The following is only based on my own
> > investigations:
> > 
> > As far as the kernel is concerned, HCI_QUIRK_INVALID_BDADDR is exposed
> > through the btmgmt API [1]. With the quirk, the BT controller will
> > appear as "unconfigured" controller to userspace, and will have the
> > public address as missing option. As soon as the address is configured
> > with the "Set Public Address Command", the unconfigured controller is
> > removed and replaced with a regular controller.
> >    Only then it will be usable through bluetoothd.
> Yes, Andy Shevchenko already discovered we are missing to put the device on
> the blacklist. I was all ready worried I would get a unconfigured
> controller. Now I see, that is a good thing. Thanks, this is really useful.
> > The btmgmt API has to be controlled from user space.
> > As far as I know, the only tool in bluez to set the public address
> > is the "btmgmt" tool:
> > 
> >    btmgmt -i hci0 public-addr xx:xx:xx:xx:xx:xx
> > 
> > ... will run the "Set Public Address Command" described above.
> Especially in combination with this. I will be documenting this for Edison,
> so hopefully other can benefit.
> > However, it was mentioned several times that "btmgmt" is not
> > a "stable" tool. In other words, it is not installed by default
> > and is only intended for debugging. It may change any time.
> > 
> > There was a related discussion on IRC recently: (I was not involved)
> > 
> >    10:50 <Mis012[m]> sjanc: do I need to convince my distro to package
> >          btmgmt, or will you revert that commit?
> >    10:51 <sjanc> Mis012[m]: I'd ask holtmann about this :) but btmgmt
> >          was more like testing tool than real end user tool
> >          (ie, no manpages, rather ad-hoc design and command set etc
> >    10:53 <sjanc> Mis012[m]: but if you really need this feature,
> >          I'd consider starting discussion on mailing list
> >          on how this could be handled by bluetoothd
> >    10:53 <sjanc> as mentioned, this could be in plugin,
> >          either common plugin or maybe platform specific,
> >          which would set public address via mgmt api
> >    10:54 <sjanc> open point is how bluetootd would extract public address,
> >          which is always platform specific
> >    10:55 <holtmann> Mis012[m]: btmgmt is not a stable tool.
> >    10:55 <Mis012[m]> holtmann: but it's the only one which can do this
> >    10:56 <holtmann> Then add support to bluetoothd for it or do it via an
> >          external tool / daemon. I wrote a long post to the mailing list
> >          about that.
> > 
> > I have such an external daemon for Android (since it does not use bluez)
> > at [2]. It would be easy to refactor it to something more portable.
> Do I understand correct: support needs to go into bluetoothd first and then
> into bluetoothctl?

I'm not very familiar with the bluez code base to be honest.
As far as I know, bluetoothctl only controls bluetoothd, so this sounds 
correct. The way such a feature would be exposed (command line tool,
configuration option, ...) would need to be discussed further on the 
mailing list first.

> > 
> > [1]: https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt
> > [2]: https://github.com/me176c-dev/android_device_asus_K013/blob/lineage-16.0/bluetooth/bdaddr.c
> > 
> > > The only way I found is bd_addr (tool from bluez that is not normally
> > > built/installed).
> > > 
> > > Using this tool requires hci0 to be up and bluetoothd to be restarted if
> > > that was already running, which is quite inconvenient.
> > > 
> > bdaddr does not use the btmgmt API. It sends vendor-specific commands to
> > the HCI interface. This might be the reason why you need to restart
> > bluetoothd.
> I see.
> > 
> > With HCI_QUIRK_INVALID_BDADDR set, the BT controller should not show up
> > at all in bluetoothctl until its public address is configured.
> > It does not matter if bluetoothd is started too early.
> > 
> > > I also saw there was a patch to put the address in dt.
> > > 
> > > But nowhere did I find a kernel parameter to pass the address. Did I miss
> > > something?
> > > 
> > I'm not familiar with setting the address from DT/kernel parameters.
> > Sorry :(
> To me sounds like reading from a configuration file on disk would make more
> sense.

On my device, the real WiFi/BT address resides on an extra partition 
with a device-specific file system layout, so a configuration file
would not really help me personally.

A simple option that would make BT work out of the box for all devices 
with this quirk would be to generate a random MAC address once,
and then keep using it across reboots.
But I'm not sure if such a feature would be accepted for bluez.
