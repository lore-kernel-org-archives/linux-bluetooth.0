Return-Path: <cyrus@holtmann.org>
Subject: Re: Getting link quality or RSSI
From: Marcel Holtmann <marcel@holtmann.org>
To: Davide Pesavento <davidepesa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTimrcSXZ-wTz7nmKCYtXjTEHY8FiPSiubRyfusxY@mail.gmail.com>
References: <AANLkTimA4dnDeoZVX1N4c=2sR1JkgAFWb4d0-0K+8S1C@mail.gmail.com>
	 <1280764595.12579.19.camel@localhost.localdomain>
	 <AANLkTimQeQ-XoM5yuWQYx5_1-xWf1H0ax_J=BbtDfG2T@mail.gmail.com>
	 <1280775482.12579.34.camel@localhost.localdomain>
	 <AANLkTimrcSXZ-wTz7nmKCYtXjTEHY8FiPSiubRyfusxY@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 15:09:49 -0700
Message-ID: <1280786989.12579.58.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Davide,

> >> >> I'm writing an application to retrieve the current link quality (or
> >> >> RSSI) between my laptop's Bluetooth adapter and a specific remote
> >> >> device (my mobile phone). In order to do that I'm of course using the
> >> >> latest version of BlueZ, but I've encountered several issues so far.
> >> >>
> >> >> The dbus API exposed by bluetoothd doesn't have any GetRSSI or
> >> >> GetLinkQuality methods. Would it be possible to export these methods
> >> >> in the public API?
> >> >
> >> > the link quality is vendor specific according to the specification and
> >> > the RSSI of an existing connection is rather useless. So we don't bother
> >> > to export those.
> >> >
> >>
> >> Does this mean you're going to reject a patch which adds those methods
> >> to the dbus API?
> >
> > constantly polling them via D-Bus, yes I would reject such a patch. To
> > make this proper you would need a kernel patch first that polls the RSSI
> > and/or link quality when a ACL is established and not in power saving
> > mode. Then you need to use this data to send async signals via D-Bus.
> >
> > I have done both, let me assure you that some chips don't provide proper
> > RSSI values. Then link quality is vendor specific and we can't do
> > anything real useful with it (except it is a CSR chip). So I have don't
> > the whole exercise and figured out that it is rather useless feature of
> > Bluetooth.
> >
> >> >> Then I looked at the bluetooth HCI library that comes with bluez.
> >> >> First of all, is there any reasons why it's totally undocumented?
> >> >> Anyway, I noticed hci_read_link_quality() and hci_read_rssi() in
> >> >> hci_lib.h and tried using them. Since they seem to require an
> >> >> established connection, I also used hci_create_connection(). However I
> >> >> soon discovered that creating a connection requires root privileges,
> >> >> is that right or did I do something wrong?
> >> >>
> >> >> Furthermore, even when running the program as root, the connection
> >> >> gets established only for a few seconds and then it disconnects from
> >> >> the remote device. Is this behaviour intended? How can I specify to
> >> >> keep the connection alive indefinitely?
> >> >
> >> > If you don't have an active connection that is used, the kernel will
> >> > terminate any idle ones. So using hcitool for this is rather pointless
> >> > unless you have a profile already using that connection.
> >> >
> >>
> >> "using a connection" means pushing some traffic over it?
> >> Is there no other way to prevent the kernel from terminating idle connections?
> >
> > You don't need to transfer data, but you need a reference count on the
> > ACL link. And that can only happen by opening a L2CAP socket.
> >
> >> By the way, I've read in the Bluetooth specs that there exists an
> >> extended inquiry mode which allows the host to gather the RSSI of
> >> available devices too. How can I perform such kind of inquiry from my
> >> application using bluez?
> >
> > Nice idea, but RSSI from inquiry result and RSSI from an ACL are not the
> > same. You can't compare them properly to make sense out of them. I tried
> > that as well. Please read the specification again to see their
> > difference when it comes to power control on the low level baseband.
> >
> 
> Well, that's a non-issue. If I decide to go that way, I'll only use
> RSSI from inquiry results so I don't need to compare RSSI values
> coming from different sources.
> How could I trigger an inquiry with RSSI reporting?

that is one by default if the hardware supports it.

Regards

Marcel


