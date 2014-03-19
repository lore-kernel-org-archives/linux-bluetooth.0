Return-Path: <cyrus@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 19 Mar 2014 16:47:07 -0700
From: Terry Hardie <terryh@orcas.net>
Cc: Adam Warski <adam@warski.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	linux-bluetooth-owner@vger.kernel.org
In-Reply-To: <CAJdJm_O6nF3NH7H+jZ8dZv=ED0VyP8-z4BqYnmxNqBcqOM8wNQ@mail.gmail.com>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org>
 <CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com>
 <A4DDF6F3-8DD4-4CF7-A5C0-205F5B4EE489@warski.org>
 <CAJdJm_PN3xGjdNOtr3o-J0SJ8N6MJXBChUCwOWOZBrdFKDBfGA@mail.gmail.com>
 <407CD6A9-AFA8-4A8A-BA2C-882D7A64EF40@warski.org>
 <0BA8DEFD-9E73-4A6A-A9E6-1957634CABF8@warski.org>
 <CAJdJm_P6gnpW5AhO9j4+LV6KX30J4sTWd_tWW=x=E+ejQq3cTQ@mail.gmail.com>
 <A2B80C7C-697D-44E5-80EA-B398E62EE608@warski.org>
 <CAJdJm_MXR08tvceb0-vHT=VD+dKY_dz2MbkO3eaUoBneeFxXMA@mail.gmail.com>
 <A6C5B873-6614-45B3-AD4C-B3E08831E6D8@warski.org>
 <CAJdJm_MrjHy-fk-OQUeepxh2C_K=ap30ekR0U91e6kK+ov42HQ@mail.gmail.com>
 <C342F1F6-C4EB-4380-85D8-1F141CB06A83@warski.org>
 <CAJdJm_O6nF3NH7H+jZ8dZv=ED0VyP8-z4BqYnmxNqBcqOM8wNQ@mail.gmail.com>
Message-ID: <59e67d6df57ced71c2e1c5c8901847da@orcas.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 2014-03-18 07:07, Anderson Lizardo wrote:
>> And the same as before, after a short amount of time I start getting 
>> similar (not exactly the same [2]) errors. So it's not the dongle :)
> 
> The logs seem to show the same behaviour as the other dongle:
> seemingly "random" packets with nonsense parameters (simply because
> the HCI packet was assembled incorrectly).
> 
> I still blame the USB controller in RPi/Beaglebone for not feeding all
> USB fragments to the bluetooth subsystem... at least is my
> interpretation from Terry's logs (which are from USB sniffing).
> 
> What I have no clue is why this is happenning: both of you tried
> powered USB hubs, and this was my only guess (insufficient power on
> the bus). If you could find a kernel version for your boards that are
> not causing any problems, then we can rule out HW related issues...

I agree that it looks like the USB controller's fault. It seems highly 
unlikely, though. A few reasons why I think so:

1. The 2 boards use completely different USB controllers.
2. Both those platforms talk to other USB devices pushing much higher 
data rates without any issue.
3. The problem doesn't show up when the bus is forced to USB 1.1 (Full 
speed instead of high speed)
4. The problem doesn't only show up during non-duplicate-filtered scans. 
I can reproduce it (although it takes a lot longer) with LE 
Advertisement packets only coming in once per second.

Let me ask another question:

Are there any other USB devices that ever send a bunch of data with no 
polling from the host? IE, if the host has no buffer space to accept an 
INT transaction, it will just be lost, and all other USB devices wait 
for the INT to be processed by getting an acknowledgement before 
generating another INT? Apologies for my lack of in-depth knowledge for 
the workings of USB bus transactions.

My suspicion is that if you follow the Bluetooth spec for HCI over USB 
(which all of these vendors making these USB devices should) then if the 
host USB controller is not fast enough, it can be overwhelmed. Forcing 
the bus to full-speed mode, means the bluetooth receiver is forced to 
buffer on its end, since it simply cannot transfer data to the host fast 
enough to overwhelm it. If my suspicion is true, then that means any 
packets of this type could overflow a host if it is busy enough, 
although much less likely to happen if the host is more powerful (in 
terms of processing power).

Regards,

Terry

