Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Subject: Re: Failed to connect: org.bluez.Error.NotReady
Date: Fri, 13 Dec 2013 16:56:48 +0100
Message-ID: <1691350.CipnhsEWy0@uw000953>
In-Reply-To: <1386949827.23365.9.camel@pc.interlinx.bc.ca>
References: <1386948800.23365.2.camel@pc.interlinx.bc.ca> <1386949351.6234.0.camel@nuvo> <1386949827.23365.9.camel@pc.interlinx.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> On Fri, 2013-12-13 at 16:42 +0100, Bastien Nocera wrote:
> > Looks like the mouse doesn't accept to be connected through remotely.
> 
> But why would it (a) all of a sudden become disconnected while I was
> using it and (b) a problem today, after having been using this mouse
> successfully for a few days now, including have it reconnect after being
> idle for long periods of time (i.e. overnight)?
> 
> > Turning it off an on should make it connect back to the machine
> 
> Unfortunately not.  After turning it off and then on again, still no
> connection and none possible:
> 
> # info 7C:1E:52:6E:59:D2
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
> I have this same problem with my previously paired headset also.  Not
> connected and won't connect.

Is your adapter powered?:)

-- 
BR
Szymon Janc


