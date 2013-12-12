Return-Path: <cyrus@holtmann.org>
Message-ID: <1386850542.3586.19.camel@bmurrell-mobl.amr.corp.intel.com>
Subject: Re: mouse not found with bluez5 but was fine with bluez4
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: Bastien Nocera <hadess@hadess.net>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 12 Dec 2013 07:15:42 -0500
In-Reply-To: <1386798596.1982.32.camel@nuvo>
References: <1386680927.11483.6.camel@pc.interlinx.bc.ca>
	 <20131211092135.GA16525@x220.p-661hnu-f1>
	 <1386776083.31076.60.camel@bmurrell-mobl.amr.corp.intel.com>
	 <20131211192523.GA17953@x220.p-661hnu-f1>
	 <1386792806.3586.6.camel@bmurrell-mobl.amr.corp.intel.com>
	 <1386798596.1982.32.camel@nuvo>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2013-12-11 at 22:49 +0100, Bastien Nocera wrote:
> 
> I don't see why it would be a problem in the wizard. You basically
> didn't have a Bluetooth adapter before you installed bluez-hid2hci.

But of course I also tried the wizard after correcting that.  I most
certainly could understand that the wizard would not have worked before
running hid2hci and would only assert that the wizard is not working by
trying it after installing bluez-hid2hci.

So just to be clear, I have a mouse working, so the adapter is
definitely in a state where bluetooth-wizard should work (right?), yet
it is not finding the headset I have sitting here in pairing mode right
this minute.

bluetoothctl certainly sees it:

$ bluetoothctl 
[NEW] Controller 00:02:72:1E:E0:12 pc.interlinx.bc.ca-0 [default]
[NEW] Device 00:0D:E6:68:B4:6F Samsung WEP850
[NEW] Device 70:F3:95:3E:92:34 brian-laptop
[NEW] Device 7C:1E:52:6E:59:D2 Microsoft Sculpt Touch Mouse

> > > Maybe that was somehow auto-run with
> > > your previous installation?
> > 
> > I don't really know.  It was F19.  And that means bluez4.  So I guess
> > this is going to be a transition issue/bug I need to raise on F20.
> 
> bluez-hid2hci was already an optional package in F19.

But since I didn't have it installed on F19, apparently needing it on
F20 is a new requirement of Bluez5.

But really, I don't want to argue about it.  I have my machine working
and have gained a bit of operational knowledge about Bluez5 that will
serve me well as I migrate machines to F20.  I have filed a ticket with
the Fedora project alerting them to the new requirement.  It's now up to
them to decide how important it is that their F20 users don't have the
same problem that I had.

Cheers and thanks much for the help!

b.



