Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Zygo Blaxell <zblaxell@dactyl.hungrycats.org>
Subject: Re: The link I had working quit.  Help
Date: Tue, 07 Apr 2009 14:54:54 -0400
Cc: jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
References: <200904041636.25409.gene.heskett@verizon.net>
 <200904061457.02511.gene.heskett@verizon.net>
 <20090406221444.GA25011@dactyl.hungrycats.org>
In-reply-to: <20090406221444.GA25011@dactyl.hungrycats.org>
MIME-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-id: <200904071454.54317.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 06 April 2009, Zygo Blaxell wrote:
>On Mon, Apr 06, 2009 at 02:57:02PM -0400, Gene Heskett wrote:
>> The device on the other end is sending a continuous string of
>> Coco3 at coyote.den
>> at about 3x/second


>> BTW, where is that list archive?
>
>vger.kernel.org mailing lists are widely distributed
>and there are a number of public archives for them.  One is at
>http://marc.info/?l=linux-bluetooth&w=1
>
>From a search on pairing I found:
[root@coyote test]# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff

But that is all it printed in about 2 minutes.

Then:
[root@coyote test]# ./test-discovery
[ 00:0C:84:00:86:F8 ]
    Name = eb101
    LegacyPairing = 1
    Alias = eb101
    Address = 00:0C:84:00:86:F8
    RSSI = 0
    Class = 0x001f00
[root@coyote test]#

But nothing seems to enable the pairing, and everytime I do that that far in 
the 'bluetooth-wizard' and it sees the eb101, it tells me to enter an 
apparently randomly derived 4 digit pin number, but the wizard gives me no 
place to enter it. Nor is there a 'proceed' button, and in 5 seconds or so it 
clears that screen and reports pairing failed.

>> >When you get it going good, write the Howto. I'd like to read it ;)
>>
>> Chuckle, So would I, like to read it that is! :)
>
>[...]
>
>> I went to google and looked up 'bluetoogh pairing' and got this:
>> http://www.bluetomorrow.com/content/section/180/284/
>> but no real howto.  And I did chase down quite a few other links, mostly
>> for pairing with mobile phones or headsets, nothing on using them as a
>> wireless rs232 circuit.  Which is what I want of course.
>
>Here's a shot at a howto for a serial device.  This is kind of ugly,
>and it occasionally uses brute force rather than the proper Bluetooth-
>or BlueZ-compliant approach; however, I've managed to force quite a
>few devices to work with procedures like this before I knew what I
>was doing.  ;-)
>
>Get the bluez source tarball so you have the 'test' directory.  In that
>directly, you'll find 'simple-agent'.
>
>Make sure the remote device is pairable (can't help you with that--the
>procedure is specific to each remote device, and if the device isn't
>pairable, no amount of trying from the bluez side will work).  Note that
>some devices (especially things like mice and headsets) will allow only
>one connection attempt after they're powered on, and whatever connects to
>them has to pair with them on the first try--so if you mistype the PIN,
>you might have to power the device back off and on again before you retry.
>
>Run 'simple-agent hci0 <remote-device-bdaddr>'.  You should be prompted
>for a PIN on both devices.  Use the same one.  ;-)

I am not, this after modifying /etc/dbus-1/systemd/bluetooth.conf to allow all 
bt stuffs.

Aha!  A chance comment I read someplace paid off!  I knew the PIN code for 
that device was 0000 after a factory reset, which had been done several times.  
The comment was that if a pairing failed, they had to be powered off before it 
could be tried again, so I went to the other end and did a powerdown reset, 
than came backup up to here and swapped one for the other of the 2 devices I 
had here, which have identical bdaddr's.

Then I ran
[root@coyote test]# ./simple-agent hci0 00:0C:84:00:86:F8
RequestPinCode (/org/bluez/2008/hci0/dev_00_0C_84_00_86_F8)
Enter PIN Code: 0000
Release
New device (/org/bluez/2008/hci0/dev_00_0C_84_00_86_F8)

Ok, tapped the hdwe reset on the coco3 and let it reboot which restarts the 
shell I killed that should be available for minicom to talk to..  

Operative word is 'should':
[root@coyote test]# minicom
minicom: cannot open /dev/rfcomm0: No such file or directory
[root@coyote test]# ./simple-agent hci0 00:0C:84:00:86:F8
Creating device failed: org.bluez.Error.AlreadyExists: Bonding already exists

[root@coyote test]# rfcomm release all
[root@coyote test]# rfcomm bind 0 00:0c:84:00:86:F8
[root@coyote test]# minicom
minicom: cannot open /dev/rfcomm0: No such file or directory

I think I'm battling with a bad error message that isn't telling me what I 
think it is.

[root@coyote test]# rfcomm connect 0 00:0c:84:00:86:F8 1
Can't connect RFCOMM socket: Host is down

[root@coyote test]# sdptool browse 00:0c:84:00:86:F8
Failed to connect to SDP server on 00:0C:84:00:86:F8: Host is down

So what is the real problem here other than I'm a clueless newbie?

>Run 'rfcomm bind /dev/rfcomm0 <remote-device-bdaddr> N' where N is the
>channel number.  If you don't have success with 'sdptool browse,' you can
>simply try channel numbers from 1 up to 15 or so.
Did that:
[root@coyote test]# rfcomm release all
[root@coyote test]# rfcomm bind /dev/rfcomm0 00:0C:84:00:86:F8 1

>Use a terminal program to see what you've connected to on rfcomm0.
>Repeat with different channel numbers until you find what you're
>looking for.

Terminal programs such as minicom cannot connect to /dev/rfcomm0, claiming it 
does not exist.
root@coyote test]# ls -l /dev/rfcomm*
crw------- 1 root root 216, 0 2009-04-07 13:08 /dev/rfcomm0
[root@coyote test]# minicom
minicom: cannot open /dev/rfcomm0: No such file or directory

Next?

KDE is doing funkity things so I'm going to restart x.  Maybe that will do 
something.



Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
The world is coming to an end ... SAVE YOUR BUFFERS!!!

