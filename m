Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMk70DBXqUnXNkOSx9Cct7ATbCWWwXzbV1jFWNyBkULzNZ6dHA@mail.gmail.com>
References: <CAMk70DBgaYSK5bMLPUR1c7Gf1xFO8px4fgtqqnQ1-qMXUOq3PA@mail.gmail.com>
	<CAFsbExJZd6w4-o4YZ82oeVLdRDr-tWhrNwN+zQv2WbJb6cKqUg@mail.gmail.com>
	<CAMk70DBXqUnXNkOSx9Cct7ATbCWWwXzbV1jFWNyBkULzNZ6dHA@mail.gmail.com>
Date: Sat, 16 Jun 2012 15:39:09 -0500
Message-ID: <CAMk70DCvRsuq7SN4dxY4Qo+saSzY8vsK1=5nDtuWA3cLGkcJWw@mail.gmail.com>
Subject: Re: Question For Devs: Is Headset Connection Automatic?
From: bubba junk <junkbubba2@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I think I figured out how to get the requested information. The
following is the output from the list-devices script. I'll create a
separate response with the output of the hcidump. Let me know if this
is correct and if you need any further details.

python list-devices output
[ /org/bluez/741/hci0 ]
    Name = milano-0
    Powered = 1
    Devices = dev_68_EB_AE_10_82_F3
    DiscoverableTimeout = 0
    PairableTimeout = 0
    Discoverable = 0
    Address = 00:02:76:17:B9:C9
    Discovering = 0
    Pairable = 1
    Class = 7209216
    UUIDs = 0x1000 0x1001 0x112d 0x1112 0x111f 0x111e 0x110a 0x110b
0x110c 0x110e 0x1103
    [ /org/bluez/741/hci0/dev_68_EB_AE_10_82_F3 ]
        Name = HM1000
        Paired = 1
        Adapter = /org/bluez/741/hci0
        Alias = HM1000
        Connected = 0
        UUIDs = 0x1108 0x111e
        Address = 68:EB:AE:10:82:F3
        Services = dbus.Array([], signature=dbus.Signature('o'),
variant_level=1)
        Blocked = 0
        Class = 0x200404
        Trusted = 1
        Icon = audio-card

On Sat, Jun 16, 2012 at 3:32 PM, bubba junk <junkbubba2@gmail.com> wrote:
> Gustavo,
>
>  Thank you so much for responding. It is encouraging to hear that the
>  expected behavior is for the headset to connect automatically. Until
>  recently I was not able to reconnect at all until the patch "[PATCH]
>  Bluetooth: Fix l2cap connfailures for ssp devices" made it into the
>  linux kernel released with Ubuntu 12.04 LTS. Since that patch, I am
>  able to successfully connect and disconnect the headset without issue.
>
>  Regarding the requested information hcidump and output from
>  list-devices script, I would be more than happy to provide the
>  information, but not sure exactly how to go about it given I've never
>  done either. If there is some basic documentation on
>  downloading/installing the package and script and running each that I
>  can review, I'm sure I can figure it out. I will try to google search
>  for instructions. Also, assuming I can figure out how to run the
>  scripts, do you want me to provide the output as text pasted into the
>  email, or as attachments?
>
>  Thanks in advance for any help you can provide.
>
> On Thu, Jun 14, 2012 at 10:24 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
>> Hi Bubba,
>>
>> On Thu, Jun 14, 2012 at 6:31 PM, bubba junk <junkbubba2@gmail.com> wrote:
>>> I am non-developer with a basic question about basic BlueZ
>>> functionality. I have a BT headset (Samsung HM1000) that I have paired
>>> with BlueZ. I am able to successfully connect / disconnect the headset
>>> using the bluetooth panel applet (in Ubuntu 12.04 lastest patches). My
>>> question is should the headset automatically connect to BlueZ after it
>>> is powered on or after pressing the talk button?
>>>
>>> My BT Logitech mouse automatically connects to BlueZ after it has been
>>> powered on or after a long period of inactivity. I expected the
>>> headset to do the same, connect automatically. Is there a way to have
>>> the headset connect automatically without having to select 'Connect'
>>> from the panel applet?
>>
>> It is supposed to connect automatically. Can you provide a hcidump
>> (usually bluez-hcidump package) of a connection attempt from the
>> headset. Also run the test list-devices script (present in bluez
>> sources under the test dir) and tell us the result.
>>
>> Gustavo
