Return-Path: <johan.hedberg@gmail.com>
Date: Sat, 20 Feb 2016 20:23:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tore Anderson <tore@fud.no>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: PROBLEM: Bluetooth mouse not working after resume since commit
 2ff1389
Message-ID: <20160220182339.GA1648@t440s.P-661HNU-F1>
References: <20160220181259.1e28f8da@envy.w5.y.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160220181259.1e28f8da@envy.w5.y.home>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tore,

On Sat, Feb 20, 2016, Tore Anderson wrote:
> Starting with commit 2ff1389, «Perform HCI update for power on
> synchronously», my Logitech M555b bluetooth mouse no longer works after
> resuming the system from suspend. The devices is handled by Blueman, and
> after resuming from suspend the white lines/triangles inside the
> systray icon doesn't turn green even though I move the mouse around.
> (The lines turning green normally indicates that a device is active.)
> 
> In order to revive it, I need to manually disable and then re-enable
> bluetooth, at which point it will re-connects fine.
> 
> I've also noticed that I need to press Blueman's «Turn Bluetooth Off»
> menu selection twice for it to take effect (so that Blueman's systray
> icon gets overlayed with a little red X symbol). This only happens once
> after each resume from suspend - after having been through one
> off-off-on cycle, bluetooth will turn off normally on the first attempt
> (until the next suspend/resume cycle). It also turns off normally on
> the first attempt after the initial boot-up. This "double-off after
> resume" behaviour also first occurred with commit 2ff1389.
> 
> Let me know if there's any other information I can provide.

Do you see the same issue if you don't use blueman? (a piece of software
I'm not really familiar with).

What exactly do you do when you say you "manually disable and then
re-enable bluetooth"? "btmgmt power off; btmgmt power on"? bluetoothctl
power off/on? Something else?

It'd be important to understand what exactly your user space software
(blueman) does when you resume. So any logs that you can take of this
would be helpful. You could e.g. take a HCI log using btmon and enable
kernel debug logs for the bluetooth module (see
Documentation/dynamic-debug-howto.txt in the kernel documentation).

Johan
