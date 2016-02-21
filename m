Return-Path: <tore@fud.no>
Date: Sun, 21 Feb 2016 12:13:22 +0100
From: Tore Anderson <tore@fud.no>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
Subject: Re: PROBLEM: Bluetooth mouse not working after resume since commit
 2ff1389
Message-ID: <20160221121322.6a19b1d4@envy.w5.y.home>
In-Reply-To: <20160221070226.GA12780@t440s.P-661HNU-F1>
References: <20160220181259.1e28f8da@envy.w5.y.home>
	<20160220182339.GA1648@t440s.P-661HNU-F1>
	<20160220182919.GA2620@t440s.P-661HNU-F1>
	<20160220213028.35760428@envy.w5.y.home>
	<20160221070226.GA12780@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Good morning,

* Johan Hedberg

> You could have also used src/main.conf from the BlueZ tree as a
> starting point and removed the '#' from the AutoEnable line:
> 
> https://git.kernel.org/cgit/bluetooth/bluez.git/plain/src/main.conf
> 
> Are you sure that you restarted bluetoothd after this change? And
> you've got a BlueZ version greater than 5.35 (where the feature was
> introduced)?

I've got version 5.36, and I had rebooted the system from scratch. I
experimented a bit more, though, and I found out that with
AutoEnable=true (and blueman uninstalled), my system behaves exactly
the same as it did with blueman, that is:

- with a pre-2ff1389 kernel: the mouse is auto-enabled and works fine
  after bootup and resume from suspend.
- with a post-2ff1389 kernel: the mouse is auto-enabled and works fine
  after bootup, but stops working after resume from suspend (until
  "hciconfig hci0 up" is issued manually).

That means we can exclude blueman as a potential cause of the problem,
so I left it uninstalled when I generated the new debug files with +pf,
which you can find here: http://filebin.net/wf9edcjbju

I added a new file too: hciconfig_hci0.$KVER.txt. This shows the
output of "while sleep .5; do hciconfig hci0; done | ts %H:%M:%.S". I
noticed something that seems highly relevant, namely that with the
post-2ff1389 kernel, the hci0 state changes to DOWN a couple of seconds
after resuming. This does not happen with the pre-2ff1389 kernel.

Tore
