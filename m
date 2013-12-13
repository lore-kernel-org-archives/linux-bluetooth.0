Return-Path: <cyrus@holtmann.org>
Message-ID: <1386949351.6234.0.camel@nuvo>
Subject: Re: Failed to connect: org.bluez.Error.NotReady
From: Bastien Nocera <hadess@hadess.net>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 13 Dec 2013 16:42:31 +0100
In-Reply-To: <1386948800.23365.2.camel@pc.interlinx.bc.ca>
References: <1386948800.23365.2.camel@pc.interlinx.bc.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2013-12-13 at 10:33 -0500, Brian J. Murrell wrote:
> So I was happily chugging along using bluez5 on F20 with the previously
> mentioned mouse and all of a sudden it stopped working.  So to
> bluetoothctl I go:
> 
> $ bluetoothctl 
> [NEW] Controller 00:02:72:1E:E0:12 pc.interlinx.bc.ca-0 [default]
> [NEW] Device 00:0D:E6:68:B4:6F Samsung WEP850
> [NEW] Device 70:F3:95:3E:92:34 brian-laptop
> [NEW] Device 7C:1E:52:6E:59:D2 Microsoft Sculpt Touch Mouse
> [bluetooth]# info 7C:1E:52:6E:59:D2
> Device 7C:1E:52:6E:59:D2
> 	Name: Microsoft Sculpt Touch Mouse
> 	Alias: Microsoft Sculpt Touch Mouse
> 	Class: 0x000580
> 	Icon: input-mouse
> 	Paired: yes
> 	Trusted: yes
> 	Blocked: no
> 	Connected: no
> 	LegacyPairing: no
> 	UUID: Service Discovery Serve.. (00001000-0000-1000-8000-00805f9b34fb)
> 	UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
> 	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> 	Modalias: usb:v045Ep077Cd011E
> [bluetooth]# connect 7C:1E:52:6E:59:D2
> Attempting to connect to 7C:1E:52:6E:59:D2
> Failed to connect: org.bluez.Error.NotReady
> 
> I've tried unplugging and plugging in the dongle.  Not sure what else to
> do at this point.

Looks like the mouse doesn't accept to be connected through remotely.
Turning it off an on should make it connect back to the machine (that's
how it behaves with the MS Wireless presenter mouse).

Cheers

