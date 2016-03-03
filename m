Return-Path: <johan.hedberg@gmail.com>
Date: Thu, 3 Mar 2016 10:42:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tore Anderson <tore@fud.no>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: PROBLEM: Bluetooth mouse not working after resume since commit
 2ff1389
Message-ID: <20160303084229.GA15622@t440s.ger.corp.intel.com>
References: <20160220181259.1e28f8da@envy.w5.y.home>
 <20160220182339.GA1648@t440s.P-661HNU-F1>
 <20160220182919.GA2620@t440s.P-661HNU-F1>
 <20160220213028.35760428@envy.w5.y.home>
 <20160221070226.GA12780@t440s.P-661HNU-F1>
 <20160221121322.6a19b1d4@envy.w5.y.home>
 <20160303085116.0567712b@echo.ms.redpill-linpro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160303085116.0567712b@echo.ms.redpill-linpro.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tore,

On Thu, Mar 03, 2016, Tore Anderson wrote:
> > > You could have also used src/main.conf from the BlueZ tree as a
> > > starting point and removed the '#' from the AutoEnable line:
> > > 
> > > https://git.kernel.org/cgit/bluetooth/bluez.git/plain/src/main.conf
> > > 
> > > Are you sure that you restarted bluetoothd after this change? And
> > > you've got a BlueZ version greater than 5.35 (where the feature was
> > > introduced)?  
> > 
> > I've got version 5.36, and I had rebooted the system from scratch. I
> > experimented a bit more, though, and I found out that with
> > AutoEnable=true (and blueman uninstalled), my system behaves exactly
> > the same as it did with blueman, that is:
> > 
> > - with a pre-2ff1389 kernel: the mouse is auto-enabled and works fine
> >   after bootup and resume from suspend.
> > - with a post-2ff1389 kernel: the mouse is auto-enabled and works fine
> >   after bootup, but stops working after resume from suspend (until
> >   "hciconfig hci0 up" is issued manually).
> > 
> > That means we can exclude blueman as a potential cause of the problem,
> > so I left it uninstalled when I generated the new debug files with +pf,
> > which you can find here: http://filebin.net/wf9edcjbju
> > 
> > I added a new file too: hciconfig_hci0.$KVER.txt. This shows the
> > output of "while sleep .5; do hciconfig hci0; done | ts %H:%M:%.S". I
> > noticed something that seems highly relevant, namely that with the
> > post-2ff1389 kernel, the hci0 state changes to DOWN a couple of seconds
> > after resuming. This does not happen with the pre-2ff1389 kernel.
> 
> Hi Johan,
> 
> I thought I'd just ping you quickly about this issue - did you get a
> chance to look at the log files, and if so did you figure out what's
> going on?
> 
> If on the other hand you don't have time to look into the issue, let me
> know if I should file this issue in the kernel.org bugzilla (or
> anywhere else) so as to avoid it being forgotten about (also note that
> the logs will be expired from filebin.net after a couple of weeks).

Sorry for the delayed response.

I tried looking at the logs but couldn't find anything helpful there. I
also tried to reproduce this myself by configuring my bluetoothd with
the AutoEnable=true and unplugging/plugging a USB dongle, but no luck
(it should roughly match what happens when you suspend/resume). I
suppose you don't have any ideas how I could successfully reproduce this
myself? (other than getting the same HW as you).

One thing you could still try is use an even newer kernel, such as the
bluetooth-next tree or the latest 4.5-rc release, and see if the issue
still persists.

Johan
