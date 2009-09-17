Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: hci0 is  invisible
Date: Thu, 17 Sep 2009 09:51:59 -0400
References: <200909161204.13479.gene.heskett@verizon.net>
 <200909162114.41157.gene.heskett@verizon.net>
 <20090917114702.7f85c5dd@strolchi.home.s3e.de>
In-reply-to: <20090917114702.7f85c5dd@strolchi.home.s3e.de>
MIME-version: 1.0
Message-id: <200909170952.00039.gene.heskett@verizon.net>
Content-type: Text/Plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 17 September 2009, Stefan Seyfried wrote:
>Hi Gene,
>
>On Wed, 16 Sep 2009 21:14:41 -0400
>
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> >I have written something up about rfcomm in a former life on
>> >http://en.opensuse.org/Bluetooth
>> >(it is not suse specific at all, but it might be outdated), for your
>> >case http://en.opensuse.org/Bluetooth/rfcomm might be even more
>> >specific.
>>
>> From that link:
>>
>> [root@coyote bluetooth]# sdptool browse local|grep Service
>> Service RecHandle: 0x10000
>> Service Class ID List:
>> Service Name: BlueZ PANU service
>> Service Description: BlueZ PAN service
>> Service RecHandle: 0x10001
>> Service Class ID List:
>> Service Name: BlueZ GN service
>> Service Description: BlueZ PAN service
>> Service RecHandle: 0x10002
>> Service Class ID List:
>> Service Name: BlueZ NAP service
>> Service Description: BlueZ PAN service
>> Service RecHandle: 0x10003
>> Service Class ID List:
>> Service Name: Headset Audio Gateway
>> Service RecHandle: 0x10004
>> Service Class ID List:
>> Service Name: Hands-Free Audio Gateway
>> Service RecHandle: 0x10005
>> Service Class ID List:
>> Service Name: Audio Source
>> Service RecHandle: 0x10006
>> Service Class ID List:
>> Service Name: AVRCP TG
>> Service RecHandle: 0x10007
>> Service Class ID List:
>> Service Name: AVRCP CT
>> Service RecHandle: 0x10008
>> Service Class ID List:
>>
>> Should there be some reference to serial communications there?
>> Nothing glaringly obvious to me.
>
>Yes. There should be something like that (but not "sdptool browse
>local", you need to do "sdptool browse xx:xx:xx:xx:xx:xx" with xx:xx...
>the BDaddr of the remote device (your eb101).

IIRC, the page fails to define whether the bdaddr to give is the local one or 
the remote one, and that bit of data seems to have been ignored throughout 
the discussion.

At the instant, the eb101 seems to have disappeared, either it is not now 
broadcasting, or my local dongle is not receiving.  And I'm now reading the 
data sheet on it to see if my reset procedure on the remote end was correctly 
done.  The instructions that came with it indicate that the machine it is 
plugged into should be powered up wwith the rest button held down until the 
green led goes out, which restores it to the discovery mode.  I have done 
that several times since I was last able to see it here.

When I was able to see it, the assistant screen could see it, and I could 
select it, but that gui spits out an error message that is cleared so fast 
its almost sublimal, and replaced with a 'failed' which is, shall we say, 
less than helpful.  And the error msg doesn't make it back to the shell it 
was started from.

At the moment:
[root@coyote test]# sdptool browse 00:0C:84:00:86:F8
Failed to connect to SDP server on 00:0C:84:00:86:F8: Host is down
[root@coyote test]# man rfcomm
[root@coyote test]# rfcomm -a
rfcomm0: 00:0C:84:00:86:F8 channel 1 closed

What does this tell us?

Also:

[root@coyote test]# ./test-serial 00:0C:84:00:86:F8
Traceback (most recent call last):
  File "./test-serial", line 26, in <module>
    path = adapter.FindDevice(address)
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 68, in 
__call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 140, in 
__call__
    **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/connection.py", line 630, in 
call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.bluez.Error.DoesNotExist: Device does not 
exist

It seems not to handle errors very well.  But it points back to dbus again, 
and I'm lost.

>Service Name: Dial-up Networking
>Service RecHandle: 0x2008004
>Service Class ID List:
>  "Dialup Networking" (0x1103)
>  "Generic Networking" (0x1201)
>Protocol Descriptor List:
>  "L2CAP" (0x0100)
>  "RFCOMM" (0x0003)
>    Channel: 1
>Profile Descriptor List:
>  "Dialup Networking" (0x1103)
>    Version: 0x0101
>
>or that:
>
>Service Name: Serial Port 1
>Service RecHandle: 0x2008003
>Service Class ID List:
>  "Serial Port" (0x1101)
>Protocol Descriptor List:
>  "L2CAP" (0x0100)
>  "RFCOMM" (0x0003)
>    Channel: 2
>
>> >Nowadays, you might also get good results with "test-serial".
>> >At least on my phone "test-serial <bdaddr>" gets me an /dev/rfcomm0
>> >which I can use to talk to it with AT commands.
>>
>> Test-serial is now a python error.  Giving it the bdaddr of the eb101:
>> [root@coyote test]# ./test-serial 00:0C:84:00:86:F8 spp
>> Traceback (most recent call last):
>>   File "./test-serial", line 26, in <module>
>>     path = adapter.FindDevice(address)
>>   File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 68,
>> in __call__
>>     return self._proxy_method(*args, **keywords)
>>   File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 140,
>> in __call__
>>     **keywords)
>>   File "/usr/lib/python2.5/site-packages/dbus/connection.py", line
>> 630, in call_blocking
>>     message, timeout)
>> dbus.exceptions.DBusException: org.bluez.Error.DoesNotExist: Device
>> does not exist
>
>That's probably because there is no serial port service on the other
>side.
>
>> Also exactly the same result if I give it the local bdaddr,
>> 11:11:11:11:11:11
>
>That's expected.
>
>> But when its working, it takes/needs no AT commands.  On the other
>> machine, I start an immortal shell session to the /t3 port, which is
>> the eb101 at the address that was shown in the message.  I start
>> minicom against (IIRC) /dev/hci0, hit return, the machine on the
>> other end returns the shell prompt and I'm off to the races.  I am
>> fully 'logged into' that machine, having bypassed the login script
>> with my shell starter command issued from its own keyboard.
>
>Then this might be a special device and not one of the common "serial
>over bluetooth" things I have seen until now, and I might be totally
>wrong.
>
>On the other hand, I am in no ways a BT expert, so you really should
>post this to the mailing list and hope that Marcel and friends will
>figure something out. Maybe if you reply to my mail, this will raise
>his attention (I know him personally ;)
>
>Good luck.
>
>> I think I see, is this then a dbus problem too?  You'll recall from
>> several previous messages that I bought 2 of these POJ's, and both
>> seem to be hard coded to a bdaddr of 11:11:11:11:11:11, which I'd
>> have to assume means they cannot possibly talk to each other, only to
>> other, more compliant devices.
>>
>> >> [root@coyote tools]# minicom coco3
>> >> Device /org/bluez/892/hci0 access failed: No such file or
>> >> directory.
>> >
>> >which then, of course, is to be expected.
>>
>> Then what is the argument I enter in the minicom serial setup menu
>> when I launch it as "minicom -s" which enables the config screen for
>> that, and then hit an A to select the comm path name?  ATM, I have
>> a /dev/rfcomm0, and minicom, when set to that path isn't objecting.
>> But it isn't communicating either.  The baud rates match, but the
>> keyboard elicits no response.  Any 'next step' help will be
>> appreciated.
>
>/dev/rfcomm0 is probably the right thing, but it first needs to be
>bound to the device, and if there is no "serial port" on your device,
>this won't work. But we (meaning the guys on the bluetooth list ;) need
>to see the "sdptool browse" output from the eb101 to know if that's
>true.

Somewhere in here, maybe there is a clue to the trained eye, that tells that    
eye what I need to fix.  Bluez is now 4.53,  blueman is now 1.10, both 
installed from the tarballs.  All bluetooth options are emabled in the 
kernel, which atm is 2.6.31 final.

Thank you.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
The NRA is offering FREE Associate memberships to anyone who wants them.
<https://www.nrahq.org/nrabonus/accept-membership.asp>

I'm not sure whether that's actually useful...
             -- Larry Wall in <199710011704.KAA21395@wall.org>
