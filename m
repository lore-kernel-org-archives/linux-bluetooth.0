Return-Path: <cyrus@holtmann.org>
Message-ID: <1386858040.3586.29.camel@bmurrell-mobl.amr.corp.intel.com>
Subject: Re: mouse not found with bluez5 but was fine with bluez4
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: Bastien Nocera <hadess@hadess.net>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 12 Dec 2013 09:20:40 -0500
In-Reply-To: <1386856382.1982.42.camel@nuvo>
References: <1386680927.11483.6.camel@pc.interlinx.bc.ca>
	 <20131211092135.GA16525@x220.p-661hnu-f1>
	 <1386776083.31076.60.camel@bmurrell-mobl.amr.corp.intel.com>
	 <20131211192523.GA17953@x220.p-661hnu-f1>
	 <1386792806.3586.6.camel@bmurrell-mobl.amr.corp.intel.com>
	 <1386798596.1982.32.camel@nuvo>
	 <1386850542.3586.19.camel@bmurrell-mobl.amr.corp.intel.com>
	 <1386856382.1982.42.camel@nuvo>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2013-12-12 at 14:53 +0100, Bastien Nocera wrote:
> 
> Is the headset still in the list of paired devices though?

Could be.

> If so, it
> wouldn't show up in the list in the wizard.

That makes sense.  I wonder if that was/is the case with the mouse then.

> If you do:
> info 00:0D:E6:68:B4:6F
> in bluetoothctl, you should also see which services your headset uses.
> Some of them aren't supported yet in Fedora (HandsFree for example)
> because the support was removed in bluez itself.

[bluetooth]# info 00:0D:E6:68:B4:6F
Device 00:0D:E6:68:B4:6F
	Name: Samsung WEP850
	Alias: Samsung WEP850
	Class: 0x200404
	Icon: audio-card
	Paired: yes
	Trusted: yes
	Blocked: no
	Connected: no
	LegacyPairing: no
	UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
	UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)

> I've just double-checked, and it's not installed by default in F19.

Right.  I never had it installed in F19.  But my dongle worked anyway,
pressumably without having to use hid2hci

> Maybe you installed it and don't remember, or upgraded from an earlier
> version that had it installed but disabled by default (there used to be
> a separate config file to enable it after installation).

No.  I still have my F19 system.  I checked and it's not installed.  So
clearly this needing it on F20 is something new with bluez5.

> There's plenty of SELinux warnings in there. Maybe you need to enable
> permissive mode, and/or file bugs about those.

Interesting that I don't get that that SELinux troubleshooter icon
notifying me of any problems, and nothing new is in the SELinux Alert
Browser.

b.


