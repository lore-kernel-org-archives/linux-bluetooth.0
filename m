Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1270598033.3201.75.camel@donpedro>
References: <r2if3ae2ce11004061001mc539e7eaq206d43ffb12fb2d2@mail.gmail.com>
	<j2tf3ae2ce11004061008x26da852el996b017a5115d595@mail.gmail.com>
	<1270577971.764253.580.nullmailer@galant.ukfsn.org> <x2xf3ae2ce11004061132gd546fb7emd890e6c096c72bd3@mail.gmail.com>
	<1270583850.437918.726.nullmailer@galant.ukfsn.org> <1270598033.3201.75.camel@donpedro>
From: Garry Paxinos <paxinos@gmail.com>
Date: Wed, 7 Apr 2010 09:07:32 -0400
Message-ID: <t2qf3ae2ce11004070607m276cb742l2a2568fdefb2ddab@mail.gmail.com>
Subject: Re: upper limit of bonded devices?
To: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Cc: Iain Hibbert <plunky@rya-online.net>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks to both of your for your info.

I was able to get RSSI iinfo, but it took a little fiddling with the
extended_inquiry_info structure but I have it working.

I have complete control over the computer but no control over the
device.   It would be best if I could cause the device to initiate the
connection but do not have a practical way to implement.

I have seen a couple times when I'm initiating a connection from the
computer to one device, another device will initiate a connection to
the computer without any explicit prompting on my part.  But I need to
investigate this further to see if I can reliably repeat this and then
if it is a usable side effect.

Having only a very limited number of active connection is not a
problem for my project.

Thanks again,
Pax.

On Tue, Apr 6, 2010 at 7:53 PM, Peter Dons Tychsen <donpedro@tdcadsl.dk> wrote:
> Hi Iain & Garry,
>
> On Tue, 2010-04-06 at 20:57 +0100, Iain Hibbert wrote:
>> Sure, but consider that the page timeout (time to failure of a
>> connection
>> attempt) is usually around 20 seconds.. and most Bluetooth controllers
>> (that I have tried) can only page a single device at a time.. So, if
>> you
>> don't know which devices are in range, you might be waiting a *long*
>> time
>> before you connect to anything..
>
> 20 seconds for a "page-timeout" is unusual for the reason you just
> mentioned. However, the "link-timeout" is usually around 10-20 seconds,
> but that is only applicable if an existing links needs to drop. The page
> timeout use usually more like 3-5 seconds. Even if it were as high as
> you describe, it is easily re-configurable. Going below ~2 seconds is
> not a good idea though as you push the odds of hitting the page-scan
> window (i do not remember the exact number, look in the spec). Even
> better test it (and tune accordingly). For an application like this you
> want a low page-timeout.
>
> On Tue, 2010-04-06 at 19:11 +0100, Iain Hibbert wrote:
>> you will probably find that because the HS device is very limited in
>> resources, it does not keep records of more than one paired device.
>> So, if
>> you pair with another device it forgets about the first and you will
>> not
>> be able to connect except that you pair it again.
>
> Many headset devices store store 8 devices they have previously paired
> with (the major brands). It is however not a guarantee, so some might
> not have it.
>
>>On Tue, 2010-04-06 at 13:08 -0400, Garry Paxinos wrote:
>> Is there a practical upper limit of the number of devices that can be
>> bonded to a single computer?
>
> The number of devices is almost limitless. However, as Iain said, in
> theory this cannot be done with one controller as the maximum devices
> for a unit is 7. In practice it looks even worse, as many controllers
> become unstable if you go beyond 2 links. The link itself also becomes
> unstable when many devices are connected, as you run out of air-time
> (your radio can only service one at any time), and you risk loosing a
> link. I recommend people to stick with one link pr. application if
> stability and speed is the name of the game. If not, test it!
>
> Recently i created a large setup of lots of BT-USB dongles connected via
> some hubs to a single box running Bluez. To my delight it was remarkably
> easy and stable. The well designed Bluez-API really is a bonus. Doing
> this on any other system has only ended in agony. Just having that many
> USB devices can cause problems on many systems. This is definitely the
> way to go if you are trying to connect to lots of devices in a reliable
> way. It is pretty cheap as well, as even good dongles are getting
> cheaper even as i type (down to $10-$15)! :-)
>
> Good luck on your project,
>
> Thanks,
>
> /Pedro
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
