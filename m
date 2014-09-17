Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Sep 2014 08:14:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Scott James Remnant <keybuk@google.com>
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
Message-ID: <20140917051457.GA4671@t440s.P-661HNU-F1>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
 <735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org>
 <CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Sep 16, 2014, Arman Uguray wrote:
> > have you looked at the the Add Device management command with the
> > 0x00 Action. That will just send out Device Found events for devices
> > in range and uses passive scanning.
> >
> > In addition if you are paired with a device and actually want to
> > connect to it, you can use Action 0x02 to allow for background
> > connection. This is currently in use for LE HID devices.
> 
> This still only sends one Device Found event though right? In Jakub's
> case, a mgmt event is desired to let the userspace know every time a
> new advertisement packet is received, with the updated RSSI and
> TxPower and so on.

It should send as many Device Found events as there are advertising
reports from the controller. We're enabling duplicate filtering in the
hci_req_add_le_passive_scan() function in hci_core.c so maybe that's
your issue? Some HW (like Broadcom) tend to be more conservative in how
many events they send when filtering is enabled whereas others (like
CSR) will give you many more of them (at least one whenever RSSI
changes).

> I think this ties in with some of the previous conversations on the
> list about adding a device scan API that is geared towards
> applications (rather than OS UI). That is, not only a mgmt API that
> enables these kinds of use cases but also (probably) a high-level API
> exposed from bluetoothd that allows applications to scan for devices
> filtered by service UUIDs, contents of the manufacturer data field,
> and so on.
> 
> As for the Add Device command, does bluetoothd currently use this somehow?

Yes, this feature (action 0x02 for Add Device) takes over the entire LE
background scanning and auto-connection mechanism from 3.17 kernel
onwards since BlueZ 5.22 (which was mentioned in our release notes btw).
This is much better than the active scanning based auto-connections that
have until now been done using Start/Stop Discovery.

Johan
