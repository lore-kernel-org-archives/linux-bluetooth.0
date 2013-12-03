Return-Path: <cyrus@holtmann.org>
Message-ID: <1386112361.5405.37.camel@nuvo>
Subject: Re: have to re-pair mouse every few hours (update: mouse needs
 periodic authorization?)
From: Bastien Nocera <hadess@hadess.net>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 04 Dec 2013 00:12:41 +0100
In-Reply-To: <1386107032.8730.22.camel@pc.interlinx.bc.ca>
References: <1385843856.12122.5.camel@pc.interlinx.bc.ca>
	 <1386107032.8730.22.camel@pc.interlinx.bc.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2013-12-03 at 16:43 -0500, Brian J. Murrell wrote:
> On Sat, 2013-11-30 at 15:37 -0500, Brian J. Murrell wrote: 
> > Hi,
> > 
> > I'm using a Microsoft Sculpt Touch Mouse on a Fedora 19 machine
> > (kernel-3.11.9-200.fc19.x86_64 and bluez-4.101-9.fc19.x86_64) with a:
> > 
> > Bus 002 Device 019: ID 0a5c:2148 Broadcom Corp. BCM92046DG-CL1ROM Bluetooth 2.1 Adapter
> > 
> > bluetooth adapter.  This exact same configuration worked for months just
> > fine with a Logitech bluetooth mouse.  But sadly that mouse was crap
> > (second one to fail within the warranty period of one of them) so
> > replaced it with this MS one.
> > 
> > The problem with this MS mouse is that it just goes AWOL and needs to be
> > delete and re-paired with the machine every few hours.  Typically it's
> > after I have gotten up from the computer and have come back to it.  But
> > I have also had it just happen while using it.
> > 
> > When this happens, the messages log reports messages such as:
> > 
> > Nov 30 12:42:03 pc kernel: [2500032.028982] Bluetooth: Unexpected continuation frame (len 0)
> > Nov 30 12:42:03 pc kernel: [2500032.115027] Bluetooth: Unexpected continuation frame (len 0)
> > 
> > Any ideas what the problem might be here?
> 
> So an interesting development in this is that after a reboot, I am now
> starting to see notification bubbles pop up when the mouse goes AWOL
> that say:
> 
> Authorization request from 'Microsoft Sculpt Touch Mouse' with a "Check
> authorization" button it.  When I click that I get a dialog popping up
> that says:
> 
> Grant access to '<uuid>'
> 
> Device 'Microsoft Sculpt Touch Mouse' (<MAC address>) wants access to
> the service '<uuid>'.
> 
> With both a Reject and a Grant button as well as an "Always grant
> access" checkbox.
> 
> Clicking Grant restores the functionality of the mouse and clearly I
> could click the Always grant access checkbox to have this automatic.

Just how did you pair your mouse?

