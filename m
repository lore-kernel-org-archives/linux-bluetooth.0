Return-Path: <cyrus@holtmann.org>
Message-ID: <3302faf9afa43a1657c93dff45656631.squirrel@mungewell.org>
In-Reply-To: <1690931.rDxa1ayEBf@athlon>
References: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
    <1434392910-31648-2-git-send-email-szymon.janc@gmail.com>
    <467bb868b4b5b8120da0818a969eb054.squirrel@mungewell.org>
    <1690931.rDxa1ayEBf@athlon>
Date: Tue, 16 Jun 2015 23:30:04 -0400
Subject: Re: [PATCH 1/5] sixaxis: Fix PID for Navigation Controller
From: simon@mungewell.org
To: "Szymon Janc" <szymon.janc@gmail.com>
Cc: simon@mungewell.org, linux-bluetooth@vger.kernel.org,
	"Veseli Veseljko" <veseljko75@gmail.com>,
	"Alex Gal" <a.gal@miip.ca>,
	"Laurence Brown" <linux-bluetooth@protazoa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>> I don't have a good way on initiating the pairing, instead used a
>> hacked-up 'psmovepair' from PSMoveAPI guys. Followed by some hand
>> editing
>> of '/var/lib/bluetooth/<my-mac>/*' files.
>
> Sixaxis plugin should work for setting up Navigation.

Hi,
I tried with current Bluez git and can get a connection established, but
as you noted before it's connecting with PID 0x0268 (Sixaxis), rather than
it's native 0x042f.

Controller was told about PC with hacked version of sixpair (just changed
PID at start) whilst connected with USB.

--
[bluetooth]# agent on
Agent registered
[bluetooth]# default-agent
Default agent request successful
[NEW] Device 00:26:43:C9:C7:49 Navigation Controller
[CHG] Device 00:26:43:C9:C7:49 Class: 0x000508
[CHG] Device 00:26:43:C9:C7:49 Icon: input-gaming
[CHG] Device 00:26:43:C9:C7:49 Connected: yes
[CHG] Device 00:26:43:C9:C7:49 Modalias: usb:v054Cp0268d0100 <----- note
here!!!
[CHG] Device 00:26:43:C9:C7:49 UUIDs: 00001124-0000-1000-8000-00805f9b34fb
[CHG] Device 00:26:43:C9:C7:49 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Device 00:26:43:C9:C7:49 Connected: no
[CHG] Device 00:26:43:C9:C7:49 Connected: yes
[CHG] Device 00:26:43:C9:C7:49 Connected: no
[CHG] Device 00:26:43:C9:C7:49 Connected: yes
[CHG] Device 00:26:43:C9:C7:49 Connected: no
[CHG] Device 00:26:43:C9:C7:49 Connected: yes
[CHG] Device 00:26:43:C9:C7:49 Connected: no
[CHG] Device 00:26:43:C9:C7:49 Connected: yes
[CHG] Device 00:26:43:C9:C7:49 Connected: no
[CHG] Device 00:26:43:C9:C7:49 Connected: yes
[CHG] Device 00:26:43:C9:C7:49 Connected: no
[CHG] Device 00:26:43:C9:C7:49 Connected: yes
[CHG] Device 00:26:43:C9:C7:49 Connected: no
[CHG] Device 00:26:43:C9:C7:49 Connected: yes
[CHG] Device 00:26:43:C9:C7:49 Connected: no
[CHG] Device 00:26:43:C9:C7:49 Connected: yes
[CHG] Device 00:26:43:C9:C7:49 Connected: no
[bluetooth]# trust 00:26:43:C9:C7:49
[CHG] Device 00:26:43:C9:C7:49 Trusted: yes
Changing 00:26:43:C9:C7:49 trust succeeded
[CHG] Device 00:26:43:C9:C7:49 Connected: yes
--
[bluetooth]# devices
Device 00:26:43:C9:C7:49 Navigation Controller
[bluetooth]# info 00:26:43:C9:C7:49
Device 00:26:43:C9:C7:49
	Name: Navigation Controller
	Alias: Navigation Controller
	Class: 0x000508
	Icon: input-gaming
	Paired: no
	Trusted: yes
	Blocked: no
	Connected: no
	LegacyPairing: no
	UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
	Modalias: usb:v054Cp0268d0100
--

Is there something I have to do to change this behaviour?
Simon.

