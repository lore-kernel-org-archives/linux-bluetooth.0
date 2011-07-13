Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 1/3] Bluetooth: Implement Read RSSI command
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 13 Jul 2011 21:47:05 +0200
In-Reply-To: <CALJ2SBL=Fdcmrbrs69pQybXxMq1yh4=Gzmx4Xa32_qnFwDe-YA@mail.gmail.com>
References: <4e1da4a5.04bfec0a.4243.00d9@mx.google.com>
	 <1310580766.21109.96.camel@aeonflux>
	 <CALJ2SBL=Fdcmrbrs69pQybXxMq1yh4=Gzmx4Xa32_qnFwDe-YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310586426.21109.100.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> >> This patch implements helper functions to make Read RSSI command
> >> interceptable by MGMT Interface. It adds a new wrapper in HCI layer and
> >> add a hook to call mgmt_read_rssi_complete when MGMT Interface has been
> >> loaded.
> >>
> >> Read RSSI command is defined on Part E, section 7.5.4 of Bluetooth 4.0
> >> Spec.
> >
> > I think that I mentioned this before. This is not something I like to
> > see at all. 1:1 copies of HCI commands is pointless.
> >
> > If you need RSSI results, then something like proper interval and
> > thresholds should be supported. Also with future Bluetooth SIG work on
> > having controller driven notifications in this area.
> 
> Note that even the RSSI and TX Power are implemented, it is not
> possible to userspace request a RSSI or TX Power actively. If
> userspace wants to receive RSSI and TX Power from the kernel, it must
> add to the "monitored commands" and wait for the responses. Read RSSI
> and TX Power Level are not being parsed on mgmt_control().
> Maybe I should change the commit message of this patch and the next one.
> 
> New Management commands were implemented in the last RFC patch to
> monitor selected commands.

no matter what, this needs to be done future proof in conjunction with
where the Bluetooth SIG is going for the controller driven notifications
of RSSI changes.

With older controllers we just have to emulate the behavior via a simple
poll mechanism.

However such monitored commands things seems like a hack as well. Please
use proper interfaces for threshold and interval values. Otherwise this
is all pointless. And you just wake up userspace for no real reason. The
plan is to get away from pointless userspace wakeups.

Regards

Marcel


