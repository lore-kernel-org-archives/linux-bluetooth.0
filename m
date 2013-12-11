Return-Path: <cyrus@holtmann.org>
Message-ID: <1386792806.3586.6.camel@bmurrell-mobl.amr.corp.intel.com>
Subject: Re: mouse not found with bluez5 but was fine with bluez4
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 11 Dec 2013 15:13:26 -0500
In-Reply-To: <20131211192523.GA17953@x220.p-661hnu-f1>
References: <1386680927.11483.6.camel@pc.interlinx.bc.ca>
	 <20131211092135.GA16525@x220.p-661hnu-f1>
	 <1386776083.31076.60.camel@bmurrell-mobl.amr.corp.intel.com>
	 <20131211192523.GA17953@x220.p-661hnu-f1>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2013-12-11 at 21:25 +0200, Johan Hedberg wrote:
> Hi Brian,

Hi Johan,

> I'm not sure if I'm interpreting this right, but it seems the device is
> in HID mode and not HCI (normal Bluetooth) mode?

I dunno.  I'm just the user.  :-)

> Have you tried running
> the hid2hci tool (part of BlueZ)?

Not yet.  It wasn't installed by default on F20.  When I did though,
things went much better:

$ bluetoothctl 
[NEW] Controller 00:02:72:1E:E0:12 pc.interlinx.bc.ca-0 [default]
[NEW] Device 00:0D:E6:68:B4:6F Samsung WEP850
[NEW] Device 70:F3:95:3E:92:34 brian-laptop
[NEW] Device 7C:1E:52:6E:59:D2 Microsoft Sculpt Touch Mouse
[bluetooth]# agent on
Agent registered
[bluetooth]# power on
Changing power on succeeded
[bluetooth]# scan on
Discovery started
[CHG] Controller 00:02:72:1E:E0:12 Discovering: yes
[CHG] Device 7C:1E:52:6E:59:D2 RSSI: -59
[bluetooth]# scan off
[CHG] Device 7C:1E:52:6E:59:D2 RSSI is nil
Discovery stopped
[CHG] Controller 00:02:72:1E:E0:12 Discovering: no
[bluetooth]# pair 7C:1E:52:6E:59:D2
Attempting to pair with 7C:1E:52:6E:59:D2
[CHG] Device 7C:1E:52:6E:59:D2 Connected: yes
[CHG] Device 7C:1E:52:6E:59:D2 Paired: yes
Pairing successful
[CHG] Device 7C:1E:52:6E:59:D2 Connected: no
[bluetooth]# connect 7C:1E:52:6E:59:D2
Attempting to connect to 7C:1E:52:6E:59:D2
[CHG] Device 7C:1E:52:6E:59:D2 Connected: yes
Connection successful
[CHG] Device 7C:1E:52:6E:59:D2 Modalias: usb:v045Ep077Cd011E
[CHG] Device 7C:1E:52:6E:59:D2 Modalias: usb:v045Ep077Cd011E
[bluetooth]# trust 7C:1E:52:6E:59:D2
Changing 7C:1E:52:6E:59:D2 trust succeeded
[bluetooth]# quit
[DEL] Controller 00:02:72:1E:E0:12 pc.interlinx.bc.ca-0 [default]

So it looks like it's a gnome bluetooth-wizard problem.  I will raise
some tickets.

> Maybe that was somehow auto-run with
> your previous installation?

I don't really know.  It was F19.  And that means bluez4.  So I guess
this is going to be a transition issue/bug I need to raise on F20.

Cheers and thanks so much!

b.


