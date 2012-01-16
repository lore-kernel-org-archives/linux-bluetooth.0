Return-Path: <cyrus@holtmann.org>
Message-ID: <1326696332.6454.272.camel@aeonflux>
Subject: Re: As long as we're adding to the Device Connected mgmt event...
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, skrovvid@codeaurora.org
Date: Mon, 16 Jan 2012 07:45:32 +0100
In-Reply-To: <20120115110354.GA12977@x220.P-661HNU-F1>
References: <alpine.DEB.2.02.1201131159420.24403@mathewm-linux>
	 <20120115110354.GA12977@x220.P-661HNU-F1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> > I noticed your recent bluez.git commit that modifies the Device
> > Connected event.  Would it also make sense to add the results of the
> > READ_REMOTE_VERSION command?
> > 
> > lmp_ver
> > manufacturer
> > lmp_subver
> > 
> > This information was captured in bluetoothd when using hciops, but
> > has so far been missing with mgmtops.
> 
> Do you have a real use-case for it? It'd expect that info to be at most
> useful to the kernel side but not so much for user-space. FWIW, we came
> to the conclusion with Marcel that a better approach with this
> mgmt_ev_device_connected is to encode both the class and the name as an
> EIR blob. We'll also do that for the class that's currently as a
> separate parameter in mgmt_ev_device_found. This simplifies the
> structure of both events and also allows for future extensibility.

in addition, these information are purely debugging details and I think
it would be better to use sysfs or debugfs for it.

Regards

Marcel


