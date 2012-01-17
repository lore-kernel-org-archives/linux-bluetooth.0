Return-Path: <cyrus@holtmann.org>
Message-ID: <1326786758.6454.287.camel@aeonflux>
Subject: Re: As long as we're adding to the Device Connected mgmt event...
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, skrovvid@codeaurora.org
Date: Tue, 17 Jan 2012 08:52:38 +0100
In-Reply-To: <20120116231423.GA13647@x220.P-661HNU-F1>
References: <alpine.DEB.2.02.1201131159420.24403@mathewm-linux>
	 <20120115110354.GA12977@x220.P-661HNU-F1>
	 <1326696332.6454.272.camel@aeonflux>
	 <alpine.DEB.2.02.1201160807170.29809@mathewm-linux>
	 <20120116231423.GA13647@x220.P-661HNU-F1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > >>>I noticed your recent bluez.git commit that modifies the Device
> > >>>Connected event.  Would it also make sense to add the results of the
> > >>>READ_REMOTE_VERSION command?
> > >>>
> > >>>lmp_ver
> > >>>manufacturer
> > >>>lmp_subver
> > >>>
> > >>>This information was captured in bluetoothd when using hciops, but
> > >>>has so far been missing with mgmtops.
> > >>
> > >>Do you have a real use-case for it? It'd expect that info to be at most
> > >>useful to the kernel side but not so much for user-space. FWIW, we came
> > >>to the conclusion with Marcel that a better approach with this
> > >>mgmt_ev_device_connected is to encode both the class and the name as an
> > >>EIR blob. We'll also do that for the class that's currently as a
> > >>separate parameter in mgmt_ev_device_found. This simplifies the
> > >>structure of both events and also allows for future extensibility.
> > >
> > >in addition, these information are purely debugging details and I think
> > >it would be better to use sysfs or debugfs for it.
> > 
> > The use case involves checking the remote LMP version to figure out
> > if the remote device supports EDR, to get a rough estimate of
> > available bandwidth.  Lower bandwidth devices can then use different
> > settings at the profile or application layer.
> 
> If something like that is really needed then I think some sort of a
> socket option might make more sense, i.e. the application could call
> getsockopt (or some higher level wrapper like BtIO) to figure this out.
> In any case it's not enough for the remote device to support EDR if the
> local device isn't capable of it.

if we look a little bit ahead of this and trying to do this right, then
we better add some SCM data that indicates what our current possible
bandwidth might be. And we do that while receiving a packet and not with
some socket option. We just have to enable it via a socket option. This
could account for BR or EDR or even HS and in case it changes on the
fly. I am pretty sure I mentioned this already some time before.

The only real bummer is that the BR/EDR packet mask is just a simple
indication that we are giving to the controller. It does not mean that
it will always give us the maximum bandwidth possible. Especially if we
also have SCO connection open.

Most likely still better than magically assuming something based on the
remote LMP version ;)

Regards

Marcel


