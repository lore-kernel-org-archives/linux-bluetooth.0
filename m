Return-Path: <cyrus@holtmann.org>
Message-ID: <1386856382.1982.42.camel@nuvo>
Subject: Re: mouse not found with bluez5 but was fine with bluez4
From: Bastien Nocera <hadess@hadess.net>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 12 Dec 2013 14:53:02 +0100
In-Reply-To: <1386850542.3586.19.camel@bmurrell-mobl.amr.corp.intel.com>
References: <1386680927.11483.6.camel@pc.interlinx.bc.ca>
	 <20131211092135.GA16525@x220.p-661hnu-f1>
	 <1386776083.31076.60.camel@bmurrell-mobl.amr.corp.intel.com>
	 <20131211192523.GA17953@x220.p-661hnu-f1>
	 <1386792806.3586.6.camel@bmurrell-mobl.amr.corp.intel.com>
	 <1386798596.1982.32.camel@nuvo>
	 <1386850542.3586.19.camel@bmurrell-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2013-12-12 at 07:15 -0500, Brian J. Murrell wrote:
> On Wed, 2013-12-11 at 22:49 +0100, Bastien Nocera wrote:
> > 
> > I don't see why it would be a problem in the wizard. You basically
> > didn't have a Bluetooth adapter before you installed bluez-hid2hci.
> 
> But of course I also tried the wizard after correcting that.  I most
> certainly could understand that the wizard would not have worked before
> running hid2hci and would only assert that the wizard is not working by
> trying it after installing bluez-hid2hci.
> 
> So just to be clear, I have a mouse working, so the adapter is
> definitely in a state where bluetooth-wizard should work (right?), yet
> it is not finding the headset I have sitting here in pairing mode right
> this minute.

Is the headset still in the list of paired devices though? If so, it
wouldn't show up in the list in the wizard.

> bluetoothctl certainly sees it:
> 
> $ bluetoothctl 
> [NEW] Controller 00:02:72:1E:E0:12 pc.interlinx.bc.ca-0 [default]
> [NEW] Device 00:0D:E6:68:B4:6F Samsung WEP850
> [NEW] Device 70:F3:95:3E:92:34 brian-laptop
> [NEW] Device 7C:1E:52:6E:59:D2 Microsoft Sculpt Touch Mouse

If you see it in bluetoothctl without typing scan, that means that
either it was discovered less than 3 minutes ago, or that it's a known
device (so paired or trusted, paired in the case of headsets).

If you do:
info 00:0D:E6:68:B4:6F
in bluetoothctl, you should also see which services your headset uses.
Some of them aren't supported yet in Fedora (HandsFree for example)
because the support was removed in bluez itself.

> > > > Maybe that was somehow auto-run with
> > > > your previous installation?
> > > 
> > > I don't really know.  It was F19.  And that means bluez4.  So I guess
> > > this is going to be a transition issue/bug I need to raise on F20.
> > 
> > bluez-hid2hci was already an optional package in F19.
> 
> But since I didn't have it installed on F19, apparently needing it on
> F20 is a new requirement of Bluez5.

I've just double-checked, and it's not installed by default in F19.
Maybe you installed it and don't remember, or upgraded from an earlier
version that had it installed but disabled by default (there used to be
a separate config file to enable it after installation).

> But really, I don't want to argue about it.  I have my machine working
> and have gained a bit of operational knowledge about Bluez5 that will
> serve me well as I migrate machines to F20.  I have filed a ticket with
> the Fedora project alerting them to the new requirement.  It's now up to
> them to decide how important it is that their F20 users don't have the
> same problem that I had.

There's plenty of SELinux warnings in there. Maybe you need to enable
permissive mode, and/or file bugs about those.

