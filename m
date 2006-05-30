Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <447C62BA.4060301@palmsource.com>
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C733@eumonex01.palmsource.com>
	<1147884880.14106.30.camel@localhost> <447C62BA.4060301@palmsource.com>
Date: Tue, 30 May 2006 17:34:34 +0200
Message-Id: <1149003274.11251.17.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Dbus and RemoteDeviceFound API
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Frederic,

> I am trying to implement other values for minor classes :
> 
>      Minor classes access point
>          fully, 1-17 percent, 17-33 percent, 33-50 percent, 50-67 percent,
>          67-83 percent, 83-99 percent, not available
> 
>      Minor classes audio video
>          uncategorized, headset, handsfree, reserved1, microphone, loudspeaker,
>          headphones, portable audio, car audio, set-top box, hifi audio, vcr,
>          video camera, camcorder, video monitor, video display and loudspeaker,
>          video conferencing, reserved2, gaming/toy
> 
>      Minor classes imaging
>          display, camera, scanner, printer
> 
>      Minor classes wearable
>          wrist watch, pager, jacket, helmet, glasses
> 
>      Minor classes toy
>          robot, vehicle, doll, controller, game
> 
> But I have a problem with peripheral class as its minor classes are divided in two parts :
> 
>      Minor classes peripheral
>          uncategorized, keyboard, pointing, combo
> 
>      Minor classes peripheral 2
>          uncategorized, joystick, gamepad, remote control, sensing,
>          digitizer tablet, card reader
> 
> A peripheral can set two minor classes (i.e. pointing and digitizer tablet) but GetRemoteMinorClass call can only return one string.
> Do you have an idea how this should be implemented to address this ?

So far, I would only return the first ones and simply ignore the others.
Basically you only wanna know if the remote device is a keyboard or
mouse or if it supports both.

> Are you OK with this list of constants ?

Looks good so far, except don't use reserved*. Simply call it unknown or
return an error.

However I leave this open for discussion, but at the end of the day we
need a complete list in the dbus-api.txt document.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
