Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447C62BA.4060301@palmsource.com>
Date: Tue, 30 May 2006 17:20:26 +0200
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C733@eumonex01.palmsource.com>
	<1147884880.14106.30.camel@localhost>
In-Reply-To: <1147884880.14106.30.camel@localhost>
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

Hello

Marcel Holtmann wrote:
> Hi Renaud,
> 
> 
>> The LIMITED_DISCOVERABLE_MODE service class is missing and minor
>>classes for other major classes than Computer and Phone are not listed
>>in "constant definition" (ie: uncategorized, keyboard, pointing, combo
>>for Peripheral major class).
>> I use the "class of device" to filter and/or display specific icon for
>>all couple of major and minor in an embedded device.
> 
> 
> we happily accept patches for fixing this. I must admit that in the
> beginning we needed to concentrate on other things and I told people not
> to focus on this. We will fix it later.
> 
> Are you really using LIMITED_DISCOVERABLE_MODE service class.
> 

I am trying to implement other values for minor classes :

     Minor classes access point
         fully, 1-17 percent, 17-33 percent, 33-50 percent, 50-67 percent,
         67-83 percent, 83-99 percent, not available

     Minor classes audio video
         uncategorized, headset, handsfree, reserved1, microphone, loudspeaker,
         headphones, portable audio, car audio, set-top box, hifi audio, vcr,
         video camera, camcorder, video monitor, video display and loudspeaker,
         video conferencing, reserved2, gaming/toy

     Minor classes imaging
         display, camera, scanner, printer

     Minor classes wearable
         wrist watch, pager, jacket, helmet, glasses

     Minor classes toy
         robot, vehicle, doll, controller, game

But I have a problem with peripheral class as its minor classes are divided in two parts :

     Minor classes peripheral
         uncategorized, keyboard, pointing, combo

     Minor classes peripheral 2
         uncategorized, joystick, gamepad, remote control, sensing,
         digitizer tablet, card reader

A peripheral can set two minor classes (i.e. pointing and digitizer tablet) but GetRemoteMinorClass call can only return one string.
Do you have an idea how this should be implemented to address this ?
Are you OK with this list of constants ?

> 
>> Perhaps a new set of APIs could be better ?
> 
> 
> Why? And what advantages would you gain?
> 
> Regards
> 
> Marcel

Regards

Fred

-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic            PalmSource Europe
Software engineer
Mail : mailto:frederic.danis@palmsource.com
-----------------------------------------------


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
