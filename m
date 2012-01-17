Return-Path: <cyrus@holtmann.org>
Message-ID: <1326785993.6454.276.camel@aeonflux>
Subject: Re: As long as we're adding to the Device Connected mgmt event...
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, skrovvid@codeaurora.org
Date: Tue, 17 Jan 2012 08:39:53 +0100
In-Reply-To: <alpine.DEB.2.02.1201160807170.29809@mathewm-linux>
References: <alpine.DEB.2.02.1201131159420.24403@mathewm-linux>
	  <20120115110354.GA12977@x220.P-661HNU-F1>
	 <1326696332.6454.272.camel@aeonflux>
	 <alpine.DEB.2.02.1201160807170.29809@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> >>> I noticed your recent bluez.git commit that modifies the Device
> >>> Connected event.  Would it also make sense to add the results of the
> >>> READ_REMOTE_VERSION command?
> >>>
> >>> lmp_ver
> >>> manufacturer
> >>> lmp_subver
> >>>
> >>> This information was captured in bluetoothd when using hciops, but
> >>> has so far been missing with mgmtops.
> >>
> >> Do you have a real use-case for it? It'd expect that info to be at most
> >> useful to the kernel side but not so much for user-space. FWIW, we came
> >> to the conclusion with Marcel that a better approach with this
> >> mgmt_ev_device_connected is to encode both the class and the name as an
> >> EIR blob. We'll also do that for the class that's currently as a
> >> separate parameter in mgmt_ev_device_found. This simplifies the
> >> structure of both events and also allows for future extensibility.
> >
> > in addition, these information are purely debugging details and I think
> > it would be better to use sysfs or debugfs for it.
> 
> The use case involves checking the remote LMP version to figure out if 
> the remote device supports EDR, to get a rough estimate of available 
> bandwidth.  Lower bandwidth devices can then use different settings at 
> the profile or application layer.

I can see your point here, but that check is wrong way in achieving
this. Such a thing needs to be done a) via supported features and b) via
the actual allowed packets. Looking at remote LMP version is wrong.

Regards

Marcel


