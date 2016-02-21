Return-Path: <johan.hedberg@gmail.com>
Date: Sun, 21 Feb 2016 09:02:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tore Anderson <tore@fud.no>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: PROBLEM: Bluetooth mouse not working after resume since commit
 2ff1389
Message-ID: <20160221070226.GA12780@t440s.P-661HNU-F1>
References: <20160220181259.1e28f8da@envy.w5.y.home>
 <20160220182339.GA1648@t440s.P-661HNU-F1>
 <20160220182919.GA2620@t440s.P-661HNU-F1>
 <20160220213028.35760428@envy.w5.y.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160220213028.35760428@envy.w5.y.home>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tore,

On Sat, Feb 20, 2016, Tore Anderson wrote:
> I uploaded debug files to http://filebin.net/pfmb8043cx :

Thanks.

> - kernel-debug-messages.$KVER.txt: kernel output (journalctl -k), after
>   having written "module bluetooth +p" to
>   the /sys/kernel/debug/dynamic_debug/control file.

These are unfortunately not very useful without function information
since most functions log very similar things. Could you do +pf instead
of +p and try to get these again? To avoid any unnecessary noise, start
the logs right before suspending and stop them right after resuming (I
hope this is how the other logs were taken).

> > Another thing to try in addition to disabling blueman: Add
> > AutoEnable=true under the [Policy] section
> > in /etc/bluetooth/main.conf. It might make a difference assuming that
> > your Bluetooth adapter gets detached and reattached to the USB bus
> > when you suspend/resume.
> 
> This made no difference. Note that I had to create that file and its
> containing directory anew, it didn't already exist on my Fedora 23
> system.

You could have also used src/main.conf from the BlueZ tree as a starting
point and removed the '#' from the AutoEnable line:

https://git.kernel.org/cgit/bluetooth/bluez.git/plain/src/main.conf

Are you sure that you restarted bluetoothd after this change? And you've
got a BlueZ version greater than 5.35 (where the feature was
introduced)?

Johan
