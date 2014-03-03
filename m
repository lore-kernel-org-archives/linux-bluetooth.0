Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0BA8DEFD-9E73-4A6A-A9E6-1957634CABF8@warski.org>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org>
	<CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com>
	<A4DDF6F3-8DD4-4CF7-A5C0-205F5B4EE489@warski.org>
	<CAJdJm_PN3xGjdNOtr3o-J0SJ8N6MJXBChUCwOWOZBrdFKDBfGA@mail.gmail.com>
	<407CD6A9-AFA8-4A8A-BA2C-882D7A64EF40@warski.org>
	<0BA8DEFD-9E73-4A6A-A9E6-1957634CABF8@warski.org>
Date: Mon, 3 Mar 2014 14:02:42 -0400
Message-ID: <CAJdJm_P6gnpW5AhO9j4+LV6KX30J4sTWd_tWW=x=E+ejQq3cTQ@mail.gmail.com>
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Adam Warski <adam@warski.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

On Mon, Mar 3, 2014 at 11:26 AM, Adam Warski <adam@warski.org> wrote:
> I'm wondering what this might mean exactly :) I guess it could point to the
> specific USB/bluetooth drivers present in the raspbian 3.10 and ubuntu 3.11
> kernels, right?

I didn't notice that you were using Raspberry PI... To rule out USB
power issues, can you try attaching a powered USB hub on the RPi, and
then attach your BT dongle on it?

I always had strange/random problems on RPi with USB HW plugged
directly on the USB port (except for pen drives, which work fine),
even for devices which supposedly draw very little current.

Given that you are disabling duplicate filtering, every single
Advertising packet is arriving at the host, so it is certainly using
more power. Just not sure if that is the cause.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
