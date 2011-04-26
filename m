Return-Path: <cyrus@holtmann.org>
Subject: Re: Read RSSI through Management Interface?
From: Marcel Holtmann <marcel@holtmann.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Johan Hedberg <johan.hedberg@nokia.com>
In-Reply-To: <BANLkTikWMu3nNP0nUN3xVr2jzJmLhrx09Q@mail.gmail.com>
References: <BANLkTinpSJeozeWCcYCBeQ=sxKU5SJSrSQ@mail.gmail.com>
	 <1303356995.15916.8.camel@aeonflux>
	 <BANLkTikWMu3nNP0nUN3xVr2jzJmLhrx09Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 25 Apr 2011 19:18:28 -0700
Message-ID: <1303784308.15916.36.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> >> we need to read the RSSI of LE and basic rate connections to implement
> >> the Proximity profile. RSSI included in the advertising packets can't
> >> be used for Proximity, it requires an "active" connection.
> >>
> >> Here are some suggestions:
> >>
> >> 1. Add a new command to mgmt interface to add a given address into a
> >> RSSI "monitoring list".
> >>    When the connection is established the kernel will automatically
> >> track the RSSI of the connection on regular intervals sending
> >> HCI_Read_RSSI. Read RSSI value can be reported through a new event in
> >> the management interface
> >
> > the HCI_Read_RSSI on basic rate is a useless command since it depends
> > highly on the power control. Especially since all Bluetooth chips try to
> > keep this one optimized.
> >
> > The RSSI from an active connection does not really give us much. And in
> > addition we have a lot of legacy BR chips just plain failing this
> > command and returning static data. How do you plan to address this?
> 
> I don't expect to have an accurate measurement of the RSSI for basic
> rate, we are only trying to have the profile operational on both
> transports. If it is not feasible enable it for basic rate we can keep
> only Link Loss service running.
> 
> For LE, I hope we get better results. The fact is: we need a way to
> get the RSSI value of an active connection on regular intervals.
> Any other suggestion to implement this service keeping transport abstraction?

the problem with RSSI is really that for basic rate, it is different
from the HCI_Read_RSSI command and Inquiry_Result_with_RSSI event. The
value from inquiry is most likely useful while the connected value is
rather pointless.

The HCI_Read_Link_Quality is way better, but the problem is that its
implementation is vendor specific :(

Regards

Marcel


