Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jun 2011 17:33:45 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: keithp@keithp.com, padovan@profusion.mobi, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression caused by "Bluetooth: Map sec_level to link key
 requirements"
Message-ID: <20110609083345.GA2894@dell.ccr.corp.intel.com>
References: <yunboy7a2so.fsf@aiko.keithp.com>
 <99B09243E1A5DA4898CDD8B700111448175AA2DB2A@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448175AA2DB2A@EXMB04.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 09, 2011, Waldemar.Rymarkiewicz@tieto.com wrote:
> >Patch 13d39315c22b128f4796fc008b04914a7c32bb1a is causing a 
> >regression From 2.6.39. I cannot communicate with my Nokia 
> >N900 using either the SyncML or DUN RFCOMM services.  I get a 
> >connection reset error shortly after startup.
> >
> >I've reverted this patch on top of something past -rc2 (to be 
> >precise, I'm branching from ef2398019b305827ea7130ebaf7bf521b444530e).
> >With the following fix-up to make things build again, my 
> >bluetooth works again.
> 
> Logs from kernel and bluez would be much appreciated to see what happend.
> As I remember this was pretty well tested with BITE test by Johan.

The patch was not only fine but actually *needed* by the BITE. So
reverting it will make some qualification tests fail.

There's no DUN support in the N900 by default and the only package I'm
aware that provides it uses the command line rfcomm tool with high
security on the socket to block just-works SSP pairing (since the rfcomm
tool doesn't use the authorization framework to guarantee a user pop-up
dialog). The SyncML code I can't comment on since I haven't seen it.

So potentially this might be limited to high security sockets.
Speculating further, if the device connecting to the N900 has a pre-2.1
Bluetooth controller this could simply be about not having a 16-digit
PIN which high security services require. So could whoever is able to
reproduce the issue try repairing and entering a 16-digit PIN to see if
the problem goes away? And if this is in fact the case then the kernel
code is working exactly as it should; the only issue is that these
services should really be using medium security level instead of high.

Johan
