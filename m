Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Zygo Blaxell <zblaxell@dactyl.hungrycats.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: The link I had working quit.  Help
Date: Tue, 07 Apr 2009 00:08:48 -0400
References: <200904041636.25409.gene.heskett@verizon.net>
 <200904061457.02511.gene.heskett@verizon.net>
 <20090406221444.GA25011@dactyl.hungrycats.org>
In-reply-to: <20090406221444.GA25011@dactyl.hungrycats.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Message-id: <200904070008.48621.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 06 April 2009, Zygo Blaxell wrote:
>On Mon, Apr 06, 2009 at 02:57:02PM -0400, Gene Heskett wrote:
>> The device on the other end is sending a continuous string of
>> Coco3 at coyote.den
>> at about 3x/second
>
>Do you seriously have a Coco3 wired up to Bluetooth?  How?  Presumably not
>with a native stack...some kind of dongle?
>
Roger Taylor is selling a remake of the old Deluxe RS-232 pack, with an a7 
eb101 module taking the place of the db25 connector.  $65.  Uses the same old 
rs-232 drivers.  He is one of the movers & shakers of the coco list on 
maltedmedia.com.

>If you do have a Coco3 with a native Bluetooth stack...I want one.  ;)
>The native Bluetooth stack, that is...I already have a Coco3 or two.

Don't need one.  I had minicom connected through this bt dongle yesterday 
morning, and anything I could do from a shell on that machine, I could do from 
here with minicom talking to /dev/rfcomm0.

>> And it has an led that when connected, will blink on and off at 2 second
>> intervals, but is not.  When it worked, it did blick correctly.
>>
>> So traffic IS flowing, I just can't get the device to show it to me,  or
>> get picocom or minicom to even find /dev/rfcomm0
>>
>> [root@coyote bin]# cat /dev/rfcomm0
>> cat: /dev/rfcomm0: Host is down
>> [root@coyote bin]# minicom
>> minicom: cannot open /dev/rfcomm0: Host is down
>
>Looks like it's bound to the wrong remote address, or the remote device
>isn't listening for connections.

The bdaddr address is correct, 00:0C:84:00:86:F8, and that device has been 
reset to factory several times, meaning its pass key is 0000.

>> Your comment about
>>
>> >Another idea is try to re-pair the devices. Are you running the
>> > passkey-agent and auth-agent?
>>
>> Is another clue, but neither of those exist on this system.  What package
>> are they part of?
>
>There is an agent written in Python named simple-agent in the Bluez
>sources, under 'test'.  It's probably the closest thing to a simple
>command-line utility.

And the contents of the test directory are not part of the normal install I 
take it?
-------------------------------------[root@coyote test]# ./simple-agent
ERROR:dbus.proxies:Introspect error on :1.67:/: dbus.exceptions.DBusException: 
org.freedesktop.DBus.Error.AccessDenied: A security policy in place prevents 
this sender from sending this message to this recipient, see message bus 
configuration file (rejected message had interface 
"org.freedesktop.DBus.Introspectable" member "Introspect" error name "(unset)" 
destination ":1.67")
Traceback (most recent call last):
  File "./simple-agent", line 86, in <module>
    path = manager.DefaultAdapter()
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 68, in 
__call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 140, in 
__call__
    **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/connection.py", line 630, in 
call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.AccessDenied: A 
security policy in place prevents this sender from sending this message to 
this recipient, see message bus configuration file (rejected message had 
interface "org.bluez.Manager" member "DefaultAdapter" error name "(unset)" 
destination ":1.67")
----------------------------

D-Bus?  Another PIMA...
>
>> I do have the bluetooth-wizard, which on its device display screen shows
>> blank space where the device list should be.
>
>Do you have any other Bluetooth devices to test with?  It would be
>one thing if you can't see the specific device you're looking for,
>but something else entirely if you can't see any devices *at all*.

None at all now.  And I've tried both of these identical devices several 
times.
>
>> >> echo "hciconfig -a hci0 putkey 0000"
>> >> hciconfig -a hci0 putkey 0000
>> >> --------which returns:
>> >> Can't find link key for 0000 on hci0
>> >> ^C
>
>You probably don't want to be using hciconfig or hcitool.  Use the DBus API
>to talk to bluetoothd instead.

DBus api?  Does Fedora 10 have such a beast?  Not that I can find in kmenu.

>On Mon, Apr 06, 2009 at 02:57:02PM -0400, Gene Heskett wrote:
>> On Monday 06 April 2009, jayjwa wrote:
>> >On Sun, 5 Apr 2009, Gene Heskett wrote:
>> >> Where are the bluetooth guru's?  Or, where can I find the RFC documents
>> >> that describe how all this is supposed to work?
>
>http://wiki.bluez.org/ has some HOWTOs that are somewhat out of
>date but still useful as a starting point.  Bluez API documents
>are in the bluez sources under doc/.  The Bluetooth specs are under
>http://www.bluetooth.com/Bluetooth/Technology/Building/Specifications/,
>but they're probably useless unless you want very high-level architectural
>information, or you know exactly what technical detail you're looking for.
>
>> >If they're on the bt list, then they are silent. They never answer me
>> > there; I asked about getting bt headsets going under 4.x, and only one
>> > person remarked he thought he saw kernel messages. I'm assuming then
>> > that no-one uses headsets under 4.x. From the other questions on the
>> > list, no-one uses anything successfully under 4.x, unless you count
>> > /usr/bin/patch. Really I'm thinking of unsubscribing.
>
>FWIW, I've gotten several bluetooth headsets to work under 3.36 and most
>of 4.x for 20 < x < 34, using the A2DP profile and the bluez-alsa plugin
>and the instructions at http://wiki.bluez.org/wiki/HOWTO/AudioDevices
>which cover audio devices.
>
>"My device doesn't work" questions on the mailing list often come down
>to two common cases: either a) you will eventually get it to work by
>following the wiki or reading the mailing list archives, so you don't
>need an answer from a guru, or b) you won't get it to work because someone
>(possibly you) has to write a patch, but the gurus are patiently waiting
>for you to provide enough information to get started on one.
>
>You may find it worthwhile to read the mailing list archives to see
>what people have included in their postings that *do* get answers,
>and see if you can supply something similar.

And where are these archives?

>> It doesn't seem to be all that helpful, you and I believe one other person
>> has replied, always by personal email rather than the list.  That is not
>> what keeping an archive of a list is all about.
>
>I agree here.  If you get a private but helpful reply, please forward
>it back to the list so that others can benefit from it.  If you are
>providing a helpful reply, post it to the list so that people can find
>it later.  ;-)
>
>> BTW, where is that list archive?
>
>vger.kernel.org mailing lists are widely distributed
>and there are a number of public archives for them.  One is at
>http://marc.info/?l=linux-bluetooth&w=1

Thanks, I'll dig into that.

>I note that the link on www.bluez.org points to an error message on
> gmane.org.
>
>> >> What I want to  do, and was doing, is to run a system shell on the bt
>> >> device on the other end, and minicom or picocom  to /dev/rfcomm0 as a
>> >> remote terminal on that system.
>
>...but if the system is a Coco3, how is it doing Bluetooth?  I have
>visions of a UART HCI Bluetooth dongle connected to the Coco3 and expected
>to work as a RS-232 port...

Almost exactly.  This bt pack actually uses the rom image from the old rs-232 
pack with one fix, the old 50 baud setting is now a 115,2kb by hooking the 
crystal directly the the sc6551 uart.

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

That is why I put this stuff in scripts, no typu's. :)

>Run 'simple-agent hci0 <remote-device-bdaddr>'.  You should be prompted
>for a PIN on both devices.  Use the same one.  ;-)

Same as above I believe:
-------------------------------------------------
./simple-agent hci0 00:0C:84:00:86:F8
ERROR:dbus.proxies:Introspect error on :1.67:/: dbus.exceptions.DBusException: 
org.freedesktop.DBus.Error.AccessDenied: A security policy in place prevents 
this sender from sending this message to this recipient, see message bus 
configuration file (rejected message had interface 
"org.freedesktop.DBus.Introspectable" member "Introspect" error name "(unset)" 
destination ":1.67")
Traceback (most recent call last):
  File "./simple-agent", line 84, in <module>
    path = manager.FindAdapter(sys.argv[1])
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 68, in 
__call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 140, in 
__call__
    **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/connection.py", line 630, in 
call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.AccessDenied: A 
security policy in place prevents this sender from sending this message to 
this recipient, see message bus configuration file (rejected message had 
interface "org.bluez.Manager" member "FindAdapter" error name "(unset)" 
destination ":1.67")
-----------------------------------------
>Run 'sdptool browse <remote-device-bdaddr>' (this will probably get me
>flamed by others on this list ;).  This might give you a list of services
>exported by the device.  It might not, in which case you probably want
>to use the org.bluez.Device.DiscoverServices DBus API call, which will
>give you a blob of XML you can decode with your handy-dandy copy of the
>Bluetooth assigned numbers.  If sdptool works, you should get a list of
>serial profile descriptions like this one:
>
>	Service Name: Dialup Networking
>	Service RecHandle: 0x10000
>	Service Class ID List:
>	  "Dialup Networking" (0x1103)
>	  "Generic Networking" (0x1201)
>	Protocol Descriptor List:
>	  "L2CAP" (0x0100)
>	  "RFCOMM" (0x0003)
>	    Channel: 1
>	Profile Descriptor List:
>	  "Dialup Networking" (0x1103)
>	    Version: 0x0100

Yup, I had such a list being returned, yesterday morning...

>The interesting parts are "Service Name" and "Channel".  There may be
>multiple records, each with its own channel.
>
>Run 'rfcomm bind /dev/rfcomm0 <remote-device-bdaddr> N' where N is the
>channel number.  If you don't have success with 'sdptool browse,' you can
>simply try channel numbers from 1 up to 15 or so.

Hummm, redid the 'release' & then 'bind' using your syntax, no error.  But:
[root@coyote test]# sdptool browse
Inquiring ... (10+ second delay, then returned this)
Browsing 00:0C:84:00:86:F8 ...
[root@coyote test]#

And I checked on the coco, it is still spitting out the string "CoCo3 at 
coyote.den" 3 or 4x a second.  IF its transmitting.  Yup, the screen is 
merrilly scrolling away yet.

>Use a terminal program to see what you've connected to on rfcomm0.
>Repeat with different channel numbers until you find what you're
>looking for.

See results above, essentially zip.  Been using channel 1 all along.  Darnit.

Poking around in /etc/dbus-1, I see there is a system.d subdir with a 
bluetooth.conf in it.  It references back to system.conf, but all that may as 
well be APL/swahili to me.

As always, I'm grateful for any help.

Thank you Zygo Blaxell.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
The person you rejected yesterday could make you happy, if you say yes.

