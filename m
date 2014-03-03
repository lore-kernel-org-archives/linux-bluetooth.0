Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Adam Warski <adam@warski.org>
In-Reply-To: <CAJdJm_P6gnpW5AhO9j4+LV6KX30J4sTWd_tWW=x=E+ejQq3cTQ@mail.gmail.com>
Date: Mon, 3 Mar 2014 22:25:02 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <A2B80C7C-697D-44E5-80EA-B398E62EE608@warski.org>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org> <CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com> <A4DDF6F3-8DD4-4CF7-A5C0-205F5B4EE489@warski.org> <CAJdJm_PN3xGjdNOtr3o-J0SJ8N6MJXBChUCwOWOZBrdFKDBfGA@mail.gmail.com> <407CD6A9-AFA8-4A8A-BA2C-882D7A64EF40@warski.org> <0BA8DEFD-9E73-4A6A-A9E6-1957634CABF8@warski.org> <CAJdJm_P6gnpW5AhO9j4+LV6KX30J4sTWd_tWW=x=E+ejQq3cTQ@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> I didn't notice that you were using Raspberry PI... To rule out USB
> power issues, can you try attaching a powered USB hub on the RPi, and
> then attach your BT dongle on it?
> 
> I always had strange/random problems on RPi with USB HW plugged
> directly on the USB port (except for pen drives, which work fine),
> even for devices which supposedly draw very little current.
> 
> Given that you are disabling duplicate filtering, every single
> Advertising packet is arriving at the host, so it is certainly using
> more power. Just not sure if that is the cause.

Same thing happens with a powered hub (with both WiFi and BT dongles plugged into the hub).

But I guess even if it was a USB issue, it would be caught earlier? The advertisement packets have a certain preamble, and a CRC, so the shifted data would be discarded? Anyway, that doesn’t seem to be the cause.

Adam

-- 
Adam Warski

http://twitter.com/#!/adamwarski
http://www.softwaremill.com
http://www.warski.org

