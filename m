Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Bastien Nocera <hadess@hadess.net>
Subject: Re: The link I had working quit.  Help
Date: Wed, 08 Apr 2009 11:06:11 -0400
Cc: Zygo Blaxell <zblaxell@feedme.hungrycats.org>,
	Zygo Blaxell <zblaxell@dactyl.vpn7.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
References: <200904041636.25409.gene.heskett@verizon.net>
 <20090407200201.GA18671@hungrycats.org>
 <1239145518.20817.915.camel@cookie.hadess.net>
In-reply-to: <1239145518.20817.915.camel@cookie.hadess.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Message-id: <200904081106.11442.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 07 April 2009, Bastien Nocera wrote:
>On Tue, 2009-04-07 at 16:02 -0400, Zygo Blaxell wrote:
>> On Tue, Apr 07, 2009 at 02:54:54PM -0400, Gene Heskett wrote:
>> > But nothing seems to enable the pairing, and everytime I do that
>>
>> that far in
>>
>> > the 'bluetooth-wizard' and it sees the eb101, it tells me to enter
>>
>> an
>>
>> > apparently randomly derived 4 digit pin number, but the wizard gives
>>
>> me no
>>
>> > place to enter it. Nor is there a 'proceed' button, and in 5 seconds
>>
>> or so it
>>
>> > clears that screen and reports pairing failed.
>>
>> bluez-gnome (where your bluetooth-wizard comes from?) has a really
>> stupid
>> UI design.  If bluetooth-wizard thinks you *can* enter a PIN into your
>> device, it will *require* you to enter a random one.  This idea
>> doesn't
>> work so well on devices that don't have keyboards or that have fixed
>> PINs,
>> and bluetooth-wizard knows only about broad categories of devices and
>> a
>> handful of exceptions.  The opposite problem occurs on devices where
>> bluez-gnome thinks it knows a fixed-PIN device's PIN, but it actually
>> doesn't.
>>
>> Also, bluez-gnome's discovery page won't show you discoverable devices
>> that
>> are already known, so it can't tell you if a known device is in range.
>> 'hcitool scan' will tell you about all devices in range, but it causes
>> some
>> problems for bluetoothd if both are running at the same time.
>>
>> If you can, use simple-agent instead of bluetooth-wizard.
>
>Or you can use gnome-bluetooth which has those problems fixed.
>
If you are referring to 'bluetooth-wizard', it will not show me a device.  I'm 
told it will not show devices which are already paired.

I get what I assume is the same message from a:

[root@coyote test]#  ./simple-agent hci0 00:0C:84:00:86:F8
Creating device failed: org.bluez.Error.AlreadyExists: Bonding already exists

I just found /var/lib/bluetooth/11:11:11:11:11:11 which has a group of small 
files in it, 2 or 3 being subjected to an updated timestamp (data in these 
files is kept in GMT).

Is this the directory I need to mv someplace in order to rerun the bluetooth-
wizard?  Ok, did that, bluetooth-wizard did show me the device, but then the 
pin screen only showed for an almost subliminal time & then reported that it 
failed.

That generated a new /var/lib/bluetooth tree, so I nuked that, and ran 
"simple-agent hci0 <bdaddr of this dongle>"
That asked me for just one PIN and I gave it the default of 0000.  No errors.
And a new /var/lib/bluetooth tree was created.

An l2ping <bdaddr of remote>
Ping: 00:0C:84:00:86:F8 from 11:11:11:11:11:11 (data size 44) ...
4 bytes from 00:0C:84:00:86:F8 id 0 time 16.93ms
4 bytes from 00:0C:84:00:86:F8 id 1 time 10.86ms
4 bytes from 00:0C:84:00:86:F8 id 2 time 27.87ms
4 bytes from 00:0C:84:00:86:F8 id 3 time 28.87ms
4 bytes from 00:0C:84:00:86:F8 id 4 time 25.93ms
4 bytes from 00:0C:84:00:86:F8 id 5 time 25.89ms

Is this normal?

I just now went down to the coco and started a shell on both /t2 (wired) and 
/t3 (bluetooth)
minicom -s & set the serial port to /dev/ttyS0, exit and I am now a remote 
terminal on that machine.
-----------------------screen snip---------------
Welcome to minicom 2.3

OPTIONS: I18n
Compiled on Aug 29 2008, 07:16:49.
Port /dev/ttyS0

               Press CTRL-A Z for help on special keys


Shell+ v2.2a 09/04/08 11:03:01

{t2|04}/DD:dir

 Directory of .  2009/04/08 11:03
BOOTTRACK       CMDS            DEFS            HDBDOS11.DSK    MAXTOR
MODULES         NEWBOOT         NITROS9         NOS96309        OLDCMDS
OLDDEFS         OLDSYS          PcDos.doc       PcDos.doc1      Pcdos.lzh
SYS             UTILS2          cc3go           UTILS2.tmp      dskini
dummy           gene            startyup        test.p          old-sysgo
utils2.merge-list               print-test.b09  sysgo           sysgo.asm
SRC             discscan4floppy dsave.out       startup         devel
p               ekodrvr

{t2|04}/DD:
------------and its waiting for me to issue new commands--------------
If all this was working, I should get an essentially identical response using 
/dev/rfcomm0, right|wrong?

But a second minicom -s, check to see the serial port is /dev/rfcomm0, which 
does exist, select exit to minicom's main screen and it exits, reporting:
minicom: cannot open /dev/rfcomm0: No route to host

So that is where I am at.  Last Saturday morning it Just Worked(TM) without 
all this hassle.  I would like it to work again.  What is the next 
troubleshooting step here?, I'll go at your pace this time.

To those who suggested I use cu, or screen:  I don't have a cu, and 'screen' 
cannot open any device I've named.  From a lengthy read of the manpage, 
'screen' is a VT100 terminal, but without the ability to work with anything 
but the local system, so I don't see as it could be useful here.

I'll go see if I can find this cu.  Thanks everybody.

>--
>To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If you don't like the way I drive, stay off the sidewalk!

