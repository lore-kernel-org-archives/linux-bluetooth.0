Return-Path: <cyrus@holtmann.org>
Date: Sun, 3 Jul 2011 23:13:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Disable pnat-server
Message-ID: <20110703201356.GA14128@dell.ger.corp.intel.com>
References: <4E108D72.3010006@kernelconcepts.de>
 <20110703180444.GA19576@dell.ger.corp.intel.com>
 <4E10B97B.8060703@kernelconcepts.de>
 <20110703190615.GA20814@dell.ger.corp.intel.com>
 <4E10C989.9060909@kernelconcepts.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E10C989.9060909@kernelconcepts.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jul 03, 2011, Nils Faerber wrote:
> > Hmm? So they don't use SDP do discover the RFCOMM channel but directly
> > connect to channel 1?
> 
> Um...well I just checked that code.
> What the device does it look for the service name on the host and on the
> host side it is bound to channel 1 - I think. I borrowed that part of my
> code from some old BlueZ code, forgot which.

So, the SDP service record is there so profiles can look up e.g. the
RFCOMM channel based on the profile UUID. If that's what the remote
device is doing you should be able to change the channel to something
else than 1 in the service record and then bind your server socket to
this new channel. However, if the remote side has a hard-coded channel
value of 1 and doesn't care what SDP says then there's really nothing
you can do (except make sure you don't have any other service on that
channel, like you now did).

> Tried that and now my device works again - yippie!

Good to hear! :)

Johan
