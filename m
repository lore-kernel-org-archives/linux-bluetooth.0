Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Adam Warski <adam@warski.org>
In-Reply-To: <CAJdJm_P6gnpW5AhO9j4+LV6KX30J4sTWd_tWW=x=E+ejQq3cTQ@mail.gmail.com>
Date: Mon, 3 Mar 2014 22:06:30 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <6B81D51F-AC36-441F-B776-3E24260DF5AE@warski.org>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org> <CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com> <A4DDF6F3-8DD4-4CF7-A5C0-205F5B4EE489@warski.org> <CAJdJm_PN3xGjdNOtr3o-J0SJ8N6MJXBChUCwOWOZBrdFKDBfGA@mail.gmail.com> <407CD6A9-AFA8-4A8A-BA2C-882D7A64EF40@warski.org> <0BA8DEFD-9E73-4A6A-A9E6-1957634CABF8@warski.org> <CAJdJm_P6gnpW5AhO9j4+LV6KX30J4sTWd_tWW=x=E+ejQq3cTQ@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 03 Mar 2014, at 19:02, Anderson Lizardo <anderson.lizardo@openbossa.org> wrote:

> Hi Adam,
> 
> On Mon, Mar 3, 2014 at 11:26 AM, Adam Warski <adam@warski.org> wrote:
>> I'm wondering what this might mean exactly :) I guess it could point to the
>> specific USB/bluetooth drivers present in the raspbian 3.10 and ubuntu 3.11
>> kernels, right?
> 
> I didn't notice that you were using Raspberry PI... To rule out USB
> power issues, can you try attaching a powered USB hub on the RPi, and
> then attach your BT dongle on it?

During these experiments I found something very weird :)

The RPi has two dongles: WiFi and BT

Things *do* work, if the LAN cable is plugged in - even if the interface is down in the system.
The moment I pull the cable, I soon get the familiar buffer overflow and a flood of errors.
How is that possible? :)

That’s without a powered hub so far.

> I always had strange/random problems on RPi with USB HW plugged
> directly on the USB port (except for pen drives, which work fine),
> even for devices which supposedly draw very little current.
> 
> Given that you are disabling duplicate filtering, every single
> Advertising packet is arriving at the host, so it is certainly using
> more power. Just not sure if that is the cause.

So where is the filtering done? In the kernel driver?

Adam

-- 
Adam Warski

http://twitter.com/#!/adamwarski
http://www.softwaremill.com
http://www.warski.org

