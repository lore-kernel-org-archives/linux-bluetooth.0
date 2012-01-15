Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 Jan 2012 13:03:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	skrovvid@codeaurora.org
Subject: Re: As long as we're adding to the Device Connected mgmt event...
Message-ID: <20120115110354.GA12977@x220.P-661HNU-F1>
References: <alpine.DEB.2.02.1201131159420.24403@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1201131159420.24403@mathewm-linux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, Jan 13, 2012, Mat Martineau wrote:
> I noticed your recent bluez.git commit that modifies the Device
> Connected event.  Would it also make sense to add the results of the
> READ_REMOTE_VERSION command?
> 
> lmp_ver
> manufacturer
> lmp_subver
> 
> This information was captured in bluetoothd when using hciops, but
> has so far been missing with mgmtops.

Do you have a real use-case for it? It'd expect that info to be at most
useful to the kernel side but not so much for user-space. FWIW, we came
to the conclusion with Marcel that a better approach with this
mgmt_ev_device_connected is to encode both the class and the name as an
EIR blob. We'll also do that for the class that's currently as a
separate parameter in mgmt_ev_device_found. This simplifies the
structure of both events and also allows for future extensibility.

Johan
