Return-Path: <cyrus@holtmann.org>
Message-ID: <1437736167.2863.24.camel@hadess.net>
Subject: Re: [PATCH 1/2 v3] adapter: Add
 btd_request_authorization_cable_configured()
From: Bastien Nocera <hadess@hadess.net>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 24 Jul 2015 13:09:27 +0200
In-Reply-To: <1530933.8bMTNVp5s8@athlon>
References: <1436278440.26954.30.camel@hadess.net>
	 <1530933.8bMTNVp5s8@athlon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2015-07-24 at 00:32 +0200, Szymon Janc wrote:
> Hi Bastien,
> 
> On Tuesday 07 July 2015 16:14:00 Bastien Nocera wrote:
> > Add btd_request_authorization_cable_configured() function to allow
> > cable configured devices to ask the user straight away about 
> > whether the
> > device should be allowed to connect to the computer.
> > 
> > This allows us to ask the user at the time of the USB connection 
> > and
> > initial setup, rather than when the first Bluetooth connection is 
> > made.
> 
> I'd also add a note to doc/agent-api.txt that this can be called also 
> for not 
> connected devices under some circumstances (and see how it fits).

As I mentioned on IRC, I'm happy to do that if the rest of the patch is
deemed fine.

> What bothers me is that now bluetoothd will send AuthorizeService 
> request for 
> device that is not connected (and authorizing will not result in 
> connection). 

That's not what that patch does though, this patch just adds wiring to
do that...

> And this was explicitly checked against before this patch.

It's still checked, just not through the sixaxis plugin. That's the
only entry point that disables that check.
<snip>
> 
> Also in general I'd prefer to use sixaxis instead of cable in names. 
> Mainly 
> for consistency with other core sixaxis specific code.

It's not sixaxis specific, and could be used by any cable pairing,
where the device is useful both when plugged in and then through BT.

Johan is the one that preferred cable rather than sixaxis, as the
method isn't specific to sixaxis but could be used for other devices
too.
