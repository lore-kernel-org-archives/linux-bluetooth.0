Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1302100288.3227.51.camel@novo.hadess.net>
References: <BANLkTikdXHstUxQ52RM6OMSnqfLWYJVMvg@mail.gmail.com>
	<BANLkTinQBr7Scuab_KAs_1L1UY-E9j87pw@mail.gmail.com>
	<BANLkTikn99GO4JV4uV64KCuka0G1QYYHpQ@mail.gmail.com>
	<1302100288.3227.51.camel@novo.hadess.net>
Date: Wed, 6 Apr 2011 19:55:38 +0200
Message-ID: <BANLkTi=gqh3fxYipPE9CqMgV=6Qr0MkTSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Support hardcoded Nintendo Wii Remote pins
From: David Herrmann <dh.herrmann@googlemail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Daniele Forsi <dforsi@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 6, 2011 at 4:31 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Wed, 2011-04-06 at 16:05 +0200, Daniele Forsi wrote:
>> 2011/4/6 David Herrmann:
>>
>> > Please try both methods: sync button and 1+2 buttons and report which
>> > method works
>> > with which PIN. As I mentioned above all my Wiimotes work with source-addr plus
>> > red-sync-button and dest-addr plus 1+2 buttons.
>>
>> now I understand, you're right, such explaination would be useful as a
>> comment in the code even if only one method is implemented
>> I can confirm that your code works unmodified for me too if I press
>> 1+2 (after I manually fix the issue I still have with vid/pid), and it
>> also works after modifying it to use source-addr and pressing the sync
>> button
>>
>> > If there is a valid PnP record maybe some bluez Dev could elaborate whether
>> > VID/PID values are guaranteed to be available when pairing is started.
>>
>> I have two original remotes from December 2008 and different one from
>> December 2010 and their SDP records are identical:
>>
>> Service RecHandle: 0x0
>> Service Class ID List:
>>   "SDP Server" (0x1000)
>> Protocol Descriptor List:
>>   "L2CAP" (0x0100)
>>     PSM: 1
>>   "SDP" (0x0001)
>> Language Base Attr List:
>>   code_ISO639: 0x656e
>>   encoding:    0x6a
>>   base_offset: 0x100
>> Profile Descriptor List:
>>   "" (0x0100)
>>     Version: 0x0100
>>
>> Service Name: Nintendo RVL-CNT-01
>> Service Description: Nintendo RVL-CNT-01
>> Service Provider: Nintendo
>> Service RecHandle: 0x10000
>> Service Class ID List:
>>   "Human Interface Device" (0x1124)
>> Protocol Descriptor List:
>>   "L2CAP" (0x0100)
>>     PSM: 17
>>   "HIDP" (0x0011)
>> Language Base Attr List:
>>   code_ISO639: 0x656e
>>   encoding:    0x6a
>>   base_offset: 0x100
>> Profile Descriptor List:
>>   "Human Interface Device" (0x1124)
>>     Version: 0x0100
>>
>> Service RecHandle: 0x10001
>> Service Class ID List:
>>   "PnP Information" (0x1200)
>> Protocol Descriptor List:
>>   "L2CAP" (0x0100)
>>     PSM: 1
>>   "SDP" (0x0001)
>> Profile Descriptor List:
>>   "PnP Information" (0x1200)
>>     Version: 0x0100
>>
>> > I couldn't figure out when autoreconnection is established, reliably. Pairing
>> > the wiimote works sometimes, but not always and I didn't figure out how to
>> > reset the internal cache of reconnection addresses.
>>
>> if you have dangerous ideas I'm willing to sacrifice for the good of
>> science :-) my remote that doesn't work well
>>
>> > If this works for you, could you run the example code at:
>> > http://goo.gl/axeqd
>> > on the new /dev/hidrawX device which is created for the wiimote?
>>
>> it kind of works, but it seems I'm running an older kernel
>> (2.6.35-28-generic #49-Ubuntu):
>> $ sudo ./hid-example /dev/hidraw0
>> Report Descriptor Size: 218
>> Report Descriptor:
>> 5 1 9 5 a1 1 85 10 15 0 26 ff 0 75 8 95 1 6 0 ff 9 1 91 0 85 11 95 1 9
>> 1 91 0 85 12 95 2 9 1 91 0 85 13 95 1 9 1 91 0 85 14 95 1 9 1 91 0 85
>> 15 95 1 9 1 91 0 85 16 95 15 9 1 91 0 85 17 95 6 9 1 91 0 85 18 95 15
>> 9 1 91 0 85 19 95 1 9 1 91 0 85 1a 95 1 9 1 91 0 85 20 95 6 9 1 81 0
>> 85 21 95 15 9 1 81 0 85 22 95 4 9 1 81 0 85 30 95 2 9 1 81 0 85 31 95
>> 5 9 1 81 0 85 32 95 a 9 1 81 0 85 33 95 11 9 1 81 0 85 34 95 15 9 1 81
>> 0 85 35 95 15 9 1 81 0 85 36 95 15 9 1 81 0 85 37 95 15 9 1 81 0 85 3d
>> 95 15 9 1 81 0 85 3e 95 15 9 1 81 0 85 3f 95 15 9 1 81 0 c0 0
>>
>> Raw Name: Nintendo RVL-CNT-01
>> Raw Phys: 00:1F:81:00:01:00
>> Raw Info:
>>       bustype: 5 (Bluetooth)
>>       vendor: 0x057e
>>       product: 0x0306
>> HIDIOCSFEATURE: Invalid argument
>> HIDIOCGFEATURE: Invalid argument
>> write() wrote 2 bytes
>> read: Resource temporarily unavailable
>>
>> > If you have ideas how to support both, sba and dba via some new DBUS
>> > interface, I would be glad to hear about it.
>>
>> using a binary pin seems to solve this problem and the pin could be
>> constructed by the agent based on user choice (and the agent can use
>> the binary pin interface also for plain strings)
>> I understand that constructing the pin in bluez would make it
>> available to all agents but then how do we ask the user for which
>> method to use?
>>
>> you know better than me, but supporting dba doesn't seem a strict
>> requirement to me because pairing with 1+2 already worked for me with
>> gnome-bluetooth 2.32 and bluez-4.69; the config file has this
>> explaination:
>
> The whole point of this is of actually pairing the Wiimote so that when
> turned on, the Wiimote connects to the computer. If you need to press
> any buttons other than the power one, then it's not working.

Exactly.

I prefer my solution with dba over sba because it allows to pair the wiimote
without opening the backside. The only issue left with the patches is the
VID/PID thing. It works perfectly for me when I delete the device with
gnome-bluetooth and add the wiimote as new device.

It would be interesting to know from a bluez dev or gnome-bluetooth dev whether
the SDP records are always retrieved before trying to connect to a remote
device or whether we need to do this manually.
