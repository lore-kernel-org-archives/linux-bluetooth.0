Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C342F1F6-C4EB-4380-85D8-1F141CB06A83@warski.org>
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
Date: Tue, 18 Mar 2014 10:07:23 -0400
Message-ID: <CAJdJm_O6nF3NH7H+jZ8dZv=ED0VyP8-z4BqYnmxNqBcqOM8wNQ@mail.gmail.com>
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Adam Warski <adam@warski.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

On Sun, Mar 16, 2014 at 3:53 PM, Adam Warski <adam@warski.org> wrote:
> I didn't yet get to doing the wireshark investigations, but just for the record, I got another bluetooth dongle [1], and the --duplicates flag doesn't seem to have any effect, I always get all the packets.

Actually, the default in hcitool is to filter duplicates,  and
"--duplicates"  *disables* duplicate filtering. It's sometimes hard to
tell from the host side whether duplicate filtering is working or not,
as the logic is running inside the dongle. The only effect is to see
*more* advertising packets coming to the host when using --duplicates.

> And the same as before, after a short amount of time I start getting similar (not exactly the same [2]) errors. So it's not the dongle :)

The logs seem to show the same behaviour as the other dongle:
seemingly "random" packets with nonsense parameters (simply because
the HCI packet was assembled incorrectly).

I still blame the USB controller in RPi/Beaglebone for not feeding all
USB fragments to the bluetooth subsystem... at least is my
interpretation from Terry's logs (which are from USB sniffing).

What I have no clue is why this is happenning: both of you tried
powered USB hubs, and this was my only guess (insufficient power on
the bus). If you could find a kernel version for your boards that are
not causing any problems, then we can rule out HW related issues...

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
